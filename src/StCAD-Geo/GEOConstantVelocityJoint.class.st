Class {
	#name : #GEOConstantVelocityJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOConstantVelocityJoint class >> mbdClass [
	^MbDConstantVelocityJoint
]

{ #category : #accessing }
GEOConstantVelocityJoint class >> nameString [
	^'ConstantVelocityJoint'
]

{ #category : #'VisualWorks metadata' }
GEOConstantVelocityJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
