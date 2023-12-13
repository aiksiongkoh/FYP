Class {
	#name : #BasicLine,
	#superclass : #BasicCurve,
	#instVars : [
		'rfStartPointf',
		'rfEndPointf'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
BasicLine >> = aObject [ 
	^self == aObject or: 
			[self class == aObject class and: 
					[(rfStartPointf - aObject rfStartPointf) length < 1.0d-9 
						and: [(rfEndPointf - aObject rfEndPointf) length < 1.0d-9]]]
]

{ #category : #accessing }
BasicLine >> aDir [

	^rfEndPointf minusFullColumn: rfStartPointf.
]

{ #category : #'As yet unclassified' }
BasicLine >> boundCylindricalSurface: aCylindricalSurface [ 
	aCylindricalSurface boundByLine: self
]

{ #category : #accessing }
BasicLine >> boundRectSurface: aRectSurface [ 
	aRectSurface boundByLine: self
]

{ #category : #accessing }
BasicLine >> cPoint [
	^Array with: rfStartPointf with: rfEndPointf.
]

{ #category : #accessing }
BasicLine >> cPoint_n1: n [ 
	| answer delta |
	answer := FullColumn new: n.
	delta := (rfEndPointf - rfStartPointf) / (n - 1).
	0 to: n - 1
		do: 
			[:i | 
			answer at: i put: (rfStartPointf plusFullVector: delta times: i asDouble)].
	^answer
]

{ #category : #accessing }
BasicLine >> cPoint_n: n [
	| delta |
	delta := (rfEndPointf - rfStartPointf) / (n - 1).
	^(0 to: n - 1)
		collect: [:i | rfStartPointf plusFullVector: delta times: i asDouble.].
]

{ #category : #'As yet unclassified' }
BasicLine >> calc [
	"Do nothing"
]

{ #category : #'As yet unclassified' }
BasicLine >> csguess [
	^Array with: (0.0d to: 1.0d nStep: 2)
]

{ #category : #'As yet unclassified' }
BasicLine >> cuv [
	^self cPoint_n: 4
]

{ #category : #accessing }
BasicLine >> gluvCurveOnSurface: aSurface [ 
	| aaCurve |
	aaCurve := aSurface gluvCurveOfLine: self.
"	aSurface condition_cuv: aaCurve."
	^aaCurve
]

{ #category : #'initialize-release' }
BasicLine >> initStartAndEnd [
	rfStartPointf := FullColumn zero: 3.
	rfEndPointf := FullColumn zero: 3.
]

{ #category : #testing }
BasicLine >> intersectPoint: aaPoint lTol: tol [

	| aLinePoint |
	aLinePoint := StCAD_Geo_LinePoint
		              aStartPoint: rfStartPointf
		              aEndPoint: rfEndPointf
		              bPoint: aaPoint. "VW_TRANSLATION:StCAD.Geo.LinePoint:StCAD_Geo_LinePoint"
	^ aLinePoint aMinDist < tol and: [ 
		  | parameter |
		  parameter := aLinePoint aPar.
		  parameter > 0.0 d and: [ parameter < 1.0 d ] ]
]

{ #category : #'As yet unclassified' }
BasicLine >> isSpatial [
	^rfStartPointf size = 3
]

{ #category : #'As yet unclassified' }
BasicLine >> magnifySelf: aDouble [ 
	rfStartPointf magnifySelf: aDouble.
	rfEndPointf magnifySelf: aDouble
]

{ #category : #'As yet unclassified' }
BasicLine >> pprfpfpupu_u: u [ 
	^FullColumn zero: rfStartPointf size
]

{ #category : #'As yet unclassified' }
BasicLine >> prfpfpu_u: u [ 
	^rfEndPointf minusFullColumn: rfStartPointf
]

{ #category : #printing }
BasicLine >> printOn: aStream [ 
	aStream nextPut: $a.
	aStream print: self class.
	aStream nextPut: $(.
	aStream
		cr;
		print: rfStartPointf.
	aStream
		cr;
		print: rfEndPointf.
	aStream nextPut: $)
]

{ #category : #printing }
BasicLine >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'Line';
		cr;
		print: rfStartPointf;
		cr;
		print: rfEndPointf
]

{ #category : #accessing }
BasicLine >> rFEndPointF [
	^rfEndPointf
]

{ #category : #accessing }
BasicLine >> rFStartPointF [
	^rfStartPointf
]

{ #category : #accessing }
BasicLine >> reverse [
	| answer |
	answer := self shallowCopy.
	answer rfStartPointf: rfEndPointf copy.
	answer rfEndPointf: rfStartPointf copy.
	^answer
]

{ #category : #'As yet unclassified' }
BasicLine >> reverseSelf [
	| temp |
	temp := rfStartPointf.
	rfStartPointf := rfEndPointf.
	rfEndPointf := temp
]

{ #category : #accessing }
BasicLine >> rfEndPointf [
	^rfEndPointf
]

{ #category : #accessing }
BasicLine >> rfEndPointf: aFullColumn [ 
	rfEndPointf := aFullColumn
]

{ #category : #accessing }
BasicLine >> rfStartPointf [
	^rfStartPointf
]

{ #category : #accessing }
BasicLine >> rfStartPointf: aFullColumn [ 
	rfStartPointf := aFullColumn
]

{ #category : #'As yet unclassified' }
BasicLine >> rfpfNurbs [
	^BasicNURBSCurve fromLine: self.
]

{ #category : #'As yet unclassified' }
BasicLine >> rfpf_u: u [ 
	^u = 0.0d 
		ifTrue: [rfStartPointf shallowCopy]
		ifFalse: 
			[u = 1.0d 
				ifTrue: [rfEndPointf shallowCopy]
				ifFalse: 
					[rfStartPointf 
						times: 1.0d - u
						plusFullColumn: rfEndPointf
						times: u]]
]

{ #category : #accessing }
BasicLine >> uOfPoint: rFpF [
	| avec bvec |
	avec := rFpF - rfStartPointf.
	bvec := rfEndPointf - rfStartPointf.
	self assert: 
			[| tol |
			tol := 1.0d-3.
			self toTranscriptCrShow: 'Line ((avec cross: bvec) length / tol) <1p>'
				ifOverOne: (avec cross: bvec) length / tol.
			true.].
	^(avec dot: bvec) / bvec sumOfSquares.
]

{ #category : #accessing }
BasicLine >> uvCurveOnSurface: aSurface [ 
	| aaCurve |
	aaCurve := aSurface uvCurveOfLine: self.
"	aSurface condition_cuv: aaCurve."
	^aaCurve
]

{ #category : #accessing }
BasicLine >> uvEnd: aFullColumn [ 
	rfEndPointf := aFullColumn
]

{ #category : #accessing }
BasicLine >> uvStart: aFullColumn [ 
	rfStartPointf := aFullColumn
]

{ #category : #'As yet unclassified' }
BasicLine >> uv_connectFromLine: aLine [ 
	aLine uv_connectToLine: self
]

{ #category : #'As yet unclassified' }
BasicLine >> uv_connectTo: aCurve [ 
	aCurve uv_connectFromLine: self
]

{ #category : #'As yet unclassified' }
BasicLine >> uv_connectToLine: aLine [ 
	aLine rfStartPointf: self rfEndPointf copy
]

{ #category : #'As yet unclassified' }
BasicLine >> uvend [
	^rfEndPointf
]

{ #category : #'As yet unclassified' }
BasicLine >> uvstart [
	^rfStartPointf
]
