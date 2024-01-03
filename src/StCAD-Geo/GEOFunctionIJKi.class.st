Class {
	#name : #GEOFunctionIJKi,
	#superclass : #GEOFunctionIJ,
	#instVars : [
		'markerK',
		'axisK'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'StCAD-UI' }
GEOFunctionIJKi >> cadStringOn: aStream [ 
	aStream nextPutAll: self class functionSymbol.
	aStream nextPut: $(.
	aStream nextPutAll: geoIJ name.
	aStream nextPut: $,.
	aStream nextPutAll: markerK asString.
	aStream nextPut: $,.
	aStream nextPutAll: axisK asString.
	aStream nextPut: $)
]

{ #category : #DYN }
GEOFunctionIJKi >> createMbD [
	| eFrmI eFrmJ dispIeJe mbdDisp efrmK |
	eFrmI := geoIJ aMarkerI mbdObject.
	eFrmJ := geoIJ aMarkerJ mbdObject.
	dispIeJe := MbDSymbolicFunction new.
	mbdDisp := markerK == #O
				ifTrue: [self mbdClassOComp
						withFrmI: eFrmI
						frmJ: eFrmJ
						axis: axisK]
				ifFalse: 
					[efrmK := markerK == #I
								ifTrue: [eFrmI]
								ifFalse: [eFrmJ].
					self mbdClassKComp
						withFrmI: eFrmI
						frmJ: eFrmJ
						frmK: efrmK
						axisK: axisK].
	dispIeJe x: mbdDisp.
	self x: dispIeJe expression: (dispIeJe times: self mbdUnit)
]

{ #category : #accessing }
GEOFunctionIJKi >> geoIJ: aGeoIJ markerK: markerk axisK: axis [ 
	geoIJ := aGeoIJ.
	markerK := markerk.
	axisK := axis
]

{ #category : #accessing }
GEOFunctionIJKi >> markerK: markerk axisK: integer [ 
	markerK := markerk.
	axisK := integer
]
