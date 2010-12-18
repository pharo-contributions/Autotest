"
AutotestListener runs automatically all tests which are senders of the method you just saved
"
Class {
	#name : #AutotestListener,
	#superclass : #Object,
	#instVars : [
		'view',
		'searcher',
		'receiver',
		'methodModifedSelector'
	],
	#category : #'Autotest-Core'
}

{ #category : #'initialize-release' }
AutotestListener class >> on: receiver methodModified: methodModifiedSelector [
	^ self new on: receiver methodModified: methodModifiedSelector
]

{ #category : #'system changes' }
AutotestListener >> event: anEvent [
	"When an event is received, notify the receiver"
	| testMethods aTestResult changedMethod |
	
	(anEvent item isKindOf: CompiledMethod) ifFalse: [^ self].
	receiver ifNil: [^ self].
	methodModifedSelector ifNil: [^ self].
	
	receiver perform: methodModifedSelector with: anEvent item.
	
]

{ #category : #'initialize-release' }
AutotestListener >> initialize [ 
	self installSystemNotifications
]

{ #category : #'system changes' }
AutotestListener >> installSystemNotifications [
	"Listen all modified and added methods"
	| events notifier|
	notifier := SystemChangeNotifier uniqueInstance.
	events := OrderedCollection new.
	#(Modified Added) do: 
		[:anEventKind|
		events addAll: (notifier systemEventsForChange: anEventKind).].
	
	notifier
		notify: self
		ofEvents: events
		using: #event:
]

{ #category : #accessing }
AutotestListener >> methodModifiedSelector: aSelector [
	"The message to send on the receiver when a method is changed in the system"
	methodModifedSelector := aSelector 
]

{ #category : #'system changes' }
AutotestListener >> noMoreNotifications [
	"Do not receiver any system change notification anymore"
	SystemChangeNotifier uniqueInstance noMoreNotificationsFor: self

]

{ #category : #'initialize-release' }
AutotestListener >> on: anObject methodModified: aSelector [
	"Initialize which receiver and which message to send on an event"
	self 
		receiver: anObject;
		methodModifiedSelector: aSelector.
]

{ #category : #accessing }
AutotestListener >> receiver: anObject [
	"Initialize the object to notify when an event is received"
	receiver := anObject.
]

{ #category : #'initialize-release' }
AutotestListener >> release [ 
	self noMoreNotifications

]
