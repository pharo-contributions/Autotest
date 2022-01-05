Class {
	#name : #AutotestTestRunner,
	#superclass : #AbstractAutotestTestCase,
	#category : #'Autotest-Tests-Core-Base'
}

{ #category : #private }
AutotestTestRunner >> error [

	'grouik' notUnderstood
]

{ #category : #private }
AutotestTestRunner >> fail [

	self assert: false
]

{ #category : #private }
AutotestTestRunner >> success [

	self assert: true
]

{ #category : #tests }
AutotestTestRunner >> testRunExecuteTestsAndReturnResult [

	| testMethods runner testResult |
	testMethods := #( success fail error ) collect: [ :aSelector | 
		               self class >> aSelector ].
	runner := AutotestRunner new.
	testResult := runner run: testMethods.

	self assert: testResult runCount equals: 3.
	self assert: testResult errorCount equals: 1.
	self assert: testResult failureCount equals: 1
]
