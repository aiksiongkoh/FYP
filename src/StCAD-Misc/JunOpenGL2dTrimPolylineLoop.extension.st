Extension { #name : #JunOpenGL2dTrimPolylineLoop }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimPolylineLoop >> kohrenderOn: aRenderingContext with: aJunOpenGLNurbsSurface for: aNurbsHandle [ 
	"Modified by A-S Koh."

	| array |
	array := Array new: points size * 3.
	1 to: points size
		do: 
			[:index | 
			| point |
			point := points at: index.
			array at: index * 3 - 2 put: point x asFloat.
			array at: index * 3 - 1 put: point y asFloat.
			array at: index * 3 put: 1.0].
	aRenderingContext trimPolyline: array for: aNurbsHandle
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimPolylineLoop >> originalrenderOn: aRenderingContext with: aJunOpenGLNurbsSurface for: aNurbsHandle [ 
	| array uMin vMin uMax vMax uWidth vWidth |
	uMin := aJunOpenGLNurbsSurface uKnotAt: aJunOpenGLNurbsSurface uOrder.
	vMin := aJunOpenGLNurbsSurface vKnotAt: aJunOpenGLNurbsSurface vOrder.
	uMax := aJunOpenGLNurbsSurface uKnotAt: aJunOpenGLNurbsSurface uSize + 1.
	vMax := aJunOpenGLNurbsSurface vKnotAt: aJunOpenGLNurbsSurface vSize + 1.
	uWidth := uMax - uMin.
	vWidth := vMax - vMin.
	array := Array new: points size + 1 * 3.
	1 to: points size
		do: 
			[:index | 
			| point |
			point := points at: index.
			array at: index * 3 - 2 put: (point x * uWidth + uMin) asFloat.
			array at: index * 3 - 1 put: (point y * vWidth + vMin) asFloat.
			array at: index * 3 put: 1.0].
	array at: points size * 3 + 1 put: (points first x * uWidth + uMin) asFloat.
	array at: points size * 3 + 2 put: (points first y * vWidth + vMin) asFloat.
	array at: points size * 3 + 3 put: 1.0.
	aRenderingContext trimPolyline: array for: aNurbsHandle
]
