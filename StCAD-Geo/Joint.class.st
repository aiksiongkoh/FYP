Class {
	#name : #Joint,
	#superclass : #RelativeConstraintSet,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #'VisualWorks metadata' }
Joint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Joint >> cut [
	aSup cutJoint: self.
	super cut
]

{ #category : #testing }
Joint >> isJoint [
	^true
]

{ #category : #accessing }
Joint >> uncut [
	aSup addJoint: self
]
