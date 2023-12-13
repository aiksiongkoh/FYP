Class {
	#name : #MbDConstantGravity,
	#superclass : #MbDItem,
	#instVars : [
		'gXYZ'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
MbDConstantGravity class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accIC }
MbDConstantGravity >> fillAccICIterError: col [ 
	TheMbDSystem parts do: [:part | col at: part iqX plusFullColumn: (gXYZ times: part m)]
]

{ #category : #dynamic }
MbDConstantGravity >> fillDynError: col [ 
	TheMbDSystem parts do: [:part | col
			at: part iqX
			plusFullColumn: gXYZ
			times: part m]
]

{ #category : #static }
MbDConstantGravity >> fillStaticError: col [ 
	self fillDynError: col
]

{ #category : #'initialize-release' }
MbDConstantGravity >> gX: gX gY: gY gZ: gZ [ 
	""

	gXYZ := FullColumn new: 3.
	gXYZ at: 1 put: gX.
	gXYZ at: 2 put: gY.
	gXYZ at: 3 put: gZ
]

{ #category : #'initialize-release' }
MbDConstantGravity >> gXYZ [
	^gXYZ
]

{ #category : #'initialize-release' }
MbDConstantGravity >> gXYZ: col [ 
	gXYZ := col
]

{ #category : #dynamic }
MbDConstantGravity >> postDynCorrectorIteration [
	"Do nothing."
]

{ #category : #dynamic }
MbDConstantGravity >> postDynOutput [
	"Do nothing."
]

{ #category : #dynamic }
MbDConstantGravity >> postDynPredictor [
	"Do nothing."
]

{ #category : #'input-output' }
MbDConstantGravity >> postInput [
	"Do nothing."
]

{ #category : #static }
MbDConstantGravity >> postStaticIteration [
	"Do nothing."
]

{ #category : #accIC }
MbDConstantGravity >> preAccIC [
	"Do nothing."
]

{ #category : #dynamic }
MbDConstantGravity >> preDynOutput [
	"Do nothing."
]

{ #category : #static }
MbDConstantGravity >> preStatic [
	"Do nothing."
]

{ #category : #dynamic }
MbDConstantGravity >> simUpdateAll [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDConstantGravity >> submitToSystem [
	TheMbDSystem forcesTorques add: self
]
