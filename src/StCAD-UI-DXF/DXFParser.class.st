Class {
	#name : #DXFParser,
	#superclass : #JunDXFScanner,
	#instVars : [
		'lengthUnit',
		'cVar',
		'cLayer',
		'cLayerColor',
		'aLayer',
		'iColor',
		'cBLOCK',
		'aItem',
		'cCount',
		'aAssembly'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI-DXF'
}

{ #category : #'parsing entities' }
DXFParser >> ARC [

	| markName x y z extrudeX extrudeY extrudeZ cBlock radius startAngle endAngle twoPi arcAngle n crfpf dangle newItem rFfF aARot |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 40 put: [ radius := dataNumber * lengthUnit ].
	cBlock at: 50 put: [ startAngle := dataNumber degreesToRadians ].
	cBlock at: 51 put: [ endAngle := dataNumber degreesToRadians ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 210 put: [ extrudeX := dataNumber ].
	cBlock at: 220 put: [ extrudeY := dataNumber ].
	cBlock at: 230 put: [ extrudeZ := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'ARC'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	twoPi := 2 * Double pi.
	arcAngle := endAngle > startAngle
		            ifTrue: [ endAngle - startAngle ]
		            ifFalse: [ endAngle + twoPi - startAngle ].
	n := (self nSegment * arcAngle / twoPi) rounded + 1.
	crfpf := Array new: n + 1.
	dangle := arcAngle / n.
	1 to: n + 1 do: [ :i | 
		| angle xx yy rfpf |
		angle := startAngle + (i - 1 * dangle).
		xx := radius * angle cos.
		yy := radius * angle sin.
		rfpf := xx yd: yy zd: 0.0 d.
		crfpf at: i put: rfpf ].
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem rfpointsf: crfpf.
	rFfF := x yd: y zd: z.
	aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
	newItem refFrame rFfF: (aARot timesFullColumn: rFfF) aAFf: aARot.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #arc.
	^ true
]

{ #category : #parsing }
DXFParser >> BLOCK [
	
	[self nextPair.
	self checkEOFin: 'BLOCK'.
	self isENDBLK] whileFalse: 
				[(groupCode = 3 and: [dataString first ~= $$]) 
					ifTrue: [self newDxfDefinition: dataString]].
	self unNextPair.
	^true
]

{ #category : #parsing }
DXFParser >> BLOCKS [
	self checkForUnits.
	
	[self nextPair.
	self checkEOFin: 'BLOCKS'.
	self isENDSEC] 
			whileFalse: [groupCode = 0 ifTrue: [self parse: dataString]].
	self unNextPair
]

{ #category : #parsing }
DXFParser >> CECOLOR [
	"$CECOLOR indicates... how to treat color
		0 - BYBLOCK
		256 - BYLAYER"

	
	| nn newItem |
	[self nextPair.
	dataString = 'EOF' ifTrue: [self expected: '$CECOLOR'].
	groupCode = 0 or: [groupCode = 9]] 
			whileFalse: [groupCode = 62 ifTrue: [nn := dataNumber]].
	newItem := nn.
	aItem := newItem.
	self unNextPair.
	^true
]

{ #category : #'parsing entities' }
DXFParser >> CIRCLE [
	| markName x y z thickness extrudeX extrudeY extrudeZ cBlock radius n crfpf dangle newItem rFfF aARot block |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	thickness := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [aLayer := dataString].
	cBlock at: 10 put: [x := dataNumber * lengthUnit].
	cBlock at: 20 put: [y := dataNumber * lengthUnit].
	cBlock at: 30 put: [z := dataNumber * lengthUnit].
	cBlock at: 39 put: [thickness := dataNumber * lengthUnit].
	cBlock at: 40 put: [radius := dataNumber * lengthUnit].
	cBlock at: 62 put: [iColor := dataNumber].
	cBlock at: 210 put: [extrudeX := dataNumber].
	cBlock at: 220 put: [extrudeY := dataNumber].
	cBlock at: 230 put: [extrudeZ := dataNumber].
	
	[self nextPair.
	self checkEOFin: 'CIRCLE'.
	groupCode = 0] 
			whileFalse: [(cBlock at: groupCode) value].
	n := self nSegment.
	crfpf := Array new: n + 1.
	dangle := 2 * Double pi / n.
	1 to: n
		do: 
			[:i | 
			| angle xx yy rfpf |
			angle := (i - 1) * dangle.
			xx := radius * angle cos.
			yy := radius * angle sin.
			rfpf := xx yd: yy zd: 0.0d.
			crfpf at: i put: rfpf].
	crfpf at: n + 1 put: crfpf first.
	newItem := self LWPOLYLINEWith: crfpf thickness: thickness.
	block := 
			[:graphic | 
			graphic name: markName.
			self setColorFor: graphic.
			(x = 0 and: 
					[y = 0 
						and: [z = 0 and: [extrudeX = 0 and: [extrudeY = 0 and: [extrudeZ = 1]]]]]) 
				ifFalse: 
					[rFfF := x yd: y zd: z.
					aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
					graphic refFrame rFfF: (aARot timesFullColumn: rFfF) aAFf: aARot]].
	newItem isSequenceable 
		ifTrue: [newItem do: block]
		ifFalse: [block value: newItem].
	self unNextPair.
	aItem := aLayer -> newItem.
	self count: #circle.
	^true
]

{ #category : #'parsing entities' }
DXFParser >> CIRCLE1 [

	| markName x y z extrudeX extrudeY extrudeZ cBlock radius n crfpf dangle newItem rFfF aARot |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 40 put: [ radius := dataNumber * lengthUnit ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 210 put: [ extrudeX := dataNumber ].
	cBlock at: 220 put: [ extrudeY := dataNumber ].
	cBlock at: 230 put: [ extrudeZ := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'CIRCLE'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	n := 100.
	crfpf := Array new: n + 1.
	dangle := 2 * Double pi / n.
	1 to: n do: [ :i | 
		| angle xx yy rfpf |
		angle := i - 1 * dangle.
		xx := radius * angle cos.
		yy := radius * angle sin.
		rfpf := xx yd: yy zd: 0.0 d.
		crfpf at: i put: rfpf ].
	crfpf at: n + 1 put: crfpf first.
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem rfpointsf: crfpf.
	rFfF := x yd: y zd: z.
	aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
	newItem refFrame rFfF: (aARot timesFullColumn: rFfF) aAFf: aARot.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #circle.
	^ true
]

{ #category : #parsing }
DXFParser >> CLASSES [
	
	[self nextPair.
	self checkEOFin: 'CLASSES'.
	self isENDSEC] 
			whileFalse: [groupCode = 0 ifTrue: [self parse: dataString]].
	self unNextPair
]

{ #category : #'parsing entities' }
DXFParser >> DFACE [

	| markName x y z x2 y2 z2 x3 y3 z3 x4 y4 z4 cBlock crfpf newItem flag cFlag |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	x2 := y2 := z2 := 0.
	x3 := y3 := z3 := 0.
	x4 := y4 := z4 := 0.
	flag := 0.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 11 put: [ x2 := dataNumber * lengthUnit ].
	cBlock at: 21 put: [ y2 := dataNumber * lengthUnit ].
	cBlock at: 31 put: [ z2 := dataNumber * lengthUnit ].
	cBlock at: 12 put: [ x3 := dataNumber * lengthUnit ].
	cBlock at: 22 put: [ y3 := dataNumber * lengthUnit ].
	cBlock at: 32 put: [ z3 := dataNumber * lengthUnit ].
	cBlock at: 13 put: [ x4 := dataNumber * lengthUnit ].
	cBlock at: 23 put: [ y4 := dataNumber * lengthUnit ].
	cBlock at: 33 put: [ z4 := dataNumber * lengthUnit ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 70 put: [ flag := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: '3DFACE'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	crfpf := OrderedCollection new: 5.
	crfpf addLast: (x yd: y zd: z).
	crfpf addLast: (x2 yd: y2 zd: z2).
	crfpf addLast: (x3 yd: y3 zd: z3).
	crfpf addLast: (x4 yd: y4 zd: z4).
	crfpf addLast: crfpf first.
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem rfpointsf: crfpf.
	flag > 0 ifTrue: [ 
		cFlag := OrderedCollection new: 5.
		cFlag add: ((flag bitAt: 1) = 1) not.
		cFlag add: ((flag bitAt: 2) = 1) not.
		cFlag add: ((flag bitAt: 3) = 1) not.
		cFlag add: ((flag bitAt: 4) = 1) not.
		newItem cFlag: cFlag ].
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #'3DFACE'.
	^ true
]

{ #category : #'parsing entities' }
DXFParser >> DFACE1 [

	| markName x y z x2 y2 z2 x3 y3 z3 x4 y4 z4 cBlock crfpf newItem |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	x2 := y2 := z2 := 0.
	x3 := y3 := z3 := 0.
	x4 := y4 := z4 := 0.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 11 put: [ x2 := dataNumber * lengthUnit ].
	cBlock at: 21 put: [ y2 := dataNumber * lengthUnit ].
	cBlock at: 31 put: [ z2 := dataNumber * lengthUnit ].
	cBlock at: 12 put: [ x3 := dataNumber * lengthUnit ].
	cBlock at: 22 put: [ y3 := dataNumber * lengthUnit ].
	cBlock at: 32 put: [ z3 := dataNumber * lengthUnit ].
	cBlock at: 13 put: [ x4 := dataNumber * lengthUnit ].
	cBlock at: 23 put: [ y4 := dataNumber * lengthUnit ].
	cBlock at: 33 put: [ z4 := dataNumber * lengthUnit ].
	cBlock at: 62 put: [ iColor := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: '3DFACE'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	crfpf := OrderedCollection new: 5.
	crfpf addLast: (x yd: y zd: z).
	crfpf addLast: (x2 yd: y2 zd: z2).
	crfpf addLast: (x3 yd: y3 zd: z3).
	crfpf addLast: (x4 yd: y4 zd: z4).
	crfpf addLast: crfpf first.
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem rfpointsf: crfpf.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #'3DFACE'.
	^ true
]

{ #category : #'parsing entities' }
DXFParser >> ELLIPSE [

	| markName x y z extrudeX extrudeY extrudeZ cBlock x2 y2 z2 ratio startAngle endAngle rFfF xDir zDir aAFf majorRadius minorRadius arcAngle n crfpf dangle newItem |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 11 put: [ x2 := dataNumber * lengthUnit ].
	cBlock at: 21 put: [ y2 := dataNumber * lengthUnit ].
	cBlock at: 31 put: [ z2 := dataNumber * lengthUnit ].
	cBlock at: 40 put: [ ratio := dataNumber ].
	cBlock at: 41 put: [ startAngle := dataNumber ].
	cBlock at: 42 put: [ endAngle := dataNumber ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 210 put: [ extrudeX := dataNumber ].
	cBlock at: 220 put: [ extrudeY := dataNumber ].
	cBlock at: 230 put: [ extrudeZ := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'ELLIPSE'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	rFfF := x yd: y zd: z.
	xDir := x2 yd: y2 zd: z2.
	zDir := extrudeX yd: extrudeY zd: extrudeZ.
	aAFf := StCAD_Math_FullMatrix rotationMatrixFromzDir: zDir xDir: xDir. "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
	majorRadius := xDir length.
	minorRadius := ratio * majorRadius.
	arcAngle := endAngle - startAngle.
	n := (self nSegment * arcAngle / (2 * Double pi)) rounded + 1.
	crfpf := Array new: n + 1.
	dangle := arcAngle / n.
	1 to: n + 1 do: [ :i | 
		| angle xx yy rfpf |
		angle := startAngle + (i - 1 * dangle).
		xx := majorRadius * angle cos.
		yy := minorRadius * angle sin.
		rfpf := xx yd: yy zd: 0.0 d.
		crfpf at: i put: rfpf ].
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem refFrame rFfF: rFfF aAFf: aAFf.
	newItem rfpointsf: crfpf.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #ellipse.
	^ true
]

{ #category : #parsing }
DXFParser >> ENTITIES [

	| aDXFBLOCK |
	self checkForUnits.
	aAssembly := StCAD_Geo_GEOAssembly new. "VW_TRANSLATION:StCAD.Geo.GEOAssembly:StCAD_Geo_GEOAssembly"
	aAssembly name: 'DXFAssembly'.
	aDXFBLOCK := DXFBLOCK new.

	[ 
	self nextPair.
	self checkEOFin: 'ENTITIES'.
	self isENDSEC ] whileFalse: [ 
		groupCode = 0 ifTrue: [ 
			self parse: dataString.
			aItem ifNotNil: [ 
				| graphic |
				graphic := aItem value.
				(graphic isMemberOf: DXFBLOCK) not ifTrue: [ 
					graphic isSequenceable
						ifTrue: [ aDXFBLOCK addGraphics: graphic ]
						ifFalse: [ aDXFBLOCK addGraphic: graphic ] ] ].
			self count: #entities ] ].
	self unNextPair.
	aDXFBLOCK calcBoundingBox.
	aDXFBLOCK aBoundingBox isDefined ifTrue: [ 
		| aPart aMassMarker rFfF aAFf |
		aPart := StCAD_Geo_GEOPart new. "VW_TRANSLATION:StCAD.Geo.GEOPart:StCAD_Geo_GEOPart"
		aPart name: 'Part0'.
		aPart aDXFBLOCK: aDXFBLOCK.
		aMassMarker := StCAD_Geo_GEOMassMarker new. "VW_TRANSLATION:StCAD.Geo.GEOMassMarker:StCAD_Geo_GEOMassMarker"
		aMassMarker name: 'MassMarker'.
		aMassMarker refFrame
			rFfF: aPart aDXFBLOCK aBoundingBox center
			aAFf: (StCAD_Math_FullMatrix identity: 3). "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
		aPart aMassMarker: aMassMarker.
		rFfF := 0 yd: 0 zd: 0.
		aAFf := StCAD_Math_FullMatrix identity: 3.
		aPart refFrame rFfF: rFfF aAFf: aAFf.
		aAssembly addAnyPart: aPart ]
]

{ #category : #parsing }
DXFParser >> EXTMAX1 [
	"answer a 3d point"

	self readXYZ.
	self cVar at: 'EXTMAX' put: aItem.
	self count: #cVar
]

{ #category : #parsing }
DXFParser >> EXTMIN1 [
	"answer a 3d point"

	self readXYZ.
	self cVar at: 'EXTMIN' put: aItem.
	self count: #cVar
]

{ #category : #parsing }
DXFParser >> HEADER [
	
	[self nextPair.
	self checkEOFin: 'HEADER'.
	self isENDSEC] 
			whileFalse: [groupCode = 9 ifTrue: [self parse: dataString]].
	self unNextPair
]

{ #category : #'parsing entities' }
DXFParser >> INSERT [

	| markName x y z xScale yScale zScale angle extrudeX extrudeY extrudeZ cBlock defName newItem rFfF aAFf aARot aPart aMassMarker |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	xScale := yScale := zScale := 1.
	angle := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 2 put: [ defName := dataString ].
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 41 put: [ xScale := dataNumber ].
	cBlock at: 42 put: [ yScale := dataNumber ].
	cBlock at: 43 put: [ zScale := dataNumber ].
	cBlock at: 50 put: [ angle := dataNumber ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 210 put: [ extrudeX := dataNumber ].
	cBlock at: 220 put: [ extrudeY := dataNumber ].
	cBlock at: 230 put: [ extrudeZ := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'INSERT'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	(cBLOCK includesKey: defName) ifFalse: [ 
		self notify: 'Unknown BLOCK is found ->' at: mark ].
	newItem := (cBLOCK at: defName) copy.
	newItem := newItem scaledBy: (xScale yd: yScale zd: zScale).
	self unNextPair.
	newItem name: markName.
	aItem := aLayer -> newItem.
	newItem graphics isEmpty not ifTrue: [ 
		aAssembly
			ifNil: [ 
				rFfF := x yd: y zd: z.
				aAFf := (StCAD_Geo_GEOEulerAnglesxyz
					         with: 0.0 d
					         with: 0.0 d
					         with: angle asDouble degreesToRadians) aA. "VW_TRANSLATION:StCAD.Geo.GEOEulerAnglesxyz:StCAD_Geo_GEOEulerAnglesxyz"
				aARot := self aAfromExtrusion:
					         (extrudeX yd: extrudeY zd: extrudeZ).
				newItem refFrame
					rFfF: (aARot timesFullColumn: rFfF)
					aAFf: (aARot timesFullMatrix: aAFf) ]
			ifNotNil: [ 
				aPart := StCAD_Geo_GEOPart new. "VW_TRANSLATION:StCAD.Geo.GEOPart:StCAD_Geo_GEOPart"
				aPart name: defName.
				aPart aDXFBLOCK: newItem.
				aMassMarker := StCAD_Geo_GEOMassMarker new. "VW_TRANSLATION:StCAD.Geo.GEOMassMarker:StCAD_Geo_GEOMassMarker"
				aMassMarker name: 'MassMarker'.
				aMassMarker refFrame
					rFfF: aPart aDXFBLOCK aBoundingBox center
					aAFf: (StCAD_Math_FullMatrix identity: 3). "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
				aPart aMassMarker: aMassMarker.
				rFfF := x yd: y zd: z.
				aAFf := (StCAD_Geo_GEOEulerAnglesxyz
					         with: 0.0 d
					         with: 0.0 d
					         with: angle asDouble degreesToRadians) aA.
				aARot := self aAfromExtrusion:
					         (extrudeX yd: extrudeY zd: extrudeZ).
				aPart refFrame
					rFfF: (aARot timesFullColumn: rFfF)
					aAFf: (aARot timesFullMatrix: aAFf).
				aAssembly addAnyPart: aPart ] ].
	^ true
]

{ #category : #parsing }
DXFParser >> INSUNITS [
	
	| iCode |
	[self nextPair.
	dataString = 'EOF' ifTrue: [self expected: 'INSUNITS code 70'].
	groupCode = 0 or: [groupCode = 9]] 
			whileFalse: [groupCode = 70 ifTrue: [iCode := dataNumber]].
	self unNextPair.
	aItem := iCode.
	self cVar at: 'INSUNITS' put: aItem.
	self count: #cVar.
	lengthUnit := self lengthUnitAt: iCode
]

{ #category : #parsing }
DXFParser >> LAYER [
	| iColor name |
	iColor := 0.
	
	[self nextPair.
	dataString = 'EOF' ifTrue: [self expected: 'LAYER'].
	groupCode = 0] 
			whileFalse: 
				[groupCode = 62 ifTrue: [iColor := dataNumber].
				groupCode = 2 ifTrue: [name := dataString]].
	self setLayer: name iColor: iColor.
	self count: #layers.
	aItem := name -> iColor.
	self unNextPair.
	^true
]

{ #category : #'parsing entities' }
DXFParser >> LINE [
	"Extrusion is always in z direction."

	| markName x y z x2 y2 z2 thickness extrudeX extrudeY extrudeZ cBlock newItem |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	x2 := y2 := z2 := 0.
	thickness := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [aLayer := dataString].
	cBlock at: 10 put: [x := dataNumber * lengthUnit].
	cBlock at: 20 put: [y := dataNumber * lengthUnit].
	cBlock at: 30 put: [z := dataNumber * lengthUnit].
	cBlock at: 11 put: [x2 := dataNumber * lengthUnit].
	cBlock at: 21 put: [y2 := dataNumber * lengthUnit].
	cBlock at: 31 put: [z2 := dataNumber * lengthUnit].
	cBlock at: 39 put: [thickness := dataNumber * lengthUnit].
	cBlock at: 62 put: [iColor := dataNumber].
	cBlock at: 210 put: [extrudeX := dataNumber].
	cBlock at: 220 put: [extrudeY := dataNumber].
	cBlock at: 230 put: [extrudeZ := dataNumber].
	
	[self nextPair.
	self checkEOFin: 'LINE'.
	groupCode = 0] 
			whileFalse: [(cBlock at: groupCode) value].
	newItem := self 
				LWPOLYLINEWith: (Array with: (x yd: y zd: z) with: (x2 yd: y2 zd: z2))
				thickness: thickness.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #line.
	^true
]

{ #category : #'parsing entities' }
DXFParser >> LINE1 [

	| markName x y z x2 y2 z2 extrudeX extrudeY extrudeZ cBlock newItem aARot |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	x2 := y2 := z2 := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 11 put: [ x2 := dataNumber * lengthUnit ].
	cBlock at: 21 put: [ y2 := dataNumber * lengthUnit ].
	cBlock at: 31 put: [ z2 := dataNumber * lengthUnit ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 210 put: [ extrudeX := dataNumber ].
	cBlock at: 220 put: [ extrudeY := dataNumber ].
	cBlock at: 230 put: [ extrudeZ := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'LINE'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	newItem := StCAD_Geo_DXFPolyline
		           start: (x yd: y zd: z)
		           end: (x2 yd: y2 zd: z2). "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
	newItem refFrame aAFf: aARot.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #line.
	^ true
]

{ #category : #'parsing entities' }
DXFParser >> LWPOLYLINE [
	| markName flag cx cy z thickness cBulge extrudeX extrudeY extrudeZ cBlock n rfpointsf newItem aARot block |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	flag := 0.
	cx := OrderedCollection new: 10.
	cy := OrderedCollection new: 10.
	z := 0.
	thickness := 0.
	cBulge := IdentityDictionary new: 10.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [aLayer := dataString].
	cBlock at: 10 put: [cx addLast: dataNumber * lengthUnit].
	cBlock at: 20 put: [cy addLast: dataNumber * lengthUnit].
	cBlock at: 38 put: [z := dataNumber * lengthUnit].
	cBlock at: 39 put: [thickness := dataNumber * lengthUnit].
	cBlock at: 42 put: [cBulge at: cx size put: dataNumber].
	cBlock at: 62 put: [iColor := dataNumber].
	cBlock at: 70 put: [flag := dataNumber].
	cBlock at: 90 put: [n := dataNumber].
	cBlock at: 210 put: [extrudeX := dataNumber].
	cBlock at: 220 put: [extrudeY := dataNumber].
	cBlock at: 230 put: [extrudeZ := dataNumber].
	
	[self nextPair.
	self checkEOFin: 'LWPOLYLINE'.
	groupCode = 0] 
			whileFalse: [(cBlock at: groupCode) value].
	rfpointsf := OrderedCollection new: n + 1.
	1 to: n do: [:i | rfpointsf addLast: ((cx at: i) yd: (cy at: i) zd: z)].
	flag = 1 ifTrue: [rfpointsf addLast: rfpointsf first].
	rfpointsf := self LWPOLYLINEWith: rfpointsf cBulge: cBulge.
	newItem := self LWPOLYLINEWith: rfpointsf thickness: thickness.
	block := 
			[:graphic | 
			graphic name: markName.
			self setColorFor: graphic.
			(extrudeX = 0 and: [extrudeY = 0 and: [extrudeZ = 1]]) 
				ifFalse: 
					[aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
					graphic refFrame aAFf: aARot]].
	newItem isSequenceable 
		ifTrue: [newItem do: block]
		ifFalse: [block value: newItem].
	self unNextPair.
	aItem := aLayer -> newItem.
	self count: #lwpolyline.
	^true
]

{ #category : #'parsing entities' }
DXFParser >> LWPOLYLINE1 [

	| markName flag cx cy z extrudeX extrudeY extrudeZ cBlock n rfpointsf newItem aARot |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	flag := 0.
	cx := OrderedCollection new: 10.
	cy := OrderedCollection new: 10.
	z := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ cx addLast: dataNumber * lengthUnit ].
	cBlock at: 20 put: [ cy addLast: dataNumber * lengthUnit ].
	cBlock at: 38 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 62 put: [ iColor := dataNumber ].
	cBlock at: 70 put: [ flag := dataNumber ].
	cBlock at: 90 put: [ n := dataNumber ].
	cBlock at: 210 put: [ extrudeX := dataNumber ].
	cBlock at: 220 put: [ extrudeY := dataNumber ].
	cBlock at: 230 put: [ extrudeZ := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'LWPOLYLINE'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	rfpointsf := OrderedCollection new: n + 1.
	1 to: n do: [ :i | 
	rfpointsf addLast: ((cx at: i) yd: (cy at: i) zd: z) ].
	flag = 1 ifTrue: [ rfpointsf addLast: rfpointsf first ].
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem rfpointsf: rfpointsf.
	aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
	newItem refFrame aAFf: aARot.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #polyline.
	^ true
]

{ #category : #'parsing entities' }
DXFParser >> LWPOLYLINEWith: crfpf cBulge: cBulge [

	"Bulge is the number of half chord length from the midpoint of the chord to the opposite point on the circumference of the circle."

	"
	d := half chord length.
	r := radius.
	h := height of center from chord.
	b := bulge.
	bd = r - h.
	r^2 = d^2 + h^2.
	(bd + h)^2 = d^2 + h^2.
	(bd)^2 + 2bdh + h^2 = d^2 + h^2.
	2bdh = d^2 - (bd)^2.
	h = (d^2 - (bd)^2)/2bd = (d/2b)*(1 - b^2)
	"

	| n answer |
	n := crfpf size.
	answer := OrderedCollection new: n.
	1 to: n - 1 do: [ :i | 
		(cBulge at: i)
			ifNil: [ answer add: (crfpf at: i) ]
			ifNotNil: [ :aBulge | 
				| sign magBulge dVector dDir dMag hDir hMag rMag center offAngle endAngle startAngle twoPi arcAngle nn dangle |
				sign := aBulge sign.
				magBulge := aBulge abs.
				dVector := 0.5 d * ((crfpf at: i + 1) - (crfpf at: i)).
				dDir := dVector copy normalizeSelf.
				dMag := dVector length.
				hDir := ((StCAD_Geo_GEOEulerAnglesxyz
					          with: 0.0 d
					          with: 0.0 d
					          with: sign * Double pi / 2)
					         calc;
					         aA) timesFullColumn: dDir. "VW_TRANSLATION:StCAD.Geo.GEOEulerAnglesxyz:StCAD_Geo_GEOEulerAnglesxyz"
				hMag := dMag / (2 * magBulge) * (1 - (magBulge * magBulge)).
				rMag := magBulge * dMag + hMag.
				center := (crfpf at: i) + dVector + (hMag * hDir).
				offAngle := Double
					            arcTan0to2piY: hDir y negated
					            overX: hDir x negated.
				endAngle := sign * (Double arcTan0to2piY: dMag overX: hMag).
				startAngle := endAngle negated.
				endAngle := endAngle + offAngle.
				startAngle := startAngle + offAngle.
				twoPi := 2 * Double pi.
				arcAngle := endAngle - startAngle.
				nn := (self nSegment * arcAngle abs / twoPi) rounded + 1.
				dangle := arcAngle / nn.
				answer add: (crfpf at: i).
				2 to: nn do: [ :j | 
					| angle xx yy rfpf |
					angle := startAngle + (j - 1 * dangle).
					xx := rMag * angle cos.
					yy := rMag * angle sin.
					rfpf := center + (xx yd: yy zd: 0.0 d).
					answer add: rfpf ] ] ].
	answer add: crfpf last.
	^ answer
]

{ #category : #'parsing entities' }
DXFParser >> LWPOLYLINEWith: crfbotf thickness: thickness [

	| block |
	block := [ :crfpf | 
	         StCAD_Geo_DXFPolyline new
		         rfpointsf: crfpf;
		         yourself "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline" ].
	^ thickness isZero
		  ifTrue: [ block value: crfbotf ]
		  ifFalse: [ 
			  | answer crftopf n |
			  answer := OrderedCollection new: crfbotf size + 2.
			  crftopf := crfbotf collect: [ :rfbotf | 
				             rfbotf copy
					             at: 3 plusNumber: thickness;
					             yourself ].
			  answer add: (block value: crfbotf).
			  answer add: (block value: crftopf).
			  n := crfbotf first = crfbotf last
				       ifTrue: [ crfbotf size - 1 ]
				       ifFalse: [ crfbotf size ].
			  1 to: n do: [ :i | 
				  answer add:
					  (StCAD_Geo_DXFPolyline
						   start: (crfbotf at: i)
						   end: (crftopf at: i)) ].
			  answer ]
]

{ #category : #parsing }
DXFParser >> MEASUREMENT [
	| iCode |
	
	[self nextPair.
	dataString = 'EOF' ifTrue: [self expected: 'MEASUREMENT code 70'].
	groupCode = 0 or: [groupCode = 9]] 
			whileFalse: [groupCode = 70 ifTrue: [iCode := dataNumber]].
	self unNextPair.
	aItem := iCode.
	self cVar at: 'MEASUREMENT' put: aItem.
	self count: #cVar
]

{ #category : #parsing }
DXFParser >> OBJECTS [
	
	[self nextPair.
	self checkEOFin: 'OBJECTS'.
	self isENDSEC] 
			whileFalse: [groupCode = 0 ifTrue: [self parse: dataString]].
	self count: #sections.
	self unNextPair
]

{ #category : #'parsing entities' }
DXFParser >> POLYLINE [
	| markName flag m n x y z extrudeX extrudeY extrudeZ cVertex cBlock isClosedPolylineOrClosedM hasCurveFitVertex hasSplineFitVertex isPolyline isPolygonMesh isClosedN isPolyfaceMesh hasLinePattern newItem block |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	flag := m := n := 0.
	x := y := z := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cVertex := OrderedCollection new: 10.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 0
		put: 
			[self parse: dataString.
			cVertex add: aItem value].
	cBlock at: 8 put: [aLayer := dataString].
	cBlock at: 10 put: [x := dataNumber * lengthUnit].
	cBlock at: 20 put: [y := dataNumber * lengthUnit].
	cBlock at: 30 put: [z := dataNumber * lengthUnit].
	cBlock at: 62 put: [iColor := dataNumber].
	cBlock at: 70 put: [flag := dataNumber].
	cBlock at: 71 put: [m := dataNumber].
	cBlock at: 72 put: [n := dataNumber].
	cBlock at: 210 put: [extrudeX := dataNumber].
	cBlock at: 220 put: [extrudeY := dataNumber].
	cBlock at: 230 put: [extrudeZ := dataNumber].
	
	[self nextPair.
	self checkEOFin: 'POLYLINE'.
	self isSEQEND] 
			whileFalse: [(cBlock at: groupCode) value].
	isClosedPolylineOrClosedM := (flag bitAt: 1) = 1.
	hasCurveFitVertex := (flag bitAt: 2) = 1.
	hasSplineFitVertex := (flag bitAt: 3) = 1.
	isPolyline := (flag bitAt: 4) = 1.
	isPolygonMesh := (flag bitAt: 5) = 1.
	isClosedN := (flag bitAt: 6) = 1.
	isPolyfaceMesh := (flag bitAt: 7) = 1.
	hasLinePattern := (flag bitAt: 8) = 1.
	newItem := isPolyline 
				ifTrue: 
					[isClosedPolylineOrClosedM 
						ifTrue: [self closedPolylineWith: cVertex]
						ifFalse: [self openPolylineWith: cVertex]]
				ifFalse: 
					[isPolygonMesh 
						ifTrue: 
							[isClosedPolylineOrClosedM 
								ifTrue: 
									[isClosedN 
										ifTrue: 
											[self 
												closedMNPolygonMeshWith: cVertex
												m: m
												n: n]
										ifFalse: 
											[self 
												closedMPolygonMeshWith: cVertex
												m: m
												n: n]]
								ifFalse: 
									[isClosedN 
										ifTrue: 
											[self 
												closedNPolygonMeshWith: cVertex
												m: m
												n: n]
										ifFalse: 
											[self 
												openPolygonMeshWith: cVertex
												m: m
												n: n]]]
						ifFalse: 
							[isPolyfaceMesh 
								ifTrue: 
									[self 
										openPolyfaceMeshWith: cVertex
										m: m
										n: n]
								ifFalse: 
									[isClosedPolylineOrClosedM 
										ifTrue: [self closedPolylineWith: cVertex]
										ifFalse: 
											[hasCurveFitVertex 
												ifTrue: [self openPolylineWith: cVertex]
												ifFalse: 
													[hasSplineFitVertex 
														ifTrue: [self openPolylineWith: cVertex]
														ifFalse: [hasLinePattern ifTrue: [self halt] ifFalse: [self halt]]]]]]].
	block := 
			[:graphic | 
			| rFfF aARot |
			graphic name: markName.
			self setColorFor: graphic.
			(x = 0 and: 
					[y = 0 
						and: [z = 0 and: [extrudeX = 0 and: [extrudeY = 0 and: [extrudeZ = 1]]]]]) 
				ifFalse: 
					[rFfF := x yd: y zd: z.
					aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
					graphic refFrame rFfF: (aARot timesFullColumn: rFfF) aAFf: aARot]].
	newItem isSequenceable 
		ifTrue: [newItem do: block]
		ifFalse: [block value: newItem].
	aItem := aLayer -> newItem.
	self count: #polyline.
	^true
]

{ #category : #'parsing entities' }
DXFParser >> POLYLINE1 [
	| markName flag m n extrudeX extrudeY extrudeZ cVertex cBlock x y z newItem block rFfF aARot |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	flag := m := n := 0.
	x := y := z := 0.
	extrudeX := extrudeY := 0.
	extrudeZ := 1.
	cVertex := OrderedCollection new: 10.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 0
		put: 
			[self parse: dataString.
			cVertex add: aItem value].
	cBlock at: 8 put: [aLayer := dataString].
	cBlock at: 10 put: [x := dataNumber * lengthUnit].
	cBlock at: 20 put: [y := dataNumber * lengthUnit].
	cBlock at: 30 put: [z := dataNumber * lengthUnit].
	cBlock at: 62 put: [iColor := dataNumber].
	cBlock at: 70 put: [flag := dataNumber].
	cBlock at: 71 put: [m := dataNumber].
	cBlock at: 72 put: [n := dataNumber].
	cBlock at: 210 put: [extrudeX := dataNumber].
	cBlock at: 220 put: [extrudeY := dataNumber].
	cBlock at: 230 put: [extrudeZ := dataNumber].
	
	[self nextPair.
	self checkEOFin: 'POLYLINE'.
	self isSEQEND] 
			whileFalse: [(cBlock at: groupCode) value].
	cBlock := IdentityDictionary new: 10.
	cBlock at: 1
		put: 
			[m = 0 
				ifTrue: [self closedPolylineWith: cVertex]
				ifFalse: 
					[self 
						closedMPolygonMeshWith: cVertex
						m: m
						n: n]].
	cBlock at: 2 put: [self halt].
	cBlock at: 4 put: [self halt].
	cBlock at: 8 put: [self openPolylineWith: cVertex].
	cBlock at: 16
		put: 
			[self 
				openPolygonMeshWith: cVertex
				m: m
				n: n].
	cBlock at: 32
		put: 
			[self 
				closedNPolygonMeshWith: cVertex
				m: m
				n: n].
	cBlock at: 48
		put: 
			[self 
				closedMNPolygonMeshWith: cVertex
				m: m
				n: n].
	cBlock at: 64
		put: 
			[self 
				openPolyfaceMeshWith: cVertex
				m: m
				n: n].
	cBlock at: 128 put: [self halt].
	newItem := (cBlock at: flag) value.
	block := 
			[:graphic | 
			graphic name: markName.
			self setColorFor: graphic.
			(x = 0 and: 
					[y = 0 
						and: [z = 0 and: [extrudeX = 0 and: [extrudeY = 0 and: [extrudeZ = 1]]]]]) 
				ifFalse: 
					[rFfF := x yd: y zd: z.
					aARot := self aAfromExtrusion: (extrudeX yd: extrudeY zd: extrudeZ).
					graphic refFrame rFfF: (aARot timesFullColumn: rFfF) aAFf: aARot]].
	newItem isSequenceable 
		ifTrue: [newItem do: block]
		ifFalse: [block value: newItem].
	aItem := aLayer -> newItem.
	self count: #polyline.
	^true
]

{ #category : #parsing }
DXFParser >> SECTION [
"	self halt."
	
	[self nextPair.
	self checkEOFin: 'SECTION'.
	self isENDSEC] 
			whileFalse: [groupCode = 2 ifTrue: [self parse: dataString]].
	self count: #sections.
	self unNextPair
]

{ #category : #'parsing entities' }
DXFParser >> SOLID [

	| markName x y z x2 y2 z2 x3 y3 z3 x4 y4 z4 cBlock crfpf newItem |
	markName := mark printString.
	aLayer := '0'.
	iColor := 256.
	x := y := z := 0.
	x2 := y2 := z2 := 0.
	x3 := y3 := z3 := 0.
	x4 := y4 := z4 := 0.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 2 put: [ aLayer := dataString ].
	cBlock at: 10 put: [ x := dataNumber * lengthUnit ].
	cBlock at: 20 put: [ y := dataNumber * lengthUnit ].
	cBlock at: 30 put: [ z := dataNumber * lengthUnit ].
	cBlock at: 11 put: [ x2 := dataNumber * lengthUnit ].
	cBlock at: 21 put: [ y2 := dataNumber * lengthUnit ].
	cBlock at: 31 put: [ z2 := dataNumber * lengthUnit ].
	cBlock at: 12 put: [ x3 := dataNumber * lengthUnit ].
	cBlock at: 22 put: [ y3 := dataNumber * lengthUnit ].
	cBlock at: 32 put: [ z3 := dataNumber * lengthUnit ].
	cBlock at: 13 put: [ x4 := dataNumber * lengthUnit ].
	cBlock at: 23 put: [ y4 := dataNumber * lengthUnit ].
	cBlock at: 33 put: [ z4 := dataNumber * lengthUnit ].
	cBlock at: 62 put: [ iColor := dataNumber ].

	[ 
	self nextPair.
	self checkEOFin: 'SOLID'.
	groupCode = 0 ] whileFalse: [ (cBlock at: groupCode) value ].
	crfpf := OrderedCollection new: 5.
	crfpf addLast: (x yd: y zd: z).
	crfpf addLast: (x2 yd: y2 zd: z2).
	crfpf addLast: (x3 yd: y3 zd: z3).
	crfpf addLast: (x4 yd: y4 zd: z4).
	crfpf addLast: crfpf first.
	newItem := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	newItem rfpointsf: crfpf.
	self unNextPair.
	newItem name: markName.
	self setColorFor: newItem.
	aItem := aLayer -> newItem.
	self count: #SOLID.
	^ true
]

{ #category : #parsing }
DXFParser >> TABLE [
	
	[self nextPair.
	self checkEOFin: 'TABLE'.
	self isENDTAB] 
			whileFalse: [groupCode = 0 ifTrue: [self parse: dataString]].
	self unNextPair.
	^true
]

{ #category : #parsing }
DXFParser >> TABLES [
	
	[self nextPair.
	self checkEOFin: 'TABLES'.
	self isENDSEC] 
			whileFalse: [groupCode = 0 ifTrue: [self parse: dataString]].
	self unNextPair
]

{ #category : #'parsing entities' }
DXFParser >> VERTEX [
	| flag x y z cBlock v1 v2 v3 v4 newItem |
	aLayer := '0'.
	iColor := 256.
	flag := 32.
	x := y := z := 0.0.
	cBlock := IdentityDictionary new: 10.
	cBlock at: 8 put: [aLayer := dataString].
	cBlock at: 10 put: [x := dataNumber * lengthUnit].
	cBlock at: 20 put: [y := dataNumber * lengthUnit].
	cBlock at: 30 put: [z := dataNumber * lengthUnit].
	cBlock at: 62 put: [iColor := dataNumber].
	cBlock at: 70 put: [flag := dataNumber].
	cBlock at: 71 put: [v1 := dataNumber].
	cBlock at: 72 put: [v2 := dataNumber].
	cBlock at: 73 put: [v3 := dataNumber].
	cBlock at: 74 put: [v4 := dataNumber].
	
	[self nextPair.
	self checkEOFin: 'VERTEX'.
	groupCode = 0] 
			whileFalse: [(cBlock at: groupCode) value].
	newItem := flag == 128 
				ifTrue: 
					[| cVertex block |
					cVertex := OrderedCollection new: 4.
					block := [:v | cVertex add: v].
					v1 ifNotNil: block.
					v2 ifNotNil: block.
					v3 ifNotNil: block.
					v4 ifNotNil: block.
					cVertex]
				ifFalse: [x yd: y zd: z].
	aItem := aLayer -> newItem.
	self count: #vertex.
	self unNextPair.
	^true
]

{ #category : #accessing }
DXFParser >> aAfromExtrusion: argzDir [

	| zDir oneOver64 |
	zDir := argzDir copy normalizeSelf.
	oneOver64 := (1 / 64) asDouble.
	^ (zDir x abs < oneOver64 and: [ zDir y abs < oneOver64 ])
		  ifTrue: [ 
			  StCAD_Math_FullMatrix
				  rotationMatrixFromzDir: zDir
				  yDir: (0 yd: 1 zd: 0) "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix" ]
		  ifFalse: [ 
			  StCAD_Math_FullMatrix
				  rotationMatrixFromzDir: zDir
				  yDir: (0 yd: 0 zd: 1) ]
]

{ #category : #accessing }
DXFParser >> aAssembly [
	^aAssembly
]

{ #category : #accessing }
DXFParser >> aAssembly: anObject [
	aAssembly := anObject
]

{ #category : #accessing }
DXFParser >> cLayerColor [
	cLayerColor isNil ifTrue: [cLayerColor := Dictionary new: 50].
	^cLayerColor
]

{ #category : #accessing }
DXFParser >> cVar [
	cVar isNil ifTrue: [cVar := Dictionary new: 10].
	^cVar
]

{ #category : #parsing }
DXFParser >> checkEOFin: aString [ 
	self isEOF ifTrue: [self expected: aString]
]

{ #category : #parsing }
DXFParser >> checkForUnits [
	| m inch ft yard mile mm cm km aDict unit dm |
	lengthUnit ifNil: 
			[m := 1.0d.
			inch := 0.0254d * m.
			ft := 12 * inch.
			yard := 3 * ft.
			mile := 5280 * ft.
			mm := 0.001d * m.
			cm := 0.01d * m.
			dm := 0.1d * m.
			km := 1000.0d * m.
			aDict := Dictionary new: 10.
			aDict at: #inch put: inch.
			aDict at: #feet put: ft.
			aDict at: #yard put: yard.
			aDict at: #mile put: mile.
			aDict at: #millimeter put: mm.
			aDict at: #centimeter put: cm.
			aDict at: #decimeter put: dm.
			aDict at: #meter put: m.
			aDict at: #kilometer put: km.
			aDict at: #custom
				put: 
					[| answer |
					
					[answer := Dialog prompt: 'How many meters is one custom unit?'
								defaultExpression: 1.
					answer isNil] 
							whileTrue.
					answer].
			
			[unit := Dialog 
						choose: 'Choose a length unit.'
						fromVerticallyAlignedButtonsWithLabels: #('inch' 'feet' 'yard' 'mile' 'millimeter' 'centimeter' 'decimeter' 'meter' 'kilometer' 'custom')
						values: #(#inch #feet #yard #mile #millimeter #centimeter #decimeter #meter #kilometer #custom)
						default: #millimeter.
			unit == #cancel] 
					whileTrue.
			lengthUnit := (aDict at: unit) value].
	^lengthUnit
]

{ #category : #'parsing entities' }
DXFParser >> closedMNPolygonMeshWith: cVertex m: m n: n [

	| aMatrix aMatrix2 aMatrix3 cPolygon |
	aMatrix := self matrixWith: cVertex m: m n: n.
	aMatrix2 := StCAD_Math_FullMatrix new: m + 1 by: n. "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
	aMatrix2 at: 1 and: 1 putFullMatrix: aMatrix.
	aMatrix2 at: m + 1 and: 1 putFullRow: (aMatrix at: 1).
	aMatrix3 := StCAD_Math_FullMatrix new: m + 1 by: n + 1.
	aMatrix3 at: 1 and: 1 putFullMatrix: aMatrix2.
	aMatrix3 at: 1 and: n + 1 putFullColumn: (aMatrix2 column: 1).
	cPolygon := OrderedCollection new: m * n.
	1 to: m do: [ :i | 
		1 to: n do: [ :j | 
			| aPolygon crfpf |
			aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
			crfpf := OrderedCollection new: 10.
			crfpf add: (aMatrix3 at: i and: j).
			crfpf add: (aMatrix3 at: i + 1 and: j).
			crfpf add: (aMatrix3 at: i + 1 and: j + 1).
			crfpf add: (aMatrix3 at: i and: j + 1).
			crfpf add: crfpf first.
			aPolygon rfpointsf: crfpf.
			cPolygon add: aPolygon ] ].
	^ cPolygon
]

{ #category : #'parsing entities' }
DXFParser >> closedMPolygonMeshWith: cVertex m: m n: n [

	| aMatrix aMatrix2 cPolygon |
	aMatrix := self matrixWith: cVertex m: m n: n.
	aMatrix2 := StCAD_Math_FullMatrix new: m + 1 by: n. "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
	aMatrix2 at: 1 and: 1 putFullMatrix: aMatrix.
	aMatrix2 at: m + 1 and: 1 putFullRow: (aMatrix at: 1).
	cPolygon := OrderedCollection new: m * (n - 1).
	1 to: m do: [ :i | 
		1 to: n - 1 do: [ :j | 
			| aPolygon crfpf |
			aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
			crfpf := OrderedCollection new: 10.
			crfpf add: (aMatrix2 at: i and: j).
			crfpf add: (aMatrix2 at: i + 1 and: j).
			crfpf add: (aMatrix2 at: i + 1 and: j + 1).
			crfpf add: (aMatrix2 at: i and: j + 1).
			crfpf add: crfpf first.
			aPolygon rfpointsf: crfpf.
			cPolygon add: aPolygon ] ].
	^ cPolygon
]

{ #category : #'parsing entities' }
DXFParser >> closedNPolygonMeshWith: cVertex m: m n: n [

	| aMatrix aMatrix3 cPolygon |
	aMatrix := self matrixWith: cVertex m: m n: n.
	aMatrix3 := StCAD_Math_FullMatrix new: m by: n + 1. "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
	aMatrix3 at: 1 and: 1 putFullMatrix: aMatrix.
	aMatrix3 at: 1 and: n + 1 putFullColumn: (aMatrix column: 1).
	cPolygon := OrderedCollection new: m - 1 * n.
	1 to: m - 1 do: [ :i | 
		1 to: n do: [ :j | 
			| aPolygon crfpf |
			aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
			crfpf := OrderedCollection new: 10.
			crfpf add: (aMatrix3 at: i and: j).
			crfpf add: (aMatrix3 at: i + 1 and: j).
			crfpf add: (aMatrix3 at: i + 1 and: j + 1).
			crfpf add: (aMatrix3 at: i and: j + 1).
			crfpf add: crfpf first.
			aPolygon rfpointsf: crfpf.
			cPolygon add: aPolygon ] ].
	^ cPolygon
]

{ #category : #'parsing entities' }
DXFParser >> closedPolylineWith: cVertex [

	| aPolygon |
	aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	cVertex add: cVertex first.
	aPolygon rfpointsf: cVertex.
	^ aPolygon
]

{ #category : #accessing }
DXFParser >> count: aSymbol [ 
	"self debug: 'count: ', aSymbol."

	(cCount includesKey: aSymbol) ifFalse: [cCount at: aSymbol put: 0].
	cCount at: aSymbol put: (cCount at: aSymbol) + 1
]

{ #category : #'error handling' }
DXFParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : #accessing }
DXFParser >> iColorOfLayer: aString [ 
	^self cLayerColor at: aString ifAbsent: [0]
]

{ #category : #'initialize-release' }
DXFParser >> initialize [
	lengthUnit := nil.
	cLayer := Dictionary new: 20.
	cBLOCK := Dictionary new: 20.
	cCount := Dictionary new: 10
]

{ #category : #parsing }
DXFParser >> isENDBLK [
	^groupCode = 0 and: [dataString = 'ENDBLK']
]

{ #category : #parsing }
DXFParser >> isENDSEC [
	^groupCode = 0 and: [dataString = 'ENDSEC']
]

{ #category : #parsing }
DXFParser >> isENDTAB [
	^groupCode = 0 and: [dataString = 'ENDTAB']
]

{ #category : #parsing }
DXFParser >> isEOF [
	^groupCode = 0 and: [dataString = 'EOF']
]

{ #category : #parsing }
DXFParser >> isSEQEND [
	^groupCode = 0 and: [dataString = 'SEQEND']
]

{ #category : #accessing }
DXFParser >> lengthUnitAt: iCode [ 
	| m unitless inch microinch mil ft yard mile angstrom nm micron mm cm dm dam hm km Gm AU ly pc aDict |
	m := 1.0d.
	unitless := [self checkForUnits].
	inch := 0.0254d * m.
	microinch := 1.0d-6 * inch.
	mil := 1.0d-3 * inch.
	ft := 12 * inch.
	yard := 3 * ft.
	mile := 5280 * ft.
	angstrom := 1.0d-10 * m.
	nm := 1.0d-9 * m.
	micron := 1.0d-6 * m.
	mm := 0.001d * m.
	cm := 0.01d * m.
	dm := 0.1d * m.
	dam := 10.0d * m.
	hm := 100.0d * m.
	km := 1000.0d * m.
	Gm := 1.0d9 * m.
	AU := 1.496d11 * m.
	ly := 9.463d15 * m.
	pc := 3.086d16 * m.
	aDict := IdentityDictionary new: 20.
	aDict at: 0 put: unitless.
	aDict at: 1 put: inch.
	aDict at: 2 put: ft.
	aDict at: 3 put: mile.
	aDict at: 4 put: mm.
	aDict at: 5 put: cm.
	aDict at: 6 put: m.
	aDict at: 7 put: km.
	aDict at: 8 put: microinch.
	aDict at: 9 put: mil.
	aDict at: 10 put: yard.
	aDict at: 11 put: angstrom.
	aDict at: 12 put: nm.
	aDict at: 13 put: micron.
	aDict at: 14 put: dm.
	aDict at: 15 put: dam.
	aDict at: 16 put: hm.
	aDict at: 17 put: Gm.
	aDict at: 18 put: AU.
	aDict at: 19 put: ly.
	aDict at: 20 put: pc.
	^(aDict at: iCode) value
]

{ #category : #'parsing entities' }
DXFParser >> matrixWith: cVertex m: m n: n [

	| aMatrix aStream |
	aMatrix := StCAD_Math_FullMatrix new: m by: n. "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
	aStream := cVertex readStream.
	1 to: m do: [ :i | 
	1 to: n do: [ :j | aMatrix at: i and: j put: aStream next ] ].
	^ aMatrix
]

{ #category : #accessing }
DXFParser >> nSegment [
	^36
]

{ #category : #parsing }
DXFParser >> newDxfDefinition: aString [ 
	| aDXFBLOCK errorString graphic |
	aDXFBLOCK := DXFBLOCK new.
	errorString := #'BLOCK <1s>' << #'StCAD.UI' expandMacrosWith: aString.
	
	[self nextPair.
	self checkEOFin: errorString.
	self isENDBLK] whileFalse: 
				[groupCode = 0 
					ifTrue: 
						[self parse: dataString.
						aItem ifNotNil: 
								[graphic := aItem value.
								graphic isSequenceable 
									ifTrue: [aDXFBLOCK addGraphics: graphic]
									ifFalse: [aDXFBLOCK addGraphic: graphic]]]].
	self unNextPair.
	self count: #names.
	aDXFBLOCK calcBoundingBox.
	cBLOCK at: aString put: aDXFBLOCK.
	^true
]

{ #category : #scanning }
DXFParser >> nextPair [
	mark := source position.
	source atEnd 
		ifTrue: 
			[dataKey := #eof.
			dataString := 'EOF'.
			^dataKey -> dataString].
	dataKey := source upTo: self lineSeparator.
	lines := lines + 1.
	dataKey := dataKey select: [:x | x isDigit].
	groupCode := dataKey asNumber.
	dataString := source upTo: self lineSeparator.
	lines := lines + 1.
	dataNumber := groupCode = 310 
				ifTrue: [0]
				ifFalse: [dataString importNumber].
	^dataKey -> dataString
]

{ #category : #'error handling' }
DXFParser >> notify: aString at: position [ 
	"Temporarily reset source in order to get full contents"

	| p contents |
	p := source position.
	contents := source
				reset;
				contents.
	source position: p.
	(SyntaxErrorException new)
		targetClass: nil;
		messageText: aString;
		source: contents;
		position: position;
		raiseSignal
]

{ #category : #'parsing entities' }
DXFParser >> openPolyfaceMeshWith: cVertex m: m n: n [

	| acVertex cFace cPolygon |
	acVertex := cVertex copyFrom: 1 to: m.
	cFace := cVertex copyFrom: m + 1 to: m + n.
	cPolygon := OrderedCollection new: n.
	1 to: n do: [ :i | 
		| aPolygon crfpf cFlag aFace |
		aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
		crfpf := OrderedCollection new: 5.
		cFlag := OrderedCollection new: 5.
		aFace := cFace at: i.
		aFace do: [ :j | 
			crfpf add: (acVertex at: j abs).
			cFlag add: j positive ].
		crfpf add: crfpf first.
		aPolygon rfpointsf: crfpf.
		aPolygon cFlag: cFlag.
		cPolygon add: aPolygon ].
	^ cPolygon
]

{ #category : #'parsing entities' }
DXFParser >> openPolygonMeshWith: cVertex m: m n: n [

	| aMatrix cPolygon aPolygon crfpf |
	aMatrix := self matrixWith: cVertex m: m n: n.
	cPolygon := OrderedCollection new: m - 1 * (n - 1).
	1 to: m - 1 do: [ :i | 
		1 to: n - 1 do: [ :j | 
			aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
			crfpf := OrderedCollection new: 10.
			crfpf add: (aMatrix at: i and: j).
			crfpf add: (aMatrix at: i + 1 and: j).
			crfpf add: (aMatrix at: i + 1 and: j + 1).
			crfpf add: (aMatrix at: i and: j + 1).
			crfpf add: crfpf first.
			aPolygon rfpointsf: crfpf.
			cPolygon add: aPolygon ] ].
	^ cPolygon
]

{ #category : #'parsing entities' }
DXFParser >> openPolylineWith: cVertex [

	| aPolygon |
	aPolygon := StCAD_Geo_DXFPolyline new. "VW_TRANSLATION:StCAD.Geo.DXFPolyline:StCAD_Geo_DXFPolyline"
	aPolygon rfpointsf: cVertex.
	^ aPolygon
]

{ #category : #accessing }
DXFParser >> paintColor: anInteger [ 
	| index |
	index := anInteger.
	(index between: 1 and: 255) ifFalse: [index := 7].
	^self class colorAt: index
]

{ #category : #parsing }
DXFParser >> parse [
	
	[self nextPair.
	self isEOF] 
			whileFalse: [groupCode = 0 ifTrue: [self parse: dataString]]
]

{ #category : #parsing }
DXFParser >> parse1: string [ 
	| char symbol |
	char := string first.
	symbol := ((char = $$ or: [char isDigit]) 
				ifTrue: [string copyFrom: 2 to: string size]
				ifFalse: [string]) asSymbol.
	self performIfCan: symbol else: [:arg | aItem := nil]
]

{ #category : #parsing }
DXFParser >> parse2: string [ 
	| char symbol aSet |
	char := string first.
	symbol := ((char = $$ or: [char isDigit]) 
				ifTrue: [string copyFrom: 2 to: string size]
				ifFalse: [string]) asSymbol.
	aSet := Set new.
	aSet add: #CIRCLE.
	aSet add: #LWPOLYLINE.
	aSet add: #POLYLINE.
	aSet add: #DFACE.
	aSet add: #VERTEX.
	(aSet includes: symbol) 
		ifFalse: [self performIfCan: symbol else: [:arg | aItem := nil]]
]

{ #category : #parsing }
DXFParser >> parse: string [ 
	| char symbol |
	char := string first.
	symbol := ((char = $$ or: [char isDigit]) 
				ifTrue: [string copyFrom: 2 to: string size]
				ifFalse: [string]) asSymbol.
	self performIfCan: symbol else: [:arg | aItem := nil]
]

{ #category : #parsing }
DXFParser >> readXYZ [

	"answer a 3d point"

	| x y z newItem |
	x := y := z := 0.0.

	[ 
	self nextPair.
	dataString = 'EOF' ifTrue: [ self expected: 'xyz coordinates' ].
	groupCode = 0 or: [ groupCode = 9 ] ] whileFalse: [ 
		groupCode = 10 ifTrue: [ x := dataNumber * lengthUnit ].
		groupCode = 20 ifTrue: [ y := dataNumber * lengthUnit ].
		groupCode = 30 ifTrue: [ z := dataNumber * lengthUnit ] ].
	newItem := StCAD_Math_FullColumn with: x with: y with: z. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	aItem := newItem.
	self unNextPair.
	^ true
]

{ #category : #'parsing entities' }
DXFParser >> setColorFor: graphic [ 
	"To do: how to handle negative iColor and background color of screen."

	iColor = 256 ifTrue: [iColor := self iColorOfLayer: aLayer].
	iColor > 0 
		ifTrue: [graphic aColor: (self paintColor: iColor)]
		ifFalse: [graphic aColor: SymbolicPaint background]
]

{ #category : #accessing }
DXFParser >> setLayer: aName iColor: index [ 
	self cLayerColor at: aName put: index
]
