"
ratioPlusOne := ratio + 1

ratio is the fraction 
# teeth on I      diameter of I
----------------- = --------------------
# teeth on J     diameter of J
"
Class {
	#name : #MbDGearConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'orbitIeJe',
		'orbitJeIe',
		'radiusI',
		'radiusJ'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDGearConstraintIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDGearConstraintIJ class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDGearConstraintIJ >> calcPostDynCorrectorIteration [
	aG := orbitJeIe value + (self ratio * orbitIeJe value) - aConstant
]

{ #category : #accessing }
MbDGearConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one parallel gear constraint '
]

{ #category : #'initialize-release' }
MbDGearConstraintIJ >> initializeGlobally [
	orbitIeJe initializeGlobally.
	orbitJeIe initializeGlobally
]

{ #category : #'initialize-release' }
MbDGearConstraintIJ >> initializeLocally [
	orbitIeJe initializeLocally.
	orbitJeIe initializeLocally
]

{ #category : #dynamic }
MbDGearConstraintIJ >> postDynCorrectorIteration [
	orbitIeJe postDynCorrectorIteration.
	orbitJeIe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDGearConstraintIJ >> postDynOutput [
	orbitIeJe postDynOutput.
	orbitJeIe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDGearConstraintIJ >> postDynPredictor [
	orbitIeJe postDynPredictor.
	orbitJeIe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDGearConstraintIJ >> postInput [
	orbitIeJe postInput.
	orbitJeIe postInput.
	aConstant 
		ifNil: [aConstant := orbitJeIe value + (self ratio * orbitIeJe value)].
	super postInput
]

{ #category : #posIC }
MbDGearConstraintIJ >> postPosICIteration [
	orbitIeJe postPosICIteration.
	orbitJeIe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDGearConstraintIJ >> postStaticIteration [
	orbitIeJe postStaticIteration.
	orbitJeIe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDGearConstraintIJ >> preAccIC [
	orbitIeJe preAccIC.
	orbitJeIe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDGearConstraintIJ >> preDynOutput [
	orbitIeJe preDynOutput.
	orbitJeIe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDGearConstraintIJ >> prePosIC [
	orbitIeJe prePosIC.
	orbitJeIe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDGearConstraintIJ >> preStatic [
	orbitIeJe preStatic.
	orbitJeIe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDGearConstraintIJ >> preVelIC [
	orbitIeJe preVelIC.
	orbitJeIe preVelIC.
	super preVelIC
]

{ #category : #accessing }
MbDGearConstraintIJ >> radiusI [
	^radiusI
]

{ #category : #accessing }
MbDGearConstraintIJ >> radiusI: aDouble [
	radiusI := aDouble
]

{ #category : #accessing }
MbDGearConstraintIJ >> radiusJ [
	^radiusJ
]

{ #category : #accessing }
MbDGearConstraintIJ >> radiusJ: aDouble [
	radiusJ := aDouble
]

{ #category : #accessing }
MbDGearConstraintIJ >> ratio [
	^radiusI / radiusJ
]

{ #category : #dynamic }
MbDGearConstraintIJ >> simUpdateAll [
	orbitIeJe simUpdateAll.
	orbitJeIe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDGearConstraintIJ >> type [
	^#essential
]

{ #category : #'initialize-release' }
MbDGearConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	orbitIeJe := MbDOrbitAnglezIecJec withFrmI: afrmI frmJ: afrmJ.
	orbitJeIe := MbDOrbitAnglezIecJec withFrmI: afrmJ frmJ: afrmI
]
