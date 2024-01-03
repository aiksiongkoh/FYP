Class {
	#name : #MbDFullMotion,
	#superclass : #MbDPrescribedMotion,
	#instVars : [
		'frIJI',
		'fangIJJ'
	],
	#category : #'StCAD-MbD-MbDMotion'
}

{ #category : #accessing }
MbDFullMotion >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Full Motion '
]

{ #category : #'initialize-release' }
MbDFullMotion >> connectsI: mkrII toJ: mkrJJ [ 
	| eFrmqct |
	super connectsI: mkrII toJ: mkrJJ.
	eFrmqct := MbD2EndFrameqct new.
	eFrmqct name: frmI name.
	eFrmqct markerFrame: frmI markerFrame.
	frmI become: eFrmqct
]

{ #category : #accessing }
MbDFullMotion >> fangIJJ: aEulerAngles [ 
	fangIJJ := aEulerAngles
]

{ #category : #accessing }
MbDFullMotion >> frIJI: col [ 
	frIJI := col
]

{ #category : #'initialize-release' }
MbDFullMotion >> initMotions [
	frmI rmemBlks: frIJI.
	frmI phiThePsiBlks: fangIJJ
]

{ #category : #'initialize-release' }
MbDFullMotion >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self initMotions.
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 2 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
