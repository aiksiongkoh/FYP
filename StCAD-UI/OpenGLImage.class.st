Class {
	#name : #OpenGLImage,
	#superclass : #Item,
	#instVars : [
		'aCPointer',
		'aImage'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'instance creation' }
OpenGLImage class >> aImage: image [ 
	^(self new)
		aImage: image;
		yourself
]

{ #category : #'VisualWorks metadata' }
OpenGLImage class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
OpenGLImage >> aImage [
	aImage isNil 
		ifTrue: 
			[| palette value |
			palette := FixedPalette 
						redShift: 16
						redMask: 255
						greenShift: 8
						greenMask: 255
						blueShift: 0
						blueMask: 255.
			aImage := Image 
						extent: 1 @ 1
						depth: 24
						palette: palette.
			value := aImage palette indexOfPaintNearest: ColorValue black.
			aImage atPoint: 0 @ 0 put: value].
	^aImage
]

{ #category : #accessing }
OpenGLImage >> aImage: image [ 
	(image width = 0 or: [image height = 0]) ifTrue: [^self].
	aImage := image.
	self flushCPointer
]

{ #category : #externals }
OpenGLImage >> flushCPointer [
	aCPointer notNil ifTrue: [aCPointer free].
	aCPointer := nil
]

{ #category : #accessing }
OpenGLImage >> height [
	^self aImage height
]

{ #category : #externals }
OpenGLImage >> pointerOfPixels [
	aCPointer isNil 
		ifTrue: 
			[Cursor execute showWhile: 
					[| aImageWidth aImageHeight byteArray index |
					aImageWidth := self aImage width.
					aImageHeight := self aImage height.
					byteArray := ByteArray new: aImageWidth * aImageHeight * 3.
					index := 0.
					aImageHeight - 1 to: 0
						by: -1
						do: 
							[:y | 
							| color red green blue |
							0 to: aImageWidth - 1
								do: 
									[:x | 
									color := self aImage valueAtPoint: x @ y.
									red := 0 max: ((color red * 255) asInteger min: 255).
									green := 0 max: ((color green * 255) asInteger min: 255).
									blue := 0 max: ((color blue * 255) asInteger min: 255).
									index := index + 1.
									byteArray at: index put: red.
									index := index + 1.
									byteArray at: index put: green.
									index := index + 1.
									byteArray at: index put: blue]].
					aCPointer := JunForeignHeap copyByteArrayToGcHeap: byteArray]].
	^aCPointer
]

{ #category : #accessing }
OpenGLImage >> width [
	^self aImage width
]
