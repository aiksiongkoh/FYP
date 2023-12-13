Extension { #name : #JunOpenGL3dNonConvexPolygon }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunOpenGL3dNonConvexPolygon classSide >> exampleKoh [
	"JunOpenGL3dNonConvexPolygon exampleKoh."

	| outline nonConvexPolygon |
	outline := Array 
				with: 0 , 0 , 0
				with: 1 , 0 , 0
				with: 0.1 , 0.1 , 0
				with: 0 , 1 , 0.
	nonConvexPolygon := JunOpenGL3dNonConvexPolygon 
				vertexes: outline
				holes: Array new
				paint: ColorValue blue.
	nonConvexPolygon show.
	^nonConvexPolygon
]
