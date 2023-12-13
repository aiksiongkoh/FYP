"
Light will point along the z direction.
"
Class {
	#name : #ParallelLighting,
	#superclass : #SingleLighting,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'instance creation' }
ParallelLighting class >> color: aColor direction: array [ 
	| answer zDir xDir aA |
	answer := self new.
	answer color: aColor.
	zDir := FullColumn 
				with: (array at: 1) asDouble
				with: (array at: 2) asDouble
				with: (array at: 3) asDouble.
	zDir normalizeSelf.
	xDir := FullColumn 
				with: 1.0d
				with: 0.0d
				with: 0.0d.
	(xDir cross: zDir) length < 1.0d-1 
		ifTrue: 
			[xDir := FullColumn 
						with: 0.0d
						with: 1.0d
						with: 0.0d].
	aA := FullMatrix rotationMatrixFromzDir: zDir xDir: xDir.
	answer aRefFrame aAFf: aA.
	^answer
]

{ #category : #'VisualWorks metadata' }
ParallelLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
ParallelLighting >> aDialog [
	^CADParallelLightingDialog openOn: self.
]

{ #category : #accessing }
ParallelLighting >> direction [
	^aRefFrame aAFf column: 3
]

{ #category : #lighting }
ParallelLighting >> lightingOn: aRenderingContext [ 
	| index |
	index := aRenderingContext getLightIndex.
	aRenderingContext 
		lightIndex: index
		position: nil
		direction: self direction
		cutoffAngle: nil
		color: self color
		alpha: self alpha.
	aRenderingContext enableLightIndex: index.
	aRenderingContext enableLighting
]
