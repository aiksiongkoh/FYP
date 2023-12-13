Class {
	#name : #InPlaneJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
InPlaneJoint class >> mbdClass [
	^MbDPointInPlaneJoint
]

{ #category : #accessing }
InPlaneJoint class >> nameString [
	^'InPlaneJoint'
]

{ #category : #'VisualWorks metadata' }
InPlaneJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
