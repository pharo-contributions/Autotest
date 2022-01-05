Class {
	#name : #MockAutotestUnavailableResource,
	#superclass : #TestResource,
	#category : #'Autotest-Tests-Core'
}

{ #category : #testing }
MockAutotestUnavailableResource >> isAvailable [ 
	^ false
]
