Class {
	#name : #RevoluteJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
RevoluteJoint class >> mbdClass [
	^MbDRevoluteJoint
]

{ #category : #accessing }
RevoluteJoint class >> nameString [
	^'RevoluteJoint'
]

{ #category : #'VisualWorks metadata' }
RevoluteJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
