"
I am a simple window for AutotestListener to display test results
"
Class {
	#name : #AutotestView,
	#superclass : #Object,
	#instVars : [
		'listener',
		'contentMorph',
		'window',
		'status',
		'errorList',
		'failureList',
		'result',
		'changedMethod'
	],
	#category : #'Autotest-GUI'
}

{ #category : #'initialize-release' }
AutotestView class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	(aBuilder item: #'Autotest')
			parent: #Tools;
			action:[self open]; 
			help: 'Run tests automatically'.
]

{ #category : #'initialize-release' }
AutotestView class >> open [
	^ self new open; yourself
]

{ #category : #'ui-access' }
AutotestView >> errorList [
	^ (self errors collect: [ :each | each printString ]) asOrderedCollection.
]

{ #category : #'ui-access' }
AutotestView >> errorSelected: anInteger [
	| errorSelected |
	errorSelected := self errors at: anInteger ifAbsent: nil.
	errorSelected ifNotNil: [ errorSelected debug ].
]

{ #category : #accessing }
AutotestView >> errors [
	^ self result errors asArray
]

{ #category : #'ui-access' }
AutotestView >> failedSelected: anInteger [
	| failedSelected |
	failedSelected := self failures at: anInteger ifAbsent: nil.
	failedSelected ifNotNil: [ failedSelected debug ].
]

{ #category : #'ui-access' }
AutotestView >> failureList [
	^ (self failures collect: [ :each | each printString ]) asOrderedCollection.
]

{ #category : #accessing }
AutotestView >> failures [
	^ self result failures asArray
]

{ #category : #ui }
AutotestView >> initWindow [ 
	window := SystemWindow labelled: 'Autotest'.
	window model: self.

	status := PluggableTextMorph on: self text: #statusText  accept: nil.
	errorList := PluggableListMorph on: self list: #errorList selected: nil changeSelected: #errorSelected:.
	failureList := PluggableListMorph on: self list: #failureList selected: nil changeSelected: #failedSelected:.
	window
	 	addMorph: status
		frame: (0.00 @ 0.00 corner: 1.00 @ 0.20);
		addMorph: failureList
		frame: (0.00 @ 0.2 corner: 1.00 @ 0.60);
		addMorph: errorList
		frame:  (0.00 @ 0.60 corner: 1.00 @ 1.00).
	window openInWorld.
]

{ #category : #ui }
AutotestView >> initialExtent [
	^ 800@200
]

{ #category : #ui }
AutotestView >> open [
	self initWindow.
	listener := Autotest view: self.
	listener runInBackground: false.
]

{ #category : #accessing }
AutotestView >> result [ 
	^ result ifNil: [result := TestResult new]
]

{ #category : #callback }
AutotestView >> showMethodModified: aCompiledMethod [ 
	^ self
]

{ #category : #callback }
AutotestView >> showTestResult: aTestResult OfMethod: aCompiledMethod [
	result := aTestResult.
	changedMethod := aCompiledMethod.
	self 
		changed: #errorList;
		changed: #failureList;
		changed: #statusText.
		
	status color: self statusColor.
]

{ #category : #'ui-access' }
AutotestView >> statusColor [
	result hasErrors 
		ifTrue: [ ^ Color red ].
	result hasFailures 
		ifTrue: [ ^ Color yellow ].
	^ Color green
]

{ #category : #'ui-access' }
AutotestView >> statusText [
	| text |
	text :=  changedMethod isNil 
					ifTrue: ['']
					ifFalse: [changedMethod methodClass asString, '>>', changedMethod selector].
	^ text, String cr, self result printString
]
