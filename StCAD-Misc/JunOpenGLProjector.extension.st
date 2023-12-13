Extension { #name : #JunOpenGLProjector }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGLProjector >> calcViewBoxFor: aJun3dBoundingBox in: aOpenGLDisplayView [ 
	| aBitmap |
	aBitmap := aOpenGLDisplayView cachedBitmap.
	^aBitmap calcViewBoxFor: aJun3dBoundingBox
		with: projection asParallelProjection
]
