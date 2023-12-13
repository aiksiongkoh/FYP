Class {
	#name : #MbDAngleJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'theIzJz'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDAngleJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDAngleJoint >> classString [
	"Used to access the descriptive name of the joint."

	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Angle Joint '
]

{ #category : #'initialize-release' }
MbDAngleJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDDirectionCosineConstraintIJ 
						withFrmI: frmI
						frmJ: frmJ
						axisI: 3
						axisJ: 3.
			constraint aConstant: theIzJz cos.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #accessing }
MbDAngleJoint >> theIzJz [
	^theIzJz
]

{ #category : #accessing }
MbDAngleJoint >> theIzJz: double [
	theIzJz := double
]
