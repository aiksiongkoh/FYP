Class {
	#name : #GEOPart,
	#superclass : #GEOPartLike,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOPart >> aColor [
	^(self triggerEvent: #getColor) ifNil: 
			[| answer |
			answer := ColorValue cyan copy.
			self aColor: answer.
			answer]
]

{ #category : #accessing }
GEOPart >> aColor: aColor [ 
	self removeActionsForEvent: #getColor.
	aColor notNil 
		ifTrue: 
			[self 
				when: #getColor
				ask: aColor
				perform: #yourself]
]

{ #category : #accessing }
GEOPart >> aMassMarker [
	^self triggerEvent: #getMassMarker
]

{ #category : #accessing }
GEOPart >> addMarkersIn: set [ 
	super addMarkersIn: set.
	set add: self massMarker
]

{ #category : #accessing }
GEOPart >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer children addFirst: (self treeNodesBlock value: featureOrder value: 'Features').
	self massMarker notNil ifTrue: [answer children addLast: self massMarker asTreeNode].
	^answer
]

{ #category : #accessing }
GEOPart >> assemblyList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOPart >> cFeature [
	^featureOrder
]

{ #category : #DYN }
GEOPart >> clearSolidModel [
	solidModel releaseFacesEdgesVertexs
]

{ #category : #DYN }
GEOPart >> createMbD [
"	solidModel momentsOfVolume isNil ifTrue: [solidModel calcMomentsOfVolume]."
	super createMbD
]

{ #category : #accessing }
GEOPart >> cut [
	container cutPart: self.
	super cut
]

{ #category : #accessing }
GEOPart >> density [
	^self massMarker density
]

{ #category : #accessing }
GEOPart >> density: double [ 
	^self massMarker density: double
]

{ #category : #accessing }
GEOPart >> forceList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOPart >> forceTorqueList: collection [ 
	"Do nothing."
]

{ #category : #testing }
GEOPart >> hasCentroid [
	^solidModel hasCentroid
]

{ #category : #accessing }
GEOPart >> isPart [
	^true
]

{ #category : #accessing }
GEOPart >> jointList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOPart >> kineIJList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOPart >> magnifySelf: aDouble [ 
	self inputData magnifySelf: aDouble.
	self aRefFrame magnifySelf: aDouble.
	self aMassMarker magnifySelf: aDouble.
	self cMarker do: [:aMarker | aMarker magnifySelf: aDouble].
	self cFeature magnifySelf: aDouble.
	self solidModel magnifySelf: aDouble.
	self aNMT ifNotNil: [:aNMT | aNMT magnifySelf: aDouble]
]

{ #category : #accessing }
GEOPart >> massMarker [
	^self triggerEvent: #getMassMarker
]

{ #category : #accessing }
GEOPart >> massMarker: massMarker [ 
	self removeActionsForEvent: #getMassMarker.
	massMarker notNil ifTrue: [self
			when: #getMassMarker
			ask: massMarker
			perform: #yourself]
]

{ #category : #accessing }
GEOPart >> motionList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOPart >> part [
	^self
]

{ #category : #accessing }
GEOPart >> partList: collection [ 
	collection add: self
]

{ #category : #rendering }
GEOPart >> removeDisplayList [
	| block |
	block := [:item | item removeDisplayList].
	self solidModel ifNotNil: block.
	self aDXFBLOCK ifNotNil: block.
	self aNMT ifNotNil: block
]

{ #category : #rendering }
GEOPart >> renderOn1: aRenderingContext [ 
	aRenderingContext productTransformation: refFrame aMFf
		while: 
			[markers do: [:marker | marker renderOn: aRenderingContext].
			self massMarker renderOn: aRenderingContext.
			featureOrder renderOn: aRenderingContext.
			solidModel renderOn: aRenderingContext.
			self aDXFBLOCK 
				ifNotNil: [:aDXFBLOCK | aDXFBLOCK renderOn: aRenderingContext].
			self aNMT ifNotNil: [:aNMT | aNMT renderOn: aRenderingContext]]
]

{ #category : #rendering }
GEOPart >> renderOn: aRenderingContext [ 
	aRenderingContext pushTransformation: refFrame aMFf
		while: 
			[| block |
			block := [:a | a renderOn: aRenderingContext].
			markers do: block.
			self massMarker ifNotNil: block.
			self featureOrder ifNotNil: block.
			self solidModel ifNotNil: block.
			self aDXFBLOCK ifNotNil: block.
			self aNMT ifNotNil: block]
]

{ #category : #printing }
GEOPart >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	self refFrame storeVelocityOn: aStream level: level + 1.
	aStream storeLevel: level + 1 title: 'FeatureOrder'.
	self featureOrder do: [:feature | feature storeOn: aStream level: level + 2].
	self massMarker storeOn: aStream level: level + 1.
	aStream storeLevel: level + 1 title: 'RefPoints'.
	self refPoints do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'RefCurves'.
	self refCurves do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'RefSurfaces'.
	self refSurfaces do: [:item | item storeOn: aStream level: level + 2]
]

{ #category : #printing }
GEOPart >> storePOVOn: aStream level: level [ 
	| fullNamePOV cColor index |
	fullNamePOV := self fullNamePOV.
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level + 1 title: 'object {'.
	self featureOrder 
		storePOVOn: aStream
		level: level + 1
		title: '<t>// Features' expandMacros.
	cColor := (OrderedCollection new)
				add: 'rgb <1.0, 0.0, 0.0>';
				add: 'rgb <0.0, 1.0, 0.0>';
				add: 'rgb <0.0, 0.0, 1.0>';
				add: 'rgb <1.0, 1.0, 0.0>';
				add: 'rgb <0.0, 1.0, 1.0>';
				add: 'rgb <1.0, 0.0, 1.0>';
				add: 'rgb <1.0, 1.0, 1.0>';
				yourself.
	index := fullNamePOV inject: 1 into: [:num :char | num + char asInteger].
	index := (index rem: cColor size) + 1.
	aStream storePOVLevel: level + 2
		title: ('texture {pigment { color <1s> }}' 
				expandMacrosWith: (cColor at: index)).
	aStream storePOVLevel: level + 2
		title: ('rotate %<<1s>_RotX[clock],<1s>_RotY[clock],<1s>_RotZ[clock]>' 
				expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level + 2
		title: ('translate %<<1s>_X[clock],<1s>_Y[clock],<1s>_Z[clock]>' 
				expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level + 1 title: '}'.
	self massMarker storePOVOn: aStream level: level + 1.
	self refPoints 
		storePOVOn: aStream
		level: level + 1
		title: '// RefPoints'.
	self refCurves 
		storePOVOn: aStream
		level: level + 1
		title: '// RefCurves'.
	self refSurfaces 
		storePOVOn: aStream
		level: level + 1
		title: '// RefSurfaces'
]

{ #category : #printing }
GEOPart >> storePOVTimeSeriesOn: aStream [ 
	super storePOVTimeSeriesOn: aStream.
	self massMarker storePOVTimeSeriesOn: aStream
]

{ #category : #printing }
GEOPart >> storePOVdatCurrentOn: aStream [ 
	super storePOVdatCurrentOn: aStream.
	self massMarker storePOVdatCurrentOn: aStream
]

{ #category : #accessing }
GEOPart >> torqueList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOPart >> translateBy: shiftXYZ [ 
	refFrame translateBy: shiftXYZ.
	self dataSeries do: [:aData | aData translateBy: shiftXYZ]
]

{ #category : #accessing }
GEOPart >> uncut [
	container addAnyPart: self.
	super uncut
]

{ #category : #DYN }
GEOPart >> zeroVelocities [
	| zero |
	zero := (FullColumn zero: 3).
	refFrame quietlyvOfO: zero omeOfO: zero
]
