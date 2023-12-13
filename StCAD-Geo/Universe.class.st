"


Instance Variables:
	aAssembly	<Assembly>	description of aAssembly
	cCamera	<Collection of Cameras>	Remembered cameras. The first element is the active camera for arbitrary camera motion.
	cLighting	<Collection of Lightings>	These are lighting in space not fixed to cameras.


"
Class {
	#name : #Universe,
	#superclass : #SpatialItem,
	#instVars : [
		'cCamera',
		'cLighting',
		'cAssembly'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Universe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Universe >> aAbsoluteFrame [
	^aRefFrame
]

{ #category : #accessing }
Universe >> addAssembly: aAssembly [ 
	aAssembly removeSup.
	super addRefFrame: aAssembly aRefFrame.
	cAssembly add: aAssembly.
	aAssembly aSup: self.
	self calcBoundingBox.
	^aAssembly
]

{ #category : #accessing }
Universe >> addCamera: aCamera [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aCamera removeSup.
	super addRefFrame: aCamera aRefFrame.
	cCamera add: aCamera.
	aCamera aSup: self.
	self calcBoundingBox.
	^aCamera
]

{ #category : #accessing }
Universe >> addLighting: aLighting [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aLighting removeSup.
	super addRefFrame: aLighting aRefFrame.
	cLighting add: aLighting.
	aLighting aSup: self.
	self calcBoundingBox.
	^aLighting
]

{ #category : #accessing }
Universe >> animationData [
	^cAssembly first animationData
]

{ #category : #accessing }
Universe >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer
		addCollection: cCamera name: 'Cameras';
		addCollection: cLighting name: 'Lightings';
		addCollection: cAssembly name: 'Assemblies'.
	^answer
]

{ #category : #accessing }
Universe >> boundingBox [
	| answer |
	answer := aRefFrame boundingBox.
	cAssembly 
		do: [:aAssembly | answer := answer merge: aAssembly boundingBoxF].
	^answer
]

{ #category : #accessing }
Universe >> cCamera [
	^cCamera
]

{ #category : #accessing }
Universe >> cCamera: anObject [
	cCamera := anObject
]

{ #category : #calc }
Universe >> cItemWithBoundingBox [
	^(OrderedCollection new: 1)
		addAll: cCamera;
		addAll: cLighting;
		addAll: cAssembly;
		yourself
]

{ #category : #accessing }
Universe >> cLighting [
	^cLighting
]

{ #category : #accessing }
Universe >> cLighting: anObject [
	cLighting := anObject
]

{ #category : #displaying }
Universe >> canUpdateForFrame: integer [ 
	^(cAssembly 
		detect: [:aAssembly | (aAssembly canUpdateForFrame: integer) not]
		ifNone: nil) isNil
]

{ #category : #accessing }
Universe >> displayLightCollection [
	^cLighting
]

{ #category : #accessing }
Universe >> displayObject [
	^cAssembly
]

{ #category : #'initialize-release' }
Universe >> initialize [

	name := #Universe.
	self aRefFrame: AbsoluteFrame new.
	cCamera := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cLighting := StCAD_Misc_OrderedSet new.
	cAssembly := StCAD_Misc_OrderedSet new.
	self addCamera: PerspectiveCamera new.
	self addLighting:
		(AmbientLighting color: ColorValue veryDarkGray copy).
	self addLighting: (ParallelLighting
			 color: ColorValue veryDarkGray copy
			 direction: #( -1 0 0 )).
	self addLighting: (ParallelLighting
			 color: ColorValue veryDarkGray copy
			 direction: #( 0 -1 0 )).
	self addLighting: (ParallelLighting
			 color: ColorValue veryDarkGray copy
			 direction: #( 0 0 -1 )).
	self calcBoundingBox
]

{ #category : #displaying }
Universe >> preRenderOn: renderingContext [ 
	cLighting do: [:aLighting | aLighting shineOn: renderingContext].
	renderingContext flush
]

{ #category : #calc }
Universe >> privateCalcBoundingBox [
	aBoundingBox := self aAbsoluteFrame boundingBox.
	self privateCalcBoundingBox: self cItemWithBoundingBox
]

{ #category : #accessing }
Universe >> removeCamera: aCamera [ 
	super removeSub: aCamera.
	cCamera remove: aCamera ifAbsent: [nil].
	aCamera aSup: nil.
	^aCamera
]

{ #category : #accessing }
Universe >> removeLighting: aLighting [ 
	super removeSub: aLighting.
	cLighting remove: aLighting ifAbsent: [nil].
	aLighting aSup: nil.
	^aLighting
]

{ #category : #displaying }
Universe >> renderOn: aRenderingContext [ 
	self preRenderOn: aRenderingContext.
	aRenderingContext 
		pushName: self name
		transformation: aRefFrame aMFf
		while: 
			[aRefFrame renderOn: aRenderingContext.
			cCamera do: [:aCamera | aCamera renderOn: aRenderingContext].
			cLighting do: [:aLighting | aLighting renderOn: aRenderingContext].
			cAssembly do: [:aAssembly | aAssembly renderOn: aRenderingContext]]
]

{ #category : #accessing }
Universe >> timeSeries [
	^cAssembly first timeSeries
]

{ #category : #displaying }
Universe >> updateForFrame: integer [ 
	cAssembly do: [:aAssembly | aAssembly updateForFrame: integer]
]

{ #category : #displaying }
Universe >> viewAsHideLine [
	cCamera do: [:aCamera | aCamera presentation: #hiddenline]
]

{ #category : #displaying }
Universe >> viewAsSolid [
	cCamera do: [:aCamera | aCamera presentation: #solid]
]

{ #category : #displaying }
Universe >> viewAsWireframe [
	cCamera do: [:aCamera | aCamera presentation: #wireframe]
]
