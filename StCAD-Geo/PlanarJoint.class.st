Class {
	#name : #PlanarJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
PlanarJoint class >> mbdClass [
	^MbDPlanarJoint
]

{ #category : #accessing }
PlanarJoint class >> nameString [
	^'PlanarJoint'
]

{ #category : #'VisualWorks metadata' }
PlanarJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
