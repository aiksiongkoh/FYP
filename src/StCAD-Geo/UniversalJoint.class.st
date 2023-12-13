Class {
	#name : #UniversalJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
UniversalJoint class >> mbdClass [
	^MbDUniversalJoint
]

{ #category : #accessing }
UniversalJoint class >> nameString [
	^'UniversalJoint'
]

{ #category : #'VisualWorks metadata' }
UniversalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
