"
I'm a method wrapper which counts hits on a method for Autotest. 

Used to check that tests actually called the modified method.
"
Class {
	#name : #AutotestHitCounter,
	#superclass : #Object,
	#instVars : [
		'method',
		'hitCount'
	],
	#category : #'Autotest-Core'
}

{ #category : #'instance creation' }
AutotestHitCounter class >> on: aCompiledMethod [ 
	^ self new on: aCompiledMethod
]

{ #category : #accessing }
AutotestHitCounter >> doesNotUnderstand: aMessage [
	(method respondsTo: aMessage selector) 
		ifTrue: [^ aMessage sendTo: method]
		ifFalse: [^ super doesNotUnderstand: aMessage].
]

{ #category : #actions }
AutotestHitCounter >> flushCache [ 
   method selector flushCache.
]

{ #category : #evaluation }
AutotestHitCounter >> hit [
	hitCount := hitCount + 1.
]

{ #category : #accessing }
AutotestHitCounter >> hitCount [
	^ hitCount
]

{ #category : #'initialize-release' }
AutotestHitCounter >> initialize [ 
	hitCount := 0
]

{ #category : #actions }
AutotestHitCounter >> install [
	(method isKindOf: AutotestHitCounter) ifTrue: [^ self]. 
	
	method methodClass methodDictionary
		at: method selector
		put: self.
]

{ #category : #'initialize-release' }
AutotestHitCounter >> on: aCompiledMethod [ 
	method := aCompiledMethod.
	self install.
	^ self
]

{ #category : #evaluation }
AutotestHitCounter >> run: aSelector with: anArray in: aReceiver [
	self hit.
	^ aReceiver withArgs: anArray executeMethod: method
]

{ #category : #actions }
AutotestHitCounter >> uninstall [
	(method isKindOf: AutotestHitCounter) ifTrue: [^ self]. 
	
	method methodClass methodDictionary
		at: method selector
		put: method
]
