"

	Description: 

	CADCreationTool is used to create CADGraphicObjects.

	Instance Variables:

	className - <Symbol> The symbol of the class to create
	creationSelector - <Symbol> The selector to send to the class
"
Class {
	#name : #CADCreationTool,
	#superclass : #GFTool,
	#instVars : [
		'className',
		'creationSelector'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #cursors }
CADCreationTool class >> cursor: aCursor class: aClass [ 
	^(self cursor: aCursor)
		setClassName: aClass name
]

{ #category : #cursors }
CADCreationTool class >> icon: anImage cursor: aCursor class: aClass [ 
	^(self
		icon: anImage
		cursor: aCursor
		name: '')
		setClassName: aClass name
]

{ #category : #cursors }
CADCreationTool class >> icon: anImage cursor: aCursor class: aClass name: aString [ 
	^(self
		icon: anImage
		cursor: aCursor
		name: aString)
		setClassName: aClass name
]

{ #category : #'VisualWorks metadata' }
CADCreationTool class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #all }
CADCreationTool >> button1DownBackground [
	| createdGO |
	(createdGO := self createGO) isNil ifTrue: [^self].
	self isSticky ifFalse: [interface setDefaultTool selection: createdGO]
]

{ #category : #all }
CADCreationTool >> button1DownGO: aGO [ 
	"Private - Just create a GO on top of the existing GO - a reasonable 
	default behavior."

	^self button1DownBackground
]

{ #category : #all }
CADCreationTool >> createGO [
	| aGO |
	interface cursorPointSnapped: true limit: true.
	aGO := self creationClass perform: self creationSelector with: interface.
	^aGO
]

{ #category : #all }
CADCreationTool >> creationClass [

	^ StCAD_UI at: className asSymbol "VW_TRANSLATION:StCAD.UI:StCAD_UI"
]

{ #category : #all }
CADCreationTool >> creationSelector [
	^creationSelector isNil
		ifTrue: [#createNotifying:]
		ifFalse: [creationSelector]
]

{ #category : #all }
CADCreationTool >> graphicObjectAtPoint: aPoint [ 
	^(self handleAt: aPoint) ifNil: [super graphicObjectAtPoint: aPoint]
]

{ #category : #all }
CADCreationTool >> isSticky [
	| painterController |
	painterController := Smalltalk at: #UIPainterController ifAbsent: [nil].
	^interface shiftDown or: [painterController notNil and: [painterController modeIsSticky]]
]

{ #category : #all }
CADCreationTool >> selectGO: aGO [ 
	interface shiftDown
		ifTrue: [interface toggleSelection: aGO]
		ifFalse: [interface selection: aGO]
]

{ #category : #all }
CADCreationTool >> setClassName: aSymbol [ 
	className := aSymbol
]

{ #category : #all }
CADCreationTool >> setCreationSelector: aSymbol [ 
	creationSelector := aSymbol
]
