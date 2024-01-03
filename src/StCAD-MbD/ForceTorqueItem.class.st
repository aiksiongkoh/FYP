Class {
	#name : #ForceTorqueItem,
	#superclass : #MbDItem,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #static }
ForceTorqueItem >> fillStaticError: col [ 
	self fillDynError: col
]

{ #category : #static }
ForceTorqueItem >> fillStaticJacob: mat [ 
	self fillpFpy: mat
]

{ #category : #accIC }
ForceTorqueItem >> postAccICIteration [
	self calcPostDynCorrectorIteration
]

{ #category : #collision }
ForceTorqueItem >> postCollisionCorrectorIteration [
	self calcPostDynCorrectorIteration
]

{ #category : #collision }
ForceTorqueItem >> postCollisionPredictor [
	self calcPostDynCorrectorIteration
]

{ #category : #'initialize-release' }
ForceTorqueItem >> submitToSystem [
	self registerName.
	TheMbDSystem forcesTorques add: self
]
