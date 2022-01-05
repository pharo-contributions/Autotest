"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAutotestTestsCore,
	#superclass : #PackageManifest,
	#category : #'Autotest-Tests-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestAutotestTestsCore class >> ruleJustSendsSuperRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AutotestTestFinder #tearDown #false)) #'2022-01-06T00:48:13.192+01:00') )
]

{ #category : #'code-critics' }
ManifestAutotestTestsCore class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestAutotestTestsCore class' #ManifestAutotestTestsCore)) #'2022-01-06T00:49:29.194+01:00') )
]

{ #category : #'code-critics' }
ManifestAutotestTestsCore class >> ruleReShouldSendSuperTearDownAsLastMessageV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AutotestTestFinder #tearDown #false)) #'2022-01-06T00:48:19.072+01:00') )
]
