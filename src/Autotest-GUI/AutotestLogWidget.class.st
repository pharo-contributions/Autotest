"
I log runned test in a list and can show them in a window
"
Class {
	#name : #AutotestLogWidget,
	#superclass : #AutotestAbstractWidget,
	#instVars : [
		'status',
		'buttonState',
		'buttonLabel',
		'window',
		'maxsize',
		'selectedLog',
		'logs',
		'selectedTest'
	],
	#category : #'Autotest-GUI-Widgets'
}

{ #category : #accessing }
AutotestLogWidget >> buttonAction [
	self window isInWorld 
		ifTrue: [self window delete. self buttonState: false.]
		ifFalse: [self window openInWorld. self buttonState: true.]
]

{ #category : #accessing }
AutotestLogWidget >> buttonLabel [
	^ buttonLabel ifNil: [
		AlphaImageMorph withForm: 
			(Form
				extent: 16@16
				depth: 32
				fromArray: #( 16777215 1221578703 4290939748 4290672713 4290404648 905969664 905969664 905969664 905969664 905969664 905969664 905969664 905969664 905969664 905969664 536870912 785371087 4107062476 4291479492 4291676097 4290273063 4294769916 4294769916 4294769916 4294769916 4294769916 4294769916 4294769916 4294769916 4294769916 4294769916 905969664 108558456 1622258097 4290348903 4291140199 4290272807 4294440951 4294440951 4294440951 4294440951 4294309365 4294243572 4294243572 4294243572 4294111986 4294704123 905969664 785371087 4107062476 4291479492 4291676096 4290206502 4294440951 4294440951 4294440951 4294440951 4294440951 4294309365 4294309365 4294309365 4294177779 4294638330 905969664 108558456 1622258097 4290216807 4291074406 4290205990 4294506744 4294506744 4286227937 4286096353 4286030817 4285965024 4285964512 4285833440 4294243572 4294638330 905969664 785371087 4107062476 4291479236 4291676096 4290074150 4294572537 4294572537 4286096353 4288921834 4288856298 4288790506 4288724714 4285636319 4294243572 4294440951 905969664 108558456 1622258097 4290085478 4291008101 4290008357 4294638330 4294638330 4285965024 4285964512 4285833440 4285767391 4285701340 4285504476 4294111986 4260820726 905969664 785371087 4107062476 4291479236 4291676096 4289876517 4294704123 4294638330 4294506744 4294506744 4294506744 4294440951 4294177779 4294111986 4293980400 4109299438 855638016 108558456 1622258097 4290084709 4290942052 4289876260 4294638330 4294506744 4285767648 4285636061 4285438684 4285241818 4285176025 4285174740 4293585642 4293717228 905969664 785371087 4107062476 4291479236 4291675840 4289809955 4294638330 4294572537 4294506744 4294440951 4294375158 4294638330 4294638330 4294638330 4294111986 4291940817 939721475 108558456 1622258097 4289952868 4290876003 4289678115 4294572537 4294572537 4294572537 4294375158 4294177779 4294638330 4294638330 4294111986 4291414473 4293454056 905969664 785371087 4107062476 4291479236 4291610304 4289612066 4294638330 4294638330 4294506744 4294243572 4294046193 4294704123 4294111986 4291480266 4293322470 4294769916 905969664 108558456 1622258097 4289952099 4290744161 4289611298 4294638330 4294638330 4294375158 4294177779 4293848814 4294177779 4291480266 4293322470 4294704123 4294769916 905969664 785371087 4107062476 4291479236 4291610304 4289479457 4294835709 4294704123 4294506744 4294243572 4293783021 4292203989 4293519849 4294967295 4294967295 4294967295 905969664 108558456 561280116 4289022764 4289682741 4289413665 4292664540 4292401368 4292138196 4292006610 4291940817 4292072403 4291940817 4291546059 4291677645 4291282887 905969664 16777215 16777215 1063265554 2172530968 1684219411 905969664 905969664 905969664 905969664 905969664 905969664 905969664 905969664 905969664 905969664 536870912)
				offset: 0@0).
		]
]

{ #category : #accessing }
AutotestLogWidget >> buttonLabel: aLabel [
	buttonLabel := aLabel
]

{ #category : #accessing }
AutotestLogWidget >> buttonState [
	^ buttonState
]

{ #category : #accessing }
AutotestLogWidget >> buttonState: aBoolean [
	buttonState := aBoolean 
]

{ #category : #'ui-access' }
AutotestLogWidget >> changedMethodSelected: anInteger [
	selectedLog := self logs at: anInteger.
	self changed: #runTests.
]

{ #category : #'initialize-release' }
AutotestLogWidget >> dashboardIsClosing [
	self window isInWorld 
		ifTrue: [self window delete. 
				self buttonState: false.
				window := nil.]
]

{ #category : #'gui building' }
AutotestLogWidget >> initChangedMethodList [ 
	| listMorph |
	listMorph := PluggableListMorph 
			on: self
			list: #logs
			selected: #selectedLog
			changeSelected: #logEntrySelected:.
	^ listMorph 
		hResizing: #spaceFill; 
		vResizing: #spaceFill;
		yourself.
					
]

{ #category : #'gui building' }
AutotestLogWidget >> initRunTestList [ 
	| listMorph |
	listMorph := PluggableListMorph 
			on: self 
			list: #runTests
			selected: #selectedTest
			changeSelected: #selectedTestChanged:.
	^ listMorph 
		hResizing: #spaceFill; 
		vResizing: #spaceFill;
		yourself.
					
]

{ #category : #'initialize-release' }
AutotestLogWidget >> initWidgetOn: aDashboard [
	| button  |
	self buttonState: false.
	button := ControlButtonMorph on: self getState: #buttonState action: #buttonAction label: #buttonLabel.
	aDashboard addMorph: button.
]

{ #category : #'gui building' }
AutotestLogWidget >> initWindow [ 
	| container |
	
	container := Morph new
		layoutPolicy: TableLayout new;
		addMorph: self initRunTestList;
		addMorph: (LabelMorph contents: 'Triggered tests');
		addMorph: self initChangedMethodList.

	window := StandardWindow labelled: 'Autotest Log'.
	window 
		model: self; 
		addMorph: (container) frame: (0@0 corner: 1@1).
		
	^ window
]

{ #category : #'ui-access' }
AutotestLogWidget >> logEntrySelected: anInteger [
	
	[selectedLog := self logs at: anInteger]
		on:Error do: [selectedLog := nil].
	self 
		changed: #runTests;
		changed: #selectedLog.
]

{ #category : #'ui-access' }
AutotestLogWidget >> logs [
	^ logs ifNil: [logs := OrderedCollection new].
]

{ #category : #accessing }
AutotestLogWidget >> maxsize [
	^ maxsize ifNil: [maxsize := 10]
]

{ #category : #accessing }
AutotestLogWidget >> maxsize: anInteger [
	maxsize := anInteger

]

{ #category : #accessing }
AutotestLogWidget >> order [
	^ 4
]

{ #category : #'ui-access' }
AutotestLogWidget >> runTests [
	^  selectedLog isNil
		ifTrue: [{}]
		ifFalse: [selectedLog result defects,
				selectedLog result passed].
]

{ #category : #'ui-access' }
AutotestLogWidget >> selectedLog [ 
	selectedLog ifNil: [^ 0].
	^ logs indexOf: selectedLog.
]

{ #category : #'ui-access' }
AutotestLogWidget >> selectedTest [
	selectedTest ifNil: [^ 0].
	^ self runTests indexOf: selectedTest.
]

{ #category : #'ui-access' }
AutotestLogWidget >> selectedTestChanged: anInteger [
	[selectedTest := self runTests at: anInteger]
		on:Error do: [selectedTest := nil].
	self changed: #selectedTest.
	selectedTest ifNotNil: [Smalltalk tools browser fullOnClass:  (selectedTest class) selector: selectedTest selector].
]

{ #category : #callbacks }
AutotestLogWidget >> showTestResult: aTestResult OfMethod: aCompiledMethod [
	| logEntry |
	logEntry := AutotestLogEntry new.
	logEntry time: Time now; 
		method: aCompiledMethod; 
		result: aTestResult.

	(self logs size = self maxsize) ifTrue: [self logs removeLast].
	self logs addFirst: logEntry.
	self changed: #logs.
]

{ #category : #accessing }
AutotestLogWidget >> window [
	^ window ifNil: [	self initWindow]

]

{ #category : #updating }
AutotestLogWidget >> windowIsClosing [
	window := nil.
	self buttonState: false;
		changed: #buttonState.
]
