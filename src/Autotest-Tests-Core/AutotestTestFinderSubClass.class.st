Class {
	#name : #AutotestTestFinderSubClass,
	#superclass : #AutotestTestFinder,
	#category : #'Autotest-Tests-Core'
}

{ #category : #private }
AutotestTestFinderSubClass >> setUp [
	super setUp
	
]

{ #category : #tests }
AutotestTestFinderSubClass >> testMethodsForASetUpMethodReturnsAllTestsAndSubClass [
	self shouldReturnAllTestsFor: #setUp
]
