Class {
	#name : #PairedUse,
	#superclass : #ItemUse,
	#instVars : [
		'mate'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
PairedUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
PairedUse >> aNurbs: aNurbs [ 
	self removeActionsForEvent: #getNurbs.
	aNurbs ifNotNil: 
			[self 
				when: #getNurbs
				ask: aNurbs
				perform: #yourself]
]

{ #category : #accessing }
PairedUse >> glNurbs [
	^(self triggerEvent: #glNurbs) ifNil: 
			[| answer |
			answer := self create_glNurbs.
			self glNurbs: answer.
			answer]
]

{ #category : #accessing }
PairedUse >> glNurbs: glNurbs [ 
	self removeActionsForEvent: #glNurbs.
	glNurbs ifNotNil: 
			[self 
				when: #glNurbs
				ask: glNurbs
				perform: #yourself]
]

{ #category : #accessing }
PairedUse >> mate [
	^mate
]

{ #category : #accessing }
PairedUse >> mate: aPairedUse [ 
	mate := aPairedUse.
	aPairedUse 
		ifNotNil: [aPairedUse mate == self ifFalse: [aPairedUse mate: self]]
]
