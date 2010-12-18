Class {
	#name : #HelpOnAutotest,
	#superclass : #CustomHelp,
	#category : #'Autotest-Help'
}

{ #category : #pages }
HelpOnAutotest class >> activation [
	^ HelpTopic
		title: 'Activation'
		contents: 'To activate the Autotest dashboard:
		- open the settings browser
		- go under System
		- check "Show Autotest Dashboard" option'
]

{ #category : #accessing }
HelpOnAutotest class >> bookName [
	^ 'Autotest: live testing tool'
]

{ #category : #pages }
HelpOnAutotest class >> heuristics [
	^ HelpTopic
		title: 'Heuristics'
		contents: 'Autotest uses the following heuristics to find the tests to run. The first one that find test methods is used
		- if the method is a test, runs it
		- if the method is a test setUp or tearDown, run all the tests of the TestCase
		- find all senders which are tests in the same package and runs them
		- search TestCases which reference the changed method class and run all of them '
]

{ #category : #pages }
HelpOnAutotest class >> introduction [
	^ HelpTopic
		title: 'Introduction'
		contents: 'Unit tests represents the security belt of software development. But having a security belt doesn''t mean it''s always fastened. You take a look at a piece code, have fun hacking it, submit the new code without checking all tests are green... it''s easy to forgot there''s tests here. Autotest automatically runs tests for you.

Test Driven Development ensures test exhaustivity, reflexion on design and so on. You stop and run tests very often to check the health of your code. In your car you don''t stop driving, hands off the wheel in order to check the speed. Autotest provides a real time dashboard so you don''t stop coding.

Testing is always here. Now you can drive.'
]

{ #category : #accessing }
HelpOnAutotest class >> key [
	^ 'Autotest'
]

{ #category : #accessing }
HelpOnAutotest class >> pages [
	^ #(introduction
		activation
		heuristics)
]
