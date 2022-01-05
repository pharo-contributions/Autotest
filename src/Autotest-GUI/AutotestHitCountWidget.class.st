"
I'm a method wrapper which counts how many times a methods has been called in a running test.

Used to check that tests run cover the modified method.
"
Class {
	#name : #AutotestHitCountWidget,
	#superclass : #AutotestAbstractWidget,
	#instVars : [
		'hitCountLabel',
		'container'
	],
	#category : #'Autotest-GUI-Widgets'
}

{ #category : #initialize }
AutotestHitCountWidget >> initWidgetOn: aDashboard [
	container := PanelMorph new 
		layoutPolicy: TableLayout new;
		listDirection: #bottomToTop;
		layoutInset: 1;
		borderStyle: (SimpleBorder new					
							width: 1;					
							baseColor: Color black);
		extent: (60@10);
		addMorph: (LabelMorph new contents: 'hit count');
		addMorph: (hitCountLabel := LabelMorph new contents: '0').		
	aDashboard addMorph: container.
]

{ #category : #accessing }
AutotestHitCountWidget >> order [
	^ 1
]

{ #category : #callbacks }
AutotestHitCountWidget >> showMethodModified: aCompiledMethod [
	hitCountLabel contents: '?'.	
	container color: Color transparent.
		

]

{ #category : #callbacks }
AutotestHitCountWidget >> showTestResult: aTestResult OfMethod: aCompiledMethod [
	hitCountLabel contents:  aTestResult hitCount asString.
	
	(aTestResult  hitCount = 0)
		ifTrue: [container color: Color red]
		ifFalse: [container color: Color green]
]
