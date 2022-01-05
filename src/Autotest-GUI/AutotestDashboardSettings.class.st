"
I register settings for AutotestDashboard.
"
Class {
	#name : #AutotestDashboardSettings,
	#superclass : #Object,
	#category : #'Autotest-GUI'
}

{ #category : #settings }
AutotestDashboardSettings class >> autotestDashboardSettingsOn: aBuilder [

	<systemsettings>
	(aBuilder setting: #showAutotestDashboard)
		label: 'Enable Autotest' translated;
		target: AutotestDashboard;
		parent: #pharoSystem;
		description:
			'Autotest dashboard shows results of automatically runned unit tests'
]
