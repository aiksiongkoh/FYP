Class {
	#name : #AmbientLighting,
	#superclass : #SingleLighting,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
AmbientLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
AmbientLighting >> aDialog [
	^CADAmbientLightingDialog openOn: self.
]

{ #category : #lighting }
AmbientLighting >> lightingOn: aRenderingContext [ 
	aRenderingContext lightAmbientColor: self color alpha: self alpha.
	aRenderingContext enableLighting
]
