Class {
	#name : #MakePrism1,
	#superclass : #CompositeOperator,
	#instVars : [
		'cTopPoint',
		'cBottomPoint',
		'newModel'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakePrism1 class >> cTopPoint: crPTopPointP cBottomPoint: crPBottomPointP [ 
	| aMakePrism1 |
	aMakePrism1 := self new.
	aMakePrism1 cTopPoint: crPTopPointP.
	aMakePrism1 cBottomPoint: crPBottomPointP.
	^aMakePrism1
]

{ #category : #'VisualWorks metadata' }
MakePrism1 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakePrism1 >> cBottomPoint [
	^cBottomPoint
]

{ #category : #accessing }
MakePrism1 >> cBottomPoint: anObject [
	cBottomPoint := anObject
]

{ #category : #accessing }
MakePrism1 >> cOperator [
	^cOperator
]

{ #category : #accessing }
MakePrism1 >> cOperator: anObject [
	cOperator := anObject
]

{ #category : #accessing }
MakePrism1 >> cTopPoint [
	^cTopPoint
]

{ #category : #accessing }
MakePrism1 >> cTopPoint: anObject [
	cTopPoint := anObject
]

{ #category : #executing }
MakePrism1 >> execute [
	| aMakeThinSolid aMakeLoft |
	aMakeThinSolid := MakeThinSolid cPoint: cBottomPoint.
	aMakeThinSolid do.
	newModel := aMakeThinSolid newModel.
	cOperator add: aMakeThinSolid.
	aMakeLoft := MakeLoft 
				inRegion: aMakeThinSolid newModel aOutsideRegion
				onFace: aMakeThinSolid newTopFace
				cTopPoint: cTopPoint.
	aMakeLoft do.
	cOperator add: aMakeLoft
]

{ #category : #accessing }
MakePrism1 >> newModel [
	^newModel
]

{ #category : #accessing }
MakePrism1 >> newModel: anObject [
	newModel := anObject
]
