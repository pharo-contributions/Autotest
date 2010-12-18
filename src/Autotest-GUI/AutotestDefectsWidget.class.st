"
I list failing tests and open debugger for the selected test
"
Class {
	#name : #AutotestDefectsWidget,
	#superclass : #AutotestAbstractWidget,
	#instVars : [
		'status',
		'result'
	],
	#category : #'Autotest-GUI'
}

{ #category : #callbacks }
AutotestDefectsWidget >> defectList [
	^ (self defects collect: [ :aTestCase | 
							 aTestCase printString, ': ',
							 (result signalFor: aTestCase) asString]) asOrderedCollection.
]

{ #category : #callbacks }
AutotestDefectsWidget >> defectSelected: anInteger [
	| errorSelected |
	errorSelected := self defects at: anInteger ifAbsent: nil.
	errorSelected ifNotNil: [ errorSelected debug ].
]

{ #category : #accessing }
AutotestDefectsWidget >> defects [
	^ self result defects asArray
]

{ #category : #'initialize-release' }
AutotestDefectsWidget >> initWidgetOn: aDashboard [
	| listMorph |
	listMorph := PluggableListMorph 
		on: self 
		list: #defectList 
		selected: nil 
		changeSelected: #defectSelected:.
	listMorph hResizing: #spaceFill.
	aDashboard addMorph: listMorph..
]

{ #category : #accessing }
AutotestDefectsWidget >> order [
	^ 3
]

{ #category : #accessing }
AutotestDefectsWidget >> result [ 
	^ result ifNil: [result := TestResult new]
]

{ #category : #callbacks }
AutotestDefectsWidget >> showTestResult: aTestResult OfMethod: aCompiledMethod [
	result := aTestResult.
	self changed: #defectList.
]
