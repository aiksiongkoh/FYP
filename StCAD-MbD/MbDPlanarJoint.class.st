Class {
	#name : #MbDPlanarJoint,
	#superclass : #MbDInPlaneJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDPlanarJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDPlanarJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Planar Joint '
]

{ #category : #'initialize-release' }
MbDPlanarJoint >> initializeGlobally [
	constraints isEmpty 
		ifTrue: 
			[self createTranslationConstraint.
			self owns: (MbDDirectionCosineConstraintIJ 
						withFrmI: frmI
						frmJ: frmJ
						axisI: 3
						axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ 
						withFrmI: frmI
						frmJ: frmJ
						axisI: 3
						axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
