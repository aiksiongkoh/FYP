Class {
	#name : #SingleLighting,
	#superclass : #AnyLighting,
	#instVars : [
		'color',
		'alpha'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'instance creation' }
SingleLighting class >> color: aColorValue [ 
	^self color: aColorValue alpha: self defaultAlpha
]

{ #category : #'instance creation' }
SingleLighting class >> color: aColorValue alpha: aNumber [ 
	^self new setColor: aColorValue alpha: aNumber
]

{ #category : #'VisualWorks metadata' }
SingleLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
SingleLighting >> alpha [
	^alpha ifNil: [1.0]
]

{ #category : #accessing }
SingleLighting >> alpha: anObject [
	alpha := anObject
]

{ #category : #accessing }
SingleLighting >> color [
	^color
]

{ #category : #accessing }
SingleLighting >> color: anObject [
	color := anObject
]

{ #category : #calc }
SingleLighting >> privateCalcBoundingBox [
	aBoundingBox := BoundingBox origin: (FullColumn zero: 3)
				corner: (FullColumn zero: 3)
]

{ #category : #accessing }
SingleLighting >> setColor: aColorValue alpha: aNumber [ 
	color := aColorValue.
	alpha := aNumber
]
