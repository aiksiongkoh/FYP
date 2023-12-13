Class {
	#name : #ItemUse,
	#superclass : #AnyNMT,
	#instVars : [
		'aNMTItem'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
ItemUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
ItemUse >> aNMTItem [
	^aNMTItem
]

{ #category : #accessing }
ItemUse >> aNMTItem: anObject [
	aNMTItem := anObject
]

{ #category : #accessing }
ItemUse >> die [
	self removeSup.
	aNMTItem removeSub: self
]
