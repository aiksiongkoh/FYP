Class {
	#name : #FixedJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
FixedJoint class >> mbdClass [
	^MbDFixedJoint
]

{ #category : #accessing }
FixedJoint class >> nameString [
	^'FixedJoint'
]

{ #category : #'VisualWorks metadata' }
FixedJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
