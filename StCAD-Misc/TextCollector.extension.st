Extension { #name : #TextCollector }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
TextCollector >> crShow: aString [ 
	self
		cr;
		show: aString
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
TextCollector >> crcrShow: aString [ 
	self
		cr;
		crShow: aString
]
