Class {
	#name : #MbDInPlaneJoint,
	#superclass : #MbDJoint,
	#instVars : [
		'offset'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'initialize-release' }
MbDInPlaneJoint >> createTranslationConstraint [
	| constraint |
	constraint := MbDTranslationConstraintIJ 
				withFrmI: frmI
				frmJ: frmJ
				axis: 3.
	constraint aConstant: offset.
	self owns: constraint
]

{ #category : #accessing }
MbDInPlaneJoint >> offset [
	^offset
]

{ #category : #accessing }
MbDInPlaneJoint >> offset: anObject [
	offset := anObject
]
