Class {
	#name : #MbDConstantVelocityJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDConstantVelocityJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDConstantVelocityJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Constant Veocity Joint '
]

{ #category : #'initialize-release' }
MbDConstantVelocityJoint >> connectsI: mkrII toJ: mkrJJ [ 
	"Subsequent prescribed motions may make endFrameI , J become prescribed end frames."
	"Use newCopyEndFrameqc to prevent efrms from becoming EndFrameqct."

	frmI := mkrII newCopyEndFrameqc.
	frmJ := mkrJJ newCopyEndFrameqc
]

{ #category : #'initialize-release' }
MbDConstantVelocityJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			self owns: (MbDConVelConstraintIJ withFrmI: frmI frmJ: frmJ).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
