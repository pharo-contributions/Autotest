Class {
	#name : #ConfigurationOfAutotest,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfAutotest
}

{ #category : #private }
ConfigurationOfAutotest class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfAutotest class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello tool support' }
ConfigurationOfAutotest class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfAutotest class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfAutotest class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfAutotest class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfAutotest class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfAutotest class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfAutotest >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
	].

	spec for: #pharo do: [
		spec
			project: 'OmniBrowser' with: [
				spec
					className: 'ConfigurationOfOmniBrowser';
					loads: #('Dev');
					file: 'ConfigurationOfOmniBrowser';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
				
		spec 
			repository: 'http://www.squeaksource.com/Autotest';
			package: 'Autotest-Core';
			package: 'Autotest-GUI' with: [spec requires: 'Autotest-Core'];
			package: 'Autotest-Help' with: [spec requires: 'Autotest-Core'];
			package: 'Autotest-Tests-Core' with: [spec requires: 'Autotest-Core'];
			package: 'OB-Autotest' with: [ spec requires:#('OmniBrowser' 'Autotest-GUI')].
			
		spec
			group: 'default' with: #('Dev' 'Tests' 'Help');
			group: 'Dev' with: #('Autotest-GUI' 'OB-Autotest');
			group: 'Help' with: #('Autotest-Help');
			group: 'Tests' with: #('Autotest-Tests-Core')
		].
]

{ #category : #accessing }
ConfigurationOfAutotest >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfAutotest >> version10: spec [ 
	<version: '1.0' imports: #('1.0-baseline') >
	
	spec for: #common do: [	
		spec 
			blessing: #release;
			author: 'Laurent Laffont';
			description: 'Autotest is a live testing tool: automatically runs tests associated to
			an modified method. It provides a dashboard to show activity and results.'
	].
	
	spec for: #pharo do: [
		spec 
			package: 'Autotest-Core' with: 'Autotest-Core-LaurentLaffont.2';
			package: 'Autotest-GUI' with:'Autotest-GUI-LaurentLaffont.2';
			package: 'Autotest-Help' with: 'Autotest-Help-LaurentLaffont.1';
			package: 'Autotest-Tests-Core' with: 'Autotest-Tests-Core-LaurentLaffont.1';
			package: 'OB-Autotest' with:'OB-Autotest-LaurentLaffont.1'].
]
