Class {
	#name : #ParallelAxesJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
ParallelAxesJoint class >> mbdClass [
	^MbDParallelAxesJoint
]

{ #category : #accessing }
ParallelAxesJoint class >> nameString [
	^'ParallelAxesJoint'
]

{ #category : #'VisualWorks metadata' }
ParallelAxesJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
