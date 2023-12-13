Extension { #name : #JunOpenGL3dNurbsSurface }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Koh [
	"JunOpenGL3dNurbsSurface example5Koh."

	| nurbs points trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsSurface.
	points := Array new: 5.
	points at: 1 put: -0.5 , -0.5.
	points at: 2 put: 1.5 , -0.5.
	points at: 3 put: 1.5 , 1.5.
	points at: 4 put: -0.5 , 1.5.
	points at: 5 put: -0.5 , -0.5.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points.
	nurbs addTrimCurve: trimCurve.
	points := Array new: 5.
	points at: 1 put: 0.1 , 0.1.
	points at: 2 put: 0.5 , 0.1.
	points at: 3 put: 0.5 , 0.5.
	points at: 4 put: 0.1 , 0.5.
	points at: 5 put: 0.1 , 0.1.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points reverse.
	nurbs addTrimCurve: trimCurve.
	points := Array new: 5.
	points at: 1 put: 0.2 , 0.2.
	points at: 2 put: 0.4 , 0.2.
	points at: 3 put: 0.4 , 0.4.
	points at: 4 put: 0.2 , 0.4.
	points at: 5 put: 0.2 , 0.2.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohb [

	"JunOpenGL3dNurbsSurface example5Kohb."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsSurface2.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0 @ 0 corner: 1.0 @ 1.0). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := (JunOpenGL2dTrimNurbsCurve fromRectangle:
		              (Graphics_Rectangle
			               origin: 0.2 @ 0.2
			               corner: 0.8 @ 0.8)) reverse.
	nurbs addTrimCurve: trimCurve.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0.3 @ 0.3 corner: 0.6 @ 0.6).
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohc [
	"JunOpenGL3dNurbsSurface example5Kohc."

	| nurbs points trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface.
	points := Array new: 5.
	points at: 1 put: -0.5 , -0.5.
	points at: 2 put: 1.5 , -0.5.
	points at: 3 put: 1.5 , 1.5.
	points at: 4 put: -0.5 , 1.5.
	points at: 5 put: -0.5 , -0.5.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points.
	nurbs addTrimCurve: trimCurve.
	points := Array new: 5.
	points at: 1 put: 0.3 , 0.3.
	points at: 2 put: 0.6 , 0.3.
	points at: 3 put: 0.6 , 0.6.
	points at: 4 put: 0.3 , 0.6.
	points at: 5 put: 0.3 , 0.3.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohcc [
	"JunOpenGL3dNurbsSurface example5Kohcc."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve exampleTopSemiCircle.
	nurbs addTrimCurve: trimCurve.
	trimCurve := JunOpenGL2dTrimNurbsCurve exampleBottomSemiCircle.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohccc [
	"JunOpenGL3dNurbsSurface example5Kohccc."

	| nurbs points trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface.
	points := OrderedCollection new: 10.
	points
		add: 0.0 , 0.0;
		add: 0.1 , 0.0;
		add: 0.10000001 , 0.0;
		add: 1.0 , 0.0;
		add: 1.0 , 1.0;
		add: 0.0 , 1.0;
		add: 0.0 , 0.0.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points.
	nurbs addTrimCurve: trimCurve.
	points := OrderedCollection new: 10.
	points
		add: 0.3 , 0.3;
		add: 0.6 , 0.3;
		add: 0.6 , 0.6;
		add: 0.3 , 0.6;
		add: 0.3 , 0.3.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohd [
	"JunOpenGL3dNurbsSurface example5Kohd."

	| nurbs points trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsCylSurface.
	points := Array new: 5.
	points at: 1 put: -0.1 , -0.1.
	points at: 2 put: 1.1 , -0.1.
	points at: 3 put: 1.1 , 1.1.
	points at: 4 put: -0.1 , 1.1.
	points at: 5 put: -0.1 , -0.1.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points.
	nurbs addTrimCurve: trimCurve.
	points := Array new: 5.
	points at: 1 put: 0.3 , 0.3.
	points at: 2 put: 0.8 , 0.3.
	points at: 3 put: 0.8 , 0.8.
	points at: 4 put: 0.3 , 0.8.
	points at: 5 put: 0.3 , 0.3.
	trimCurve := JunOpenGL2dTrimPolylineLoop points: points reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohe [

	"JunOpenGL3dNurbsSurface example5Kohe."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsCylSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle
			              origin: -0.1 @ -0.1
			              corner: 1.1 @ 1.1). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := (JunOpenGL2dTrimNurbsCurve fromRectangle:
		              (Graphics_Rectangle
			               origin: 0.3 @ 0.3
			               corner: 0.8 @ 0.8)) reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohee [

	"JunOpenGL3dNurbsSurface example5Kohee."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsCylSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0 @ 0 corner: 1.0 @ 1.0). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := (JunOpenGL2dTrimNurbsCurve
		              center: 0.5 d @ 0.5 d
		              radius: 0.25 d) reverse.
	nurbs addTrimCurve: trimCurve.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0.4 @ 0.4 corner: 0.6 @ 0.6).
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohf [

	"JunOpenGL3dNurbsSurface example5Kohf."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0 @ 0 corner: 1 @ 1). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := (JunOpenGL2dTrimNurbsCurve fromRectangle:
		              (Graphics_Rectangle
			               origin: 0.3 @ 0.3
			               corner: 0.6 @ 0.6)) reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohf2 [

	"JunOpenGL3dNurbsSurface example5Kohf2."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface2.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0 @ 0 corner: 1 @ 1). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := (JunOpenGL2dTrimNurbsCurve fromRectangle:
		              (Graphics_Rectangle
			               origin: 0.3 @ 0.3
			               corner: 0.5 @ 0.5)) reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example5Kohff [

	"JunOpenGL3dNurbsSurface example5Kohff."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface reverse.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: -1 @ 0 corner: 0 @ 1). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := (JunOpenGL2dTrimNurbsCurve fromRectangle:
		              (Graphics_Rectangle
			               origin: -0.6 @ 0.3
			               corner: -0.3 @ 0.6)) reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example6Koh [

	"JunOpenGL3dNurbsSurface example6Koh."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsRectSurface2.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0 @ 0 corner: 1 @ 1). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := JunOpenGL2dTrimNurbsCurve nonconvexPolygon reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> example6Kohee [

	"JunOpenGL3dNurbsSurface example6Kohee."

	| nurbs trimCurve |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsCylSurface.
	trimCurve := JunOpenGL2dTrimNurbsCurve fromRectangle:
		             (Graphics_Rectangle origin: 0 @ 0 corner: 1.0 @ 1.0). "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	nurbs addTrimCurve: trimCurve.
	trimCurve := JunOpenGL2dTrimNurbsCurve nonconvexPolygon reverse.
	nurbs addTrimCurve: trimCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^ nurbs
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsCone [
	"JunOpenGL3dNurbsSurface exampleNurbsCone name: 'example'; paint: ColorValue blue; show."

	| n circleNurbs zEnd circleControlPoints controlPoints circleWeights weights point frontend backend middle knots circleKnots uMax |
	n := 2.
	circleNurbs := JunOpenGL3dNurbsCurve exampleCircle.
	zEnd := 2.0d.
	circleControlPoints := circleNurbs controlPoints.
	controlPoints := JunMatrix new: circleControlPoints size by: n.
	circleWeights := circleNurbs weights.
	weights := JunMatrix new: circleControlPoints size by: n.
	1 to: circleControlPoints size
		do: 
			[:i | 
			1 to: n
				do: 
					[:j | 
					point := (circleControlPoints at: i) copy.
					j == 2 
						ifTrue: 
							[point setX: 0.
							point setY: 0.
							point setZ: zEnd].
					controlPoints atPoint: i @ j put: point.
					weights atPoint: i @ j put: (circleWeights at: i)]].
	circleKnots := circleNurbs knotVector.
	uMax := circleKnots last.
	circleKnots := circleKnots collect: [:knot | knot asDouble / uMax].
	frontend := (Array new: n - 1)
				atAllPut: 0.0d;
				yourself.
	backend := (Array new: n - 1)
				atAllPut: 1.0d;
				yourself.
	middle := Array with: 0.0d with: 1.0d.
	knots := frontend , middle , backend.
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: circleKnots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsCylSurface [
	"JunOpenGL3dNurbsSurface exampleNurbsCylSurface name: 'example'; paint: ColorValue blue; show."

	| n circleNurbs zEnd circleControlPoints controlPoints circleWeights weights point frontend backend middle knots circleKnots uMax |
	n := 2.
	circleNurbs := JunOpenGL3dNurbsCurve exampleCircle.
	zEnd := 2.0d.
	circleControlPoints := circleNurbs controlPoints.
	controlPoints := JunMatrix new: circleControlPoints size by: n.
	circleWeights := circleNurbs weights.
	weights := JunMatrix new: circleControlPoints size by: n.
	1 to: circleControlPoints size
		do: 
			[:i | 
			1 to: n
				do: 
					[:j | 
					point := (circleControlPoints at: i) copy.
					j == 2 ifTrue: [point setZ: zEnd].
					controlPoints atPoint: i @ j put: point.
					weights atPoint: i @ j put: (circleWeights at: i)]].
	circleKnots := circleNurbs knotVector.
	uMax := circleKnots last.
	circleKnots := circleKnots collect: [:knot | knot asDouble / uMax].
	frontend := (Array new: n - 1)
				atAllPut: 0.0d;
				yourself.
	backend := (Array new: n - 1)
				atAllPut: 1.0d;
				yourself.
	middle := Array with: 0.0d with: 1.0d.
	knots := frontend , middle , backend.
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: circleKnots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsCylSurface2 [
	"JunOpenGL3dNurbsSurface exampleNurbsCylSurface name: 'example'; paint: ColorValue blue; show."

	| n circleNurbs zEnd circleControlPoints controlPoints circleWeights weights point frontend backend middle knots circleKnots uMax |
	n := 2.
	circleNurbs := JunOpenGL3dNurbsCurve exampleCircle.
	zEnd := 2.0d.
	circleControlPoints := circleNurbs controlPoints.
	controlPoints := JunMatrix new: circleControlPoints size by: n.
	circleWeights := circleNurbs weights.
	weights := JunMatrix new: circleControlPoints size by: n.
	1 to: circleControlPoints size
		do: 
			[:i | 
			1 to: n
				do: 
					[:j | 
					point := (circleControlPoints at: i) copy.
					j == 2 ifTrue: [point setZ: zEnd].
					controlPoints atPoint: i @ j put: point.
					weights atPoint: i @ j put: (circleWeights at: i)]].
	circleKnots := circleNurbs knotVector.
	uMax := 1.
	circleKnots := circleKnots collect: [:knot | knot asDouble / uMax].
	frontend := (Array new: n - 1)
				atAllPut: 0.0d;
				yourself.
	backend := (Array new: n - 1)
				atAllPut: 1.0d;
				yourself.
	middle := Array with: 0.0d with: 1.0d.
	knots := frontend , middle , backend.
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: circleKnots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsRectSurface [
	"JunOpenGL3dNurbsSurface exampleNurbsRectSurface name: 'example'; paint: ColorValue blue; show."

	| xLength yLength n dx dy controlPoints weights frontend backend middle knots |
	xLength := 2.0d.
	yLength := 3.0d.
	n := 2.
	dx := xLength / (n - 1).
	dy := yLength / (n - 1).
	controlPoints := JunMatrix new: n.
	1 to: 2
		do: 
			[:i | 
			1 to: 2
				do: 
					[:j | 
					controlPoints atPoint: i @ j
						put: (Jun3dPoint 
								x: (i - 1) * dx
								y: (j - 1) * dy
								z: 0.0d)]].
	weights := JunMatrix new: 2
				collection: ((1 to: n * n) collect: [:i | 1.0d]).
	frontend := (Array new: n - 1)
				atAllPut: 0.0d;
				yourself.
	backend := (Array new: n - 1)
				atAllPut: 1.0d;
				yourself.
	middle := Array with: 0.0d with: 1.0d.
	knots := frontend , middle , backend.
	^JunOpenGL3dNurbsSurface 
		controlPoints: (JunMatrix new: n collection: controlPoints)
		weights: weights
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsRectSurface2 [
	"JunOpenGL3dNurbsSurface exampleNurbsRectSurface2 name: 'example'; paint: ColorValue blue; show."

	| xLength yLength controlPoints weights knots |
	xLength := 2.0d.
	yLength := 3.0d.
	controlPoints := JunMatrix new: 2.
	controlPoints atPoint: 1 @ 1
		put: (Jun3dPoint 
				x: 0.0d
				y: 0.0d
				z: 0.0d).
	controlPoints atPoint: 1 @ 2
		put: (Jun3dPoint 
				x: 0.0d
				y: yLength
				z: 0.0d).
	controlPoints atPoint: 2 @ 1
		put: (Jun3dPoint 
				x: xLength
				y: 0.0d
				z: 0.0d).
	controlPoints atPoint: 2 @ 2
		put: (Jun3dPoint 
				x: xLength
				y: yLength
				z: 0.0d).
	weights := JunMatrix new: 2
				collection: ((1 to: 2 * 2) collect: [:i | 1.0d]).
	knots := #(0 0 1 1).
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: knots copy
		vKnotVector: knots copy
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsRectSurface2a [
	"JunOpenGL3dNurbsSurface exampleNurbsRectSurface2a name: 'example'; paint: ColorValue blue; show."

	| xLength yLength controlPoints weights knots |
	xLength := 2.0d.
	yLength := 3.0d.
	controlPoints := JunMatrix new: 2.
	controlPoints atPoint: 1 @ 1
		put: (Jun3dPoint 
				x: xLength
				y: 0.0d
				z: 0.0d).
	controlPoints atPoint: 1 @ 2
		put: (Jun3dPoint 
				x: xLength
				y: yLength
				z: 0.0d).
	controlPoints atPoint: 2 @ 1
		put: (Jun3dPoint 
				x: 0.0d
				y: 0.0d
				z: 0.0d).
	controlPoints atPoint: 2 @ 2
		put: (Jun3dPoint 
				x: 0.0d
				y: yLength
				z: 0.0d).
	weights := JunMatrix new: 2
				collection: ((1 to: 2 * 2) collect: [:i | 1.0d]).
	knots := #(0 0 1 1).
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: knots copy
		vKnotVector: knots copy
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsSurface [
	"JunOpenGL3dNurbsSurface exampleNurbsSurface show."

	| controlPoints weights knots |
	controlPoints := JunMatrix new: 4.
	1 to: 4 do: [:x | 1 to: 4 do: [:y | controlPoints atPoint: x @ y put: (Jun3dPoint
					x: x - 2.5 * 2 / 3
					y: y - 2.5 * 2 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	weights := JunMatrix new: 4 collection: ((1 to: 16)
					collect: [:i | i // 4 + 1 / 2.0]).
	knots := #(0.0 0.0 0.5 0.5 1.0 1.0 1.0 1.0).
	^JunOpenGL3dNurbsSurface
		controlPoints: (JunMatrix new: 4 collection: controlPoints)
		weights: weights
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsSurface2 [
	"JunOpenGL3dNurbsSurface exampleNurbsSurface show."

	| controlPoints weights knots |
	controlPoints := JunMatrix new: 4.
	1 to: 4 do: [:x | 1 to: 4 do: [:y | controlPoints atPoint: x @ y put: (Jun3dPoint
					x: x - 2.5 * 2 / 3
					y: y - 2.5 * 2 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	weights := JunMatrix new: 4 collection: ((1 to: 16)
					collect: [:i | i // 4 + 1 / 2.0]).
	knots := #(0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0).
	^JunOpenGL3dNurbsSurface
		controlPoints: (JunMatrix new: 4 collection: controlPoints)
		weights: weights
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> exampleNurbsSurface3 [
	"JunOpenGL3dNurbsSurface exampleNurbsSurface3 name: 'example'; paint: ColorValue blue; show."

	| n circleNurbs zEnd circleControlPoints controlPoints circleWeights weights point frontend backend middle knots circleKnots |
	n := 2.
	circleNurbs := JunOpenGL3dNurbsCurve exampleEllipseHalf.
	zEnd := 2.0d.
	circleControlPoints := circleNurbs controlPoints.
	controlPoints := JunMatrix new: circleControlPoints size by: n.
	circleWeights := circleNurbs weights.
	weights := JunMatrix new: circleControlPoints size by: n.
	1 to: circleControlPoints size
		do: 
			[:i | 
			1 to: n
				do: 
					[:j | 
					point := (circleControlPoints at: i) copy.
					j == 2 ifTrue: [point setZ: zEnd].
					controlPoints atPoint: i @ j put: point.
					weights atPoint: i @ j put: (circleWeights at: i)]].
	circleKnots := circleNurbs knotVector.
	frontend := (Array new: n - 1)
				atAllPut: 0.0d;
				yourself.
	backend := (Array new: n - 1)
				atAllPut: 1.0d;
				yourself.
	middle := Array with: 0.0d with: 1.0d.
	knots := frontend , middle , backend.
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: circleKnots
		vKnotVector: knots
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface classSide >> fromRectangle: aRectangle [ 
	"JunOpenGL3dNurbsSurface fromRectangle: (Graphics.Rectangle origin: 0 @ 0 corner: 1.0 @ 1.0)."

	| minxminy maxxmaxy controlPoints weights knots |
	minxminy := aRectangle origin.
	maxxmaxy := aRectangle corner.
	controlPoints := JunMatrix new: 2.
	controlPoints atPoint: 1 @ 1
		put: (Jun3dPoint 
				x: minxminy x
				y: minxminy y
				z: 0.0d).
	controlPoints atPoint: 1 @ 2
		put: (Jun3dPoint 
				x: minxminy x
				y: maxxmaxy y
				z: 0.0d).
	controlPoints atPoint: 2 @ 1
		put: (Jun3dPoint 
				x: maxxmaxy x
				y: minxminy y
				z: 0.0d).
	controlPoints atPoint: 2 @ 2
		put: (Jun3dPoint 
				x: maxxmaxy x
				y: maxxmaxy y
				z: 0.0d).
	weights := JunMatrix new: 2
				collection: ((1 to: 2 * 2) collect: [:i | 1.0d]).
	knots := #(0 0 1 1).
	^JunOpenGL3dNurbsSurface 
		controlPoints: controlPoints
		weights: weights
		uKnotVector: knots copy
		vKnotVector: knots copy
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNurbsSurface >> reverse [
	| answer answeruKnotVector size answerControlPoints nrow ncol |
	answer := self copy.
	answeruKnotVector := answer uKnotVector.
	size := uKnotVector size.
	1 to: size
		do: [:i | answeruKnotVector at: size - i + 1 put: (uKnotVector at: i) negated].
	answerControlPoints := answer controlPoints.
	nrow := controlPoints rowSize.
	ncol := controlPoints columnSize.
	1 to: nrow
		do: 
			[:i | 
			1 to: ncol
				do: 
					[:j | 
					answerControlPoints atPoint: (nrow - i + 1) @ j
						put: (controlPoints atPoint: i @ j)]].
	^answer
]
