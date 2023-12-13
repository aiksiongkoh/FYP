Class {
	#name : #ArrayLighting,
	#superclass : #AnyLighting,
	#instVars : [
		'cLighting'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
ArrayLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #calc }
ArrayLighting >> cItemWithBoundingBox [
	^(OrderedCollection new: cLighting size)
		addAll: cLighting;
		yourself
]
