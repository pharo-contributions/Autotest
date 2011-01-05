Class {
	#name : #AutotestOpenDashboardTest,
	#superclass : #TestCase,
	#category : #'Autotest-Tests-GUI'
}

{ #category : #running }
AutotestOpenDashboardTest >> tearDown [
	AutotestDashboard close.
]

{ #category : #tests }
AutotestOpenDashboardTest >> testShouldNotRaiseDeprecation [
	self shouldnt: [AutotestDashboard open] raise: Deprecation
]
