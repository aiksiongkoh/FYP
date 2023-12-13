Extension { #name : #Boolean }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Boolean >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self printString
]
