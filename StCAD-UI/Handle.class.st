Class {
	#name : #Handle,
	#superclass : #Object,
	#instVars : [
		'aView',
		'originPx',
		'image',
		'aSpatialItem'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #resources }
Handle class >> handleImage [

	"Tools.UIMaskEditor new openOnClass: self andSelector: #handleImage"

	<resource: #image>
	^ Image
		  extent: 5 @ 5
		  depth: 1
		  bitsPerPixel: 1
		  palette: (Graphics_MappedPalette withColors: ((Core_Array new: 1)
					    at: 1 put: Graphics_ColorValue black;
					    yourself))
		  usingBits: #[ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ] "VW_TRANSLATION:Graphics.MappedPalette:Graphics_MappedPalette" "VW_TRANSLATION:Graphics.ColorValue:Graphics_ColorValue" "VW_TRANSLATION:Core.Array:Core_Array"
]

{ #category : #resources }
Handle class >> handleImage2 [
	"Tools.UIMaskEditor new openOnClass: self andSelector: #handleImage2"

	<resource: #image>
	^(Image extent: 8@8 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette blackWhite usingBits: #[0 0 0 0 96 0 0 0 0 0 0 0 48 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])
]

{ #category : #resources }
Handle class >> handleImage3 [

	"Tools.UIMaskEditor new openOnClass: self andSelector: #handleImage3"

	<resource: #image>
	^ Image
		  extent: 5 @ 5
		  depth: 1
		  bitsPerPixel: 1
		  palette: (Graphics_MappedPalette withColors: ((Core_Array new: 2)
					    at: 1 put: Graphics_ColorValue black;
					    at: 2 put: Graphics_ColorValue yellow;
					    yourself))
		  usingBits: #[ 0 0 0 0 96 0 0 0 0 0 0 0 48 0 0 0 0 0 0 0 ] "VW_TRANSLATION:Graphics.MappedPalette:Graphics_MappedPalette" "VW_TRANSLATION:Graphics.ColorValue:Graphics_ColorValue" "VW_TRANSLATION:Core.Array:Core_Array"
]

{ #category : #'VisualWorks metadata' }
Handle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
Handle >> aView [
	^aView
]

{ #category : #accessing }
Handle >> aView: anObject [
	aView := anObject
]

{ #category : #accessing }
Handle >> image [
	^image ifNil: [image := self class handleImage]
]

{ #category : #accessing }
Handle >> originPx [
	^originPx
]

{ #category : #accessing }
Handle >> originPx: anObject [
	originPx := anObject
]

{ #category : #displaying }
Handle >> renderOn: aRenderingContext [ 
	self subclassResponsibility
]
