Extension { #name : #CompiledMethod }

{ #category : #'*Autotest-Core' }
CompiledMethod >> belongsToTestCase [
	^ self methodClass isKindOf: TestCase class.
]

{ #category : #'*Autotest-Core' }
CompiledMethod >> isTestMethod [ 
  	^ 	self belongsToTestCase
		and: [ self methodClass allTestSelectors includes: self selector].
]

{ #category : #'*Autotest-Core' }
CompiledMethod >> isTestSetUpMethod [
	^ (self selector = #setUp) 
	   and: [self belongsToTestCase].
]

{ #category : #'*Autotest-Core' }
CompiledMethod >> isTestTearDownMethod [
	^ (self selector = #tearDown) 
	   and:[self belongsToTestCase].
]
