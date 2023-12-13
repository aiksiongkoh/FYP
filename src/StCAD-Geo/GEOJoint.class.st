Class {
	#name : #GEOJoint,
	#superclass : #GEORelativeConstraintSet,
	#classVars : [
		'Geo'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOJoint >> cut [
	container cutJoint: self.
	super cut
]

{ #category : #testing }
GEOJoint >> isJoint [
	^true
]

{ #category : #'ops on self' }
GEOJoint >> magnifySelf: aDouble [ 
	"Do nothing."
]

{ #category : #accessing }
GEOJoint >> uncut [
	container addJoint: self
]
