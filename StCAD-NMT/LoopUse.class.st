Class {
	#name : #LoopUse,
	#superclass : #PairedUse,
	#instVars : [
		'cItemUse'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
LoopUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
LoopUse >> aEdgeAt: index [ 
	^(cItemUse at: index) aEdge
]

{ #category : #accessing }
LoopUse >> aEdgeUse [
	^nil
]

{ #category : #accessing }
LoopUse >> aFace [
	^aSup aFace
]

{ #category : #accessing }
LoopUse >> aFaceUse [
	^aSup aFaceUse
]

{ #category : #accessing }
LoopUse >> aLoop [
	^aNMTItem
]

{ #category : #accessing }
LoopUse >> aSurface [
	^aSup aSurface
]

{ #category : #accessing }
LoopUse >> addEdgeUse: aEdgeUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	(aEdgeUse isMemberOf: FaceEdgeUse) 
		ifFalse: [aEdgeUse changeClassToThatOf: FaceEdgeUse basicNew].
	aEdgeUse removeSup.
	cItemUse add: aEdgeUse.
	aEdgeUse aSup: self.
	^aEdgeUse
]

{ #category : #accessing }
LoopUse >> addEdgeUse: newEdgeUse before: oldEdgeUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	newEdgeUse removeSup.
	cItemUse add: newEdgeUse before: oldEdgeUse.
	newEdgeUse aSup: self.
	^newEdgeUse
]

{ #category : #accessing }
LoopUse >> addEdgeUseFirst: aEdgeUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	(aEdgeUse isMemberOf: FaceEdgeUse) 
		ifFalse: [aEdgeUse changeClassToThatOf: FaceEdgeUse basicNew].
	aEdgeUse removeSup.
	cItemUse addFirst: aEdgeUse.
	aEdgeUse aSup: self.
	^aEdgeUse
]

{ #category : #accessing }
LoopUse >> addGeometry: aFACE_BOUND onFACE1: aFACE [ 
	self assert: [aFACE_BOUND orientation].
	cItemUse with: aFACE_BOUND bound edge_list
		parallelDo: [:aEdgeUse :aORIENTED_EDGE | aEdgeUse addGeometry: aORIENTED_EDGE onFACE: aFACE]
]

{ #category : #accessing }
LoopUse >> addGeometry: aFACE_BOUND onFACE2: aFACE [ 
	| cORIENTED_EDGE lastEdgeUse lastORIENTED_EDGE preEdgeUse |
	self assert: [aFACE_BOUND orientation].
	cORIENTED_EDGE := aFACE_BOUND bound edge_list.
	lastEdgeUse := cItemUse last.
	lastORIENTED_EDGE := cORIENTED_EDGE last.
	lastEdgeUse 
		addGeometry: lastORIENTED_EDGE
		onFACE: aFACE
		preEdgeUse: nil.
	preEdgeUse := lastEdgeUse.
	cItemUse with: aFACE_BOUND bound edge_list
		parallelDo: 
			[:aEdgeUse :aORIENTED_EDGE | 
			aEdgeUse 
				addGeometry: aORIENTED_EDGE
				onFACE: aFACE
				preEdgeUse: preEdgeUse.
			preEdgeUse := aEdgeUse]
]

{ #category : #accessing }
LoopUse >> addGeometry: aFACE_BOUND onFACE: aFACE [ 
	self assert: [aFACE_BOUND orientation].
	cItemUse with: aFACE_BOUND bound edge_list
		parallelDo: [:aEdgeUse :aORIENTED_EDGE | aEdgeUse addGeometry: aORIENTED_EDGE onFACE: aFACE]
]

{ #category : #accessing }
LoopUse >> addMateGeometry [
	cItemUse do: [:aEdgeUse | aEdgeUse addMateGeometry]
]

{ #category : #accessing }
LoopUse >> addVertexUse: aVertexUse [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	(aVertexUse isMemberOf: LoopVertexUse) 
		ifFalse: [aVertexUse changeClassToThatOf: LoopVertexUse basicNew].
	aVertexUse removeSup.
	cItemUse add: aVertexUse.
	aVertexUse aSup: self.
	^aVertexUse
]

{ #category : #accessing }
LoopUse >> cCurve [

	| c_uvCurve |
	c_uvCurve := OrderedCollection new.
	self cFaceEdgeUse
		do: [:aFaceEdgeUse | c_uvCurve addAll: aFaceEdgeUse c_uvCurve].
	^c_uvCurve
]

{ #category : #accessing }
LoopUse >> cEdgeUse [
	^cItemUse
]

{ #category : #accessing }
LoopUse >> cFaceEdgeUse [
	^cItemUse
]

{ #category : #accessing }
LoopUse >> cItemUse [
	^cItemUse
]

{ #category : #accessing }
LoopUse >> cItemUse: anObject [
	cItemUse := anObject
]

{ #category : #accessing }
LoopUse >> cSub [
	^cItemUse
]

{ #category : #accessing }
LoopUse >> c_uvCurve [

	| c_uvCurve |
	c_uvCurve := OrderedCollection new.
	self cFaceEdgeUse
		do: [:aFaceEdgeUse | c_uvCurve addAll: aFaceEdgeUse c_uvCurve].
	^c_uvCurve
]

{ #category : #accessing }
LoopUse >> ccuv [

	^self cCurve collect: [:aCurve | aCurve cuv]
]

{ #category : #accessing }
LoopUse >> cglTrimNurbs [
	^(self triggerEvent: #cglTrimNurbs) ifNil: 
			[| answer |
			answer := self create_cglTrimNurbs.
			self cglTrimNurbs: answer.
			answer]
]

{ #category : #accessing }
LoopUse >> cglTrimNurbs: cglTrimNurbs [ 
	self removeActionsForEvent: #cglTrimNurbs.
	cglTrimNurbs ifNotNil: 
			[self 
				when: #cglTrimNurbs
				ask: cglTrimNurbs
				perform: #yourself]
]

{ #category : #accessing }
LoopUse >> cgluvTrimNurbs [

	| cgluvTrimNurbs |
	cgluvTrimNurbs := OrderedCollection new.
	cItemUse do: [:aEdgeUse | cgluvTrimNurbs addAll: aEdgeUse cgluvTrimNurbs].
	cgluvTrimNurbs := self aSurface condition_cgluvTrimNurbs: cgluvTrimNurbs.
	^cgluvTrimNurbs
]

{ #category : #accessing }
LoopUse >> conditionSelf [
	"
	Assume there is at most only one singularity per loop.
	(cFaceEdgeUse at: iStart) can have a discontinuity at the beginning.
	Connect the rest beginning from iStart.
	"

	| c_uvCurve n aSurface iStart |
	c_uvCurve := self c_uvCurve.
	n := c_uvCurve size.
	aSurface := self aSurface.
	iStart := 1.
	1 to: n
		do: 
			[:i |
			| cEndSingularity |
			cEndSingularity := aSurface cEndSingularityOf: (c_uvCurve at: i).
			cEndSingularity first
				ifTrue: 
					[iStart == 1 ifTrue: [iStart := i] ifFalse: [self assert: [iStart = i]]]
				ifFalse: 
					[cEndSingularity last
						ifTrue: 
							[iStart == 1 ifTrue: [iStart := i + 1] ifFalse: [self assert: [false]]]]].
	aSurface smooth_cuv: (c_uvCurve at: (iStart cyclic: n)).
	2 to: n
		do: 
			[:i |
			| ii iipre |
			ii := iStart - 1 + i cyclic: n.
			iipre := ii - 1 cyclic: n.
			(c_uvCurve at: iipre) uv_connectTo: (c_uvCurve at: ii).
			aSurface smooth_cuv: (c_uvCurve at: ii)]
]

{ #category : #accessing }
LoopUse >> conditionSelfWithin: uvBound [
	"
	Assume there is at most only one singularity per loop.
	(cFaceEdgeUse at: iStart) can have a discontinuity at the beginning.
	Connect the rest beginning from iStart.
	"

	| c_uvCurve n aSurface iStart |
	c_uvCurve := self c_uvCurve.
	n := c_uvCurve size.
	aSurface := self aSurface.
	iStart := 1.
	1 to: n
		do: 
			[:i |
			| cEndSingularity |
			cEndSingularity := aSurface cEndSingularityOf: (c_uvCurve at: i).
			cEndSingularity first
				ifTrue: 
					[iStart == 1 ifTrue: [iStart := i] ifFalse: [self assert: [iStart = i]]]
				ifFalse: 
					[cEndSingularity last
						ifTrue: 
							[iStart == 1 ifTrue: [iStart := i + 1] ifFalse: [self assert: [false]]]]].
	aSurface smooth_cuv: (c_uvCurve at: (iStart cyclic: n)) within: uvBound.
	2 to: n
		do: 
			[:i |
			| ii iipre |
			ii := iStart - 1 + i cyclic: n.
			iipre := ii - 1 cyclic: n.
			(c_uvCurve at: iipre) uv_connectTo: (c_uvCurve at: ii).
			aSurface smooth_cuv: (c_uvCurve at: ii) within: uvBound]
]

{ #category : #accessing }
LoopUse >> crFcurveF [

	^cItemUse collect: [:a | a aNMTItem aCurve]
]

{ #category : #accessing }
LoopUse >> create_cglTrimNurbs [

	| cglTrimNurbs |
	cglTrimNurbs := OrderedCollection new.
	self cFaceEdgeUse
		do: [:aFaceEdgeUse | cglTrimNurbs addAll: aFaceEdgeUse cglTrimNurbs].
	^self aSurface condition_cglTrimNurbs: cglTrimNurbs
]

{ #category : #accessing }
LoopUse >> create_cgluvTrimNurbs [
	self halt
]

{ #category : #accessing }
LoopUse >> cuvFirst [

	^cItemUse first cuvFirst
]

{ #category : #accessing }
LoopUse >> cuvInto: cuv [

	cItemUse do: [:aFaceEdgeUse | aFaceEdgeUse cuvInto: cuv]
]

{ #category : #accessing }
LoopUse >> cuvLast [

	^cItemUse last cuvLast
]

{ #category : #'initialize-release' }
LoopUse >> emptySelf [
	cItemUse asArray do: [:aUse | self removeSub: aUse]
]

{ #category : #'initialize-release' }
LoopUse >> initialize [

	cItemUse := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #testing }
LoopUse >> isSelfLoop [
	^cItemUse size == 1
]

{ #category : #testing }
LoopUse >> isVertexLoop [
	^cItemUse first isVertexUse
]

{ #category : #calc }
LoopUse >> minusU: offset [

	cItemUse do: [:aFaceEdgeUse | aFaceEdgeUse minusU: offset]
]

{ #category : #calc }
LoopUse >> minusV: offset [

	cItemUse do: [:aFaceEdgeUse | aFaceEdgeUse minusV: offset]
]

{ #category : #displaying }
LoopUse >> plotccuv [

	| ccuvPoint cuvPoint |
	ccuvPoint := OrderedCollection new.
	self ccuv do: [ :cuv | 
		cuvPoint := OrderedCollection new.
		ccuvPoint add: cuvPoint.
		cuv do: [ :uv | uv ifNotNil: [ cuvPoint add: uv u @ uv v ] ] ].
	Examples_BG_XY new: ccuvPoint "VW_TRANSLATION:Examples.BG_XY:Examples_BG_XY"
]

{ #category : #displaying }
LoopUse >> plotcuv [

	| cuvPoint |
	cuvPoint := OrderedCollection new.
	self ccuv do: [ :cuv | 
		cuv do: [ :uv | uv ifNotNil: [ cuvPoint add: uv u @ uv v ] ] ].
	Examples_BG_XY new: cuvPoint "VW_TRANSLATION:Examples.BG_XY:Examples_BG_XY"
]

{ #category : #printing }
LoopUse >> printOn: aStream [ 
	aStream nextPutAll: 'aLU'.
	aStream nextPut: $(.
	cItemUse do: [:item | item aVertexUse aVertex aPoint printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #printing }
LoopUse >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'LoopUse';
		cr;
		printVerbose: cItemUse
]

{ #category : #accessing }
LoopUse >> rSkFacePointSkAt: t0 [ 
	^aSup rSkFacePointSkAt: t0
]

{ #category : #displaying }
LoopUse >> renderOn: aRenderingContext [ 
	| cPoint |
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	aRenderingContext lineWidth: self lineWidth.
	self hasStipple 
		ifTrue: 
			[aRenderingContext lineStippleFactor: self stippleFactor
				pattern: self stipplePattern.
			aRenderingContext enableLineStipple].
	cPoint := OrderedCollection new.
	cItemUse do: [:aEdgeUse | cPoint add: aEdgeUse aVertex aPoint].
	cPoint add: cPoint first.
	"	aRenderingContext displayLines: cPoint."
	aRenderingContext displayPolygon: cPoint.
	self hasStipple ifTrue: [aRenderingContext disableLineStipple]
]

{ #category : #enumerating }
LoopUse >> selectEdge: aBlock into: aSet [ 
	cItemUse do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
LoopUse >> selectEdgeUse: aBlock into: aSet [ 
	cItemUse do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
LoopUse >> selectLoop: aBlock into: aSet [ 
	aNMTItem selectLoop: aBlock into: aSet
]

{ #category : #enumerating }
LoopUse >> selectLoopUse: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
LoopUse >> selectVertex: aBlock into: aSet [ 
	cItemUse do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
LoopUse >> selectVertexUse: aBlock into: aSet [ 
	cItemUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #ops }
LoopUse >> startLoopAtVertex: argVertex [ 
	self cEdgeUse 
		cyclicShiftElementToTop: [:aEdgeUse | aEdgeUse includesVertex: argVertex]
]

{ #category : #ops }
LoopUse >> startLoopAtVertexUse: argVertexUse [ 
	self cEdgeUse 
		cyclicShiftElementToTop: [:aEdgeUse | aEdgeUse includesVertexUse: argVertexUse]
]

{ #category : #accessing }
LoopUse >> uvBound [

	| uvBound |
	uvBound := StCAD_Misc_BoundingRectangle new. "VW_TRANSLATION:StCAD.Misc.BoundingRectangle:StCAD_Misc_BoundingRectangle"
	cItemUse do: [ :aFaceEdgeUse | 
		uvBound expandToBound: aFaceEdgeUse uvBound ].
	^ uvBound
]

{ #category : #accessing }
LoopUse >> uvEnd [
	^cItemUse last uvEnd
]

{ #category : #accessing }
LoopUse >> uvStart [
	^cItemUse first uvStart
]
