Extension { #name : #IdentityDictionary }

{ #category : #'*StCAD-MbD-StCAD-MbD' }
IdentityDictionary >> at: key [ 
	"Answer the value at key. If key is not found, return nil."

	| index |
	index := self findKeyOrNil: key.
	^(self basicAt: index) == nil
		ifTrue: [nil]
		ifFalse: [valueArray at: index]
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
IdentityDictionary >> removeKey: key [ 
	"Remove key from the receiver. If key is not in the receiver, 
	do nothing and return nil. Otherwise, answer the value 
	associated with key."

	| index value |
	index := self findKeyOrNil: key.
	^(self basicAt: index) == nil
		ifTrue: [nil]
		ifFalse: 
			[value := valueArray at: index.
			self removeAndCleanUpAtIndex: index.
			value]
]
