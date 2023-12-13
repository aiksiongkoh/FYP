Class {
	#name : #CADDistanceIJDialog,
	#superclass : #CADDialog,
	#instVars : [
		'distanceIJ',
		'aJoint'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADDistanceIJDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADDistanceIJDialog >> distanceIJ [
	^distanceIJ
]

{ #category : #'initialize-release' }
CADDistanceIJDialog >> initialize [
	super initialize.
	aJoint := nil asValue.
	distanceIJ := self bufferedAdaptorFor: #distanceIJ
]

{ #category : #accessing }
CADDistanceIJDialog >> subject [
	^aJoint
]
