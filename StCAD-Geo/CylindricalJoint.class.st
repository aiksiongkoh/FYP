Class {
	#name : #CylindricalJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
CylindricalJoint class >> mbdClass [
	^MbDCylindricalJoint
]

{ #category : #accessing }
CylindricalJoint class >> nameString [
	^'CylindricalJoint'
]

{ #category : #'VisualWorks metadata' }
CylindricalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
