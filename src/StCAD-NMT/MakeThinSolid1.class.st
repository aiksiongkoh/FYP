Class {
	#name : #MakeThinSolid1,
	#superclass : #CompositeOperator,
	#instVars : [
		'cPoint',
		'newModel',
		'newTopFace',
		'newBottomFace'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeThinSolid1 class >> cPoint: crPPointP [ 
	| aMakeThinSolid1 |
	aMakeThinSolid1 := self new.
	aMakeThinSolid1 cPoint: crPPointP.
	^aMakeThinSolid1
]

{ #category : #'VisualWorks metadata' }
MakeThinSolid1 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeThinSolid1 >> cPoint [
	^cPoint
]

{ #category : #accessing }
MakeThinSolid1 >> cPoint: anObject [
	cPoint := anObject
]

{ #category : #executing }
MakeThinSolid1 >> execute [
	| nPoint aOutsideRegion aMakeSV aVertex1 aMakeRSFL aFace1 fromVertex indexOfFirstMMakeEV aMMakeEV aMMakeEFL |
	nPoint := cPoint size - 1.	"Since first and last points are indentical."
	aOutsideRegion := newModel aOutsideRegion.
	aMakeSV := MakeSV inRegion: aOutsideRegion aPoint: (cPoint at: 1).
	cOperator add: aMakeSV do.
	aVertex1 := aMakeSV newVertex.
	aMakeRSFL := MakeRSFL inRegion: aOutsideRegion aVertex: aVertex1.
	cOperator add: aMakeRSFL do.
	aFace1 := aMakeRSFL newFace.
	fromVertex := aVertex1.
	indexOfFirstMMakeEV := cOperator size + 1.
	1 to: nPoint - 1
		do: 
			[:i | 
			aMMakeEV := MMakeEV 
						inRegion: aOutsideRegion
						inFace: aFace1
						aEdge: nil
						fromVertex: fromVertex
						toPoint: (cPoint at: i + 1)
						orient: nil.
			cOperator add: aMMakeEV do.
			fromVertex := aMMakeEV newVertex].
	aMMakeEFL := MMakeE 
				inRegion: aOutsideRegion
				inFace: aFace1
				aEdge: cOperator last newEdge
				aVertex: fromVertex
				orient: nil
				aEdge: (cOperator at: indexOfFirstMMakeEV) newEdge
				aVertex: aVertex1
				orient: nil.
	cOperator add: aMMakeEFL do.
	newTopFace := aMMakeEFL newFace.
	newBottomFace := aMMakeEFL aFace
]

{ #category : #'initialize-release' }
MakeThinSolid1 >> initialize [

	super initialize.
	newModel := StCAD_NMT_Model new "VW_TRANSLATION:StCAD.NMT.Model:StCAD_NMT_Model"
]

{ #category : #accessing }
MakeThinSolid1 >> newBottomFace [
	^newBottomFace
]

{ #category : #accessing }
MakeThinSolid1 >> newBottomFace: anObject [
	newBottomFace := anObject
]

{ #category : #accessing }
MakeThinSolid1 >> newModel [
	^newModel
]

{ #category : #accessing }
MakeThinSolid1 >> newModel: anObject [
	newModel := anObject
]

{ #category : #accessing }
MakeThinSolid1 >> newTopFace [
	^newTopFace
]

{ #category : #accessing }
MakeThinSolid1 >> newTopFace: anObject [
	newTopFace := anObject
]

{ #category : #executing }
MakeThinSolid1 >> precondition [
	"cPoint must make a closed loop."

	^cPoint first = cPoint last
]
