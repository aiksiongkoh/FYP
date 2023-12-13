Class {
	#name : #NoRotationJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
NoRotationJoint class >> mbdClass [
	^MbDNoRotationJoint
]

{ #category : #accessing }
NoRotationJoint class >> nameString [
	^'NoRotationJoint'
]

{ #category : #'VisualWorks metadata' }
NoRotationJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
