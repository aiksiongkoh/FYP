Class {
	#name : #MbDRackPinConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'xIeJeIe',
		'thezIeJe',
		'pitchRadius'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDRackPinConstraintIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDRackPinConstraintIJ class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDRackPinConstraintIJ >> calcPostDynCorrectorIteration [
	| x thez |
	x := xIeJeIe value.
	thez := thezIeJe thez.
	aG := x + (pitchRadius * thez) - aConstant
]

{ #category : #accessing }
MbDRackPinConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one rack and pinion constraint '
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIJ >> initialize [
	super initialize.
	self initxIeJeIe.
	self initthezIeJe
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIJ >> initializeGlobally [
	xIeJeIe initializeGlobally.
	thezIeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIJ >> initializeLocally [
	xIeJeIe initializeLocally.
	thezIeJe initializeLocally
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIJ >> initthezIeJe [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIJ >> initxIeJeIe [
	self subclassResponsibility
]

{ #category : #accessing }
MbDRackPinConstraintIJ >> pitchRadius: double [ 
	pitchRadius := double
]

{ #category : #dynamic }
MbDRackPinConstraintIJ >> postDynCorrectorIteration [
	xIeJeIe postDynCorrectorIteration.
	thezIeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDRackPinConstraintIJ >> postDynOutput [
	xIeJeIe postDynOutput.
	thezIeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDRackPinConstraintIJ >> postDynPredictor [
	xIeJeIe postDynPredictor.
	thezIeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDRackPinConstraintIJ >> postInput [
	xIeJeIe postInput.
	thezIeJe postInput.
	aConstant 
		ifNil: [aConstant := xIeJeIe value + (pitchRadius * thezIeJe value)].
	super postInput
]

{ #category : #posIC }
MbDRackPinConstraintIJ >> postPosICIteration [
	xIeJeIe postPosICIteration.
	thezIeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDRackPinConstraintIJ >> postStaticIteration [
	xIeJeIe postStaticIteration.
	thezIeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDRackPinConstraintIJ >> preAccIC [
	xIeJeIe preAccIC.
	thezIeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDRackPinConstraintIJ >> preDynOutput [
	xIeJeIe preDynOutput.
	thezIeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDRackPinConstraintIJ >> prePosIC [
	xIeJeIe prePosIC.
	thezIeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDRackPinConstraintIJ >> preStatic [
	xIeJeIe preStatic.
	thezIeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDRackPinConstraintIJ >> preVelIC [
	xIeJeIe preVelIC.
	thezIeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDRackPinConstraintIJ >> simUpdateAll [
	xIeJeIe simUpdateAll.
	thezIeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
MbDRackPinConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	xIeJeIe
		withFrmI: afrmI
		frmJ: afrmJ
		frmK: afrmI
		axisK: 1.
	thezIeJe withFrmI: afrmI frmJ: afrmJ
]
