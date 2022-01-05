Class {
	#name : #AutotestTestFinder,
	#superclass : #AbstractAutotestTestCase,
	#instVars : [
		'finder'
	],
	#category : #'Autotest-Tests-Core-Base'
}

{ #category : #testing }
AutotestTestFinder >> expectedFailures [
	^ (Smalltalk at: #Phexample ifAbsent: nil)   
		ifNil: [#(testMethodsForMethodThatStartWithShouldReturnsIt)]
		ifNotNil: [#()]
]

{ #category : #private }
AutotestTestFinder >> packageOfClass: aClass [
	^ aClass package
]

{ #category : #running }
AutotestTestFinder >> setUp [

	super setUp.
	finder := AutotestFinder new
]

{ #category : #private }
AutotestTestFinder >> shouldBeFound [
	"method used to check that it is found by Autotest"
	self assert: true
]

{ #category : #private }
AutotestTestFinder >> shouldNotBeFound: anArgument [
	"method used to check that is not found by Autotest"
	self assert: true
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
AutotestTestFinder >> testBasePackageName [
	self assert: 'Zork' equals: (finder basePackageNameOf: 'Zork').
	self assert: 'ZorkCore' equals: (finder basePackageNameOf: 'ZorkCore').
	self assert: 'Zork' equals: (finder basePackageNameOf: 'Zork-Core').
	self assert: 'Zork' equals: (finder basePackageNameOf: 'Zork-Tests').
	self assert: 'Zork' equals: (finder basePackageNameOf: 'ZorkTests').
	self assert: 'Zork' equals: (finder basePackageNameOf: 'Tests-Zork').
	self assert: 'Zork' equals: (finder basePackageNameOf: 'Zork-Tests-Core').
	self assert: 'Zork-GUI' equals: (finder basePackageNameOf: 'Zork-Tests-GUI').
	self assert: 'Zork-Core-Data' equals: (finder basePackageNameOf: 'Zork-Tests-Core-Data').
	self assert: 'Tools-PointerFinder' equals: (finder basePackageNameOf: 'ToolsTest-PointerFinder').
	self deny: ('Zork'  = (finder basePackageNameOf: 'Grouik')).
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
	foundMethods := finder methodsFor: (finder class>>'basePackageNameOfMethod:' asSymbol).
	self assert: foundMethods equals: myTestMethods.
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForMethodThatHasAnArgumentShouldNotReturnIt [
		| lookupMethod foundMethods thisMethod |
	
	lookupMethod := (self class>>#shouldNotBeFound:).
	foundMethods := (finder methodsFor: lookupMethod).

	self deny: (foundMethods includes: lookupMethod).
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForMethodThatStartWithShouldReturnsIt [
		| lookupMethod foundMethods thisMethod |
	
	lookupMethod := (self class>>#shouldBeFound).
	foundMethods := (finder methodsFor: lookupMethod).

	self assert: (foundMethods includes: lookupMethod).
]

{ #category : #tests }
AutotestTestFinder >> testMethodsForReturnsTestCaseOfSamePackage [
	| lookupMethod foundMethods thisMethod allMethods otherPackages thisPackage |
	
	thisPackage := self packageOfClass: thisContext methodClass.
	lookupMethod := (AutotestFinder>>#allSendersOf:).
	 
	"Check that allSendersOf: actually returns methods from other packages than Autotest"
	allMethods := finder allSendersOf: lookupMethod.
	otherPackages := (allMethods reject: 
								[:aMethod|  
								thisPackage = (self packageOfClass: aMethod methodClass)]).
	
	self assert: (otherPackages size > 0).
	
	"Now check methodsFor: filter found tests to returns only those which belongs to same package"
	foundMethods := finder methodsFor: lookupMethod.
	foundMethods do: [:aMethod|
						self 
							assert: (self packageOfClass: aMethod methodClass)
							equals: thisPackage].
]
