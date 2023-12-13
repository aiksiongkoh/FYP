Class {
	#name : #FaceUse,
	#superclass : #PairedUse,
	#instVars : [
		'cLoopUse',
		'aSurface',
		'isSameSense',
		'mark'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
FaceUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
FaceUse >> aFace [
	^aNMTItem
]

{ #category : #accessing }
FaceUse >> aFaceUse [
	^self
]

{ #category : #accessing }
FaceUse >> aSketch [
	^aSurface aSketch
]

{ #category : #accessing }
FaceUse >> aSketchRefFrame [
	^aSurface aSketchRefFrame
]

{ #category : #accessing }
FaceUse >> aSurface [
	^aSurface
]

{ #category : #accessing }
FaceUse >> aSurface: aaSurface [ 
	self aModel addSurface: aaSurface.
	aSurface := aaSurface
]

{ #category : #accessing }
FaceUse >> addIntoShellUse: aShellUse [ 
	^aShellUse addFaceUse: self
]

{ #category : #accessing }
FaceUse >> addLoopUse: aLoopUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aLoopUse removeSup.
	cLoopUse add: aLoopUse.
	aLoopUse aSup: self.
	^aLoopUse
]

{ #category : #accessing }
FaceUse >> addMateGeometry [
	mate aSurface: aSurface.
	mate isSameSense: false.
	cLoopUse do: [:aLoopUse | aLoopUse addMateGeometry]
]

{ #category : #accessing }
FaceUse >> addPositiveSurface: aaSurface [ 
	| positiveFaceUse negativeFaceUse |
	positiveFaceUse := self.
	negativeFaceUse := positiveFaceUse mate.
	positiveFaceUse aSurface: aaSurface.
	negativeFaceUse aSurface: aaSurface.
	positiveFaceUse isSameSense: true.
	negativeFaceUse isSameSense: false
]

{ #category : #accessing }
FaceUse >> cLoopUse [
	^cLoopUse
]

{ #category : #accessing }
FaceUse >> cLoopUse: anObject [
	cLoopUse := anObject
]

{ #category : #accessing }
FaceUse >> cSub [
	^cLoopUse
]

{ #category : #accessing }
FaceUse >> ccgluvTrimNurbs [

	^(self triggerEvent: #ccgluvTrimNurbs)
		ifNil: 
			[| answer |
			answer := self create_ccgluvTrimNurbs.
			self ccgluvTrimNurbs: answer.
			answer]
]

{ #category : #accessing }
FaceUse >> ccgluvTrimNurbs: ccgluvTrimNurbs [

	self removeActionsForEvent: #ccgluvTrimNurbs.
	ccgluvTrimNurbs
		ifNotNil: 
			[self when: #ccgluvTrimNurbs ask: ccgluvTrimNurbs perform: #yourself]
]

{ #category : #'ops on self' }
FaceUse >> conditionForSurface [

	self assert: isSameSense.
	cLoopUse do: [:aLoopUse | aLoopUse conditionSelf].
	aSurface condition_cLoopUse: cLoopUse.
	aSurface condition_cLoopUse: cLoopUse within: self cuvBound.
	self finalize_cLoopUse
]

{ #category : #'ops on self' }
FaceUse >> conditionSelf [

	aSurface condtionFaceUse: self
]

{ #category : #'ops on self' }
FaceUse >> conditionSelf1 [
	(aSurface isMemberOf: RectSurface) 
		ifFalse: 
			[| outerLoopUse aBoundingRectangle |
			outerLoopUse := cLoopUse first.
			outerLoopUse conditionSelf.
			aBoundingRectangle := BoundingRectangle new.
			outerLoopUse ccuv 
				do: [:cuv | cuv do: [:uv | aBoundingRectangle expandToBound: uv]].
			2 to: cLoopUse size
				do: [:i | (cLoopUse at: i) conditionSelfWithin: aBoundingRectangle].
			self aSurface condition_cLoopUse: cLoopUse within: aBoundingRectangle.
			self finalize_cLoopUse]
]

{ #category : #'ops on self' }
FaceUse >> condition_glLoopUse: aLoopUse aBoundingRectangle: aBoundingRectangle [ 
	"
	Assume there is at most only one singularity per loop.
	(cFaceEdgeUse at: iStart) can have a discontinuity at the beginning.
	Connect the rest beginning from iStart.
	"

	| cFaceEdgeUse n iStart newBoundingRectangle |
	cFaceEdgeUse := aLoopUse cItemUse.
	n := cFaceEdgeUse size.
	iStart := 1.
	1 to: n
		do: 
			[:i | 
			| cEndSingularity |
			cEndSingularity := self aSurface 
						cEndSingularityOf: (cFaceEdgeUse at: i) glTrimNurbs.
			cEndSingularity first 
				ifTrue: 
					[iStart == 1 ifTrue: [iStart := i] ifFalse: [self assert: [iStart = i]]]
				ifFalse: 
					[cEndSingularity last 
						ifTrue: 
							[iStart == 1 ifTrue: [iStart := i + 1] ifFalse: [self assert: [false]]]]].
	newBoundingRectangle := BoundingRectangle new.
	newBoundingRectangle expandToBound: (self glNurbs 
				condition_cuv: (cFaceEdgeUse at: (iStart cyclic: n)) glTrimNurbs
				within: aBoundingRectangle).
	2 to: n
		do: 
			[:i | 
			| ii iipre |
			ii := iStart - 1 + i cyclic: n.
			iipre := ii - 1 cyclic: n.
			(cFaceEdgeUse at: iipre) glTrimNurbs 
				uv_connectTo: (cFaceEdgeUse at: ii) glTrimNurbs.
			newBoundingRectangle expandToBound: (self glNurbs 
						condition_cuv: (cFaceEdgeUse at: ii) glTrimNurbs
						within: aBoundingRectangle)].
	^newBoundingRectangle
]

{ #category : #nurbs }
FaceUse >> controlPointAtU: u v: v [ 
	^aSurface controlPointAtU: u v: v
]

{ #category : #accessing }
FaceUse >> create_ccgluvTrimNurbs [

	^aSurface isCyclic
		ifTrue: [self create_ccgluvTrimNurbsForCyclicSurface]
		ifFalse: [cLoopUse collect: [:aLoopUse | aLoopUse cgluvTrimNurbs]]
]

{ #category : #accessing }
FaceUse >> create_ccgluvTrimNurbsForCyclicSurface [

	| tol answer ccgluvTrimNurbs aStream cgluvTrimNurbs uvEnd nextcgluvTrimNurbs uvStart agluvTrimNurbs |
	tol := 1.0d-6.
	answer := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	ccgluvTrimNurbs := cLoopUse collect: [ :aLoopUse | 
		                   aLoopUse cgluvTrimNurbs ].
	aStream := ccgluvTrimNurbs readStream.
	[ aStream atEnd ] whileFalse: [ 
		cgluvTrimNurbs := StCAD_Misc_OrderedSet new.
		cgluvTrimNurbs addAll: aStream next.
		(cgluvTrimNurbs last uvEnd - cgluvTrimNurbs first uvStart) length
		< tol ifFalse: [ 
			[ 
			uvEnd := cgluvTrimNurbs last uvEnd.
			nextcgluvTrimNurbs := aStream atEnd
				                      ifTrue: [ ccgluvTrimNurbs first ]
				                      ifFalse: [ aStream next ].
			uvStart := nextcgluvTrimNurbs first uvStart.
			agluvTrimNurbs := NurbsCurve
				                  fromStart: uvEnd copy
				                  toEnd: uvStart copy.
			agluvTrimNurbs isSpatial: false.
			cgluvTrimNurbs add: agluvTrimNurbs.
			(cgluvTrimNurbs last uvEnd - cgluvTrimNurbs first uvStart) length
			< tol ] whileFalse: [ cgluvTrimNurbs addAll: nextcgluvTrimNurbs ] ].
		answer add: cgluvTrimNurbs ].
	^ answer
]

{ #category : #nurbs }
FaceUse >> create_glNurbs [
	| glNurbs |
	glNurbs := self aSurface glNurbs.
	^isSameSense ifTrue: [glNurbs] ifFalse: [glNurbs reverse]
]

{ #category : #accessing }
FaceUse >> create_glSurface [
	| glSurface |
	glSurface := self aSurface glSurface.
	^isSameSense ifTrue: [glSurface] ifFalse: [glSurface reverse]
]

{ #category : #accessing }
FaceUse >> cuv [

	| cuv |
	cuv := OrderedCollection new.
	self cuvInto: cuv.
	^cuv
]

{ #category : #accessing }
FaceUse >> cuvBound [

	| cuvBound |
	cuvBound := StCAD_Misc_BoundingRectangle new. "VW_TRANSLATION:StCAD.Misc.BoundingRectangle:StCAD_Misc_BoundingRectangle"
	self cuv do: [ :uv | cuvBound expandToBound: uv ].
	^ cuvBound
]

{ #category : #accessing }
FaceUse >> cuvInto: cuv [

	cLoopUse do: [:aLoopUse | aLoopUse cuvInto: cuv]
]

{ #category : #'ops on self' }
FaceUse >> finalize_cLoopUse [

	cLoopUse
		do: [:aLoopUse | aLoopUse cCurve do: [:aCurve | aCurve finalize_cuv]]
]

{ #category : #accessing }
FaceUse >> glSurface [
	^(self triggerEvent: #glSurface) ifNil: 
			[| answer |
			answer := self create_glSurface.
			self glSurface: answer.
			answer]
]

{ #category : #accessing }
FaceUse >> glSurface: glSurface [ 
	self removeActionsForEvent: #glSurface.
	glSurface ifNotNil: 
			[self 
				when: #glSurface
				ask: glSurface
				perform: #yourself]
]

{ #category : #'initialize-release' }
FaceUse >> initialize [

	cLoopUse := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #accessing }
FaceUse >> isSameSense [
	^isSameSense
]

{ #category : #accessing }
FaceUse >> isSameSense: anObject [
	isSameSense := anObject
]

{ #category : #testing }
FaceUse >> mark [
	^mark
]

{ #category : #enumerating }
FaceUse >> markAllOnSameSide [
	mark 
		ifFalse: 
			[mark := true.
			cLoopUse do: 
					[:aLoopUse | 
					aLoopUse cEdgeUse 
						do: [:aEdgeUse | aEdgeUse radial aFaceUse markAllOnSameSide]]]
]

{ #category : #accessing }
FaceUse >> negated [
	isSameSense := isSameSense not
]

{ #category : #copying }
FaceUse >> postCopy [
	self halt: 'Check this.'.
	aNMTItem := aNMTItem copy.
	cLoopUse copy do: [:aLoopUse | self addLoopUse: aLoopUse].
	aSurface := aSurface copy
]

{ #category : #printing }
FaceUse >> printOn: aStream [ 
	aStream nextPutAll: 'aFU'.
	aStream print: (self selectFaceUse: [:item | true]) size.
	aStream nextPutAll: ':LU'.
	aStream print: (self selectLoopUse: [:item | true]) size.
	aStream nextPutAll: ':EU'.
	aStream print: (self selectEdgeUse: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size
]

{ #category : #printing }
FaceUse >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'FaceUse';
		cr;
		nextPutAll: 'isSameSense = ';
		printVerbose: isSameSense;
		cr;
		printVerbose: aSurface;
		cr;
		printVerbose: cLoopUse
]

{ #category : #accessing }
FaceUse >> rSkFacePointSkAt: uv [ 
	| arg |
	arg := isSameSense 
				ifTrue: [uv]
				ifFalse: 
					[(uv copy)
						at: 2 put: (uv at: 2) negated;
						yourself].
	^aSurface rSkFacePointSkAt: arg
]

{ #category : #displaying }
FaceUse >> renderOn1: aRenderingContext [ 
	cLoopUse do: [:aLoopUse | aLoopUse renderOn: aRenderingContext]
]

{ #category : #displaying }
FaceUse >> renderOn: aRenderingContext [ 
	"All face and edge geometry must be in sketch frame coordinates."

	aRenderingContext paint: self aColor.
	aRenderingContext pushTransformation: aSurface aSketchRefFrame aMFf
		while: [aRenderingContext displayFaceUse: self]
]

{ #category : #enumerating }
FaceUse >> selectEdge: aBlock into: aSet [ 
	cLoopUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
FaceUse >> selectEdgeUse: aBlock into: aSet [ 
	cLoopUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
FaceUse >> selectFace: aBlock into: aSet [ 
	aNMTItem selectFace: aBlock into: aSet
]

{ #category : #enumerating }
FaceUse >> selectFaceUse: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
FaceUse >> selectLoop: aBlock into: aSet [ 
	cLoopUse do: [:each | each selectLoop: aBlock into: aSet]
]

{ #category : #enumerating }
FaceUse >> selectLoopUse: aBlock into: aSet [ 
	cLoopUse do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #enumerating }
FaceUse >> selectSurface: aBlock into: aSet [ 
	(aBlock value: aSurface) ifTrue: [aSet add: aSurface]
]

{ #category : #enumerating }
FaceUse >> selectVertex: aBlock into: aSet [ 
	cLoopUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
FaceUse >> selectVertexUse: aBlock into: aSet [ 
	cLoopUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #nurbs }
FaceUse >> trimCurvesDo: arg1 [
	"Dummy method template.  This was installed by the debugger
	define method command."

	^self halt
]

{ #category : #nurbs }
FaceUse >> uKnotVector [
	^aSurface uKnotVector
]

{ #category : #nurbs }
FaceUse >> uOrder [
	^aSurface uOrder
]

{ #category : #nurbs }
FaceUse >> uSize [
	^aSurface uSize
]

{ #category : #accessing }
FaceUse >> unmark [
	mark := false
]

{ #category : #accessing }
FaceUse >> uvBound: uvBound [ 
	self removeActionsForEvent: #uvBound.
	uvBound ifNotNil: 
			[self 
				when: #uvBound
				ask: uvBound
				perform: #yourself]
]

{ #category : #nurbs }
FaceUse >> vKnotVector [
	^aSurface vKnotVector
]

{ #category : #nurbs }
FaceUse >> vSize [
	^aSurface vSize
]

{ #category : #nurbs }
FaceUse >> weightAtU: u v: v [ 
	^aSurface weightAtU: u v: v
]
