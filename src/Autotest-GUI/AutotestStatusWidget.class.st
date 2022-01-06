"
I show the number of tests run, fails or errors.
"
Class {
	#name : #AutotestStatusWidget,
	#superclass : #AutotestAbstractWidget,
	#instVars : [
		'result',
		'runLabel',
		'failureLabel',
		'errorLabel',
		'container'
	],
	#category : #'Autotest-GUI-Widgets'
}

{ #category : #'initialize-release' }
AutotestStatusWidget >> initWidgetOn: aDashboard [

	container := PanelMorph new.
	container
		layoutPolicy: TableLayout new;
		listDirection: #bottomToTop;
		layoutInset: 1;
		borderStyle: (SimpleBorder new
				 width: 1;
				 baseColor: Color black).
	aDashboard addMorph: container.

	container addMorph: (runLabel := LabelMorph new).
	container addMorph: (failureLabel := LabelMorph new).
	container addMorph: (errorLabel := LabelMorph new).

	self updateContents
]

{ #category : #accessing }
AutotestStatusWidget >> order [

	^ 2
]

{ #category : #accessing }
AutotestStatusWidget >> result [

	^ result ifNil: [ result := TestResult new ]
]

{ #category : #callbacks }
AutotestStatusWidget >> showMethodModified: aCompiledMethod [

	runLabel contents: 'R: ?'.
	failureLabel contents: 'F: ?'.
	errorLabel contents: 'E: ?'.
	container color: Color transparent
]

{ #category : #callbacks }
AutotestStatusWidget >> showTestResult: aTestResult OfMethod: aCompiledMethod [

	result := aTestResult.
	self updateContents.
	self updateColor
]

{ #category : #updating }
AutotestStatusWidget >> updateColor [

	| color alpha |
	color := self result hasErrors
		         ifTrue: [ Color red ]
		         ifFalse: [ 
			         self result hasFailures
				         ifTrue: [ Color yellow ]
				         ifFalse: [ Color green ] ].

	"Color effect to see that tests has been run"
	alpha := 0.
	[ 
	50 timesRepeat: [ 
		container color: (color alpha: alpha).
		alpha := alpha + 0.02.
		(Delay forMilliseconds: 15) wait ] ] forkAt:
		Processor userBackgroundPriority
]

{ #category : #updating }
AutotestStatusWidget >> updateContents [

	runLabel contents: 'R: ' , self result runCount asString.
	failureLabel contents: 'F: ' , self result failureCount asString.
	errorLabel contents: 'E: ' , self result errorCount asString
]
