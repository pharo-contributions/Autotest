Class {
	#name : #AutotestTestListener,
	#superclass : #AbstractAutotestTestCase,
	#instVars : [
		'methodModifiedCalled',
		'listener'
	],
	#category : #'Autotest-Tests-Core'
}

{ #category : #callbacks }
AutotestTestListener >> aMethodToChange [
						^ self
]

{ #category : #callbacks }
AutotestTestListener >> methodModified: aCompiledMethod [
	methodModifiedCalled := true.
]

{ #category : #running }
AutotestTestListener >> setUp [

	listener := AutotestListener on: self methodModified: #methodModified:.
	methodModifiedCalled := false
]

{ #category : #running }
AutotestTestListener >> tearDown [

	listener receiver: nil.
	listener := nil.
	self class removeSelector: #newMethod.
	Smalltalk garbageCollectMost.
	(Delay forMilliseconds: 200) wait.
	super tearDown
]

{ #category : #tests }
AutotestTestListener >> testCallbackOnAddedMethod [	
	self class
		compile: 'newMethod
						^ self'
		classified: 'callbacks'.
		
	self assert: methodModifiedCalled.
]

{ #category : #tests }
AutotestTestListener >> testCallbackOnModifiedMethod [
	self class
		compile: 'aMethodToChange
						^ self'
		classified: 'callbacks'.
		
	self assert: methodModifiedCalled.
]
