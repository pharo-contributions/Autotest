"
Test that Autotest search and run tests in a background thread
"
Class {
	#name : #AutotestTestOneLongRun,
	#superclass : #AbstractAutotestTestLongRun,
	#category : #'Autotest-Tests-Core'
}

{ #category : #running }
AutotestTestOneLongRun >> setUp [

	super setUp.
	self deny: (AutotestTestMockTestCase>>#testLongMethod) class = AutotestHitCounter.
	autotest methodModified: (AutotestTestMockTestCase>>#testLongMethod)
]

{ #category : #tests }
AutotestTestOneLongRun >> testResultHitCountEqualsOne [
	(Delay forMilliseconds: 1000) wait.
	self deny: givenResult isNil.
	self assert: 1 equals: givenResult hitCount.
]

{ #category : #tests }
AutotestTestOneLongRun >> testRunInBackground [
	self  assert: self showTestResultCallCount equals: 0.
	(Delay forMilliseconds: 1000) wait.
	self  assert: self showTestResultCallCount equals: 1.
]

{ #category : #tests }
AutotestTestOneLongRun >> testShowMethodModifiedCalledBeforeTest [
	self assert: showMethodModifiedCalled.
]
