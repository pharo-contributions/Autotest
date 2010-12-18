Class {
	#name : #AutotestTestTwoLongRun,
	#superclass : #AbstractAutotestTestLongRun,
	#category : #'Autotest-Tests-Core'
}

{ #category : #tests }
AutotestTestTwoLongRun >> testRunOneThreadAtTheSameTime [
	autotest methodModified: (AutotestTestMockTestCase>>#testSuccess).
	autotest methodModified: (AutotestTestMockTestCase>>#testSuccess).
	self  assert: self showTestResultCallCount equals: 0.

	(Delay forMilliseconds: 1000) wait.
	self  assert: self showTestResultCallCount equals: 1.

]
