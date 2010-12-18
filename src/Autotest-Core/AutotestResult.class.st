"
I'm a TestResult who remembers why the tests have failed (store the Error objects)
"
Class {
	#name : #AutotestResult,
	#superclass : #TestResult,
	#instVars : [
		'signals',
		'hitCount'
	],
	#category : #'Autotest-Core'
}

{ #category : #accessing }
AutotestResult >> addError: aTestCase signal: anError [
	errors add: aTestCase.
	self signalFor: aTestCase Is: anError. 
]

{ #category : #accessing }
AutotestResult >> addFailure: aTestCase signal: anError [
	failures add: aTestCase.
	self signalFor: aTestCase Is: anError. 
]

{ #category : #accessing }
AutotestResult >> hitCount [ 
	^ hitCount ifNil: [hitCount := 0]
]

{ #category : #accessing }
AutotestResult >> hitCount: anInteger [
	hitCount := anInteger.
]

{ #category : #running }
AutotestResult >> runCase: aTestCase [
	| testCasePassed |
	testCasePassed := true.
	[[aTestCase runCase] 
			on: self class failure
			do: 
				[:signal | 
				self addFailure: aTestCase signal: signal. 
				testCasePassed := false.
				signal return: false]]
					on: self class error
					do:
						[:signal |
						self addError: aTestCase signal: signal. 
						testCasePassed := false.
						signal return: false].
	testCasePassed ifTrue: [passed add: aTestCase]
]

{ #category : #accessing }
AutotestResult >> signalFor: aTestCase [
	"Answers the Error associated with this failing TestCase"
	^ self signals at: aTestCase.
]

{ #category : #accessing }
AutotestResult >> signalFor: aTestCase Is: aSignal [
	"Store the error which causes the test to fail"
	self signals at: aTestCase put: aSignal.
]

{ #category : #accessing }
AutotestResult >> signals [
	"All failed TestCases errors"
	^ signals ifNil: [signals := Dictionary new].
]
