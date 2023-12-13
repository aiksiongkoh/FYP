Class {
	#name : #MbDAllowZRotationConstraintIqctJqc,
	#superclass : #MbDDirectionCosineConstraintIqctJqc,
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDAllowZRotationConstraintIqctJqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'input-output' }
MbDAllowZRotationConstraintIqctJqc >> postInput [

	| aAImJe aEulerAngleszxz the1z the2x |
	aAImJe := frmI markerFrame aAOm transpose timesFullMatrix: frmJ aAOe.
	aEulerAngleszxz := StCAD_StGeo_GEOEulerAngleszxz fromA: aAImJe. "VW_TRANSLATION:StCAD.StGeo.GEOEulerAngleszxz:StCAD_StGeo_GEOEulerAngleszxz"
	the1z := aEulerAngleszxz at: 1.
	the2x := aEulerAngleszxz at: 2.
	the2x abs < (Double pi / 2.0 d)
		ifTrue: [ (frmI phiThePsiBlks at: 1) value: the1z ]
		ifFalse: [ (frmI phiThePsiBlks at: 1) value: Double pi + the1z ].
	frmI postInput.
	super postInput
]

{ #category : #'input-output' }
MbDAllowZRotationConstraintIqctJqc >> postInput1 [

	| aAImJe aEulerAngleszxz the1z the2x |
	aAImJe := frmI markerFrame aAOm transpose timesFullMatrix: frmJ aAOe.
	aEulerAngleszxz := StCAD_StGeo_GEOEulerAngleszxz fromA: aAImJe. "VW_TRANSLATION:StCAD.StGeo.GEOEulerAngleszxz:StCAD_StGeo_GEOEulerAngleszxz"
	the1z := aEulerAngleszxz at: 1.
	the2x := aEulerAngleszxz at: 2.
	the2x abs < (Double pi / 2.0 d)
		ifTrue: [ (frmI phiThePsiBlks at: 1) value: the1z ]
		ifFalse: [ (frmI phiThePsiBlks at: 1) value: Double pi + the1z ].
	frmI postInput.
	super postInput
]

{ #category : #'input-output' }
MbDAllowZRotationConstraintIqctJqc >> postInput2 [

	| aAImJe aEulerAngleszxz the1z the2x |
	aAImJe := frmI markerFrame aAOm transpose timesFullMatrix: frmJ aAOe.
	aEulerAngleszxz := StCAD_StGeo_GEOEulerAngleszxz fromA: aAImJe. "VW_TRANSLATION:StCAD.StGeo.GEOEulerAngleszxz:StCAD_StGeo_GEOEulerAngleszxz"
	the1z := aEulerAngleszxz at: 1.
	the2x := aEulerAngleszxz at: 2.
	the2x abs < (Double pi / 2.0 d)
		ifTrue: [ (frmI phiThePsiBlks at: 1) value: the1z ]
		ifFalse: [ (frmI phiThePsiBlks at: 1) value: 0.45437913892377 d ].
	frmI postInput.
	super postInput
]

{ #category : #posIC }
MbDAllowZRotationConstraintIqctJqc >> postPosIC [
	self becomeRedundantConstraint
]

{ #category : #posIC }
MbDAllowZRotationConstraintIqctJqc >> prePosIC1 [

	| aAImJe aEulerAngleszxz the1z |
	aAImJe := frmI markerFrame aAOm transpose timesFullMatrix: frmJ aAOe.
	aEulerAngleszxz := StCAD_StGeo_GEOEulerAngleszxz fromA: aAImJe. "VW_TRANSLATION:StCAD.StGeo.GEOEulerAngleszxz:StCAD_StGeo_GEOEulerAngleszxz"
	the1z := aEulerAngleszxz at: 1.
	(frmI phiThePsiBlks at: 1) value: the1z.
	frmI prePosIC.
	super prePosIC
]
