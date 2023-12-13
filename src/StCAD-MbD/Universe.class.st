Class {
	#name : #Universe,
	#superclass : #SpatialItem,
	#instVars : [
		'cAssembly'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
Universe class >> aRefFrameClass [
	^AbsoluteFrame
]

{ #category : #'VisualWorks metadata' }
Universe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
Universe >> addAssembly: aAssembly [ 
	aAssembly removeSup.
	super addRefFrame: aAssembly aRefFrame.
	cAssembly add: aAssembly.
	aAssembly aSup: self.
	^aAssembly
]

{ #category : #'initialize-release' }
Universe >> initialize [

	super initialize.
	name := #Universe.
	cAssembly := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]
