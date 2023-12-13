Class {
	#name : #ManyUseItem,
	#superclass : #ConcreteNMT,
	#instVars : [
		'cUse'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
ManyUseItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #comparing }
ManyUseItem >> = anObject [ 
	^self == anObject
]

{ #category : #accessing }
ManyUseItem >> addUse: aUse [ 
	cUse add: aUse.
	aUse aNMTItem: self
]

{ #category : #accessing }
ManyUseItem >> cSub [
	^cUse
]

{ #category : #accessing }
ManyUseItem >> cUse [
	^cUse
]

{ #category : #'initialize-release' }
ManyUseItem >> initialize [

	cUse := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #accessing }
ManyUseItem >> newUse [
	| aItemUse |
	aItemUse := self useClass new.
	self addUse: aItemUse.
	^aItemUse
]

{ #category : #accessing }
ManyUseItem >> removeSub: aSub [ 
	| answer |
	answer := super removeSub: aSub.
	self cUse isEmpty ifTrue: [self die].
	^answer
]

{ #category : #accessing }
ManyUseItem >> useClass [
	self subclassResponsibility
]
