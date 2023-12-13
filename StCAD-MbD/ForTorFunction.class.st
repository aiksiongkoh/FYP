Class {
	#name : #ForTorFunction,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'kineIJs',
		'kinedotIJs',
		'jointActions',
		'forTorFunc',
		'pFTpkineIJFuncs',
		'pFTpkinedotIJFuncs',
		'pFTpJtActFuncs'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
ForTorFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
ForTorFunction >> calcPostDynCorrectorIteration [
	"Do nothing."
]

{ #category : #accessing }
ForTorFunction >> forTor [
	^forTorFunc value
]

{ #category : #accessing }
ForTorFunction >> forTorFunc [
	^forTorFunc
]

{ #category : #accessing }
ForTorFunction >> forTorFunc: function [ 
	forTorFunc := function
]

{ #category : #accessing }
ForTorFunction >> formula [
	^forTorFunc
]

{ #category : #accessing }
ForTorFunction >> formula: function [ 
	forTorFunc := function
]

{ #category : #'initialize-release' }
ForTorFunction >> initialize [
	kineIJs := OrderedCollection new.
	kinedotIJs := OrderedCollection new.
	jointActions := OrderedCollection new
]

{ #category : #'initialize-release' }
ForTorFunction >> initializeGlobally [
	kineIJs do: [:kineIJ | kineIJ initializeGlobally].
	kinedotIJs do: [:kinedotIJ | kinedotIJ initializeGlobally].
	jointActions do: [:jointAction | jointAction initializeGlobally].
	pFTpkineIJFuncs := kineIJs collect: [:kineIJ | (forTorFunc differentiateWRT: kineIJ) simplified].
	pFTpkinedotIJFuncs := kinedotIJs collect: [:kinedotIJ | (forTorFunc differentiateWRT: kinedotIJ) simplified].
	pFTpJtActFuncs := jointActions collect: [:jointAction | (forTorFunc differentiateWRT: jointAction) simplified]
]

{ #category : #'initialize-release' }
ForTorFunction >> initializeLocally [
	forTorFunc fillKineIJs: kineIJs.
	forTorFunc fillKinedotIJs: kinedotIJs.
	forTorFunc fillJointForces: jointActions.
	forTorFunc fillJointTorques: jointActions.
	kineIJs do: [:kineIJ | kineIJ initializeLocally].
	kinedotIJs do: [:kinedotIJ | kinedotIJ initializeLocally].
	jointActions do: [:jointAction | jointAction initializeLocally]
]

{ #category : #accessing }
ForTorFunction >> jointActions [
	^jointActions
]

{ #category : #accessing }
ForTorFunction >> kineIJs [
	^kineIJs
]

{ #category : #accessing }
ForTorFunction >> kinedotIJs [
	^kinedotIJs
]

{ #category : #accessing }
ForTorFunction >> pFTpJtActs [
	^pFTpJtActFuncs collect: [:pFTpJtActFunc | pFTpJtActFunc value]
]

{ #category : #accessing }
ForTorFunction >> pFTpkineIJs [
	^pFTpkineIJFuncs collect: [:pFTpkineIJFunc | pFTpkineIJFunc value]
]

{ #category : #accessing }
ForTorFunction >> pFTpkinedotIJs [
	^pFTpkinedotIJFuncs collect: [:pFTpkinedotIJFunc | pFTpkinedotIJFunc value]
]

{ #category : #accIC }
ForTorFunction >> postAccICIteration [
	kineIJs do: [:kineIJ | kineIJ postAccICIteration].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postAccICIteration].
	jointActions do: [:jointAction | jointAction postAccICIteration].
	super postAccICIteration
]

{ #category : #collision }
ForTorFunction >> postCollisionCorrectorIteration [
	kineIJs do: [:kineIJ | kineIJ postCollisionCorrectorIteration].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postCollisionCorrectorIteration].
	jointActions do: [:jointAction | jointAction postCollisionCorrectorIteration].
	super postCollisionCorrectorIteration
]

{ #category : #collision }
ForTorFunction >> postCollisionPredictor [
	kineIJs do: [:kineIJ | kineIJ postCollisionPredictor].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postCollisionPredictor].
	jointActions do: [:jointAction | jointAction postCollisionPredictor].
	super postCollisionPredictor
]

{ #category : #dynamic }
ForTorFunction >> postDynCorrectorIteration [
	kineIJs do: [:kineIJ | kineIJ postDynCorrectorIteration].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postDynCorrectorIteration].
	jointActions do: [:jointAction | jointAction postDynCorrectorIteration].
	super postDynCorrectorIteration
]

{ #category : #dynamic }
ForTorFunction >> postDynOutput [
	kineIJs do: [:kineIJ | kineIJ postDynOutput].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postDynOutput].
	jointActions do: [:jointAction | jointAction postDynOutput].
	super postDynOutput
]

{ #category : #dynamic }
ForTorFunction >> postDynPredictor [
	kineIJs do: [:kineIJ | kineIJ postDynPredictor].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postDynPredictor].
	jointActions do: [:jointAction | jointAction postDynPredictor].
	super postDynPredictor
]

{ #category : #'input-output' }
ForTorFunction >> postInput [
	kineIJs do: [:kineIJ | kineIJ postInput].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postInput].
	jointActions do: [:jointAction | jointAction postInput].
	super postInput
]

{ #category : #static }
ForTorFunction >> postStaticIteration [
	kineIJs do: [:kineIJ | kineIJ postStaticIteration].
	kinedotIJs do: [:kinedotIJ | kinedotIJ postStaticIteration].
	jointActions do: [:jointAction | jointAction postStaticIteration].
	super postStaticIteration
]

{ #category : #accIC }
ForTorFunction >> preAccIC [
	kineIJs do: [:kineIJ | kineIJ preAccIC].
	kinedotIJs do: [:kinedotIJ | kinedotIJ preAccIC].
	jointActions do: [:jointAction | jointAction preAccIC].
	super preAccIC
]

{ #category : #dynamic }
ForTorFunction >> preDynOutput [
	kineIJs do: [:kineIJ | kineIJ preDynOutput].
	kinedotIJs do: [:kinedotIJ | kinedotIJ preDynOutput].
	jointActions do: [:jointAction | jointAction preDynOutput].
	super preDynOutput
]

{ #category : #static }
ForTorFunction >> preStatic [
	kineIJs do: [:kineIJ | kineIJ preStatic].
	kinedotIJs do: [:kinedotIJ | kinedotIJ preStatic].
	jointActions do: [:jointAction | jointAction preStatic].
	super preStatic
]

{ #category : #dynamic }
ForTorFunction >> simUpdateAll [
	kineIJs do: [:kineIJ | kineIJ simUpdateAll].
	kinedotIJs do: [:kinedotIJ | kinedotIJ simUpdateAll].
	jointActions do: [:jointAction | jointAction simUpdateAll].
	super simUpdateAll
]

{ #category : #'initialize-release' }
ForTorFunction >> useEquationNumbers [
	"Do nothing."
]
