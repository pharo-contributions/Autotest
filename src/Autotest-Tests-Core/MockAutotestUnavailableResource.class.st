"
A mock for an unavailable test resource
"
Class {
	#name : #MockAutotestUnavailableResource,
	#superclass : #TestResource,
	#category : #'Autotest-Tests-Core-Resources'
}

{ #category : #testing }
MockAutotestUnavailableResource >> isAvailable [

	^ false
]
