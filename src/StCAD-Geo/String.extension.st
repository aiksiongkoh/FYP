Extension { #name : #String }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
String >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self replaceCRandTabWithMacros
]
