Class {
	#name : #MbDCVCVJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'rIeJe'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDCVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDCVCVJoint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Curve-Curve contact '
]

{ #category : #accessing }
MbDCVCVJoint >> contactForce [
	"Compression is positive."

	^(self aFIeJtO dot: frmI keO) negated
]

{ #category : #'initialize-release' }
MbDCVCVJoint >> initializeGlobally [
	"Contact with parallel normals."

	constraints isEmpty
		ifTrue: 
			[rIeJe := MbDDistIecJec withFrmI: frmI frmJ: frmJ.
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDTranslationConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: 
			[rIeJe initializeGlobally.
			super initializeGlobally]
]

{ #category : #'initialize-release' }
MbDCVCVJoint >> initializeLocally [
	constraints isEmpty
		ifFalse: 
			[rIeJe initializeLocally.
			super initializeLocally]
]

{ #category : #posIC }
MbDCVCVJoint >> prePosIC [
	frmI prePosIC.
	frmJ prePosIC.
	super prePosIC
]
