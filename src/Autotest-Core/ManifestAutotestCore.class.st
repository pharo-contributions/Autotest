"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAutotestCore,
	#superclass : #PackageManifest,
	#category : #'Autotest-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestAutotestCore class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AutotestFinder #testsForClassReferenceOf: #false)) #'2022-01-05T22:40:56.84+01:00') )
]

{ #category : #'code-critics' }
ManifestAutotestCore class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestAutotestCore class' #ManifestAutotestCore)) #'2022-01-05T22:41:52.856+01:00') )
]
