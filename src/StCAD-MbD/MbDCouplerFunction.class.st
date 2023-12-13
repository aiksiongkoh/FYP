Class {
	#name : #MbDCouplerFunction,
	#superclass : #MbDCouplerConstraint,
	#instVars : [
		'n',
		'kineIJs',
		'func',
		'pfuncpkineIJs',
		'ppfuncpkineIJpkineIJs',
		'funcBlk',
		'pfuncpkineIJBlks',
		'ppfuncpkineIJpkineIJBlks'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDCouplerFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDCouplerFunction >> calcPostDynCorrectorIteration [
	| ppfuncpkineIJpkineIJsi ppfuncpkineIJpkineIJBlksi |
	1 to: n do: [:i | 
			pfuncpkineIJs at: i put: (pfuncpkineIJBlks at: i) value.
			ppfuncpkineIJpkineIJsi := ppfuncpkineIJpkineIJs at: i.
			ppfuncpkineIJpkineIJBlksi := ppfuncpkineIJpkineIJBlks at: i.
			i to: n do: [:j | ppfuncpkineIJpkineIJsi at: j put: (ppfuncpkineIJpkineIJBlksi at: j) value]]
]

{ #category : #accessing }
MbDCouplerFunction >> func [
	^funcBlk value
]

{ #category : #accessing }
MbDCouplerFunction >> funcBlk: function [ 
	funcBlk := function
]

{ #category : #'initialize-release' }
MbDCouplerFunction >> initializeGlobally [
	| kineIJi ppfuncpkineIJpkineIJBlksi kineIJj pfuncpkineIJBlksi |
	n := kineIJs size.
	1 to: n do: [:i | 
			kineIJi := (kineIJs at: i) initializeGlobally.
			pfuncpkineIJBlksi := (funcBlk differentiateWRT: kineIJi) simplified.
			pfuncpkineIJBlks at: i put: pfuncpkineIJBlksi.
			ppfuncpkineIJpkineIJBlksi := ppfuncpkineIJpkineIJBlks at: i.
			i to: n do: [:j | 
					kineIJj := kineIJs at: j.
					ppfuncpkineIJpkineIJBlksi at: j put: (pfuncpkineIJBlksi differentiateWRT: kineIJj) simplified]]
]

{ #category : #'initialize-release' }
MbDCouplerFunction >> initializeLocally [
	kineIJs := OrderedCollection new.
	funcBlk fillKineIJs: kineIJs.
	kineIJs := kineIJs asArray.
	kineIJs do: [:kineIJ | kineIJ initializeLocally].
	n := kineIJs size.
	pfuncpkineIJs := FullColumn new: n.
	ppfuncpkineIJpkineIJs := FullMatrix new: n by: n.
	pfuncpkineIJBlks := FullColumn new: n.
	ppfuncpkineIJpkineIJBlks := FullMatrix new: n by: n
]

{ #category : #accessing }
MbDCouplerFunction >> kineIJs [
	^kineIJs
]

{ #category : #accessing }
MbDCouplerFunction >> n [
	^n
]

{ #category : #accessing }
MbDCouplerFunction >> pfuncpkineIJs [
	^pfuncpkineIJs
]

{ #category : #dynamic }
MbDCouplerFunction >> postDynCorrectorIteration [
	kineIJs do: [:kineIJi | kineIJi postDynCorrectorIteration].
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDCouplerFunction >> postDynOutput [
	kineIJs do: [:kineIJi | kineIJi postDynOutput].
	super postDynOutput
]

{ #category : #dynamic }
MbDCouplerFunction >> postDynPredictor [
	kineIJs do: [:kineIJi | kineIJi postDynPredictor].
	super postDynPredictor
]

{ #category : #'input-output' }
MbDCouplerFunction >> postInput [
	kineIJs do: [:kineIJi | kineIJi postInput].
	super postInput
]

{ #category : #posIC }
MbDCouplerFunction >> postPosICIteration [
	kineIJs do: [:kineIJi | kineIJi postPosICIteration].
	super postPosICIteration
]

{ #category : #static }
MbDCouplerFunction >> postStaticIteration [
	kineIJs do: [:kineIJi | kineIJi postStaticIteration].
	super postStaticIteration
]

{ #category : #accessing }
MbDCouplerFunction >> ppfuncpkineIJpkineIJs [
	^ppfuncpkineIJpkineIJs
]

{ #category : #accIC }
MbDCouplerFunction >> preAccIC [
	kineIJs do: [:kineIJ | kineIJ preAccIC].
	super preAccIC
]

{ #category : #dynamic }
MbDCouplerFunction >> preDynOutput [
	kineIJs do: [:kineIJi | kineIJi preDynOutput].
	super preDynOutput
]

{ #category : #posIC }
MbDCouplerFunction >> prePosIC [
	kineIJs do: [:kineIJi | kineIJi prePosIC].
	super prePosIC
]

{ #category : #static }
MbDCouplerFunction >> preStatic [
	kineIJs do: [:kineIJi | kineIJi preStatic].
	super preStatic
]

{ #category : #velIC }
MbDCouplerFunction >> preVelIC [
	kineIJs do: [:kineIJi | kineIJi preVelIC].
	super preVelIC
]

{ #category : #dynamic }
MbDCouplerFunction >> simUpdateAll [
	kineIJs do: [:kineIJi | kineIJi simUpdateAll].
	super simUpdateAll
]

{ #category : #'initialize-release' }
MbDCouplerFunction >> useEquationNumbers [
	"Do nothing."
]
