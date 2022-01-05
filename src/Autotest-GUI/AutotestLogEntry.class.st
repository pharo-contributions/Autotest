"
A log entry for Autotest
"
Class {
	#name : #AutotestLogEntry,
	#superclass : #Object,
	#instVars : [
		'time',
		'method',
		'result'
	],
	#category : #'Autotest-GUI-Utilities'
}

{ #category : #accessing }
AutotestLogEntry >> method [
	^ method
]

{ #category : #accessing }
AutotestLogEntry >> method: aCompiledMethod [
	method := aCompiledMethod

]

{ #category : #printing }
AutotestLogEntry >> printOn: aStream [
	aStream 
		nextPutAll: '['; 
		nextPutAll: time asString; 
		nextPutAll:  '] - ';
		nextPutAll: method methodClass asString;
		nextPutAll: '>>';
		nextPutAll: method selector asString;
		nextPutAll: ' - hit count:';
		nextPutAll: result hitCount asString;
		nextPutAll: ' - ';
		nextPutAll: result asString.
		
]

{ #category : #accessing }
AutotestLogEntry >> result [
	^ result
]

{ #category : #accessing }
AutotestLogEntry >> result: aTestResult [
	result := aTestResult

]

{ #category : #accessing }
AutotestLogEntry >> time [
	^ time
]

{ #category : #accessing }
AutotestLogEntry >> time: aTime [
	time := aTime

]
