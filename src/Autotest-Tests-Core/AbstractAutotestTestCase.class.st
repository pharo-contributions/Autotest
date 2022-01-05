Class {
	#name : #AbstractAutotestTestCase,
	#superclass : #TestCase,
	#category : #'Autotest-Tests-Core'
}

{ #category : #testing }
AbstractAutotestTestCase class >> isAbstract [
		
	^ self == AbstractAutotestTestCase
]

{ #category : #running }
AbstractAutotestTestCase >> tearDown [

	AutotestListener allInstancesDo: [:anAutotestListener| anAutotestListener noMoreNotifications].
	super tearDown 
]
