"
When edgeuse in not on a face, its geometry is stored in the edge element.
When edgeuse is on a face, it stores the curve as xyz function of uv function of t. xyx(uv(t)).

Instance Variables:
	aVertexUse	<EdgeUse | VertexUse>	description of aVertexUse
	orientation	<ArithmeticValue | EdgeUse | FaceUse | JunAngle | JunPenAngle | JunPenLocation | JunPoint | StMArray | StMSparseVector | StMSymbolic>	description of orientation
	radial	<Object>	description of radial
	uvOFtORxyzOFu	<Object>	stores uv(t) to be used with the face xyz(uv) to get xyz(uv(t)). Or xyz(u).


"
Class {
	#name : #EdgeUse,
	#superclass : #PairedUse,
	#instVars : [
		'aVertexUse',
		'radial',
		'c_uvCurve',
		'isSameSense'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
EdgeUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
EdgeUse >> aCurve [
	^c_uvCurve
]

{ #category : #accessing }
EdgeUse >> aCurve: aaCurve [ 
	c_uvCurve := aaCurve
]

{ #category : #accessing }
EdgeUse >> aEdge [
	^aNMTItem
]

{ #category : #accessing }
EdgeUse >> aEdgeUse [
	^self
]

{ #category : #accessing }
EdgeUse >> aEndPoint [
	^self mate aVertex aPoint
]

{ #category : #accessing }
EdgeUse >> aFaceUse [
	^aSup aFaceUse
]

{ #category : #accessing }
EdgeUse >> aPoint [
	"Dummy method template.  This was installed by the debugger
	define method command."

	^self halt
]

{ #category : #accessing }
EdgeUse >> aSketch [
	^self aCurve aSketch
]

{ #category : #accessing }
EdgeUse >> aSketchRefFrame [
	^self aCurve aSketchRefFrame
]

{ #category : #accessing }
EdgeUse >> aStartPoint [
	^self aVertex aPoint
]

{ #category : #accessing }
EdgeUse >> aVertex [
	^aVertexUse aVertex
]

{ #category : #accessing }
EdgeUse >> aVertexUse [
	^aVertexUse
]

{ #category : #accessing }
EdgeUse >> aVertexUse: argVertexUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	(argVertexUse isMemberOf: EdgeVertexUse) 
		ifFalse: [argVertexUse changeClassToThatOf: EdgeVertexUse basicNew].
	argVertexUse removeSup.
	aVertexUse := argVertexUse.
	argVertexUse aSup: self.
	^argVertexUse
]

{ #category : #accessing }
EdgeUse >> addPositiveCurve: aaCurve [ 
	| positiveEdgeUse negativeEdgeUse |
	positiveEdgeUse := self.
	negativeEdgeUse := positiveEdgeUse mate.
	positiveEdgeUse uvOFt: aaCurve.
	negativeEdgeUse uvOFt: aaCurve.
	positiveEdgeUse isSameSense: true.
	negativeEdgeUse isSameSense: false
]

{ #category : #accessing }
EdgeUse >> c_uvCurve [
	^c_uvCurve
]

{ #category : #accessing }
EdgeUse >> c_uvCurve: cCurve [ 
	c_uvCurve := cCurve
]

{ #category : #copying }
EdgeUse >> copy [
	| newEdgeUse newVertexUse |
	newEdgeUse := self aNMTItem newUse.
	newVertexUse := aVertexUse copy.
	newEdgeUse aVertexUse: newVertexUse.
	^newEdgeUse
]

{ #category : #accessing }
EdgeUse >> isSameSense [
	^isSameSense
]

{ #category : #accessing }
EdgeUse >> isSameSense: aBoolean [ 
	isSameSense := aBoolean
]

{ #category : #testing }
EdgeUse >> isWireframe [
	^false
]

{ #category : #accessing }
EdgeUse >> negated [
	isSameSense := isSameSense not
]

{ #category : #printing }
EdgeUse >> printOn: aStream [ 
	aStream nextPutAll: 'aEU'.
	aStream print: (self selectEdgeUse: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size
]

{ #category : #printing }
EdgeUse >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'EdgeUse';
		cr;
		printVerbose: self aCurve;
		cr;
		nextPutAll: 'isSameSense = ';
		printVerbose: isSameSense
]

{ #category : #accessing }
EdgeUse >> rFfF3: double [ 
	self aCurve aRefFrame rFfF at: 3 put: double
]

{ #category : #accessing }
EdgeUse >> rSkFacePointSkAt: t0 [ 
	^aSup rSkFacePointSkAt: (self aCurve value: t0)
]

{ #category : #accessing }
EdgeUse >> rSkPointSk [
	| xyzCurve u0 rfpf |
	xyzCurve := self aCurve.
	u0 := aVertexUse u0.
	rfpf := xyzCurve atU: u0.
	^xyzCurve aRefFrame rFpFfromrfpf: rfpf
]

{ #category : #accessing }
EdgeUse >> radial [
	^radial
]

{ #category : #accessing }
EdgeUse >> radial: aEdgeUse [ 
	radial := aEdgeUse.
	aEdgeUse 
		ifNotNil: [aEdgeUse radial == self ifFalse: [aEdgeUse radial: self]]
]

{ #category : #accessing }
EdgeUse >> removeSub: aSub [ 
	^aVertexUse == aSub 
		ifTrue: 
			[aVertexUse := nil.
			aSub aSup: nil.
			aSub]
		ifFalse: [self halt: 'check this']
]

{ #category : #enumerating }
EdgeUse >> selectEdge: aBlock into: aSet [ 
	aNMTItem selectEdge: aBlock into: aSet
]

{ #category : #enumerating }
EdgeUse >> selectEdgeUse: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
EdgeUse >> selectFace: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
EdgeUse >> selectFaceUse: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
EdgeUse >> selectLoop: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
EdgeUse >> selectLoopUse: aBlock into: aSet [ 
	"Do nothing."
]

{ #category : #enumerating }
EdgeUse >> selectVertex: aBlock into: aSet [ 
	aVertexUse selectVertex: aBlock into: aSet
]

{ #category : #enumerating }
EdgeUse >> selectVertexUse: aBlock into: aSet [

	aVertexUse ifNotNil: [:a | a selectVertexUse: aBlock into: aSet]
]

{ #category : #accessing }
EdgeUse >> uvOFt [
	^self aCurve
]

{ #category : #accessing }
EdgeUse >> uvOFt: anObject [ 
	self aCurve: anObject
]

{ #category : #accessing }
EdgeUse >> xyzCurve [

	| xyzCurve |
	xyzCurve := aNMTItem aCurve.
	^isSameSense ifTrue: [xyzCurve] ifFalse: [xyzCurve reverse]
]

{ #category : #accessing }
EdgeUse >> xyzOFu [
	^self aCurve
]
