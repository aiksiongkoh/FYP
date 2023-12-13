Class {
	#name : #MbDSurfaceSurfaceJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'rIeJe'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDSurfaceSurfaceJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDSurfaceSurfaceJoint >> classString [
	"Used to access the descriptive name of the constraint."

	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Surface-Surface contact '
]

{ #category : #accessing }
MbDSurfaceSurfaceJoint >> contactForce [
	"Compression is positive."

	^(self aFIeJtO dot: frmI keO) negated
]

{ #category : #'initialize-release' }
MbDSurfaceSurfaceJoint >> initializeGlobally [
	"Contact with parallel normals."

	constraints isEmpty 
		ifTrue: 
			[rIeJe := MbDDistIecJec withFrmI: frmI frmJ: frmJ.
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: 
			[rIeJe initializeGlobally.
			super initializeGlobally]
]

{ #category : #'initialize-release' }
MbDSurfaceSurfaceJoint >> initializeLocally [
	constraints isEmpty
		ifFalse: 
			[rIeJe initializeLocally.
			super initializeLocally]
]

{ #category : #posIC }
MbDSurfaceSurfaceJoint >> prePosIC [
	frmI prePosIC.
	frmJ prePosIC.
	super prePosIC
]
