Class {
	#name : #Part,
	#superclass : #AnyPart,
	#instVars : [
		'm',
		'cJ',
		'cRefGeo'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
Part class >> aRefFrameClass [
	^PartFrame
]

{ #category : #'VisualWorks metadata' }
Part class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
Part >> addRefGeo: aRefGeo [

	aRefGeo removeSup.
	super addRefFrame: aRefGeo aRefFrame.
	cRefGeo add: aRefGeo.
	aRefGeo aSup: self.
	^aRefGeo
]

{ #category : #'initialize-release' }
Part >> initialize [

	super initialize.
	cRefGeo := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]
