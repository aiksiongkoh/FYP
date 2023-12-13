Class {
	#name : #GEOGeneralMotion,
	#superclass : #GEOMotion,
	#instVars : [
		'rotOrder'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOGeneralMotion class >> mbdClass [
	^MbDFullMotion
]

{ #category : #accessing }
GEOGeneralMotion class >> nameString [
	^'GeneralMotion'
]

{ #category : #'VisualWorks metadata' }
GEOGeneralMotion class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOGeneralMotion >> angleIJJ [
	^FullColumn 
		with: phiIJ
		with: theIJ
		with: psiIJ
]

{ #category : #accessing }
GEOGeneralMotion >> angleIJJ: col [ 
	phiIJ := col at: 1.
	theIJ := col at: 2.
	psiIJ := col at: 3
]

{ #category : #DYN }
GEOGeneralMotion >> createMbD [
	| block mbdFullMotion length frIJI angle fangIJJ |
	super createMbD.
	block := 
			[:ufunc :mbdUnit | 
			| func parser stack |
			func := ufunc isNil 
						ifTrue: [Constant with: 0]
						ifFalse: 
							[parser := self functionParser.
							stack := parser 
										parseUserFunction: ufunc
										notifying: nil
										ifFail: nil.
							stack last].
			(func / mbdUnit) createMbD simplified].
	mbdFullMotion := self mbdObject.
	length := self mbdUnits length.
	frIJI := FullColumn 
				with: (block value: xIJ value: length)
				with: (block value: yIJ value: length)
				with: (block value: zIJ value: length).
	angle := self mbdUnits angle.
	fangIJJ := MbDEulerAngles 
				with: (block value: phiIJ value: angle)
				with: (block value: theIJ value: angle)
				with: (block value: psiIJ value: angle).
	fangIJJ rotOrder: rotOrder.
	mbdFullMotion frIJI: frIJI.
	mbdFullMotion fangIJJ: fangIJJ
]

{ #category : #accessing }
GEOGeneralMotion >> rIJI [
	^FullColumn 
		with: xIJ
		with: yIJ
		with: zIJ
]

{ #category : #accessing }
GEOGeneralMotion >> rIJI: col [ 
	xIJ := col at: 1.
	yIJ := col at: 2.
	zIJ := col at: 3
]

{ #category : #accessing }
GEOGeneralMotion >> rotOrder [
	^rotOrder
]

{ #category : #accessing }
GEOGeneralMotion >> rotOrder: col [ 
	rotOrder := col
]

{ #category : #printing }
GEOGeneralMotion >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream 
		storeLevel: level + 1
		title: 'rIJI1'
		object: xIJ.
	aStream 
		storeLevel: level + 1
		title: 'rIJI2'
		object: yIJ.
	aStream 
		storeLevel: level + 1
		title: 'rIJI3'
		object: zIJ.
	aStream 
		storeLevel: level + 1
		title: 'angIJJ1'
		object: phiIJ.
	aStream 
		storeLevel: level + 1
		title: 'angIJJ2'
		object: theIJ.
	aStream 
		storeLevel: level + 1
		title: 'angIJJ3'
		object: psiIJ.
	aStream 
		storeLevel: level + 1
		title: 'RotationOrder'
		object: rotOrder
]
