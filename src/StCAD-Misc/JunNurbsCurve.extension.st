Extension { #name : #JunNurbsCurve }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunNurbsCurve classSide >> exampleKoh1 [
	"self exampleKoh1"

	| aNurbCurve |
	aNurbCurve := self exampleBSplineCurve.
	aNurbCurve atT: 0.5d
]
