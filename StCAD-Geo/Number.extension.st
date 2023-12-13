Extension { #name : #Number }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Number >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self printForExport
]
