Class {
	#name : #SubItem,
	#superclass : #Item,
	#instVars : [
		'cEventHandler',
		'aSup'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
SubItem >> aSup [
	^aSup
]

{ #category : #accessing }
SubItem >> aSup: anObject [
	aSup := anObject
]

{ #category : #change }
SubItem >> changed [
	self triggerEvent: #changed
]

{ #category : #accessing }
SubItem >> dataSeries [
	| answer |
	answer := self triggerEvent: #getDataSeries.
	answer isNil 
		ifTrue: 
			[answer := OrderedCollection new.
			self dataSeries: answer].
	^answer
]

{ #category : #accessing }
SubItem >> dataSeries: dataSeries [ 
	self removeActionsForEvent: #getDataSeries.
	dataSeries notNil ifTrue: [self
			when: #getDataSeries
			ask: dataSeries
			perform: #yourself]
]

{ #category : #accessing }
SubItem >> fullName [
	| stream |
	stream := WriteStream on: (String new: 256).
	self fullpath do: [:node | (node respondsTo: #name)
			ifTrue: [node name isString
					ifTrue: 
						[stream nextPut: $/.
						stream nextPutAll: node name]]].
	^stream contents asSymbol
]

{ #category : #accessing }
SubItem >> fullpath [
	| fullpath |
	fullpath := aSup isNil 
				ifTrue: [OrderedCollection new]
				ifFalse: [aSup fullpath].
	fullpath add: self.
	^fullpath
]

{ #category : #accessing }
SubItem >> geoTime [
	^aSup ifNotNil: [aSup geoTime]
]

{ #category : #accessing }
SubItem >> inputData: inputData [ 
	self removeActionsForEvent: #getInputData.
	inputData notNil ifTrue: [self
			when: #getInputData
			ask: inputData
			perform: #yourself]
]

{ #category : #testing }
SubItem >> isAssembly [
	^false
]

{ #category : #testing }
SubItem >> isJoint [
	^false
]

{ #category : #testing }
SubItem >> isMotion [
	^false
]

{ #category : #'private event table' }
SubItem >> myEventTable [
	^cEventHandler
]

{ #category : #'private event table' }
SubItem >> myEventTable: anEventTable [ 
	cEventHandler := anEventTable
]

{ #category : #accessing }
SubItem >> name [
	^self triggerEvent: #getName
]

{ #category : #accessing }
SubItem >> notes: notes [ 
	self removeActionsForEvent: #getNotes.
	notes notNil 
		ifTrue: 
			[self 
				when: #getNotes
				ask: notes
				perform: #yourself]
]

{ #category : #copying }
SubItem >> postCopy [
	super postCopy.
	cEventHandler := nil.
	aSup := nil
]

{ #category : #accessing }
SubItem >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeSub: self]
]
