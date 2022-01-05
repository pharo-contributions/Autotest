Class {
	#name : #AutotestTestFinderSubClass,
	#superclass : #AutotestTestFinder,
	#category : #'Autotest-Tests-Core-Base'
}

{ #category : #running }
AutotestTestFinderSubClass >> setUp [

	super setUp
]

{ #category : #tests }
AutotestTestFinderSubClass >> testMethodsForASetUpMethodReturnsAllTestsAndSubClass [

	self shouldReturnAllTestsFor: #setUp
]
