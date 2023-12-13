Class {
	#name : #AdTitle,
	#superclass : #AdData,
	#instVars : [
		'title'
	],
	#category : #'StCAD-Doc-StDoc'
}

{ #category : #'VisualWorks metadata' }
AdTitle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Doc'
		'superclassNamespace' 'StCAD.Doc'
	)

]

{ #category : #accessing }
AdTitle >> title [
	^title
]

{ #category : #accessing }
AdTitle >> title: string [ 
	title := string asString
]
