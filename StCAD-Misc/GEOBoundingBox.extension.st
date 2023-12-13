Extension { #name : #GEOBoundingBox }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
GEOBoundingBox >> inRefFrame: aFrame [ 
	| minCornerF maxCornerF |
	minCornerF := aFrame rFpFfromrfpf: minCorner.
	maxCornerF := aFrame rFpFfromrfpf: maxCorner.
	^Jun3dBoundingBox origin: minCornerF asJun3dPoint
		corner: maxCornerF asJun3dPoint
]
