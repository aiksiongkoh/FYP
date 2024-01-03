Class {
	#name : #'SI_UNIT',
	#superclass : #'NAMED_UNIT',
	#instVars : [
		'prefix'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SI_UNIT >> angleFactor [
	^name ifNotNil: 
			[name = 'RADIAN' 
				ifTrue: 
					[(prefix isNil or: [prefix = $$]) 
						ifTrue: [1.0d]
						ifFalse: [CPrefix at: prefix asUppercase asSymbol]]
				ifFalse: [nil]]
]

{ #category : #accessing }
SI_UNIT >> lengthFactor [
	^name ifNotNil: 
			[name = 'METRE' 
				ifTrue: 
					[(prefix isNil or: [prefix = $$]) 
						ifTrue: [1.0d]
						ifFalse: [CPrefix at: prefix asUppercase asSymbol]]
				ifFalse: [nil]]
]

{ #category : #accessing }
SI_UNIT >> prefix [
	^prefix
]

{ #category : #accessing }
SI_UNIT >> prefix: anObject [ 
	prefix := anObject
]
