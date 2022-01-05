Class {
	#name : #AutotestTestResult,
	#superclass : #AbstractAutotestTestCase,
	#category : #'Autotest-Tests-Core-Base'
}

{ #category : #mock }
AutotestTestResult >> error [
	'grouik' notUnderstood.
]

{ #category : #tests }
AutotestTestResult >> testRememberSignals [
	| result testCase |
	result := AutotestResult new.
	testCase := self class selector: #error.
	result runCase: testCase.
	
	self assert:  ((result signalFor: testCase) isKindOf: Error).
	
]
