Class {
	#name : #OrderedSet,
	#superclass : #OrderedCollection,
	#type : #variable,
	#instVars : [
		'comparisonBlock'
	],
	#category : #'StCAD-Misc'
}

{ #category : #adding }
OrderedSet >> addFirst: newObject [ 
	(self includes: newObject) ifFalse: [super addFirst: newObject].
	^newObject
]

{ #category : #adding }
OrderedSet >> addLast: newObject [ 
	(self includes: newObject) ifFalse: [super addLast: newObject].
	^newObject
]

{ #category : #accessing }
OrderedSet >> comparisonBlock [
	^comparisonBlock
]

{ #category : #accessing }
OrderedSet >> comparisonBlock: anObject [
	comparisonBlock := anObject
]

{ #category : #private }
OrderedSet >> cyclicShiftElementToTop: block [ 
	| index |
	index := self findFirst: block.
	self shiftElementUp: index - 1
]

{ #category : #private }
OrderedSet >> find: oldObject [ 
	| index |
	index := firstIndex.
	
	[index <= lastIndex 
		and: [(comparisonBlock value: oldObject value: (self basicAt: index)) not]] 
			whileTrue: [index := index + 1].
	index <= lastIndex ifTrue: [^index] ifFalse: [^self notFoundError]
]

{ #category : #'initialize-release' }
OrderedSet >> forEquality [
	comparisonBlock := [:a :b | a = b]
]

{ #category : #'initialize-release' }
OrderedSet >> forIdentity [
	comparisonBlock := [:a :b | a == b]
]

{ #category : #testing }
OrderedSet >> includes: anObject [ 
	firstIndex to: lastIndex
		do: 
			[:i | 
			(comparisonBlock value: anObject value: (self basicAt: i)) ifTrue: [^true]].
	^false
]

{ #category : #removing }
OrderedSet >> remove: oldObject ifAbsent: anExceptionBlock [ 
	"Remove oldObject as one of the receiver's elements.  If several of the
	elements are equal to oldObject, only one is removed. If no element is equal to
	oldObject, answer the result of evaluating anExceptionBlock.  Otherwise,
	answer the argument, oldObject."

	firstIndex to: lastIndex
		do: 
			[:index | 
			(comparisonBlock value: oldObject value: (self basicAt: index)) 
				ifTrue: 
					[self removeIndex: index.
					^oldObject]].
	^anExceptionBlock value
]

{ #category : #private }
OrderedSet >> shiftElementUp: n [ 
	1 to: n do: [:i | self addLast: self removeFirst]
]
