"
I'm the dashboard for your developement driving. I displayed several widgets which show the status of your tests
"
Class {
	#name : #AutotestDashboard,
	#superclass : #Object,
	#instVars : [
		'dock',
		'widgets',
		'autotest'
	],
	#classVars : [
		'Default',
		'ShowAutotestDashboard'
	],
	#category : #'Autotest-GUI'
}

{ #category : #twmbar }
AutotestDashboard class >> activeAutotestButtonOn: aBuilder [
	<twmBarButton>
	aBuilder 
		action: [AutotestDashboard showAutotestDashboard: (AutotestDashboard showAutotestDashboard not) ];
		icon: self autotestIcon;
		help: 'Toggle autotest'.
]

{ #category : #twmbar }
AutotestDashboard class >> autotestIcon [ 
	^ ((Morph new
		fillStyle: (CompositeFillStyle fillStyles: {
 					ImageFillStyle form: ( Morph new
											color: Color yellow;
											bounds: (0@0 corner: 16@16)) imageForm.
					ImageFillStyle form: TestRunner taskbarIcon.} ) )
		extent: 16@16) imageForm.
]

{ #category : #actions }
AutotestDashboard class >> close [
	self default close.
	Default := nil.
	Smalltalk garbageCollect.
]

{ #category : #defaults }
AutotestDashboard class >> default [ 
	^ Default ifNil: [Default := self new].
]

{ #category : #actions }
AutotestDashboard class >> open [
	^ self default open.
]

{ #category : #settings }
AutotestDashboard class >> showAutotestDashboard [
	^ ShowAutotestDashboard ifNil: [ShowAutotestDashboard := false].
]

{ #category : #settings }
AutotestDashboard class >> showAutotestDashboard: aBoolean [
	ShowAutotestDashboard := aBoolean.
	ShowAutotestDashboard 
		ifTrue: [self open] 
		ifFalse: [self close].
	^ ShowAutotestDashboard.
]

{ #category : #actions }
AutotestDashboard >> addMorph: aMorph [
	dock addMorph: aMorph.
]

{ #category : #accessing }
AutotestDashboard >> autotest [ 
	^ autotest.
]

{ #category : #actions }
AutotestDashboard >> close [ 
	widgets do: [:aWidget | aWidget dashboardIsClosing].
	self dock delete.
]

{ #category : #actions }
AutotestDashboard >> createWidgets [ 
	widgets := AutotestAbstractWidget subclasses collect: [:aClass | aClass new].
	(widgets sort: [:a :b| a order > b order]) 
		do: [:widget | widget initWidgetOn: self].
	^ widgets.
]

{ #category : #accessing }
AutotestDashboard >> dock [
	^ dock ifNil: [dock := self initializeDock]
]

{ #category : #'initialize-release' }
AutotestDashboard >> initialize [
	autotest := Autotest view: self.
]

{ #category : #'initialize-release' }
AutotestDashboard >> initializeDock [ 
	dock := DashboardMorph new.
	^ dock.
]

{ #category : #actions }
AutotestDashboard >> open [
	self dock 
		openInWorld; 
		left: 0.
	self createWidgets.
]

{ #category : #callbacks }
AutotestDashboard >> showMethodModified: aCompiledMethod [ 
	self widgets do: [:aWidget | aWidget showMethodModified: aCompiledMethod].
]

{ #category : #callbacks }
AutotestDashboard >> showTestResult: aTestResult OfMethod: aCompiledMethod [
	self widgets do: [:aWidget | aWidget showTestResult: aTestResult OfMethod: aCompiledMethod].
]

{ #category : #actions }
AutotestDashboard >> triggerAutotestOn: aCompiledMethod [
	self autotest methodModified: aCompiledMethod
]

{ #category : #actions }
AutotestDashboard >> widgets [ 
	^ widgets ifNil: [ widgets := self createWidgets]
]
