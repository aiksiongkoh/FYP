Class {
	#name : #PerpendicularJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
PerpendicularJoint class >> mbdClass [
	^MbDPerpendicularJoint
]

{ #category : #accessing }
PerpendicularJoint class >> nameString [
	^'PerpendicularJoint'
]

{ #category : #'VisualWorks metadata' }
PerpendicularJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
