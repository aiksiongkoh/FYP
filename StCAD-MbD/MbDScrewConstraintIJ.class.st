Class {
	#name : #MbDScrewConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'zIeJeIe',
		'thezIeJe',
		'pitch'
	],
	#classVars : [
		'MbD'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDScrewConstraintIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDScrewConstraintIJ class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDScrewConstraintIJ >> calcPostDynCorrectorIteration [
	| z thez |
	z := zIeJeIe value.
	thez := thezIeJe thez.
	aG := TwoPi * z - (thez * pitch) - aConstant
]

{ #category : #accessing }
MbDScrewConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one screw constraint '
]

{ #category : #'initialize-release' }
MbDScrewConstraintIJ >> initialize [
	super initialize.
	self initziIeJeIe.
	self initthezIeJe
]

{ #category : #'initialize-release' }
MbDScrewConstraintIJ >> initializeGlobally [
	zIeJeIe initializeGlobally.
	thezIeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDScrewConstraintIJ >> initializeLocally [
	zIeJeIe initializeLocally.
	thezIeJe initializeLocally
]

{ #category : #'initialize-release' }
MbDScrewConstraintIJ >> initthezIeJe [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDScrewConstraintIJ >> initziIeJeIe [
	self subclassResponsibility
]

{ #category : #accessing }
MbDScrewConstraintIJ >> pitch: double [ 
	pitch := double
]

{ #category : #dynamic }
MbDScrewConstraintIJ >> postDynCorrectorIteration [
	zIeJeIe postDynCorrectorIteration.
	thezIeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDScrewConstraintIJ >> postDynOutput [
	zIeJeIe postDynOutput.
	thezIeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDScrewConstraintIJ >> postDynPredictor [
	zIeJeIe postDynPredictor.
	thezIeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDScrewConstraintIJ >> postInput [
	zIeJeIe postInput.
	thezIeJe postInput.
	aConstant 
		ifNil: [aConstant := TwoPi * zIeJeIe value - (thezIeJe value * pitch)].
	super postInput
]

{ #category : #posIC }
MbDScrewConstraintIJ >> postPosICIteration [
	zIeJeIe postPosICIteration.
	thezIeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDScrewConstraintIJ >> postStaticIteration [
	zIeJeIe postStaticIteration.
	thezIeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDScrewConstraintIJ >> preAccIC [
	zIeJeIe preAccIC.
	thezIeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDScrewConstraintIJ >> preDynOutput [
	zIeJeIe preDynOutput.
	thezIeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDScrewConstraintIJ >> prePosIC [
	zIeJeIe prePosIC.
	thezIeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDScrewConstraintIJ >> preStatic [
	zIeJeIe preStatic.
	thezIeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDScrewConstraintIJ >> preVelIC [
	zIeJeIe preVelIC.
	thezIeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDScrewConstraintIJ >> simUpdateAll [
	zIeJeIe simUpdateAll.
	thezIeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
MbDScrewConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	zIeJeIe
		withFrmI: afrmI
		frmJ: afrmJ
		frmK: afrmI
		axisK: 3.
	thezIeJe withFrmI: afrmI frmJ: afrmJ
]
