"
An assembly has one fixed part at the origin to accept markers. Other parts are not fixed.

Instance Variables:
	aSimData	<Object>	description of aSimData
	aTimeSeries	<Object>	description of aTimeSeries
	cAnyPart	<Object>	description of cAnyPart
	cConstraintSet	<Object>	description of cConstraintSet
	cField	<Object>	description of cField
	cForceTorque	<Object>	description of cForceTorque
	cNote	<Object>	description of cNote
	cVariable	<Object>	description of cVariable


"
Class {
	#name : #Assembly,
	#superclass : #AnyPart,
	#instVars : [
		'cAnyPart',
		'cConstraintSet',
		'cForceTorque',
		'cField',
		'cVariable',
		'aSimData',
		'aTimeSeries'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Assembly class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Assembly >> aOriginPart [
	^cAnyPart at: 1
]

{ #category : #accessing }
Assembly >> aSimulationData: simulationData [ 
	self removeActionsForEvent: #getSimulationData.
	simulationData notNil ifTrue: [self
			when: #getSimulationData
			ask: simulationData
			perform: #yourself]
]

{ #category : #accessing }
Assembly >> addAnyPart: aAnyPart [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aAnyPart removeSup.
	super addRefFrame: aAnyPart aRefFrame.
	cAnyPart add: aAnyPart.
	aAnyPart aSup: self.
	self calcBoundingBox.
	^aAnyPart
]

{ #category : #accessing }
Assembly >> addAnyParts: arrayAnyPart [ 
	arrayAnyPart do: [:aAnyPart | self addAnyPart: aAnyPart]
]

{ #category : #accessing }
Assembly >> addForceTorque: aForceTorque [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aForceTorque removeSup.
	cForceTorque add: aForceTorque.
	aForceTorque aSup: self.
	^aForceTorque
]

{ #category : #accessing }
Assembly >> addForceTorques: arrayForceTorque [ 
	arrayForceTorque do: [:aForceTorque | self addForceTorque: aForceTorque]
]

{ #category : #accessing }
Assembly >> addGeneralConstraintSet: aGeneralConstraintSet [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aGeneralConstraintSet removeSup.
	cConstraintSet add: aGeneralConstraintSet.
	aGeneralConstraintSet aSup: self.
	^aGeneralConstraintSet
]

{ #category : #accessing }
Assembly >> addGeneralConstraintSets: cGeneralConstraintSet [ 
	cGeneralConstraintSet 
		do: [:aGeneralConstraintSet | self addGeneralConstraintSet: aGeneralConstraintSet]
]

{ #category : #accessing }
Assembly >> addJoint: aJoint [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aJoint removeSup.
	cConstraintSet add: aJoint.
	aJoint aSup: self.
	^aJoint
]

{ #category : #accessing }
Assembly >> addJoints: cJoint [ 
	cJoint do: [:aJoint | self addJoint: aJoint]
]

{ #category : #accessing }
Assembly >> addKinematicIJs: cKinematicIJ [ 
	cKinematicIJ do: [:aKinematicIJ | self addKineIJ: aKinematicIJ]
]

{ #category : #accessing }
Assembly >> addMotion: aMotion [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aMotion removeSup.
	cConstraintSet add: aMotion.
	aMotion aSup: self.
	^aMotion
]

{ #category : #accessing }
Assembly >> addMotions: cMotion [ 
	cMotion do: [:aMotion | self addMotion: aMotion]
]

{ #category : #accessing }
Assembly >> addRefCurve: aRefCurve [ 
	^self aOriginPart addRefCurve: aRefCurve
]

{ #category : #accessing }
Assembly >> addRefCurves: cRefCurve [ 
	cRefCurve do: [:aRefCurve | self addRefCurve: aRefCurve]
]

{ #category : #accessing }
Assembly >> addRefPoint: aRefPoint [ 
	^self aOriginPart addRefPoint: aRefPoint
]

{ #category : #accessing }
Assembly >> addRefPoints: cRefPoint [ 
	cRefPoint do: [:aRefPoint | self addRefPoint: aRefPoint]
]

{ #category : #accessing }
Assembly >> addRefSurface: aRefSurface [ 
	^self aOriginPart addRefSurface: aRefSurface
]

{ #category : #accessing }
Assembly >> addRefSurfaces: cRefSurface [ 
	cRefSurface do: [:aRefSurface | self addRefSurface: aRefSurface]
]

{ #category : #accessing }
Assembly >> animationData [
	| dataSeries answer nseries |
	dataSeries := self dataSeries.
	nseries := dataSeries isNil ifTrue: [0] ifFalse: [dataSeries size].
	answer := self triggerEvent: #getAnimationData.
	answer == nil 
		ifTrue: 
			[answer := DataAnimation new.
			self animationData: answer].
	answer nframe: nseries.
	^answer
]

{ #category : #accessing }
Assembly >> animationData: animationData [ 
	self removeActionsForEvent: #getAnimationData.
	animationData notNil ifTrue: [self
			when: #getAnimationData
			ask: animationData
			perform: #yourself]
]

{ #category : #accessing }
Assembly >> asTreeNode [
	^(super asTreeNode)
		addCollection: cAnyPart name: 'Parts';
		addCollection: cConstraintSet name: 'Constraints';
		addCollection: cForceTorque name: 'ForceTorques';
		addCollection: cField name: 'Fields';
		addCollection: cVariable name: 'Variables';
		yourself
]

{ #category : #calc }
Assembly >> cItemWithBoundingBox [
	^(OrderedCollection new: cAnyPart size)
		addAll: cAnyPart;
		yourself
]

{ #category : #accessing }
Assembly >> canUpdateForFrame: integer [ 
	(super canUpdateForFrame: integer) ifFalse: [^false].
	cAnyPart 
		do: [:aAnyPart | (aAnyPart canUpdateForFrame: integer) ifFalse: [^false]].
	cConstraintSet 
		do: [:aConstraintSet | (aConstraintSet canUpdateForFrame: integer) ifFalse: [^false]].
	cForceTorque 
		do: [:aForceTorque | (aForceTorque canUpdateForFrame: integer) ifFalse: [^false]].
	^true
]

{ #category : #accessing }
Assembly >> findMarkerNamed: nameComponents [ 
	| cShortenedNameComponent answer |
	self name = (nameComponents at: 1) ifFalse: [^nil].
	cShortenedNameComponent := nameComponents copyFrom: 2
				to: nameComponents size.
	cAnyPart do: 
			[:aAnyPart | 
			(answer := aAnyPart findMarkerNamed: cShortenedNameComponent) 
				ifNotNil: [^answer]].
	^answer
]

{ #category : #accessing }
Assembly >> findMarkerNamedOld: nameComponents [ 
	| cShortenedNameComponent answer |
	self name = (nameComponents at: 1) ifFalse: [^nil].
	cShortenedNameComponent := nameComponents copyFrom: 2
				to: nameComponents size.
	cAnyPart do: 
			[:aAnyPart | 
			(answer := aAnyPart findMarkerNamedOld: cShortenedNameComponent) 
				ifNotNil: [^answer]].
	^answer
]

{ #category : #accessing }
Assembly >> forceTorqueList [
	^cForceTorque asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
Assembly >> geoTime [
	| answer |
	answer := self triggerEvent: #getTime.
	^answer
		ifNil: 
			[answer := GEOTime new.
			self geoTime: answer.
			answer.].
]

{ #category : #accessing }
Assembly >> geoTime: geoTime [ 
	self removeActionsForEvent: #getTime.
	^geoTime ifNotNil: 
			[geoTime aSup: self.
			self 
				when: #getTime
				ask: geoTime
				perform: #yourself.
			geoTime]
]

{ #category : #accessing }
Assembly >> gravity [
	| answer |
	answer := self triggerEvent: #getGravity.
	answer == nil
		ifTrue: 
			[answer := Gravity new
						gX: 0.0d
						gY: 0.0d
						gZ: 0.0d.
			self gravity: answer].
	^answer
]

{ #category : #accessing }
Assembly >> gravity: gravity [ 
	self removeActionsForEvent: #getGravity.
	gravity notNil 
		ifTrue: 
			[gravity removeSup.
			gravity aSup: self.
			self 
				when: #getGravity
				ask: gravity
				perform: #yourself]
]

{ #category : #'initialize-release' }
Assembly >> initialize [

	super initialize.
	cAnyPart := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cConstraintSet := StCAD_Misc_OrderedSet new.
	cForceTorque := StCAD_Misc_OrderedSet new.
	cField := StCAD_Misc_OrderedSet new.
	cVariable := StCAD_Misc_OrderedSet new
]

{ #category : #testing }
Assembly >> isAssembly [
	^true
]

{ #category : #accessing }
Assembly >> jointList [
	^(cConstraintSet select: [:set | set isJoint]) 
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
Assembly >> motionList [
	^(cConstraintSet select: [:set | set isMotion]) 
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
Assembly >> partList [
	^cAnyPart asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
Assembly >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeAssembly: self]
]

{ #category : #displaying }
Assembly >> renderOn: aRenderingContext [ 
	aRenderingContext 
		pushName: self name
		transformation: aRefFrame aMFf
		while: [cAnyPart do: [:aAnyPart | aAnyPart renderOn: aRenderingContext]]
]

{ #category : #accessing }
Assembly >> timeSeries [
	^self triggerEvent: #getTimeSeries
]

{ #category : #accessing }
Assembly >> timeSeries: timeSeries [ 
	self removeActionsForEvent: #getTimeSeries.
	timeSeries notNil ifTrue: [self
			when: #getTimeSeries
			ask: timeSeries
			perform: #yourself]
]

{ #category : #displaying }
Assembly >> updateForFrame: integer [ 
	super updateForFrame: integer.
	cAnyPart do: [:aAnyPart | aAnyPart updateForFrame: integer].
	cConstraintSet 
		do: [:aConstraintSet | aConstraintSet updateForFrame: integer].
	cForceTorque do: [:aForceTorque | aForceTorque updateForFrame: integer]
]
