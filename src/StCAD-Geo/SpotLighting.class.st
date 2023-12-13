Class {
	#name : #SpotLighting,
	#superclass : #SingleLighting,
	#instVars : [
		'cutoffAngle'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
SpotLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #lighting }
SpotLighting >> lightingOn: aRenderingContext [ 
	| index |
	index := aRenderingContext getLightIndex.
	aRenderingContext 
		lightIndex: index
		position: self position
		direction: (self direction isNil 
				ifTrue: [aRenderingContext projection sightPoint - self position]
				ifFalse: [self direction])
		cutoffAngle: (cutoffAngle isNil 
				ifTrue: [JunAngle fromDeg: 45]
				ifFalse: [cutoffAngle])
		color: self color
		alpha: self alpha.
	aRenderingContext enableLightIndex: index.
	aRenderingContext enableLighting
]
