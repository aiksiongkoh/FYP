Class {
	#name : #GEOFourierTransformData,
	#superclass : #GEOData,
	#instVars : [
		'f',
		'aFx',
		'aFy'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOFourierTransformData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOFourierTransformData >> aFx [
	^aFx
]

{ #category : #accessing }
GEOFourierTransformData >> aFx: realPart [ 
	aFx := realPart
]

{ #category : #accessing }
GEOFourierTransformData >> aFy [
	^aFy
]

{ #category : #accessing }
GEOFourierTransformData >> aFy: imPart [ 
	aFy := imPart
]

{ #category : #accessing }
GEOFourierTransformData >> f [
	^f
]

{ #category : #accessing }
GEOFourierTransformData >> f: frequency [ 
	f := frequency
]

{ #category : #'initialize-release' }
GEOFourierTransformData >> initialize [
	"Do nothing."
]

{ #category : #accessing }
GEOFourierTransformData >> magnitude [
	^(aFx * aFx + (aFy * aFy)) sqrt
]

{ #category : #accessing }
GEOFourierTransformData >> oneSidedSpectralDensity [
	"One sided spectral density of real functions."

	^2 * (aFx * aFx + (aFy * aFy))
]

{ #category : #accessing }
GEOFourierTransformData >> phase [
	^Double arcTan0to2piY: aFy overX: aFx
]

{ #category : #accessing }
GEOFourierTransformData >> phase1 [
	^Double arcTanMpiTOpiY: aFy overX: aFx
]

{ #category : #accessing }
GEOFourierTransformData >> phaseDegrees [
	^[(Double arcTan0to2piY: aFy overX: aFx) radiansToDegrees] on: Error
		do: [:ex | 0.0d]
]

{ #category : #accessing }
GEOFourierTransformData >> spectralDensity [
	"One sided spectral density of real functions."

	^2 * (aFx * aFx + (aFy * aFy))
]
