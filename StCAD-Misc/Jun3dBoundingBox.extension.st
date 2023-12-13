Extension { #name : #Jun3dBoundingBox }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Jun3dBoundingBox >> cVertex [

	| cVertex |
	cVertex := OrderedCollection new: 10.
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: origin y with: origin z). "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: origin y with: origin z).
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: corner y with: origin z).
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: origin y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: corner y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: corner y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: origin y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: corner y with: origin z).
	^ cVertex
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Jun3dBoundingBox >> vertexes [

	| cVertex |
	cVertex := OrderedCollection new: 10.
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: origin y with: origin z). "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: origin y with: origin z).
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: corner y with: origin z).
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: origin y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: corner y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: origin x with: corner y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: origin y with: corner z).
	cVertex add:
		(StCAD_Math_FullColumn with: corner x with: corner y with: origin z).
	^ cVertex
]
