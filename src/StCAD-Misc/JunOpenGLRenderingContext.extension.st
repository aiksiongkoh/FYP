Extension { #name : #JunOpenGLRenderingContext }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGLRenderingContext >> trimNurbsCurve: aNurbsCurve for: aNurbsHandle [ 
	| knotVector controlPoints weights floatArray |
	knotVector := aNurbsCurve knotVector collect: [:each | each asFloat].
	controlPoints := aNurbsCurve controlPoints.
	weights := aNurbsCurve weights.
	floatArray := WriteStream on: Array new.
	controlPoints with: weights
		do: 
			[:point :weight | 
			floatArray nextPut: (point x * weight) asFloat.
			floatArray nextPut: (point y * weight) asFloat.
			floatArray nextPut: weight asFloat].
	floatArray := floatArray contents.
	OpenGLInterface gluBeginTrim: aNurbsHandle.
	OpenGLInterface 
		gluNurbsCurve: aNurbsHandle
		with: knotVector size
		with: (JunForeignHeap copyFloatArrayToGcHeap: knotVector)
		with: 3
		with: (JunForeignHeap copyFloatArrayToGcHeap: floatArray)
		with: aNurbsCurve order
		with: OpenGLInterface GLU_MAP1_TRIM_3.
	OpenGLInterface gluEndTrim: aNurbsHandle
]
