Class {
	#name : #'CONNECTED_FACE_SET',
	#superclass : #'TOPOLOGICAL_REPRESENTATION_ITEM',
	#instVars : [
		'cfs_faces'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CONNECTED_FACE_SET class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CONNECTED_FACE_SET >> cfs_faces [
	^cfs_faces
]

{ #category : #accessing }
CONNECTED_FACE_SET >> cfs_faces: anObject [
	cfs_faces := anObject
]
