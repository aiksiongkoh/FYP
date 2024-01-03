Class {
	#name : #GEOCircle,
	#superclass : #GEOEllipse,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOCircle >> magnifySelf: aDouble [ 
	self aRefFrame magnifySelf: aDouble.
	xRadius := xRadius * aDouble.
	yRadius := yRadius * aDouble
]

{ #category : #accessing }
GEOCircle >> radius: r [ 
	xRadius := r abs.
	yRadius := xRadius.
	self changed
]

{ #category : #printing }
GEOCircle >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'Circle'.
	self refFrame store2DOn: aStream level: level + 1.
	aStream
		storeLevel: level + 1
		title: 'Radius'
		object: xRadius
]

{ #category : #accessing }
GEOCircle >> xRadius: xr yRadius: yr [ 
	xRadius := xr max: 0.0d.
	yRadius := xRadius.
	self changed
]
