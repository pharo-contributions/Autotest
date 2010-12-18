"
I run automatically needed tests when a method is changed.

I create a Listener to detect test, use Finder to know which tests has to be run and give them to a Runner.
"
Class {
	#name : #Autotest,
	#superclass : #Object,
	#instVars : [
		'view',
		'runner',
		'listener',
		'currentTestThread',
		'finder',
		'runInBackground'
	],
	#category : #'Autotest-Core'
}

{ #category : #'initialize-release' }
Autotest class >> view: aView [
	"see instance side"
	^ self new view: aView.
]

{ #category : #private }
Autotest >> findRunAndShowTestsOf:  changedMethod [
	| testMethods aTestResult counter |
	"Finds the test related to changedMethod, run them and tell the view to update"
	testMethods := finder methodsFor: changedMethod.
	
	counter := AutotestHitCounter on: changedMethod.
	[aTestResult := runner run: testMethods] 
		ensure: [counter uninstall].
	aTestResult hitCount: counter hitCount.
	
	self view ifNotNil: 	
				[ self view 
					showTestResult: aTestResult 
					OfMethod: changedMethod.]
]

{ #category : #'initialize-release' }
Autotest >> initialize [
	runInBackground := true.
	listener := AutotestListener on: self methodModified: #methodModified:.
	finder := AutotestFinder new.
	runner := AutotestRunner new.
]

{ #category : #callbacks }
Autotest >> methodModified:  changedMethod [
	"A method has been modified (callback from AutotestListener). It needs:
	- to find tests to run, related to changedMethod 
	- run the tests
	- tell the view to update
	Find and Run is done in a background thread, only once at the same time (each new changeMethod is rejected while current thread is not finished)
	Note the current thread may be suspended (when a halt is encountered, debugger abondonned.)
	"
	
	"Case when the wrapped method is a sender of another method which is 
	programmatically modified => loop. So ignore them"
	(changedMethod isKindOf: AutotestHitCounter) ifTrue: [^ self].

	"Only one thread at once as we can have infinite loop for an equivalent
	case as above"
	currentTestThread ifNotNil: 
		[currentTestThread isActiveProcess 
									ifFalse: [currentTestThread terminate]
		 							ifTrue: [^ self]].
	self view showMethodModified: changedMethod.

	"Only for debugging"
	runInBackground ifFalse: [^ self findRunAndShowTestsOf: changedMethod.].
	
	"The real one"
	currentTestThread := [self findRunAndShowTestsOf: changedMethod.
						     currentTestThread := nil.
						   ] forkAt: Processor userBackgroundPriority
]

{ #category : #debugging }
Autotest >> runInBackground: aBoolean [
	"If true (default), create a thread for tests search and run. 
	You can deactivate this for debugging purposes"
	runInBackground := aBoolean
]

{ #category : #actions }
Autotest >> start [ 
	listener installSystemNotifications.
]

{ #category : #actions }
Autotest >> stop [
	listener noMoreNotifications.
]

{ #category : #accessing }
Autotest >> view [
	^ view
]

{ #category : #accessing }
Autotest >> view: aView [
	"The view must implements:
	- showMethodModified: called when a method is added or modified
	- showTestResult:OfMethod: called when tests has been run. See AutotestDashboard or AutotestView for an implementation example"
	view := aView
]
