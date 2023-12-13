Extension { #name : #Text }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Text >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self storeString replaceCRandTabWithMacros
]
