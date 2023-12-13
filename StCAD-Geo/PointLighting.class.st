Class {
	#name : #PointLighting,
	#superclass : #SingleLighting,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
PointLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #lighting }
PointLighting >> lightingOn: aRenderingContext [ 
	| index |
	index := aRenderingContext getLightIndex.
	aRenderingContext 
		lightIndex: index
		position: self position
		direction: nil
		cutoffAngle: nil
		color: self color
		alpha: self alpha.
	aRenderingContext enableLightIndex: index.
	aRenderingContext enableLighting
]
