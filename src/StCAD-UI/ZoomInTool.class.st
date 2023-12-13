Class {
	#name : #ZoomInTool,
	#superclass : #Tool,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
ZoomInTool class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
ZoomInTool >> aCursor [
	^aCursor
]

{ #category : #accessing }
ZoomInTool >> aCursor: anObject [
	aCursor := anObject
]

{ #category : #accessing }
ZoomInTool >> aIcon [
	^aIcon
]

{ #category : #accessing }
ZoomInTool >> aIcon: anObject [
	aIcon := anObject
]

{ #category : #accessing }
ZoomInTool >> name [
	^name
]

{ #category : #accessing }
ZoomInTool >> name: anObject [
	name := anObject
]
