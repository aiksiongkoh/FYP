Extension { #name : #SubItem }

{ #category : #'*StCAD-UI-accessing' }
SubItem >> asTreeNode [

	| answer |
	answer := StCAD_UI_TreeNode new. "VW_TRANSLATION:StCAD.UI.TreeNode:StCAD_UI_TreeNode"
	answer geoItem: self.
	answer displayString: self name.
	^ answer
]
