"
No relative displacement or rotation. Use for efficiency.
"
Class {
	#name : #OriginFrame,
	#superclass : #CartesianFrame,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
OriginFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #'initialize-release' }
OriginFrame >> initialize [
	super initialize.
	self fixedAtRef
]
