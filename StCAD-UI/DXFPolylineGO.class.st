Class {
	#name : #DXFPolylineGO,
	#superclass : #CADPolylineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
DXFPolylineGO class >> metaClass [
	^DXFPolyline
]

{ #category : #'VisualWorks metadata' }
DXFPolylineGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #debug }
DXFPolylineGO >> color: aColorValue [ 
	"Copyright (C) 1993-1995 Polymorphic Software, Inc.  All Rights Reserved"

	"Set the path color of the receiver"

	color := aColorValue
]

{ #category : #displaying }
DXFPolylineGO >> displayWith: aPen [ 
	| cFlag |
	cFlag := self metaObject cFlag.
	cFlag ifNil: [super displayWith: aPen]
		ifNotNil: 
			[(cFlag detect: [:aFlag | aFlag == false] ifNone: nil) 
				ifNil: [super displayWith: aPen]
				ifNotNil: 
					[1 to: cFlag size
						do: 
							[:i | 
							(cFlag at: i) 
								ifTrue: 
									[aPen 
										setStyle: lineStyle
										color: color
										width: self width.
									[aPen displayLineFrom: (points at: i) to: (points at: i + 1)] on: Error
										do: 
											[:ex | 
											ex messageText = 'a primitive has failed' 
												ifTrue: [ex return]
												ifFalse: [ex pass]]]]]]
]

{ #category : #accessing }
DXFPolylineGO >> geoObject: geoObject [ 
	super geoObject: geoObject.
	self color: geoObject aColor
]

{ #category : #calc }
DXFPolylineGO >> graphicsIntersecting: rDpD collectIn: set [ 
	"Do nothing."
]
