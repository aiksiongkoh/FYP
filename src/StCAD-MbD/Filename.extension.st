Extension { #name : #Filename }

{ #category : #'*StCAD-MbD-StCAD-MbD' }
Filename >> longMoniker [
	^(Filename splitExtension: self asString) at: 1
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
Filename >> moniker [
	^(Filename splitExtension: self tail)
		at: 1
]
