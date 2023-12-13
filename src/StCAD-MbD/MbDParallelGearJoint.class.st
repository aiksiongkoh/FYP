Class {
	#name : #MbDParallelGearJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'ratio',
		'aConstant'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDParallelGearJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDParallelGearJoint >> aConstant [
	^aConstant
]

{ #category : #accessing }
MbDParallelGearJoint >> aConstant: anObject [
	aConstant := anObject
]

{ #category : #accessing }
MbDParallelGearJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Parallel Gear Joint '
]

{ #category : #'initialize-release' }
MbDParallelGearJoint >> initializeGlobally [
	| constraint |
	constraints isEmpty 
		ifTrue: 
			[constraint := MbDParallelGearConstraintIJ withFrmI: frmI frmJ: frmJ.
			constraint ratio: ratio.
			constraint aConstant: aConstant.
			self owns: constraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]

{ #category : #accessing }
MbDParallelGearJoint >> ratio [
	^ratio
]

{ #category : #accessing }
MbDParallelGearJoint >> ratio: anObject [
	ratio := anObject
]
