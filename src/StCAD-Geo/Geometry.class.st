Class {
	#name : #Geometry,
	#superclass : #SpatialItem,
	#instVars : [
		'isSpatial'
	],
	#classVars : [
		'Geo'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Geometry class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Geometry >> aModel [
	^aSup aModel
]

{ #category : #accessing }
Geometry >> aNurbs [
	^(self triggerEvent: #getNurbs) ifNil: 
			[| answer |
			answer := self createNurbs.
			self aNurbs: answer.
			answer]
]

{ #category : #accessing }
Geometry >> aNurbs: aNurbs [ 
	self removeActionsForEvent: #getNurbs.
	aNurbs ifNotNil: 
			[self 
				when: #getNurbs
				ask: aNurbs
				perform: #yourself]
]

{ #category : #accessing }
Geometry >> aSketch [
	^aSup aSketch
]

{ #category : #accessing }
Geometry >> aSketchRefFrame [
	^aSup aSketch aRefFrame
]

{ #category : #accessing }
Geometry >> create_glNurbs [

	| answer aModelFrame aAMf rMfM |
	answer := self rfpfNurbs.
	answer isSpatial: isSpatial.
	(isSpatial and: [aSup notNil])
		ifTrue: 
			[aModelFrame := self aModel aRefFrame.
			aAMf := aRefFrame aAFfforF: aModelFrame.
			rMfM := aRefFrame rFpFfromrfpf: (FullColumn zero: 3) forF: aModelFrame]
		ifFalse: 
			[aAMf := aRefFrame aAFf.
			rMfM := aRefFrame rFfF].
	answer transformSelfBy_rFfF: rMfM aAFf: aAMf.
	answer conditionOpenGL.
	^answer
]

{ #category : #accessing }
Geometry >> glNurbs [
	^(self triggerEvent: #glNurbs) ifNil: 
			[| answer |
			answer := self create_glNurbs.
			self glNurbs: answer.
			answer]
]

{ #category : #accessing }
Geometry >> glNurbs: glNurbs [ 
	self removeActionsForEvent: #glNurbs.
	glNurbs ifNotNil: 
			[self 
				when: #glNurbs
				ask: glNurbs
				perform: #yourself]
]

{ #category : #accessing }
Geometry >> glTrimNurbs [
	| answer aModelFrame aAMf rMfM |
	answer := self rfpfNurbs.
	answer isSpatial: isSpatial.
	isSpatial 
		ifTrue: 
			[aModelFrame := self aModel aRefFrame.
			aAMf := aRefFrame aAFfforF: aModelFrame.
			rMfM := aRefFrame rFpFfromrfpf: (FullColumn zero: 3) forF: aModelFrame]
		ifFalse: 
			[aAMf := aRefFrame aAFf.
			rMfM := aRefFrame rFfF].
	answer transformSelfBy_rFfF: rMfM aAFf: aAMf.
	answer conditionOpenGL.
	^answer
]

{ #category : #'initialize-release' }
Geometry >> initialize [
	super initialize.
	isSpatial := true
]

{ #category : #accessing }
Geometry >> isSpatial [
	^isSpatial
]

{ #category : #accessing }
Geometry >> isSpatial: anObject [
	isSpatial := anObject
]

{ #category : #accessing }
Geometry >> removeSup [
	aSup ifNotNil: [:a | a removeGeometry: self]
]

{ #category : #accessing }
Geometry >> rfpfNurbs [

	self subclassResponsibility
]

{ #category : #viewing }
Geometry >> showWithAxes [
	"(1 , 1 , 1 cylinder: 1 height: 2) showWithAxes."

	^self asJunOpenGL3dObject showWithAxes
]
