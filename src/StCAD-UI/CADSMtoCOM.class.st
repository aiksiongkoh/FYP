Class {
	#name : #CADSMtoCOM,
	#superclass : #Item,
	#instVars : [
		'aAssembly',
		'aWorldFrame',
		'aTextCollector',
		'aMbDSystem',
		'mbdUnits',
		'mbdProcess',
		'aCADSMAlibre',
		'pauseAfterOutput'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
CADSMtoCOM class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADSMtoCOM >> aAssembly [
	^aAssembly
]

{ #category : #accessing }
CADSMtoCOM >> aAssembly: aaAssembly [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aaAssembly removeSup.
	self addRefFrame: aaAssembly aRefFrame.
	aAssembly := aaAssembly.
	aaAssembly aSup: self.
	^aaAssembly
]

{ #category : #accessing }
CADSMtoCOM >> aCADSMAlibre [
	^aCADSMAlibre
]

{ #category : #accessing }
CADSMtoCOM >> aCADSMAlibre: anObject [
	aCADSMAlibre := anObject
]

{ #category : #accessing }
CADSMtoCOM >> aMbDSystem [
	^aMbDSystem
]

{ #category : #accessing }
CADSMtoCOM >> aMbDSystem: aaMbDSystem [ 
	aMbDSystem := aaMbDSystem.
	aaMbDSystem ifNotNil: [aaMbDSystem admSystem: self]
]

{ #category : #accessing }
CADSMtoCOM >> aRefFrame [
	^aWorldFrame
]

{ #category : #accessing }
CADSMtoCOM >> aRefFrame: aaRefFrame [ 
	aWorldFrame := aaRefFrame.
	aaRefFrame body: self
]

{ #category : #accessing }
CADSMtoCOM >> addRefFrame: argRefFrame [ 
	"Example usage:

	addSurface: aSurface 
		aSurface removeSup.
		super addRefFrame: aSurface aRefFrame.
		cSurface add: aSurface.
		aSurface aSup: self.
		^aSurface
	"

	self aRefFrame addSub: argRefFrame
]

{ #category : #DYN }
CADSMtoCOM >> canUpdateForFrame: integer [ 
	^aAssembly canUpdateForFrame: integer
]

{ #category : #accessing }
CADSMtoCOM >> connectorList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	aAssembly == nil ifFalse: [aAssembly connectorList: collection].
	^collection
]

{ #category : #accessing }
CADSMtoCOM >> fullpath [
	^OrderedCollection with: self
]

{ #category : #accessing }
CADSMtoCOM >> getString: string [ 
	^aTextCollector getString: string
]

{ #category : #'initialize-release' }
CADSMtoCOM >> initialize [
	super initialize.
	self aRefFrame: ((GEOWorldFrame2 new)
				refFrame: self;
				fixedAtRef;
				yourself).
	aTextCollector := TextCollector new.
	pauseAfterOutput := false.
]

{ #category : #accessing }
CADSMtoCOM >> interface [
	^self
]

{ #category : #accessing }
CADSMtoCOM >> isInterface [
	^true
]

{ #category : #DYN }
CADSMtoCOM >> isSimulating [
	^(mbdProcess isMemberOf: Process) and: [mbdProcess isTerminated not]
]

{ #category : #output }
CADSMtoCOM >> logString: aString [ 
	self toDebugTxtShowString: aString mbdMessage.
	aTextCollector logString: aString
]

{ #category : #output }
CADSMtoCOM >> logString: string withArgument: string1 [ 
	self toDebugTxtShowString: (string mbdMessage expandWithArgument: string1).
	aTextCollector logString: string withArgument: string1
]

{ #category : #output }
CADSMtoCOM >> logString: string withArguments: arrayOfStrings [ 
	self toDebugTxtShowString: (string mbdMessage 
				expandWithArguments: arrayOfStrings).
	aTextCollector logString: string withArguments: arrayOfStrings
]

{ #category : #accessing }
CADSMtoCOM >> mbdSystem [
	^aMbDSystem
]

{ #category : #accessing }
CADSMtoCOM >> mbdUnits [
	^mbdUnits
]

{ #category : #accessing }
CADSMtoCOM >> mbdUnits: anObject [
	mbdUnits := anObject
]

{ #category : #accessing }
CADSMtoCOM >> messages [
	| answer |
	answer := (IOAccessor 
				convertStringForPlatform: aTextCollector value string) asString.
	aTextCollector clear.
	^answer
]

{ #category : #accessing }
CADSMtoCOM >> nFrames [
	^aAssembly dataSeries size
]

{ #category : #output }
CADSMtoCOM >> outputASMFile: aFilename [

	| bos |
	bos := StCAD_Misc_BinaryObjectStorage onNew:
		       aFilename asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"

	[ 
	aAssembly cadObject release.
	aAssembly preSave.
	aAssembly container: nil.
	aAssembly refFrame refFrame removeDependentFrame: aAssembly refFrame.
	aAssembly refFrame refFrame: nil.
	bos nextPut: aAssembly ] valueNowOrOnUnwindDo: [ bos close ].
	self aAssembly: aAssembly
]

{ #category : #output }
CADSMtoCOM >> outputDebug1ASM [
	self outputASMFile: Filename findDefaultDirectory asString , '\debug1.asm'
]

{ #category : #output }
CADSMtoCOM >> outputDebug2ASM [
"	self outputASMFile: Filename findDefaultDirectory asString , '\debug2.asm'"
]

{ #category : #DYN }
CADSMtoCOM >> outputFor: analysisType [ 
	"Yield process at the end of output so that current process may be aborted safely."

	((analysisType == #DYNAMIC or: [analysisType == #'INITIAL CONDITIONS']) 
		or: [analysisType == #STATIC]) 
			ifTrue: 
				[aAssembly updateFromMbD.
				aAssembly refFrame changed.
				self tellAlibreOfFrame: aAssembly dataSeries size]
			ifFalse: 
				[analysisType == #INPUT 
					ifTrue: 
						[aAssembly storeInputFromMbD.
						self tellAlibreOfFrame: 0]
					ifFalse: 
						[analysisType == #DISCONTINUITY 
							ifTrue: [aAssembly storeDiscontinuityFromMbD]]].
	Processor yield
]

{ #category : #accessing }
CADSMtoCOM >> partList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	aAssembly == nil ifFalse: [aAssembly partList: collection].
	^collection
]

{ #category : #accessing }
CADSMtoCOM >> pauseAfterOutput [
	^pauseAfterOutput
]

{ #category : #accessing }
CADSMtoCOM >> pauseAfterOutput: anObject [
	pauseAfterOutput := anObject
]

{ #category : #DYN }
CADSMtoCOM >> performSimulation: symbol [ 
	self isSimulating 
		ifTrue: 
			[self 
				error: 'A simulation is running. <n>Stop current simulation before starting a new one.' 
						expandMacros]
		ifFalse: 
			[aAssembly storeInputState.
			self outputDebug1ASM.
			self deleteDebugTxt.
			mbdProcess := 
					[| elapsedSeconds |
					aMbDSystem := MbDSystem new.
					self aMbDSystem: aMbDSystem.
					self logString: #'ADM \\\Starting Simulation.'.
					elapsedSeconds := Time secondsToRun: 
									[[aMbDSystem perform: symbol] on: SimulationStoppingError
										do: [:ex | ex return]].
					self logString: #'ADM \Elapsed time is %1 seconds.'
						withArgument: elapsedSeconds printString.
					self aMbDSystem: nil.
					aCADSMAlibre ifNotNil: [aCADSMAlibre simulationComplete].
					self outputDebug2ASM] 
							forkAt: Processor userBackgroundPriority]
]

{ #category : #DYN }
CADSMtoCOM >> postMbDrun [
	aAssembly deleteMbD
]

{ #category : #DYN }
CADSMtoCOM >> preMbDrun [
	aAssembly calcCharacteristicDimensions.
	aAssembly deleteMbD.
	aAssembly createMbD.
	aAssembly mbdObject asFixed
]

{ #category : #DYN }
CADSMtoCOM >> resumeSimulation [
	"
	The garbage can cursor persists when this command is executed during garbage collection.
	'Cursor normal show' forces a normal cursor.
	"

	self isSimulating 
		ifTrue: 
			[[mbdProcess resume] on: Error do: [:ex | ex return].
			Cursor normal show]
]

{ #category : #DYN }
CADSMtoCOM >> startDynamic [
	self performSimulation: #runDYNAMIC
]

{ #category : #DYN }
CADSMtoCOM >> startKinematic [
	self performSimulation: #runKINEMATIC
]

{ #category : #DYN }
CADSMtoCOM >> startQuasiStatic [
	"
	Convergence is fragile for quasistatic analysis.
	When there is no convergence, the aA matrices are no longer valid rotation matrices. So all geometry is no longer correct. Condition the aA matrices to avoid the problem.
	"

	self performSimulation: #runSTATICS.
	(aAssembly refFrame)
		conditionA;
		changed
]

{ #category : #DYN }
CADSMtoCOM >> startTransient [
	self performSimulation: #runTRANSIENT
]

{ #category : #DYN }
CADSMtoCOM >> stopSimulation [
	"
	The garbage can cursor persists when this command is executed during garbage collection.
	'Cursor normal show' forces a normal cursor.
	"

	| sem |
	self isSimulating 
		ifTrue: 
			[sem := Semaphore new.
			
			[mbdProcess terminate.
			mbdProcess := nil.
			sem signal] 
					forkAt: mbdProcess priority.
			sem wait.
			Cursor normal show]
]

{ #category : #DYN }
CADSMtoCOM >> suspendSimulation [
	"
	The garbage can cursor persists when this command is executed during garbage collection.
	'Cursor normal show' forces a normal cursor.
	"

	self isSimulating 
		ifTrue: 
			[[mbdProcess suspend] on: Error do: [:ex | ex return].
			Cursor normal show]
]

{ #category : #DYN }
CADSMtoCOM >> tellAlibreOfFrame: i [ 
	aCADSMAlibre ifNotNil: 
			[aCADSMAlibre newFrame: i.
			pauseAfterOutput ifTrue: [self suspendSimulation]]
]

{ #category : #DYN }
CADSMtoCOM >> useCollisionTrialStepStats: stats [ 
	| mbdUnits impulse array |
	mbdUnits := self mbdUnits.
	impulse := mbdUnits force * mbdUnits time.
	array := Array new: 6.
	array at: 1 put: (stats at: #istep) printString.
	array at: 2 put: ((stats at: #t) * impulse) asFloat printString.
	array at: 3 put: (stats at: #order) printString.
	array at: 4 put: ((stats at: #h) * impulse) asFloat printString.
	array at: 5 put: (stats at: #corIterNo) printString.
	array at: 6 put: (stats at: #truncError) asFloat printString.
	self logString: #'ADM: \%1 , imp=%2 , o=%3 , dimp=%4 , it=%5 , e=%6'
		withArguments: array
]

{ #category : #DYN }
CADSMtoCOM >> useDynTrialStepStats: stats [ 
	| time array |
	time := mbdUnits time.
	array := Array new: 6.
	array at: 1 put: (stats at: #istep) printString.
	array at: 2 put: ((stats at: #t) * time) asFloat printString.
	array at: 3 put: (stats at: #order) printString.
	array at: 4 put: ((stats at: #h) * time) asFloat printString.
	array at: 5 put: (stats at: #corIterNo) printString.
	array at: 6
		put: ((stats at: #truncError) ifNotNil: [:a | a asFloat]) printString.
	self logString: #'ADM: \%1 , t=%2 , o=%3 , h=%4 , it=%5 , e=%6'
		withArguments: array
]

{ #category : #DYN }
CADSMtoCOM >> useKineTrialStepStats: stats [ 
	self useDynTrialStepStats: stats
]

{ #category : #DYN }
CADSMtoCOM >> zeroAllVelocities [
	self partList do: [:part | part zeroVelocities]
]
