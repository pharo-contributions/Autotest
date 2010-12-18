"
I'm the base class for widgets to be displayed in Autotest Dashboard.
"
Class {
	#name : #AutotestAbstractWidget,
	#superclass : #Object,
	#category : #'Autotest-GUI'
}

{ #category : #'initialize-release' }
AutotestAbstractWidget >> dashboardIsClosing [
	self
]

{ #category : #'initialize-release' }
AutotestAbstractWidget >> initWidgetOn: aDashboard [
	self subclassResponsibility.
]

{ #category : #accessing }
AutotestAbstractWidget >> order [
	^ 100
]

{ #category : #callbacks }
AutotestAbstractWidget >> showMethodModified: aCompiledMethod [ 
	^ self
]

{ #category : #callbacks }
AutotestAbstractWidget >> showTestResult: aTestResult OfMethod: aCompiledMethod [
	self
]
