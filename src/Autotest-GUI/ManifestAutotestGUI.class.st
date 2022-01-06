"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAutotestGUI,
	#superclass : #PackageManifest,
	#category : #'Autotest-GUI-Manifest'
}

{ #category : #'code-critics' }
ManifestAutotestGUI class >> ruleClassNameInSelectorRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'AutotestDashboard class' #AutotestDashboard)) #'2022-01-06T01:11:39.514+01:00') )
]
