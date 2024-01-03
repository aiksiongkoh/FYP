Class {
	#name : #GEOTreeNode,
	#superclass : #GEOItem,
	#instVars : [
		'geoItem',
		'children',
		'displayString'
	],
	#category : #'StCAD-Geo-GEOTree'
}

{ #category : #accessing }
GEOTreeNode >> children [
	^children isNil
		ifTrue: [children := Array new]
		ifFalse: [children]
]

{ #category : #accessing }
GEOTreeNode >> children: aCollection [ 
	children := aCollection
]

{ #category : #copying }
GEOTreeNode >> copyFrom: node [ 
	| dictA dictB childB childA setA |
	geoItem == node geoItem 
		ifTrue: 
			[children notNil 
				ifTrue: 
					[dictA := IdentityDictionary new: children size.
					children do: [:child | dictA at: child geoItem put: child].
					dictB := IdentityDictionary new: node children size.
					node children do: [:child | dictB at: child geoItem put: child].
					children do: 
							[:child | 
							childB := dictB removeKey: child geoItem.
							childB notNil 
								ifTrue: 
									[childA := dictA removeKey: child geoItem.
									childA copyFrom: childB]].
					setA := nil.
					dictA isEmpty 
						ifFalse: 
							[setA isNil ifTrue: [setA := children asSet].
							dictA do: [:value | setA remove: value]].
					dictB isEmpty 
						ifFalse: 
							[setA isNil ifTrue: [setA := children asSet].
							dictB do: [:value | setA add: value]].
					setA notNil 
						ifTrue: 
							[children := setA asList.
							children sortWith: 
									[:node1 :node2 | 
									node1 displayString ifNil: [true] ifNotNil: [:a | a <= node2 displayString]]]].
			displayString := node displayString]
		ifFalse: 
			[geoItem := node geoItem.
			children := node children.
			displayString := node displayString]
]

{ #category : #accessing }
GEOTreeNode >> displayString [
	^displayString
]

{ #category : #accessing }
GEOTreeNode >> displayString: string [ 
	
	[geoItem name: string.
	displayString := string]
		on: MessageNotUnderstood
		do: 
			[:ex | 
			displayString isNil ifTrue: [displayString := string].
			ex return]
]

{ #category : #accessing }
GEOTreeNode >> geoItem [
	^geoItem
]

{ #category : #accessing }
GEOTreeNode >> geoItem: item [ 
	geoItem := item
]

{ #category : #accessing }
GEOTreeNode >> inPlaceEdit: string [ 
	self displayString: string
]

{ #category : #'initialize-release' }
GEOTreeNode >> initialize [
	"Do nothing."
]
