Class {
	#name : #SphericalJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
SphericalJoint class >> mbdClass [
	^MbDSphericalJoint
]

{ #category : #accessing }
SphericalJoint class >> nameString [
	^'SphericalJoint'
]

{ #category : #'VisualWorks metadata' }
SphericalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
