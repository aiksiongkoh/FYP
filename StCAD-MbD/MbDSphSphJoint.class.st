Class {
	#name : #MbDSphSphJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'distanceIJ'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDSphSphJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDSphSphJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Spherical-Spherical Joint '
]

{ #category : #accessing }
MbDSphSphJoint >> distanceIJ: double [ 
	distanceIJ := double
]

{ #category : #'initialize-release' }
MbDSphSphJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDDistanceConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint aConstant: distanceIJ.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
