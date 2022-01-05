Class {
	#name : #AutotestRunnerTestErrorOnTestRessource,
	#superclass : #AbstractAutotestTestCase,
	#instVars : [
		'runner'
	],
	#classInstVars : [
		'resources'
	],
	#category : #'Autotest-Tests-Core'
}

{ #category : #'as yet unclassified' }
AutotestRunnerTestErrorOnTestRessource class >> resources [
	| current |
	current := resources ifNil: [#()].
	resources := #().
	
	^ current.
]

{ #category : #'as yet unclassified' }
AutotestRunnerTestErrorOnTestRessource class >> resources: aCollection [
	resources := aCollection.
]

{ #category : #handling }
AutotestRunnerTestErrorOnTestRessource >> pass [
	self assert: true
]

{ #category : #running }
AutotestRunnerTestErrorOnTestRessource >> setUp [

	super setUp.
	runner := AutotestRunner new
]

{ #category : #tests }
AutotestRunnerTestErrorOnTestRessource >> testWithAvailableRessource [
	| result |
	self class resources:  {MockAutotestAvailableResource}.
	result := runner run: {self class>>#pass}.
	
	self assert: 1 equals: result passedCount.
	self assert: 0 equals: result errorCount.
]

{ #category : #tests }
AutotestRunnerTestErrorOnTestRessource >> testWithUnavailableRessource [
	| result |
	self class resources: {MockAutotestUnavailableResource}.
	result := runner run: {self class>>#pass}.
	
	self assert: 1 equals: result errorCount.
	self assert: 0 equals: result passedCount.
]
