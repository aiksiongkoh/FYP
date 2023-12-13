Class {
	#name : #AdImage,
	#superclass : #AdData,
	#instVars : [
		'image',
		'http'
	],
	#category : #'StCAD-Doc-StDoc'
}

{ #category : #'VisualWorks metadata' }
AdImage class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Doc'
		'superclassNamespace' 'StCAD.Doc'
	)

]

{ #category : #accessing }
AdImage >> http [
	^http
]

{ #category : #accessing }
AdImage >> http: string [ 
	http := string asString
]

{ #category : #accessing }
AdImage >> image [
	^image
]

{ #category : #accessing }
AdImage >> image: cachedImage [ 
	image := cachedImage
]
