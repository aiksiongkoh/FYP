Class {
	#name : #GEOPartLike,
	#superclass : #GEOAnyPart,
	#instVars : [
		'featureOrder',
		'solidModel'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOPartLike >> aAPp [
	^self massMarker aAPp
]

{ #category : #accessing }
GEOPartLike >> aAPpv [
	^solidModel momentsOfVolume aAPp
]

{ #category : #accessing }
GEOPartLike >> aBoundingBox [
	| aBoundingBox block |
	aBoundingBox := BoundingBox new.
	block := [:item | aBoundingBox expandToBound: item aBoundingBox].
	self solidModel ifNotNil: block.
	self aDXFBLOCK ifNotNil: block.
	self aNMT ifNotNil: block.
	^aBoundingBox
]

{ #category : #accessing }
GEOPartLike >> addFeature: aFeature [ 
	featureOrder add: aFeature
]

{ #category : #accessing }
GEOPartLike >> addFeatureOrder: array [ 
	array do: [:feature | self addFeature: feature]
]

{ #category : #accessing }
GEOPartLike >> boundingBox [
	^solidModel boundingBox
]

{ #category : #modeling }
GEOPartLike >> buildSolidModel [
	self preBuildSolidModel.
	self privateBuildSolidModel.
	self postBuildSolidModel
]

{ #category : #accessing }
GEOPartLike >> center [
	| sumDiagonal sumMoment block rPcenterP |
	sumDiagonal := 0.0d.
	sumMoment := FullColumn zero: 3.
	block := 
			[:object | 
			| aBBox diagonal |
			aBBox := object aBoundingBox.
			aBBox isDefined 
				ifTrue: 
					[diagonal := aBBox extent length.
					sumDiagonal := sumDiagonal + diagonal.
					sumMoment equalSelfPlus: aBBox center times: diagonal]].
	solidModel ifNotNil: block.
	self aDXFBLOCK ifNotNil: block.
	self aNMT ifNotNil: block.
	rPcenterP := sumDiagonal isZero 
				ifTrue: [sumMoment]
				ifFalse: [sumMoment times: sumDiagonal reciprocal].
	^rPcenterP
]

{ #category : #accessing }
GEOPartLike >> featureOrder [
	^featureOrder
]

{ #category : #accessing }
GEOPartLike >> findMarkerNamed: nameComponents [ 
	| answer massMarker |
	answer := super findMarkerNamed: nameComponents.
	(answer isNil and: [(massMarker := self massMarker) notNil and: [massMarker name = (nameComponents at: 2)]])
		ifTrue: [answer := massMarker].
	^answer
]

{ #category : #testing }
GEOPartLike >> hasVolume [
	^solidModel notNil and: [solidModel momentsOfVolume notNil and: [solidModel momentsOfVolume volume notNil]]
]

{ #category : #'initialize-release' }
GEOPartLike >> initialize [
	super initialize.
	featureOrder := GEOFeatureOrder for: self.
	solidModel := GEOSolidModel for: self.
]

{ #category : #testing }
GEOPartLike >> isCMtheCentriod [
	| block |
	^solidModel hasCentroid 
		ifTrue: 
			[block := 
					[:num :den | 
					den > MachineAccuracy OfDoubleTimesFour 
						ifTrue: [num / den > 1.0d-12 ifTrue: [^false]]
						ifFalse: [num > MachineAccuracy OfDoubleTimesFour ifTrue: [^false]]].
			block value: (self mass - (self density * self volume)) abs
				value: self mass.
			block value: (self mJpp - (self density * self vJpp)) sumOfSquares
				value: self mJpp sumOfSquares.
			block value: (self rPcmP - self rPcP) sumOfSquares
				value: self rPcmP sumOfSquares.
			block value: (self aAPp - self aAPpv) sumOfSquares
				value: self aAPp sumOfSquares.
			true]
		ifFalse: [false]
]

{ #category : #accessing }
GEOPartLike >> mJpp [
	^self massMarker mJpp
]

{ #category : #accessing }
GEOPartLike >> mass [
	^self massMarker mass
]

{ #category : #accessing }
GEOPartLike >> omeOpO [
	| omeOpO |
	omeOpO := refFrame omeOfO.
	^omeOpO notNil
		ifTrue: [omeOpO]
		ifFalse: [(FullColumn zero: 3)]
]

{ #category : #modeling }
GEOPartLike >> postBuildSolidModel [
	self interface createUpdateSelectGOfor: solidModel.
	solidModel removeDisplayList.
	self triggerEvent: #postBuildSolidModel.
	container postBuildSolidModelFrom: self
]

{ #category : #copying }
GEOPartLike >> postCopy1 [
	| originalFeatureOrder |
	super postCopy.
	originalFeatureOrder := featureOrder.
	featureOrder := GEOFeatureOrder for: self.
	originalFeatureOrder do: [:feature | self addFeature: feature copy.].
	solidModel := GEOSolidModel for: self.
	self privateBuildSolidModel.
]

{ #category : #modeling }
GEOPartLike >> preBuildSolidModel [
	self triggerEvent: #preBuildSolidModel.
	self clearSolidModel.
	container preBuildSolidModelFrom: self
]

{ #category : #copying }
GEOPartLike >> preSave [
	| block |
	super preSave.
	block := [:item | item preSave].
	self featureOrder ifNotNil: block.
	self solidModel ifNotNil: block.
	self aDXFBLOCK ifNotNil: block.
	self aNMT ifNotNil: block.
	self massMarker ifNotNil: block.
	self removeActionsForEvent: #preBuildSolidModel.
	self removeActionsForEvent: #postBuildSolidModel
]

{ #category : #modeling }
GEOPartLike >> privateBuildSolidModel [
	| massMarker |
	solidModel releaseFacesEdgesVertexs.
	featureOrder buildIn: solidModel.
	solidModel calcBoundingBox.
	solidModel calcMomentsOfVolume.
	massMarker := self massMarker.
	massMarker isNil
		ifTrue: 
			[massMarker := GEOMassMarker new.
			massMarker name: 'MassMarker'.
			massMarker container: self.
			self massMarker: massMarker.
			massMarker refFrame
				refFrame: refFrame
				rFfF: self rPcP copy
				aAFf: self aAPpv copy.
			massMarker guideFrame: refFrame.
			self interface createUpdateSelectGOfor: massMarker.].
]

{ #category : #accessing }
GEOPartLike >> qEp [
	^self massMarker qEp
]

{ #category : #accessing }
GEOPartLike >> rOcenterO [
	| sumDiagonal sumMoment block rPcenterP |
	sumDiagonal := 0.0d.
	sumMoment := FullColumn zero: 3.
	block := 
			[:object | 
			| aBBox diagonal |
			aBBox := object aBoundingBox.
			aBBox isDefined 
				ifTrue: 
					[diagonal := aBBox extent length.
					sumDiagonal := sumDiagonal + diagonal.
					sumMoment equalSelfPlus: aBBox center times: diagonal]].
	self solidModel ifNotNil: block.
	self aDXFBLOCK ifNotNil: block.
	self aNMT ifNotNil: block.
	rPcenterP := sumDiagonal > 0 
				ifTrue: [sumMoment times: sumDiagonal reciprocal]
				ifFalse: [0 yd: 0 zd: 0].
	^refFrame rOpOfromrfpf: rPcenterP
]

{ #category : #accessing }
GEOPartLike >> rOcmO [
	^self massMarker rOcmO
]

{ #category : #accessing }
GEOPartLike >> rPcP [
	^solidModel momentsOfVolume rPcP
]

{ #category : #accessing }
GEOPartLike >> rPcmP [
	^self massMarker rPcmP
]

{ #category : #'initialize-release' }
GEOPartLike >> release [
	| block |
	block := [:item | item release].
	self featureOrder ifNotNil: block.
	self solidModel ifNotNil: block.
	self aDXFBLOCK ifNotNil: block.
	self aNMT ifNotNil: block.
	super release
]

{ #category : #'initialize-release' }
GEOPartLike >> removeGEO: aGEO [ 
	featureOrder removeGEO: aGEO.
	solidModel removeGEO: aGEO
]

{ #category : #accessing }
GEOPartLike >> sketchList [
	^featureOrder sketchList
]

{ #category : #accessing }
GEOPartLike >> sketchList: collection [ 
	featureOrder sketchList: collection
]

{ #category : #accessing }
GEOPartLike >> solidModel [
	^solidModel
]

{ #category : #accessing }
GEOPartLike >> solidModel: solid [ 
	solid container: self.
	solidModel := solid
]

{ #category : #accessing }
GEOPartLike >> vJpp [
	^solidModel momentsOfVolume vJpp
]

{ #category : #accessing }
GEOPartLike >> vOcmO [
	| vOPO omeOPO rPcmO |
	vOPO := refFrame vOfO.
	omeOPO := refFrame omeOfO.
	vOPO isNil ifTrue: [vOPO := (FullColumn zero: 3)].
	omeOPO isNil ifTrue: [omeOPO := (FullColumn zero: 3)].
	rPcmO := self massMarker rOcmO - refFrame rOfO.
	^vOPO + (omeOPO cross: rPcmO)
]

{ #category : #accessing }
GEOPartLike >> volume [
	^solidModel momentsOfVolume volume
]
