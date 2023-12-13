Class {
	#name : #MakeFU,
	#superclass : #EulerOperator,
	#instVars : [
		'cEdgeUse',
		'newFaceUse'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
MakeFU class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #'instance creation' }
MakeFU class >> withcEdge: cEdgeUse [ 
	| aMakeFU |
	aMakeFU := self new.
	aMakeFU cEdgeUse: cEdgeUse.
	^aMakeFU
]

{ #category : #accessing }
MakeFU >> cEdgeUse [
	^cEdgeUse
]

{ #category : #accessing }
MakeFU >> cEdgeUse: anObject [
	cEdgeUse := anObject
]

{ #category : #executing }
MakeFU >> checkNewShellRegion [
	| aModel |
	aModel := newFaceUse aModel.
	aModel unmarkFaceUse.
	newFaceUse markAllOnSameSide.
	newFaceUse mate mark ifFalse: [self createNewShellRegion]
]

{ #category : #executing }
MakeFU >> createNewShellRegion [
	"
	Find interior region.
	Find enclosed shells.
	Make new region to include the new shell and the enclosed shells.
	"

	| aModel newRegion newShell newShellUse cMarkedFaceUse |
	aModel := newFaceUse aModel.
	newRegion := aModel newRegion.
	newShell := aModel newShell.
	newShellUse := newShell newUse.
	newRegion addShellUse: newShellUse.
	cMarkedFaceUse := newFaceUse aShellUse 
				selectFaceUse: [:aFaceUse | aFaceUse mark].
	cMarkedFaceUse do: [:aFaceUse | newShellUse addFaceUse: aFaceUse mate]
]

{ #category : #executing }
MakeFU >> execute [

	| firstEdgeUse aModel aShellUse newFace newLoop newLoopUse otherLoopUse otherFaceUse aFaceEdgeUse otherFaceEdgeUse bccCurve bccCurveReverse n |
	firstEdgeUse := cEdgeUse first.
	aModel := firstEdgeUse aModel.
	aShellUse := firstEdgeUse aShellUse.
	newFace := aModel newFace.
	bccCurve := cEdgeUse collect: 
					[:a |
					| rFcurveF |
					rFcurveF := a aNMTItem aCurve.
					MathArray with: rFcurveF with: rFcurveF reverse].
	bccCurve := bccCurve reject: [:cCurve | cCurve first isNil].
	bccCurveReverse := bccCurve reverse.
	n := cEdgeUse size.
	newLoop := (aModel selectLoop: 
					[:aaLoop |
					| acCurve |
					acCurve := aaLoop crFcurveF.
					acCurve size = n and: 
							[((1 to: n) allSatisfy: 
									[:i |
									(bccCurve at: i)
										anySatisfy: [:bijCurve | (acCurve at: i) equal: bijCurve ltol: 1.0d-9]])
								or: 
									[(1 to: n) allSatisfy: 
											[:i |
											(bccCurveReverse at: i)
												anySatisfy: [:bijCurve | (acCurve at: i) equal: bijCurve ltol: 1.0d-9]]]]])
				soleItem.
	newLoop ifNil: [newLoop := aModel newLoop].
	newLoopUse := newLoop newUse.
	otherLoopUse := newLoop newUse.
	cEdgeUse do: 
			[:aEdgeUse |
			aEdgeUse isWireframe
				ifTrue: 
					[aFaceEdgeUse := aEdgeUse.
					otherFaceEdgeUse := aEdgeUse mate.
					aFaceEdgeUse radial: otherFaceEdgeUse]
				ifFalse: 
					[aFaceEdgeUse := aEdgeUse copy.
					aFaceEdgeUse isSameSense: true.
					otherFaceEdgeUse := aEdgeUse mate copy.
					otherFaceEdgeUse isSameSense: false.
					aFaceEdgeUse radial: aEdgeUse mate.
					otherFaceEdgeUse radial: aEdgeUse.
					aFaceEdgeUse mate: otherFaceEdgeUse].
			newLoopUse addEdgeUse: aFaceEdgeUse.
			otherLoopUse addEdgeUseFirst: otherFaceEdgeUse].
	newLoopUse mate: otherLoopUse.
	newFaceUse := newFace newUse.
	newFaceUse isSameSense: true.
	otherFaceUse := newFace newUse.
	otherFaceUse isSameSense: false.
	newFaceUse addLoopUse: newLoopUse.
	otherFaceUse addLoopUse: otherLoopUse.
	newFaceUse mate: otherFaceUse.
	aShellUse addFaceUse: newFaceUse.
	aShellUse addFaceUse: otherFaceUse.
	self checkNewShellRegion
]

{ #category : #accessing }
MakeFU >> newFaceUse [
	^newFaceUse
]

{ #category : #accessing }
MakeFU >> newFaceUse: anObject [
	newFaceUse := anObject
]
