Class {
	#name : #AutotestTestFinder,
	#superclass : #AbstractAutotestTestCase,
	#instVars : [
		'finder'
	],
	#category : #'Autotest-Tests-Core'
}

{ #category : #running }
AutotestTestFinder >> setUp [
	finder := AutotestFinder new.
	
]

{ #category : #private }
AutotestTestFinder >> shouldReturnAllTestsFor: aSelector [
	| lookupMethod foundMethods thisMethod myTests |

	lookupMethod := (self class>>aSelector).
	myTests := OrderedCollection new.
	myTests addAll: (self class methods select: [:aCompiledMethod| aCompiledMethod isTestMethod]).
	(self class subclasses do:[:aSubClass | 
						myTests addAll: (aSubClass methods select: [:aCompiledMethod| aCompiledMethod isTestMethod])]).
	foundMethods := (finder methodsFor: lookupMethod) asOrderedCollection.

	self assert: myTests equals: foundMethods.
]

{ #category : #running }
AutotestTestFinder >> tearDown [
	"Used for tests"
	^ super tearDown.
]

{ #category : #tests }
AutotestTestFinder >> testBaseCategoryName [
	self assert: 'Zork' equals: (finder baseCategoryNameOf: 'Zork').
	self assert: 'ZorkCore' equals: (finder baseCategoryNameOf: 'ZorkCore').
	self assert: 'Zork' equals: (finder baseCategoryNameOf: 'Zork-Core').
	self assert: 'Zork' equals: (finder baseCategoryNameOf: 'Zork-Tests').
	self assert: 'Zork' equals: (finder baseCategoryNameOf: 'ZorkTests').
	self assert: 'Zork' equals: (finder baseCategoryNameOf: 'Tests-Zork').
	self assert: 'Zork' equals: (finder baseCategoryNameOf: 'Zork-Tests-Core').
	self assert: 'Zork-GUI' equals: (finder baseCategoryNameOf: 'Zork-Tests-GUI').
	self assert: 'Zork-Core-Data' equals: (finder baseCategoryNameOf: 'Zork-Tests-Core-Data').
	self assert: 'Tools-PointerFinder' equals: (finder baseCategoryNameOf: 'ToolsTest-PointerFinder').
	self deny: ('Zork'  = (finder baseCategoryNameOf: 'Grouik')).
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForASetUpMethodReturnsAllTests [
	self shouldReturnAllTestsFor: #setUp
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForATearDownMethodReturnsAllTests [	
	self shouldReturnAllTestsFor: #tearDown
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForATestCaseMethodReturnsIt [
	| lookupMethod foundMethods thisMethod |
	
	foundMethods := (finder methodsFor: thisContext method).
	self assert: foundMethods size equals: 1.
	
	self
		assert: foundMethods first
		equals:  thisContext method.
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForATestedMethodReturnsSenders [
	| lookupMethod foundMethods thisMethod |
	
	lookupMethod := (AutotestFinder>>#methodsFor:).
	foundMethods := (finder methodsFor: lookupMethod).

	self assert: (foundMethods includes: thisContext method).
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForLastHeuristicReturnsAllTestWhichReferenceTheClass [
	| myTestMethods foundMethods |
	myTestMethods := self class allTestMethods asOrderedCollection.
	foundMethods := finder methodsFor: (finder class>>'baseCategoryNameOfMethod:' asSymbol).
	self assert: foundMethods equals: myTestMethods.
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForReturnsTestCaseOfSamePackage [
	| lookupMethod foundMethods thisMethod allMethods otherPackages thisPackage |
	
	thisPackage := thisContext methodClass package.
	lookupMethod := (AutotestFinder>>#allSendersOf:).
	 
	"Check that allSendersOf: actually returns methods from other packages than Autotest"
	allMethods := finder allSendersOf: lookupMethod.
	otherPackages := (allMethods reject: 
								[:aMethod|  
								 aMethod methodClass package = thisPackage]).
	
	self assert: (otherPackages size > 0).
	
	"Now check methodsFor: filter found tests to returns only those which belongs to same package"
	foundMethods := finder methodsFor: lookupMethod.
	foundMethods do: [:aMethod|
						self 
							assert: aMethod methodClass package
							equals: thisPackage].
]
