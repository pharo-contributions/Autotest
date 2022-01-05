"
A morph docked on one side of the screen, used by AutotestDashboard.

"
Class {
	#name : #DashboardMorph,
	#superclass : #DockingBarMorph,
	#classVars : [
		'Default'
	],
	#category : #'Autotest-GUI-Morphic'
}

{ #category : #geometry }
DashboardMorph >> addMorph: aMorph [
	aMorph height: self height.
	^ super addMorph: aMorph.
]

{ #category : #initialization }
DashboardMorph >> initialize [
	"Initialize the receiver."
	super initialize.
	self
		initializeLayout;
		initializeAppearance;
		adhereToTop.
]

{ #category : #initialization }
DashboardMorph >> initializeAppearance [
	"Initialize the appearance."

	self
		color: (Color white alpha: 0.8).
]

{ #category : #initialization }
DashboardMorph >> initializeLayout [
	"Initialize the layout."
	self
		changeTableLayout;
		layoutInset: 1;
		cellInset: 0;
		listDirection: #leftToRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		extent: self minimumExtent
]

{ #category : #geometry }
DashboardMorph >> minimumExtent [
	"Answer the minimum extent."
	^ 400@45
]

{ #category : #geometry }
DashboardMorph >> ownerChanged [
	"The receiver's owner has changed its layout.
	Since this method is called synchronously in the
	ui, delete the receiver if there are any excpetions."
	
	self owner ifNil: [^self].
	[self updateBounds]
		on: Exception
		do: [:ex | self delete. ex pass].
	super ownerChanged
]

{ #category : #geometry }
DashboardMorph >> updateBounds [
	"Update the receiver's bounds to fill the world."
	self width: self owner width.
]
