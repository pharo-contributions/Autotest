Class {
	#name : #AutotestTestHitCounter,
	#superclass : #AbstractAutotestTestCase,
	#instVars : [
		'counter'
	],
	#category : #'Autotest-Tests-Core'
}

{ #category : #running }
AutotestTestHitCounter >> setUp [
	self assert: 'zork' equals: self zork.	
	counter := AutotestHitCounter on: (self class>>#zork).
]

{ #category : #running }
AutotestTestHitCounter >> tearDown [
	counter uninstall.
	super tearDown.
]

{ #category : #tests }
AutotestTestHitCounter >> testHitCountIncrements [
	self zork.
	self assert: counter hitCount equals: 1.
	
	self zork.
	self assert: counter hitCount equals: 2.
	
	self zork; zork.
	self assert: counter hitCount equals: 4.
]

{ #category : #tests }
AutotestTestHitCounter >> testHitCountIsZeroBeforeCall [
	self assert: counter hitCount equals: 0.
]

{ #category : #tests }
AutotestTestHitCounter >> testMethodIsWrapped [
	self assert: (self class>>#zork) class equals: AutotestHitCounter.
]

{ #category : #tests }
AutotestTestHitCounter >> testWrappedMethodIsExecuted [
	self assert: 'zork' equals: self zork.
]

{ #category : #mock }
AutotestTestHitCounter >> zork [
	^ 'zork'
]
