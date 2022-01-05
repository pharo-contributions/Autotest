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
AutotestListener >> event: anAnnouncement [
	"When an announcement is received, notify the receiver"
	receiver ifNil: [^ self].
	methodModifedSelector ifNil: [^ self].
	
	receiver perform: methodModifedSelector with: anAnnouncement newMethod.
	
]

{ #category : #'initialize-release' }
AutotestListener >> initialize [ 
	self installSystemNotifications
]

{ #category : #'system changes' }
AutotestListener >> installSystemNotifications [
	"Listen all modified and added methods"
	SystemAnnouncer uniqueInstance weak
	  when: MethodAdded send: #methodAdded: to: self;
	  when: MethodModified send: #methodModified: to: self.
]

{ #category : #'system changes' }
AutotestListener >> methodAdded: anAnnouncement [
	"When an announcement is received, notify the receiver"
	receiver ifNil: [^ self].
	methodModifedSelector ifNil: [^ self].
	
	receiver perform: methodModifedSelector with: anAnnouncement method.
	
]

{ #category : #'system changes' }
AutotestListener >> methodModified: anAnnouncement [
	"When an announcement is received, notify the receiver"
	receiver ifNil: [^ self].
	methodModifedSelector ifNil: [^ self].
	
	receiver perform: methodModifedSelector with: anAnnouncement newMethod.

]

{ #category : #accessing }
AutotestListener >> methodModifiedSelector: aSelector [
	"The message to send on the receiver when a method is changed in the system"
	methodModifedSelector := aSelector 
]

{ #category : #'system changes' }
AutotestListener >> noMoreNotifications [
	"Do not receiver any system change notification anymore"
	SystemAnnouncer uniqueInstance unsubscribe: self.
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
