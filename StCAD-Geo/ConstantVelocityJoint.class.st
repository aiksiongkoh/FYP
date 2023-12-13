Class {
	#name : #ConstantVelocityJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
ConstantVelocityJoint class >> mbdClass [
	^MbDConstantVelocityJoint
]

{ #category : #accessing }
ConstantVelocityJoint class >> nameString [
	^'ConstantVelocityJoint'
]

{ #category : #'VisualWorks metadata' }
ConstantVelocityJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
