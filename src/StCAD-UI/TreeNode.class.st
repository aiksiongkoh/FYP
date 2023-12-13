"
TreeNode is for the tree view in StCAD.
To do:
Move it to subclass of SupItem.
"
Class {
	#name : #TreeNode,
	#superclass : #Item,
	#instVars : [
		'geoItem',
		'children',
		'displayString'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
TreeNode class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]

{ #category : #comparing }
TreeNode >> = anObject [ 
	^self == anObject
]

{ #category : #accessing }
TreeNode >> addChild: item [ 
	item notNil ifTrue: [children add: item asTreeNode]
]

{ #category : #accessing }
TreeNode >> addCollection: cItem [

	"Do not treat collection as a node."

	cItem notNil ifTrue: [ 
		children := Core_List new: cItem size. "VW_TRANSLATION:Core.List:Core_List"
		cItem do: [ :item | children add: item asTreeNode ].
		children sortWith: [ :node1 :node2 | 
			node1 geoItem name <= node2 geoItem name ] ]
]

{ #category : #accessing }
TreeNode >> addCollection: cItem name: string [

	"Treat collection as a node."

	| child |
	cItem notNil ifTrue: [ 
		child := StCAD_UI_TreeNode new. "VW_TRANSLATION:StCAD.UI.TreeNode:StCAD_UI_TreeNode"
		child geoItem: cItem.
		child addCollection: cItem.
		child displayString: string.
		children add: child ]
]

{ #category : #accessing }
TreeNode >> children [
	^children isNil
		ifTrue: [children := Array new]
		ifFalse: [children]
]

{ #category : #accessing }
TreeNode >> children: aCollection [ 
	children := aCollection
]

{ #category : #copying }
TreeNode >> copyFrom: node [

	| dictA dictB childB childA setA |
	geoItem == node geoItem
		ifTrue: [ 
			children notNil ifTrue: [ 
				dictA := Core_IdentityDictionary new: children size. "VW_TRANSLATION:Core.IdentityDictionary:Core_IdentityDictionary"
				children do: [ :child | dictA at: child geoItem put: child ].
				dictB := Core_IdentityDictionary new: node children size.
				node children do: [ :child | dictB at: child geoItem put: child ].
				children do: [ :child | 
					childB := dictB removeKey: child geoItem.
					childB notNil ifTrue: [ 
						childA := dictA removeKey: child geoItem.
						childA copyFrom: childB ] ].
				setA := nil.
				dictA isEmpty ifFalse: [ 
					setA isNil ifTrue: [ setA := children asSet ].
					dictA do: [ :value | setA remove: value ] ].
				dictB isEmpty ifFalse: [ 
					setA isNil ifTrue: [ setA := children asSet ].
					dictB do: [ :value | setA add: value ] ].
				setA notNil ifTrue: [ 
					children := setA asList.
					children sortWith: [ :node1 :node2 | 
						node1 displayString <= node2 displayString ] ] ].
			displayString := node displayString ]
		ifFalse: [ 
			geoItem := node geoItem.
			children := node children.
			displayString := node displayString ]
]

{ #category : #accessing }
TreeNode >> displayString [
	^displayString
]

{ #category : #accessing }
TreeNode >> displayString: string [

	[ 
	geoItem name: string.
	displayString := string ]
		on: Core_MessageNotUnderstood
		do: [ :ex | 
			displayString isNil ifTrue: [ displayString := string ].
			ex return ] "VW_TRANSLATION:Core.MessageNotUnderstood:Core_MessageNotUnderstood"
]

{ #category : #accessing }
TreeNode >> geoItem [
	^geoItem
]

{ #category : #accessing }
TreeNode >> geoItem: item [ 
	geoItem := item
]

{ #category : #accessing }
TreeNode >> inPlaceEdit: string [ 
	self displayString: string
]

{ #category : #'initialize-release' }
TreeNode >> initialize [

	children := Core_List new: 1 "VW_TRANSLATION:Core.List:Core_List"
]
