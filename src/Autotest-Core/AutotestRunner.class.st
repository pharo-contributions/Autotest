"
I run a bunch of tests for Autotest
"
Class {
	#name : #AutotestRunner,
	#superclass : #Object,
	#category : #'Autotest-Core'
}

{ #category : #testing }
AutotestRunner >> run: listOfTestMethods [
	"Build and runs the TestCase for this method, answers the result"
	| aTestResult |
	aTestResult := AutotestResult new.
	listOfTestMethods do: [:aCompiledMethod|
					   		self runTest: aCompiledMethod result: aTestResult.].
	^ aTestResult.
						
]

{ #category : #testing }
AutotestRunner >> runTest: aCompiledMethod result: aTestResult [
	"Build and run the TestCase for this method, result put in given TestResult"
	| aTestCase |
	 aCompiledMethod methodClass isAbstract ifTrue: [^ aTestResult].
	aTestCase := aCompiledMethod methodClass selector: aCompiledMethod selector.
	
	[	aTestCase resources do: [ :each |
			each isAvailable
				ifFalse: [ self signal:  'Resource ' ,  each name , ' could not be initialized' ] ].
	
		[aTestCase run: aTestResult.] 
			ensure: [ aTestCase resources do: [ :each | each reset ]].
		
	] on: Error do: [:signal|
					aTestResult addError: aTestCase signal: signal. 
					signal return: false].
		
	^ aTestResult.
]
