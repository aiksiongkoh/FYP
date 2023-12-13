Extension { #name : #JunOpenGLPerspectiveProjection }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGLPerspectiveProjection >> viewYupXleft [

	| rFeyeF rFfocusF reyefocus ufocuseyeF rFupF |
	rFeyeF := self rFeyeF.
	rFfocusF := self rFfocusF.
	reyefocus := (rFfocusF - rFeyeF) length.
	ufocuseyeF := StCAD_Math_FullColumn
		              with: 0.0 d
		              with: 0.0 d
		              with: -1.0 d. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	rFeyeF := rFfocusF plusFullColumn: ufocuseyeF times: reyefocus.
	rFupF := StCAD_Math_FullColumn with: 0.0 d with: 1.0 d with: 0.0 d.
	self rFeyeF: rFeyeF.
	self rFupF: rFupF
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGLPerspectiveProjection >> viewYupXright [

	| rFeyeF rFfocusF reyefocus ufocuseyeF rFupF |
	rFeyeF := self rFeyeF.
	rFfocusF := self rFfocusF.
	reyefocus := (rFfocusF - rFeyeF) length.
	ufocuseyeF := StCAD_Math_FullColumn
		              with: 0.0 d
		              with: 0.0 d
		              with: 1.0 d. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	rFeyeF := rFfocusF plusFullColumn: ufocuseyeF times: reyefocus.
	rFupF := StCAD_Math_FullColumn with: 0.0 d with: 1.0 d with: 0.0 d.
	self rFeyeF: rFeyeF.
	self rFupF: rFupF
]
