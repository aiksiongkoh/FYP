Class {
	#name : #MbDDirectionCosineConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'axisI',
		'axisJ',
		'aAijIeJe'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDDirectionCosineConstraintIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDirectionCosineConstraintIJ class >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass
						withFrmI: afrmI
						frmJ: afrmJ
						axisI: aaxisI
						axisJ: aaxisJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #accessing }
MbDDirectionCosineConstraintIJ >> addToJointForceI: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDDirectionCosineConstraintIJ >> addToJointForceJ: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDDirectionCosineConstraintIJ >> addpFIeiGOplamto: mat [ 
	"pGpXI is zero."
	"Do nothing."
]

{ #category : #calc }
MbDDirectionCosineConstraintIJ >> calcPostDynCorrectorIteration [
	aG := aAijIeJe aAijIeJe - aConstant
]

{ #category : #accessing }
MbDDirectionCosineConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: perpendicular constraint '
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIJ >> initialize [
	super initialize.
	aAijIeJe := self directionCosineClass new
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIJ >> initializeGlobally [
	aAijIeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIJ >> initializeLocally [
	aAijIeJe initializeLocally
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIJ >> postDynCorrectorIteration [
	aAijIeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIJ >> postDynOutput [
	aAijIeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIJ >> postDynPredictor [
	aAijIeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDDirectionCosineConstraintIJ >> postInput [
	aAijIeJe postInput.
	super postInput
]

{ #category : #posIC }
MbDDirectionCosineConstraintIJ >> postPosICIteration [
	aAijIeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDDirectionCosineConstraintIJ >> postStaticIteration [
	aAijIeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDDirectionCosineConstraintIJ >> preAccIC [
	aAijIeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIJ >> preDynOutput [
	aAijIeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDDirectionCosineConstraintIJ >> prePosIC [
	aAijIeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDDirectionCosineConstraintIJ >> preStatic [
	aAijIeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDDirectionCosineConstraintIJ >> preVelIC [
	aAijIeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDDirectionCosineConstraintIJ >> simUpdateAll [
	aAijIeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDDirectionCosineConstraintIJ >> type [
	^#perpendicular
]

{ #category : #'initialize-release' }
MbDDirectionCosineConstraintIJ >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axisI := aaxisI.
	axisJ := aaxisJ.
	aAijIeJe
		withFrmI: afrmI
		frmJ: afrmJ
		axisI: aaxisI
		axisJ: aaxisJ
]
