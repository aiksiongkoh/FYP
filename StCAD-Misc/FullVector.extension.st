Extension { #name : #FullVector }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
FullVector >> asJun3dPoint [
	^Jun3dPoint 
		x: (self at: 1)
		y: (self at: 2)
		z: (self at: 3)
]
