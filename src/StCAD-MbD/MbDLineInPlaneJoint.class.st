Class {
	#name : #MbDLineInPlaneJoint,
	#superclass : #MbDInPlaneJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDLineInPlaneJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDLineInPlaneJoint >> classString [
	"Used to access the descriptive name of the joint."

	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: LineInPlane Joint '
]

{ #category : #'initialize-release' }
MbDLineInPlaneJoint >> initializeGlobally [
	constraints isEmpty 
		ifTrue: 
			[self createTranslationConstraint.
			self owns: (MbDDirectionCosineConstraintIJ 
						withFrmI: frmI
						frmJ: frmJ
						axisI: 3
						axisJ: 3).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
