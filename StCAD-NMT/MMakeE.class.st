Class {
	#name : #MMakeE,
	#superclass : #ManifoldMake,
	#instVars : [
		'aRegion',
		'aFace',
		'aEdge1',
		'aVertex1',
		'orient1',
		'aEdge2',
		'aVertex2',
		'orient2',
		'aCurve',
		'newEdge'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MMakeE class >> inRegion: aRegion inFace: aFace aEdge: aEdge1 aVertex: aVertex1 orient: orient1 aEdge: aEdge2 aVertex: aVertex2 orient: orient2 [ 
	| oldFaceUse oldLoopUse aMMakeESub |
	oldFaceUse := (aFace 
				selectFaceUse: [:aFaceUse | aFaceUse aRegion == aRegion]) soleItem.
	oldLoopUse := (oldFaceUse selectLoopUse: 
					[:aLoopUse | 
					(aLoopUse includesVertex: aVertex1) 
						and: [aLoopUse includesVertex: aVertex2]]) 
				soleItem.
	aMMakeESub := oldLoopUse notNil 
				ifTrue: [MMakeEFL new]
				ifFalse: [MMakeEKillL new].
	aMMakeESub aRegion: aRegion.
	aMMakeESub aFace: aFace.
	aMMakeESub aEdge1: aEdge1.
	aMMakeESub aVertex1: aVertex1.
	aMMakeESub orient1: orient1.
	aMMakeESub aEdge2: aEdge2.
	aMMakeESub aVertex2: aVertex2.
	aMMakeESub orient2: orient2.
	^aMMakeESub
]

{ #category : #'VisualWorks metadata' }
MMakeE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MMakeE >> aEdge1 [
	^aEdge1
]

{ #category : #accessing }
MMakeE >> aEdge1: anObject [
	aEdge1 := anObject
]

{ #category : #accessing }
MMakeE >> aEdge2 [
	^aEdge2
]

{ #category : #accessing }
MMakeE >> aEdge2: anObject [
	aEdge2 := anObject
]

{ #category : #accessing }
MMakeE >> aFace [
	^aFace
]

{ #category : #accessing }
MMakeE >> aFace: anObject [
	aFace := anObject
]

{ #category : #accessing }
MMakeE >> aRegion [
	^aRegion
]

{ #category : #accessing }
MMakeE >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MMakeE >> aVertex1 [
	^aVertex1
]

{ #category : #accessing }
MMakeE >> aVertex1: anObject [
	aVertex1 := anObject
]

{ #category : #accessing }
MMakeE >> aVertex2 [
	^aVertex2
]

{ #category : #accessing }
MMakeE >> aVertex2: anObject [
	aVertex2 := anObject
]

{ #category : #accessing }
MMakeE >> newEdge [
	^newEdge
]

{ #category : #accessing }
MMakeE >> orient1 [
	^orient1
]

{ #category : #accessing }
MMakeE >> orient1: anObject [
	orient1 := anObject
]

{ #category : #accessing }
MMakeE >> orient2 [
	^orient2
]

{ #category : #accessing }
MMakeE >> orient2: anObject [
	orient2 := anObject
]
