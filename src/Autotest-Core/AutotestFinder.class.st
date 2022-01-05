"
Heuristics for Autotest, find tests methods related to a changed method
"
Class {
	#name : #AutotestFinder,
	#superclass : #Object,
	#category : #'Autotest-Core'
}

{ #category : #search }
AutotestFinder >> allSendersOf: aCompiledMethod [
     "Returns all senders as a collection of CompiledMethod"
	| methodReferences senders |
	methodReferences := (SystemNavigation default allReferencesTo: aCompiledMethod selector).
	^ methodReferences collect:  [:aMethodReference | 
					 				aMethodReference compiledMethod].
]

{ #category : #search }
AutotestFinder >> baseCategoryNameOf: aCategoryName [
	"For Zork-Tests, Zork, ZorkTests or Tests-Zork answers Zork."
	"Todo: find a good regex"
	| words |
	words := ('-' split: aCategoryName) reject: [:str| 'Test(s)?' asRegex matches: str ].
	(words last = 'Core') ifTrue: [words removeLast].
	^ (('-' join: words) copyReplaceAll: 'Tests' with: '')
		copyReplaceAll: 'Test' with: ''.
]

{ #category : #search }
AutotestFinder >> baseCategoryNameOfMethod: aCompiledMethod [

	"Often tests are not in the same package as the methods. So we need to find the
	category related to a given method. We compare just the root/base of the category name.
	
	 For a method of category Zork-Tests answers 'Zork'.
	 See baseCategoryNameOf:'"

	^ self baseCategoryNameOf:
		  aCompiledMethod methodClass instanceSide category
]

{ #category : #search }
AutotestFinder >> methodsFor: aCompiledMethod [ 
	"Heuristics for finding the tests methods of the given CompiledMethod.
	Returns on the first heuristic which has found some tests"
	#( 	testsForATestMethod:
		testsForASetUpMethod:
		testsForATearDownMethod:
		testsForAStandardMethod:
		testsForClassReferenceOf:) do: 
			[:heuristic | |methods|
			methods := self perform: heuristic with: aCompiledMethod.
			methods isEmpty ifFalse: [^ methods]].
	^ {}.
]

{ #category : #heuristics }
AutotestFinder >> testsForASetUpMethod: aCompiledMethod [
	"If the method is a TestCase setUp, returns all the tests of this TestCase and its subclasses"
	^ (aCompiledMethod isTestSetUpMethod) 
				ifTrue: [|result|
					result := OrderedCollection new. 
					result addAll: aCompiledMethod methodClass allTestMethods.
					(aCompiledMethod methodClass subclasses do:[:aSubClass | result addAll: aSubClass allTestMethods]). 
					result]
				ifFalse: [{}].
]

{ #category : #heuristics }
AutotestFinder >> testsForAStandardMethod: aCompiledMethod [
	"Find all senders of the method which belongs to a TestCase of the same package (or related category).
	For example, if the method is part of the package Zork-Core and the tests in package Zork-Tests, it will
	find it"
	| allSenders baseCategoryName |
	baseCategoryName := self baseCategoryNameOfMethod: aCompiledMethod.
	allSenders := self allSendersOf: aCompiledMethod.
	^ allSenders select: 
		[:sender|  
		sender isTestMethod
		and: [baseCategoryName = (self baseCategoryNameOfMethod: sender)]].
]

{ #category : #heuristics }
AutotestFinder >> testsForATearDownMethod: aCompiledMethod [
	"If the method is a TestCase tearDown, returns all the tests of this TestCase"
	^ (aCompiledMethod isTestTearDownMethod) 
				ifTrue: [
					|result|
					result := OrderedCollection new. 
					result addAll: aCompiledMethod methodClass allTestMethods.
					(aCompiledMethod methodClass subclasses do:[:aSubClass | result addAll: aSubClass allTestMethods]).
					result]
				ifFalse: [{}].
]

{ #category : #heuristics }
AutotestFinder >> testsForATestMethod: aCompiledMethod [
	"If the method is a TestCase test, returns it" 
	^ aCompiledMethod isTestMethod
				ifTrue: [{aCompiledMethod}]
				ifFalse: [{}].
]

{ #category : #heuristics }
AutotestFinder >> testsForClassReferenceOf: aCompiledMethod [
	"Find all tests in related packages that reference the method's class"
	| baseCategoryName allSendersClass allTests |
	baseCategoryName := self baseCategoryNameOfMethod: aCompiledMethod.
	allSendersClass := (aCompiledMethod methodClass allCallsOn 
							collect: [:aReference| 
									 aReference methodClass]) asSet
							select: [:aClass| 
									(aClass isKindOf: TestCase class) 
									and: [baseCategoryName = (self baseCategoryNameOf: aClass category)]].
	
	allTests := OrderedCollection new.
	allSendersClass do: [:aClass|  allTests addAll: aClass allTestMethods].
	^ allTests.
]
