Extension { #name : #ScreenGraphicsContext }

{ #category : #'*StCAD-UI-StCAD-UI' }
ScreenGraphicsContext >> basicDisplayRectangleOrigin: originPoint extent: extentPoint [ 
	"Display the rectangle with the top left corner extent. Use the current paint."
	"Do not override."

	<primitive: 988>
	self roundedPrimDisplayRectangleOrigin: originPoint rounded extent: extentPoint rounded
]

{ #category : #'*StCAD-UI-StCAD-UI' }
ScreenGraphicsContext >> basicDisplayRectangularBorderOrigin: originPoint extent: extentPoint [ 
	"Display the rectangular border with the specified top left corner 
	and extent. Use the current line width, cap style, join style, and paint."
	"Do not override."

	<primitive: 989>
	self roundedPrimDisplayRectangularBorderOrigin: originPoint rounded extent: extentPoint rounded
]
