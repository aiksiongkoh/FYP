Extension { #name : #Stream }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Stream >> printVerbose: anObject [ 
	"Have anObject print on the receiver."

	anObject printVerboseOn: self
]
