"
c_uvCurve := Collection of piecewise uv curves in order.
uvCurve is the parametric representation of xyzCurve on a xyzSurface.
Although xyzCurve is a single curve, singularities may require piecewise combination of multiple uvCurves.
For example: a meridian going over the north pole of a sphere will have discontinuous uvCurves.
aNMTItem := xyzCurve in space.



"
Class {
	#name : #FaceEdgeUse,
	#superclass : #EdgeUse,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
FaceEdgeUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
FaceEdgeUse >> _aCurve [
	^isSameSense ifTrue: [self aCurve] ifFalse: [self aCurve reverse]
]

{ #category : #accessing }
FaceEdgeUse >> aFace [
	^aSup aFace
]

{ #category : #accessing }
FaceEdgeUse >> aLoop [
	^aSup aLoop
]

{ #category : #accessing }
FaceEdgeUse >> aSurface [
	^aSup aSurface
]

{ #category : #accessing }
FaceEdgeUse >> addGeometry: aORIENTED_EDGE onFACE: aFACE [ 
	self c_uvCurve: (aORIENTED_EDGE xyzCurve uvCurveOnSurface: aFACE aSurface).
	self isSameSense: true
]

{ #category : #accessing }
FaceEdgeUse >> addGeometry: aORIENTED_EDGE onFACE: aFACE preEdgeUse: preEdgeUse [

	self aCurve: (aORIENTED_EDGE xyzCurve uvCurveOnSurface: aFACE aSurface
				preCurve: (preEdgeUse ifNotNil: [:a | a _aCurve])).
	self isSameSense: true
]

{ #category : #accessing }
FaceEdgeUse >> addMateGeometry [
	mate c_uvCurve: self c_uvCurve.
	mate isSameSense: false
]

{ #category : #accessing }
FaceEdgeUse >> cEndSingularity [
	^self aSurface cEndSingularityOf: self aCurve
]

{ #category : #accessing }
FaceEdgeUse >> cglTrimNurbs [

	^self c_uvCurve collect: [:uvCurve | uvCurve glTrimNurbs]
]

{ #category : #accessing }
FaceEdgeUse >> cgluvTrimNurbs [

	^self c_uvCurve collect: [:uvCurve | uvCurve glTrimNurbs]
]

{ #category : #accessing }
FaceEdgeUse >> conditionSelf [
	self aSurface smooth_cuv: self aCurve
]

{ #category : #accessing }
FaceEdgeUse >> conditionSelfWithin: uvBound [ 
	self aSurface smooth_cuv: self aCurve within: uvBound
]

{ #category : #accessing }
FaceEdgeUse >> create_cglTrimNurbs [

	| cglTrimNurbs |
	cglTrimNurbs := self create_glTrimNurbs.
	self aFaceUse isSameSense
		ifFalse: [cglTrimNurbs cPoint do: [:aPoint | aPoint x: aPoint x negated]].
	^isSameSense ifTrue: [cglTrimNurbs] ifFalse: [cglTrimNurbs reverse]
]

{ #category : #accessing }
FaceEdgeUse >> create_glNurbs [
	| glNurbs |
	glNurbs := self aCurve glNurbs.
	self aFaceUse isSameSense 
		ifFalse: [glNurbs cPoint do: [:aPoint | aPoint x: aPoint x negated]].
	^isSameSense ifTrue: [glNurbs] ifFalse: [glNurbs reverse]
]

{ #category : #accessing }
FaceEdgeUse >> create_glTrimNurbs [
	| glTrimNurbs |
	glTrimNurbs := self aCurve glTrimNurbs.
	self aFaceUse isSameSense 
		ifFalse: [glTrimNurbs cPoint do: [:aPoint | aPoint x: aPoint x negated]].
	^isSameSense ifTrue: [glTrimNurbs] ifFalse: [glTrimNurbs reverse]
]

{ #category : #accessing }
FaceEdgeUse >> create_glTrimNurbs1 [
	| glTrimNurbs |
	glTrimNurbs := self aCurve glTrimNurbs.
	self aFaceUse isSameSense 
		ifFalse: [glTrimNurbs cPoint do: [:aPoint | aPoint x: aPoint x negated]].
	^isSameSense ifTrue: [glTrimNurbs] ifFalse: [glTrimNurbs reverse]
]

{ #category : #accessing }
FaceEdgeUse >> cuvFirst [

	^isSameSense
		ifTrue: [c_uvCurve first cuvFirst]
		ifFalse: [c_uvCurve last cuvLast]
]

{ #category : #accessing }
FaceEdgeUse >> cuvInto: cuv [

	c_uvCurve do: [:uvCurve | uvCurve cuvInto: cuv]
]

{ #category : #accessing }
FaceEdgeUse >> cuvLast [

	^isSameSense
		ifTrue: [c_uvCurve last cuvLast]
		ifFalse: [c_uvCurve first cuvFirst]
]

{ #category : #accessing }
FaceEdgeUse >> die [
	aVertexUse die.
	self c_uvCurve ifNotNil: [self c_uvCurve die].
	mate ifNotNil: [mate mate: nil].
	radial ifNotNil: [radial radial: nil].
	super die
]

{ #category : #accessing }
FaceEdgeUse >> glTrimNurbs [
	^self create_glTrimNurbs
]

{ #category : #accessing }
FaceEdgeUse >> gluvTrimNurbs [

	^self c_uvCurve collect: [:uvCurve | uvCurve glTrimNurbs]
]

{ #category : #calc }
FaceEdgeUse >> minusU: offset [

	c_uvCurve do: [:uvCurve | uvCurve minusU: offset]
]

{ #category : #calc }
FaceEdgeUse >> minusV: offset [

	c_uvCurve do: [:uvCurve | uvCurve minusV: offset]
]

{ #category : #accessing }
FaceEdgeUse >> selectCurve: aBlock into: aSet [

	self c_uvCurve do: [:a | (aBlock value: a) ifTrue: [aSet add: a]]
]

{ #category : #accessing }
FaceEdgeUse >> uvEnd [

	^isSameSense
		ifTrue: [c_uvCurve last uvEnd]
		ifFalse: [c_uvCurve first uvStart]
]

{ #category : #accessing }
FaceEdgeUse >> uvStart [

	^isSameSense
		ifTrue: [c_uvCurve first uvStart]
		ifFalse: [c_uvCurve last uvEnd]
]

{ #category : #accessing }
FaceEdgeUse >> uv_connectTo: aFaceEdgeUse [ 
	self aCurve uv_connectTo: aFaceEdgeUse aCurve
]
