Class {
	#name : #'SI_UNIT',
	#superclass : #'NAMED_UNIT',
	#instVars : [
		'prefix'
	],
	#classVars : [
		'UI',
		'UI'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'class initialization' }
SI_UNIT class >> initialize [
	"SI_UNIT initialize."

	CPrefix := IdentityDictionary new: 20.
	CPrefix at: #EXA put: 1.0d18.
	CPrefix at: #PETA put: 1.0d15.
	CPrefix at: #TERA put: 1.0d12.
	CPrefix at: #GIGA put: 1.0d9.
	CPrefix at: #MEGA put: 1.0d6.
	CPrefix at: #KILO put: 1.0d3.
	CPrefix at: #HECTO put: 1.0d2.
	CPrefix at: #DECA put: 1.0d1.
	CPrefix at: #DECI put: 1.0d-1.
	CPrefix at: #CENTI put: 1.0d-2.
	CPrefix at: #MILLI put: 1.0d-3.
	CPrefix at: #MICRO put: 1.0d-6.
	CPrefix at: #NANO put: 1.0d-9.
	CPrefix at: #PICO put: 1.0d-12.
	CPrefix at: #FEMTO put: 1.0d-15.
	CPrefix at: #ATTO put: 1.0d-18.
	""
	CName := IdentityDictionary new: 20.
	CName at: #METRE put: 1.0d
]

{ #category : #'VisualWorks metadata' }
SI_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

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
