Class {
	#name : #Parser,
	#superclass : #ExternalLanguageParser,
	#instVars : [
		'geoRootItem'
	],
	#category : #'StCAD-UI-Parser'
}

{ #category : #'VisualWorks metadata' }
Parser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.MOSES'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #'VisualWorks metadata' }
Parser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.POVRay'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #'VisualWorks metadata' }
Parser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.Sebert'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #scanning }
Parser >> dash [
	token == #- 
		ifTrue: 
			[self scanToken.
			^true].
	^false
]

{ #category : #'error handling' }
Parser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : #accessing }
Parser >> geoRootItem: geoItem [ 
	geoRootItem := geoItem
]

{ #category : #accessing }
Parser >> geoRootItem: geoItem [ 
	geoRootItem := geoItem
]

{ #category : #accessing }
Parser >> geoRootItem: geoItem [ 
	geoRootItem := geoItem
]

{ #category : #'initialize-release' }
Parser >> initScanner [
	super initScanner.
	typeTable at: $" asInteger put: #DoubleQuote.
	typeTable at: $$ asInteger put: #Dollar.	"dollar sign"
	typeTable at: $' asInteger put: #SingleQuote.
	template := WriteStream on: (String new: 1000).
	expressions := OrderedCollection new
]

{ #category : #'error handling' }
Parser >> notify: aString [ 
	"Notify problem at token starting 'here'"

	^self notify: aString at: mark
]
