Class {
	#name : #SupItem,
	#superclass : #SubItem,
	#instVars : [
		'cSub'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
SupItem >> aSup: anObject [ 
	aSup := anObject
]

{ #category : #accessing }
SupItem >> addSub: aSub [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aSub removeSup.
	cSub add: aSub.
	aSub aSup: self.
	^aSub
]

{ #category : #'initialize-release' }
SupItem >> initialize [

	super initialize.
	cSub := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #copying }
SupItem >> postCopy [
	super postCopy.
	cSub := IdentitySet new
]

{ #category : #accessing }
SupItem >> removeSub: aSub [ 
	^(cSub remove: aSub ifAbsent: [nil]) ifNotNil: 
			[:aaSub | 
			aaSub aSup: nil.
			aaSub]
]
