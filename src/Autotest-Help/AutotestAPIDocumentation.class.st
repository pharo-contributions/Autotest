"
Provides an API documentation for Autotest package
"
Class {
	#name : #AutotestAPIDocumentation,
	#superclass : #HelpOnAutotest,
	#category : #'Autotest-Help-API'
}

{ #category : #accessing }
AutotestAPIDocumentation class >> bookName [ 
	^ 'API Documentation'
]

{ #category : #defaults }
AutotestAPIDocumentation class >> builder [
	^ PackageAPIHelpBuilder
]

{ #category : #accessing }
AutotestAPIDocumentation class >> helpPackages [
	^#('Autotest-Core' 'Autotest-GUI')
]
