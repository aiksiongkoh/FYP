"
The points are defined relative to the first point, i.e. the first point is always (0,0,0).

Instance Variables:

points	<OrderedCollection>	vertices of polyline.
isClosed	<Boolean>		first point = last point.
"
Class {
	#name : #GEOPolyline,
	#superclass : #GEOCurve,
	#instVars : [
		'rfpointsf',
		'isClosed'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOPolyline >> aBoundingBox [
	^self triggerEvent: #getBoundingBox
]

{ #category : #calc }
GEOPolyline >> calcBoundingBox [
	| aBoundingBox |
	aBoundingBox := BoundingBox new.
	rfpointsf inject: aBoundingBox
		into: [:bbox :rfpf | bbox expandToBound: rfpf].
	self aBoundingBox: aBoundingBox
]

{ #category : #accessing }
GEOPolyline >> crfpointf [
	^rfpointsf
]

{ #category : #testing }
GEOPolyline >> isClosed [
	^isClosed
]

{ #category : #testing }
GEOPolyline >> isClosed: bool [ 
	isClosed := bool
]

{ #category : #accessing }
GEOPolyline >> listCopyOfPoints [
	| list |
	list := List new: rfpointsf size.
	rfpointsf do: [:rfpointf | list addLast: rfpointf copy].
	^list
]

{ #category : #accessing }
GEOPolyline >> magnifySelf: aDouble [ 
	self aBoundingBox ifNotNil: [:a | a magnifySelf: aDouble].
	self aRefFrame magnifySelf: aDouble.
	self crfpointf do: [:rfpointf | rfpointf magnifySelf: aDouble]
]

{ #category : #'ops on self' }
GEOPolyline >> makeOppositeFacePositive [
	"
	For plane loops only. 
	Flip refFrame 180 degrees about x-axis. 
	Reverse order of rfpointsf. 
	Negate all y coordinates of rfpointsf. 
	"

	refFrame rotateAxisf: 1 theta: Double pi.
	rfpointsf := rfpointsf reverse.
	rfpointsf do: [:rfpointf | rfpointf at: 2 put: (rfpointf at: 2) negated]
]

{ #category : #copying }
GEOPolyline >> postCopy [
	super postCopy.
	rfpointsf := rfpointsf collect: [:rfpointf | rfpointf copy]
]

{ #category : #accessing }
GEOPolyline >> rFpointsF: array [ 
	"
	rFpF := rFfF + aAFf * rfpf. 
	rfpf := aAFfT * (rFpF - rFfF). 
	"

	| rFfF aAFfT |
	rFfF := array at: 1.
	refFrame rFfF: rFfF.
	aAFfT := refFrame aAFf transpose.
	self rfpointsf: (array collect: [:rFpF | aAFfT timesFullColumn: rFpF - rFfF])
]

{ #category : #accessing }
GEOPolyline >> refFrame: refFrm rFpointsF: rFptsF [ 
	"If polyline is closed, create a Frame at first point and use right hand rule for z of plane."

	| n area cross rForiginF rfptsF aAFfT newRefFrame |
	n := rFptsF size.
	rForiginF := rFptsF at: 1.
	(rForiginF ~~ (rFptsF at: n) and: [rForiginF ~= (rFptsF at: n)])
		ifTrue: 
			["Open polyline."
			self refFrame refFrame: refFrm.
			self rFpointsF: rFptsF]
		ifFalse: 
			["Closed polyline."
			rfptsF := rFptsF collect: [:rFpF | rFpF - rForiginF].
			area := (FullColumn zero: 3).
			2 to: n - 2
				do: 
					[:i | 
					cross := (rfptsF at: i)
								cross: (rfptsF at: i + 1).
					area equalSelfPlus: cross].
			newRefFrame := GEOCartesianFrame2
						refFrame: refFrm
						rFfF: (rFptsF at: 1)
						xPoint: (rFptsF at: 2)
						zPoint: (rFptsF at: 1)
								+ area.
			self refFrame: newRefFrame.
			aAFfT := refFrame aAFf transpose.
			self rfpointsf: (rfptsF collect: [:rfpF | aAFfT timesFullColumn: rfpF])]
]

{ #category : #rendering }
GEOPolyline >> renderOn1: aRenderingContext [ 
	aRenderingContext productTransformation: refFrame aMFf
		while: 
			[self hasPaint ifTrue: [aRenderingContext paint: self paint].
			self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
			aRenderingContext lineWidth: self lineWidth.
			self hasStipple 
				ifTrue: 
					[aRenderingContext lineStippleFactor: self stippleFactor
						pattern: self stipplePattern.
					aRenderingContext enableLineStipple].
			aRenderingContext displayLines: self vertexes.
			self hasStipple ifTrue: [aRenderingContext disableLineStipple]]
]

{ #category : #rendering }
GEOPolyline >> renderOn3: aRenderingContext [ 
	aRenderingContext productTransformation: refFrame aMFf
		while: 
			[self hasPaint ifTrue: [aRenderingContext paint: self paint].
			self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
			aRenderingContext lineWidth: self lineWidth.
			self hasStipple 
				ifTrue: 
					[aRenderingContext lineStippleFactor: self stippleFactor
						pattern: self stipplePattern.
					aRenderingContext enableLineStipple].
			aRenderingContext displayPolygon: self vertexes.
			self hasStipple ifTrue: [aRenderingContext disableLineStipple]]
]

{ #category : #rendering }
GEOPolyline >> renderOn4: aRenderingContext [ 
	"JunOpenGL3dNonConvexPolygon does not have the last vertex repeated."

	| nonConvexPolygon cVertex |
	aRenderingContext productTransformation: refFrame aMFf
		while: 
			[cVertex := Array new: rfpointsf size - 1.
			1 to: rfpointsf size - 1
				do: [:i | cVertex at: i put: (rfpointsf at: i) asJun3dPoint].
			nonConvexPolygon := JunOpenGL3dNonConvexPolygon 
						vertexes: cVertex
						holes: Array new
						paint: self paint.
			nonConvexPolygon renderOn: aRenderingContext]
]

{ #category : #rendering }
GEOPolyline >> renderPolyfaceOn: aRenderingContext [ 
	self cadObject notNil 
		ifTrue: 
			[aRenderingContext pushTransformation: refFrame aMFf
				while: 
					[self hasPaint ifTrue: [aRenderingContext paint: self paint].
					self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
					aRenderingContext lineWidth: self lineWidth.
					self hasStipple 
						ifTrue: 
							[aRenderingContext lineStippleFactor: self stippleFactor
								pattern: self stipplePattern.
							aRenderingContext enableLineStipple].
					aRenderingContext displayPolyface: self rfpointsf.
					self hasStipple ifTrue: [aRenderingContext disableLineStipple]]]
]

{ #category : #accessing }
GEOPolyline >> rfpointfAt: i put: col [ 
	(isClosed and: [i == 1 or: [i == rfpointsf size]]) 
		ifTrue: 
			[rfpointsf at: 1 put: col.
			rfpointsf at: rfpointsf size put: col]
		ifFalse: [rfpointsf at: i put: col].
	self calcBoundingBox.
	self changed
]

{ #category : #accessing }
GEOPolyline >> rfpointsf [
	^rfpointsf
]

{ #category : #accessing }
GEOPolyline >> rfpointsf: array [ 
	rfpointsf := array.
	isClosed := rfpointsf first = rfpointsf last.
	self calcBoundingBox.
	self changed
]

{ #category : #transforming }
GEOPolyline >> scaledBy: aFullColumn [ 
	self isClosed 
		ifTrue: 
			[| n |
			n := rfpointsf size.
			1 to: n - 1 do: [:i | (rfpointsf at: i) scaleSelfBy: aFullColumn].
			rfpointsf at: n put: rfpointsf first]
		ifFalse: [rfpointsf do: [:rfpointf | rfpointf scaleSelfBy: aFullColumn]].
	self calcBoundingBox
]

{ #category : #accessing }
GEOPolyline >> setrfpointsf: array [ 
	rfpointsf := array
]

{ #category : #accessing }
GEOPolyline >> start: start end: end [ 
	rfpointsf := Array with: start with: end.
	isClosed := false.
	self calcBoundingBox.
	self changed
]

{ #category : #printing }
GEOPolyline >> storeOn: aStream level: level [ 
	| block |
	aStream storeLevel: level title: 'Polyline'.
	self refFrame store2DOn: aStream level: level + 1.
	aStream storeLevel: level + 1 title: 'Vertices'.
	block := 
			[:title :array | 
			| collection |
			collection := OrderedCollection new: array size + 1.
			collection add: title.
			collection addAll: array.
			collection storeOn: aStream level: level + 1].
	block value: 'Number' value: (1 to: rfpointsf size by: 1).
	block value: 'x' value: (rfpointsf collect: [:col | col at: 1]).
	block value: 'y' value: (rfpointsf collect: [:col | col at: 2])
]

{ #category : #accessing }
GEOPolyline >> vertexes [
	^rfpointsf
]
