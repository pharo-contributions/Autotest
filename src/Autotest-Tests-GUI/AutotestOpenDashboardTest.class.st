Class {
	#name : #AutotestOpenDashboardTest,
	#superclass : #TestCase,
	#category : #'Autotest-Tests-GUI-Base'
}

{ #category : #running }
AutotestOpenDashboardTest >> tearDown [

	AutotestDashboard close.
	super tearDown
]

{ #category : #tests }
AutotestOpenDashboardTest >> testShouldNotRaiseDeprecation [

	self shouldnt: [ AutotestDashboard open ] raise: Deprecation
]
