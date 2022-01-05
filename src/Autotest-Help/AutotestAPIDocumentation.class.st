Class {
	#name : #AutotestAPIDocumentation,
	#superclass : #HelpOnAutotest,
	#category : #'Autotest-Help'
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
