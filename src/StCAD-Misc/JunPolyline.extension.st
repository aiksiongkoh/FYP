Extension { #name : #JunPolyline }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunPolyline classSide >> fromcPoint: cPoint [
	"cPoint can contain nil."

	| dimension polyClass pointClass cValidPoint cJunPoint |
	cPoint detect: 
			[:aPoint |
			dimension := aPoint size.
			#(2 3) includes: dimension].
	dimension = 2
		ifTrue: 
			[polyClass := Jun2dPolyline.
			pointClass := Jun2dPoint]
		ifFalse: 
			[polyClass := Jun3dPolyline.
			pointClass := Jun3dPoint].
	cValidPoint := cPoint select: [:aPoint | aPoint notNil].
	cJunPoint := cValidPoint collect: [:aPoint | pointClass fromArray: aPoint].
	^polyClass points: cJunPoint
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunPolyline classSide >> showcPoint: cPoint withAxes: withAxes [

	| dimension polyClass |
	dimension := cPoint first size.
	polyClass := dimension = 2 ifTrue: [Jun2dPolyline] ifFalse: [Jun3dPolyline].
	polyClass showccPoint: (Array with: cPoint) withAxes: withAxes
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunPolyline classSide >> showccPoint: ccPoint withAxes: withAxes [

	| dimension polyClass aBody aPolyline |
	dimension := ccPoint first first size.
	polyClass := dimension = 2 ifTrue: [Jun2dPolyline] ifFalse: [Jun3dPolyline].
	aBody := JunOpenGL3dCompoundObject new.
	ccPoint do: 
			[:cPoint |
			aPolyline := polyClass fromcPoint: cPoint.
			aBody add: aPolyline asJunOpenGL3dObject].
	withAxes ifTrue: [aBody showWithAxes] ifFalse: [aBody show]
]
