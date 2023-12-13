Extension { #name : #RowTypeMatrix }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
RowTypeMatrix >> storeOn: aStream level: level [ 
	self size > 0 ifTrue: [self do: [:row | row storeOn: aStream level: level]]
]
