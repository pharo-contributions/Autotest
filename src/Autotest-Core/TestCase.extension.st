Extension { #name : #TestCase }

{ #category : #'*Autotest-Core' }
TestCase class >> allTestMethods [
	^ self  methods select: [:aCompiledMethod| 
							   aCompiledMethod isTestMethod].
]
