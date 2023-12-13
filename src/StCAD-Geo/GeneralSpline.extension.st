Extension { #name : #GeneralSpline }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
GeneralSpline >> storeOn: aStream level: level [ 
	| block |
	aStream storeLevel: level title: 'GeneralSpline'.
	aStream
		storeLevel: level + 1
		title: 'Order'
		object: degree.
	aStream storeLevel: level + 1 title: 'DataPoints'.
	block := 
			[:title :array | 
			| collection |
			collection := OrderedCollection new: array size + 1.
			collection add: title.
			collection addAll: array.
			collection storeOn: aStream level: level + 1].
	block value: 'Number' value: (1 to: xs size by: 1).
	block value: 's' value: xs.
	block value: 'x' value: (ys collect: [:yi | yi at: 1]).
	block value: 'y' value: (ys collect: [:yi | yi at: 2]).
	block value: 'z' value: (ys collect: [:yi | yi at: 3])
]
