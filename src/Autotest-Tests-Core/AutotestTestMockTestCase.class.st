Class {
	#name : #AutotestTestMockTestCase,
	#superclass : #AbstractAutotestTestCase,
	#category : #'Autotest-Tests-Core'
}

{ #category : #mock }
AutotestTestMockTestCase >> longMethod [
	(Delay forMilliseconds: 250) wait.
	self assert: true.
]

{ #category : #mock }
AutotestTestMockTestCase >> testForZork1 [
	self zorky
]

{ #category : #mock }
AutotestTestMockTestCase >> testForZork2 [
	self zorky
]

{ #category : #mock }
AutotestTestMockTestCase >> testLongMethod [
	self longMethod
]

{ #category : #mock }
AutotestTestMockTestCase >> testSuccess [
	self assert: true
]

{ #category : #mock }
AutotestTestMockTestCase >> zorky [
	^ self
]
