Extension { #name : #GraphicsContext }

{ #category : #'*StCAD-UI-StCAD-UI' }
GraphicsContext >> centerHandleAt: location sizeInPixel: sizeInPixel [ 
	"location is in Drawing coordinates."

	self setFill ifTrue: [self basicDisplayRectangleOrigin: (self scalePoint: location)
				- (sizeInPixel // 2) extent: sizeInPixel].
	self setFore ifTrue: [self basicDisplayRectangularBorderOrigin: (self scalePoint: location)
				- (sizeInPixel // 2) extent: sizeInPixel]
]
