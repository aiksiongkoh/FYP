Extension { #name : #PsiEventModel }

{ #category : #'*StCAD-UI-StCAD-UI' }
PsiEventModel >> representBinaryOn: bosWriter [ 
	self halt: 'Only GEO objects should be BOSS' expandMacros.
	^0
]
