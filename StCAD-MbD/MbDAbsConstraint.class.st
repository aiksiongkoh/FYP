Class {
	#name : #MbDAbsConstraint,
	#superclass : #MbDConstraint,
	#instVars : [
		'axis',
		'iqXminusOnePlusAxis'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDAbsConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDAbsConstraint >> axis: aInteger [ 
	axis := aInteger
]

{ #category : #calc }
MbDAbsConstraint >> calcPostDynCorrectorIteration [
	axis < 4
		ifTrue: [aG := owner qX at: axis]
		ifFalse: [aG := owner qE at: axis - 3]
]

{ #category : #accessing }
MbDAbsConstraint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: absolute constraint '
]

{ #category : #accIC }
MbDAbsConstraint >> fillAccICIterError: col [ 
	| sum |
	col at: iqXminusOnePlusAxis plusNumber: lam.
	sum := axis <= 3
				ifTrue: [owner qXddot at: axis]
				ifFalse: [owner qEddot at: axis - 3].
	col at: iG plusNumber: sum
]

{ #category : #collision }
MbDAbsConstraint >> fillCollisionError: col [ 
	"lamDeriv is now PlamDeriv."
	"qEddot is now qEdotDeriv."

	| sum |
	col at: iqXminusOnePlusAxis plusNumber: lamDeriv.
	sum := axis <= 3
				ifTrue: [owner qXddot at: axis]
				ifFalse: [owner qEddot at: axis - 3].
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDAbsConstraint >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXminusOnePlusAxis plusNumber: lam
]

{ #category : #posIC }
MbDAbsConstraint >> fillPosICJacob: mat [ 
	mat at: iG and: iqXminusOnePlusAxis plusNumber: 1.0d.
	mat at: iqXminusOnePlusAxis and: iG plusNumber: 1.0d
]

{ #category : #posIC }
MbDAbsConstraint >> fillPosKineJacob: mat [ 
	mat at: iG and: iqXminusOnePlusAxis plusNumber: 1.0d
]

{ #category : #velIC }
MbDAbsConstraint >> fillVelICJacob: mat [ 
	self fillPosICJacob: mat
]

{ #category : #velIC }
MbDAbsConstraint >> fillVelKineJacob: mat [ 
	self fillPosKineJacob: mat
]

{ #category : #dynamic }
MbDAbsConstraint >> fillpFpy: mat [ 
	mat
		at: iG
		and: iqXminusOnePlusAxis
		plusNumber: 1.0d
]

{ #category : #dynamic }
MbDAbsConstraint >> fillpFpydot: mat [ 
	mat
		at: iqXminusOnePlusAxis
		and: iG
		plusNumber: 1.0d
]

{ #category : #'initialize-release' }
MbDAbsConstraint >> useEquationNumbers [
	iqXminusOnePlusAxis := owner iqX - 1 + axis
]
