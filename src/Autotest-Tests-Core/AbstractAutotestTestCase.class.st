Class {
	#name : #AbstractAutotestTestCase,
	#superclass : #TestCase,
	#category : #'Autotest-Tests-Core'
}

{ #category : #'as yet unclassified' }
AbstractAutotestTestCase >> tearDown [ 
	AutotestListener allInstancesDo: [:anAutotestListener| anAutotestListener noMoreNotifications].
	super tearDown.   
]
