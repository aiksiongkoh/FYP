Class {
	#name : #Item,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
Item class >> shortName [

	^self name
]

{ #category : #'VisualWorks metadata' }
Item class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
Item >> fillInstVarFrom: aDict [ 
	| block |
	block := 
			[:aArray | 
			1 to: aArray size
				do: 
					[:j | 
					| element |
					element := aArray at: j.
					element isSequenceable 
						ifTrue: 
							[(element isString and: [element isEmpty not and: [element first = $#]]) 
								ifTrue: 
									[| aReadStream index |
									aReadStream := element readStream.
									aReadStream next.
									index := Number readFrom: aReadStream.
									aArray at: j put: (aDict at: index)]
								ifFalse: [block value: element]]]].
	1 to: self class instSize
		do: 
			[:i | 
			| instVar |
			instVar := self instVarAt: i.
			instVar isSequenceable 
				ifTrue: 
					[(instVar isString and: [instVar isEmpty not and: [instVar first = $#]]) 
						ifTrue: 
							[| aReadStream index |
							aReadStream := instVar readStream.
							aReadStream next.
							index := Number readFrom: aReadStream.
							self instVarAt: i put: (aDict at: index)]
						ifFalse: [block value: instVar]]]
]

{ #category : #accessing }
Item >> fillInstVarWith1: aDict [ 
	1 to: self class instSize
		do: 
			[:i | 
			| instVar |
			instVar := self instVarAt: i.
			instVar isSequenceable 
				ifTrue: 
					[(instVar isString and: [instVar isEmpty not and: [instVar first = $#]]) 
						ifTrue: 
							[| aReadStream index |
							aReadStream := instVar readStream.
							aReadStream next.
							index := Number readFrom: aReadStream.
							self instVarAt: i put: (aDict at: index)]
						ifFalse: 
							[1 to: instVar size
								do: 
									[:j | 
									| element |
									element := instVar at: j.
									(element isString and: [element isEmpty not and: [element first = $#]]) 
										ifTrue: 
											[| aReadStream index |
											aReadStream := element readStream.
											aReadStream next.
											index := Number readFrom: aReadStream.
											instVar at: j put: (aDict at: index)]]]]]
]

{ #category : #accessing }
Item >> fillInstVarWith2: aDict [ 
	| block |
	block := 
			[:aArray | 
			1 to: aArray size
				do: 
					[:j | 
					| element |
					element := aArray at: j.
					element isSequenceable 
						ifTrue: 
							[(element isString and: [element isEmpty not and: [element first = $#]]) 
								ifTrue: 
									[| aReadStream index |
									aReadStream := element readStream.
									aReadStream next.
									index := Number readFrom: aReadStream.
									aArray at: j put: (aDict at: index)]
								ifFalse: [block value: element]]]].
	1 to: self class instSize
		do: 
			[:i | 
			| instVar |
			instVar := self instVarAt: i.
			instVar isSequenceable 
				ifTrue: 
					[(instVar isString and: [instVar isEmpty not and: [instVar first = $#]]) 
						ifTrue: 
							[| aReadStream index |
							aReadStream := instVar readStream.
							aReadStream next.
							index := Number readFrom: aReadStream.
							self instVarAt: i put: (aDict at: index)]
						ifFalse: [block value: instVar]]]
]

{ #category : #accessing }
Item >> fillInstVarWith: aDict [ 
	| block |
	block := 
			[:aArray | 
			1 to: aArray size
				do: 
					[:j | 
					| element |
					element := aArray at: j.
					element isSequenceable 
						ifTrue: 
							[(element isString and: [element isEmpty not and: [element first = $#]]) 
								ifTrue: 
									[| aReadStream index |
									aReadStream := element readStream.
									aReadStream next.
									index := Number readFrom: aReadStream.
									aArray at: j put: (aDict at: index)]
								ifFalse: [block value: element]]]].
	1 to: self class instSize
		do: 
			[:i | 
			| instVar |
			instVar := self instVarAt: i.
			instVar isSequenceable 
				ifTrue: 
					[(instVar isString and: [instVar isEmpty not and: [instVar first = $#]]) 
						ifTrue: 
							[| aReadStream index |
							aReadStream := instVar readStream.
							aReadStream next.
							index := Number readFrom: aReadStream.
							self instVarAt: i put: (aDict at: index)]
						ifFalse: [block value: instVar]]]
]

{ #category : #testing }
Item >> isSupOf1: aSTEPItem [ 
	1 to: self class instSize
		do: 
			[:i | 
			| instVar |
			instVar := self instVarAt: i.
			instVar == aSTEPItem ifTrue: [^true].
			(instVar isSequenceable and: [instVar isString not]) 
				ifTrue: 
					[(instVar detect: 
							[:aaSTEPItem | 
							aaSTEPItem == aSTEPItem 
								ifTrue: [^true]
								ifFalse: 
									[(aaSTEPItem isSequenceable and: [aaSTEPItem isString not]) 
										ifTrue: 
											[(aaSTEPItem detect: [:aaaSTEPItem | aaaSTEPItem == aSTEPItem] ifNone: nil) 
												ifNotNil: [^true]]]]
						ifNone: nil) ifNotNil: [^true]]].
	^false
]

{ #category : #testing }
Item >> isSupOf: aSTEPItem [ 
	| block |
	block := 
			[:aObject | 
			aObject == aSTEPItem ifTrue: [^true].
			(aObject isSequenceable and: [aObject isString not]) 
				ifTrue: [aObject do: [:aaObject | block value: aaObject]]].
	1 to: self class instSize
		do: 
			[:i | 
			| instVar |
			instVar := self instVarAt: i.
			block value: instVar].
	^false
]

{ #category : #accessing }
Item >> name [
	^name
]

{ #category : #accessing }
Item >> name: aString [ 
	aString = 'NONE' ifTrue: [name := nil] ifFalse: [name := aString]
]

{ #category : #printing }
Item >> printOn: aStream [ 
	aStream nextPut: $a.
	aStream nextPutAll: self class printString.
	aStream nextPut: $(.
	1 to: self class instSize
		do: 
			[:i | 
			aStream
				print: (self instVarAt: i);
				space].
	1 to: self basicSize
		do: 
			[:i | 
			aStream
				print: (self at: i);
				space].
	aStream nextPut: $)
]
