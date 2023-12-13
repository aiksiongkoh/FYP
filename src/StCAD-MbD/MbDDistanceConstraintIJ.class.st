Class {
	#name : #MbDDistanceConstraintIJ,
	#superclass : #MbDConstraintIJ,
	#instVars : [
		'distIeJe'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDDistanceConstraintIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDistanceConstraintIJ class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDDistanceConstraintIJ >> calcPostDynCorrectorIteration [
	aG := distIeJe value - aConstant
]

{ #category : #accessing }
MbDDistanceConstraintIJ >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one distance constraint '
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIJ >> init_distIeJe [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIJ >> initialize [
	super initialize.
	self init_distIeJe
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIJ >> initializeGlobally [
	distIeJe initializeGlobally
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIJ >> initializeLocally [
	distIeJe initializeLocally
]

{ #category : #dynamic }
MbDDistanceConstraintIJ >> postDynCorrectorIteration [
	distIeJe postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDDistanceConstraintIJ >> postDynOutput [
	distIeJe postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDDistanceConstraintIJ >> postDynPredictor [
	distIeJe postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDDistanceConstraintIJ >> postInput [
	distIeJe postInput.
	super postInput
]

{ #category : #posIC }
MbDDistanceConstraintIJ >> postPosICIteration [
	distIeJe postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDDistanceConstraintIJ >> postStaticIteration [
	distIeJe postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDDistanceConstraintIJ >> preAccIC [
	distIeJe preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDDistanceConstraintIJ >> preDynOutput [
	distIeJe preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDDistanceConstraintIJ >> prePosIC [
	distIeJe prePosIC.
	super prePosIC
]

{ #category : #static }
MbDDistanceConstraintIJ >> preStatic [
	distIeJe preStatic.
	super preStatic
]

{ #category : #velIC }
MbDDistanceConstraintIJ >> preVelIC [
	distIeJe preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDDistanceConstraintIJ >> simUpdateAll [
	distIeJe simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
MbDDistanceConstraintIJ >> type [
	^#displacement
]

{ #category : #'initialize-release' }
MbDDistanceConstraintIJ >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	distIeJe withFrmI: afrmI frmJ: afrmJ
]
