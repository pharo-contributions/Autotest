Class {
	#name : #AutotestTestMethodWithTwoTests,
	#superclass : #AbstractAutotestTestLongRun,
	#category : #'Autotest-Tests-Core'
}

{ #category : #'as yet unclassified' }
AutotestTestMethodWithTwoTests >> testHitCountEqualsTwo [
	autotest methodModified: (
		(Smalltalk at: ('AutotestTestMockTestCase') asSymbol)  
			lookupSelector: 'zorky' asSymbol).
	(Delay forMilliseconds: 1000) wait.
	self deny: givenResult isNil.
	self assert: 2 equals: givenResult hitCount.
]
