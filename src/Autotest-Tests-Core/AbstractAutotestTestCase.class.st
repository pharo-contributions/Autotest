Class {
	#name : #AbstractAutotestTestCase,
	#superclass : #TestCase,
	#category : #'Autotest-Tests-Core'
}

{ #category : #running }
AbstractAutotestTestCase >> tearDown [

	AutotestListener allInstancesDo: [:anAutotestListener| anAutotestListener noMoreNotifications].
	super tearDown 
]
