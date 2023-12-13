Extension { #name : #JunOpenGL2dTrimNurbsCurve }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> center: centerPoint radius: radius [ 
	"JunOpenGL2dTrimNurbsCurve center: 1.0d@1.0d radius: 1.0d"

	| xCenter yCenter controlPoints weights knots |
	xCenter := centerPoint x.
	yCenter := centerPoint y.
	controlPoints := Array new: 9.
	controlPoints at: 1 put: xCenter + 0 , (yCenter - radius) , 0.
	controlPoints at: 2 put: xCenter + radius , (yCenter - radius) , 0.
	controlPoints at: 3 put: xCenter + radius , (yCenter + 0) , 0.
	controlPoints at: 4 put: xCenter + radius , (yCenter + radius) , 0.
	controlPoints at: 5 put: xCenter + 0 , (yCenter + radius) , 0.
	controlPoints at: 6 put: xCenter - radius , (yCenter + radius) , 0.
	controlPoints at: 7 put: xCenter - radius , (yCenter + 0) , 0.
	controlPoints at: 8 put: xCenter - radius , (yCenter - radius) , 0.
	controlPoints at: 9 put: xCenter + 0 , (yCenter - radius) , 0.
	weights := Array new: 9.
	weights at: 1 put: 1.0d.
	weights at: 2 put: 1 / 2.0d sqrt.
	weights at: 3 put: 1.0d.
	weights at: 4 put: 1 / 2.0d sqrt.
	weights at: 5 put: 1.0d.
	weights at: 6 put: 1 / 2.0d sqrt.
	weights at: 7 put: 1.0d.
	weights at: 8 put: 1 / 2.0d sqrt.
	weights at: 9 put: 1.0d.
	knots := #(0 0 0 1 1 2 2 3 3 4 4 4).
	knots := knots collect: [:knot | knot asDouble / 4].
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> controlPoints [
	"Answers anArray that contains my control points."

	^controlPoints copy
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> controlPoints: anArrayOfPoints weights: anArrayOfNumber1 knotVector: anArrayOfNumber2 [ 
	controlPoints := anArrayOfPoints.
	weights := anArrayOfNumber1.
	knotVector := anArrayOfNumber2
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> controlPoints: anArrayOfPoints weights: anArrayOfNumber1 knotVector: anArrayOfNumber2 [ 
	^self new 
		controlPoints: anArrayOfPoints
		weights: anArrayOfNumber1
		knotVector: anArrayOfNumber2
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> exampleBottomSemiCircle [
	"JunOpenGL2dTrimNurbsCurve exampleBottomSemiCircle"

	| controlPoints weights knots |
	controlPoints := Array new: 3.
	controlPoints at: 1 put: -1 , 0 , 0.
	controlPoints at: 2 put: 0 , -1 , 0.
	controlPoints at: 3 put: 1 , 0 , 0.
	weights := Array new: 3.
	weights at: 1 put: 1.0d.
	weights at: 2 put: 0.0d.
	weights at: 3 put: 1.0d.
	knots := #(0 0 0 1 1 1).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> exampleCircle [
	"JunOpenGL2dTrimNurbsCurve exampleCircle"

	| controlPoints weights knots |
	controlPoints := Array new: 9.
	controlPoints at: 1 put: 0 , -1 , 0.
	controlPoints at: 2 put: 1 , -1 , 0.
	controlPoints at: 3 put: 1 , 0 , 0.
	controlPoints at: 4 put: 1 , 1 , 0.
	controlPoints at: 5 put: 0 , 1 , 0.
	controlPoints at: 6 put: -1 , 1 , 0.
	controlPoints at: 7 put: -1 , 0 , 0.
	controlPoints at: 8 put: -1 , -1 , 0.
	controlPoints at: 9 put: 0 , -1 , 0.
	weights := Array new: 9.
	weights at: 1 put: 1.0d.
	weights at: 2 put: 1 / 2.0d sqrt.
	weights at: 3 put: 1.0d.
	weights at: 4 put: 1 / 2.0d sqrt.
	weights at: 5 put: 1.0d.
	weights at: 6 put: 1 / 2.0d sqrt.
	weights at: 7 put: 1.0d.
	weights at: 8 put: 1 / 2.0d sqrt.
	weights at: 9 put: 1.0d.
	knots := #(0 0 0 1 1 2 2 3 3 4 4 4).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> exampleTopSemiCircle [
	"JunOpenGL2dTrimNurbsCurve exampleTopSemiCircle"

	| controlPoints weights knots |
	controlPoints := Array new: 3.
	controlPoints at: 1 put: 1 , 0 , 0.
	controlPoints at: 2 put: 0 , 1 , 0.
	controlPoints at: 3 put: -1 , 0 , 0.
	weights := Array new: 3.
	weights at: 1 put: 1.0d.
	weights at: 2 put: 0.0d.
	weights at: 3 put: 1.0d.
	knots := #(0 0 0 1 1 1).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> fromRectangle: aRectangle [ 
	"JunOpenGL2dTrimNurbsCurve fromRectangle: (Graphics.Rectangle origin: 0 @ 0 corner: 1.0 @ 1.0)"

	| controlPoints weights knots |
	controlPoints := aRectangle asPointArray.
	weights := (Array new: 5)
				atAllPut: 1.0d;
				yourself.
	knots := #(0 0 1 2 3 4 4).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> knotVector [
	"Answer an Array that contains my knots."

	^knotVector copy
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> nonconvexPolygon [
	| controlPoints weights knots |
	controlPoints := Array new: 5.
	controlPoints at: 1 put: 0.1 , 0.1.
	controlPoints at: 2 put: 0.9 , 0.1.
	controlPoints at: 3 put: 0.25 , 0.25.
	controlPoints at: 4 put: 0.1 , 0.9.
	controlPoints at: 5 put: 0.1 , 0.1.
	weights := Array new: 5.
	weights at: 1 put: 1.0.
	weights at: 2 put: 1.0.
	weights at: 3 put: 1.0.
	weights at: 4 put: 1.0.
	weights at: 5 put: 1.0.
	knots := #(0 0 1 2 3 4 4).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> nonconvexPolygon1 [
	| controlPoints weights knots |
	controlPoints := Array new: 5.
	controlPoints at: 1 put: 0 , 0.
	controlPoints at: 2 put: 1 , 0.
	controlPoints at: 3 put: 0.25 , 0.25.
	controlPoints at: 4 put: 0 , 1.
	controlPoints at: 5 put: 0 , 0.
	weights := Array new: 5.
	weights at: 1 put: 1.0.
	weights at: 2 put: 1.0.
	weights at: 3 put: 1.0.
	weights at: 4 put: 1.0.
	weights at: 5 put: 1.0.
	knots := #(0 0 1 2 3 4 4).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> order [
	^knotVector size - controlPoints size
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> renderOn: aRenderingContext with: aJunOpenGLNurbsSurface for: aNurbsHandle [ 
	"Modified by A-S Koh."

	aRenderingContext trimNurbsCurve: self for: aNurbsHandle
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> reverse [
	^self class 
		controlPoints: controlPoints reverse
		weights: weights reverse
		knotVector: (knotVector collect: [:knot | knot negated]) reverse
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> setKnotVector: knotArray controlPoints: controlPointArray weights: weightArray [ 
	knotVector := knotArray.
	controlPoints := controlPointArray.
	weights := weightArray
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> start: startPoint end: endPoint [ 
	"JunOpenGL2dTrimNurbs start: 0 @ 0 end: 1.0 @ 1.0"

	| controlPoints weights knots |
	controlPoints := Array with: startPoint with: endPoint.
	weights := (Array new: 2)
				atAllPut: 1.0d;
				yourself.
	knots := #(0 0 1 1).
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve classSide >> start: startPoint end: endPoint ustart: ustart uend: uend [ 
	"JunOpenGL2dTrimNurbs start: 0 @ 0 end: 1.0 @ 1.0 ustart: 0 uend: 1"

	| controlPoints weights knots |
	controlPoints := Array with: startPoint with: endPoint.
	weights := (Array new: 2)
				atAllPut: 1.0d;
				yourself.
	knots := Array 
				with: ustart
				with: ustart
				with: uend
				with: uend.
	^JunOpenGL2dTrimNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL2dTrimNurbsCurve >> weights [
	"Answer an Array of my weight map of control points."

	^weights copy
]
