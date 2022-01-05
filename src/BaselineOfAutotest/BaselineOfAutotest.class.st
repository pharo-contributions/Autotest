"
A baseline for https://github.com/pharo-contributions/Autotest
"
Class {
	#name : #BaselineOfAutotest,
	#superclass : #BaselineOf,
	#category : #BaselineOfAutotest
}

{ #category : #baselines }
BaselineOfAutotest >> baselineOf: spec [

	<baseline>
	spec for: #common do: [ 
		"Packages"
		spec
			package: 'Autotest-Core';
			package: 'Autotest-GUI' with: [ spec requires: 'Autotest-Core' ];
			package: 'Autotest-Help' with: [ spec requires: 'Autotest-Core' ];
			package: 'Autotest-Tests-Core' with: [ spec requires: 'Autotest-Core' ];
			package: 'Autotest-Tests-GUI' with: [ spec requires: 'Autotest-Core' ].
			
		"Groups"	
		spec 
			group: 'Core' with: #('Autotest-Core');
			group: 'UI' with: #('Autotest-GUI');
			group: 'Help' with: #('Autotest-Help');
			group: 'Tests' with: #('Autotest-Tests-Core' 'Autotest-Tests-GUI');			
			group: 'Runtime' with: #('Core' 'UI' 'Help');			
			group: 'Development' with: #('Runtime' 'Tests');		
			"virtual groups"					
			group: 'all' with: #('Runtime' 'Development');
			group: 'default' with: #('all').		 			
	]
]
