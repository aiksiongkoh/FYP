Class {
	#name : #GEOAssembly,
	#superclass : #GEOAnyPart,
	#instVars : [
		'anyParts',
		'constraintSets'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAssembly >> aAPp [
	^(FullMatrix identity: 3)
]

{ #category : #accessing }
GEOAssembly >> aSimulationData [
	| answer |
	answer := self triggerEvent: #getSimulationData.
	answer == nil
		ifTrue: 
			[answer := GEOSimulationData new.
			self aSimulationData: answer].
	^answer
]

{ #category : #accessing }
GEOAssembly >> aSimulationData: simulationData [ 
	self removeActionsForEvent: #getSimulationData.
	simulationData notNil ifTrue: [self
			when: #getSimulationData
			ask: simulationData
			perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> addAnyPart: geoAnyPart [

	geoAnyPart
		ifNotNil: 
			[geoAnyPart container: self.
			geoAnyPart refFrame refFrame: refFrame.
			anyParts add: geoAnyPart]
]

{ #category : #accessing }
GEOAssembly >> addForce: geoForce [ 
	geoForce container: self.
	self forcesTorques add: geoForce
]

{ #category : #accessing }
GEOAssembly >> addForceTorque: geoForceTorque [ 
	geoForceTorque container: self.
	self forcesTorques add: geoForceTorque
]

{ #category : #accessing }
GEOAssembly >> addForceTorques: array [ 
	array do: [:joint | self addForceTorque: joint]
]

{ #category : #accessing }
GEOAssembly >> addGeneralConstraintSets: array [ 
	array do: [:joint | self addGeneralConstraintSet: joint]
]

{ #category : #accessing }
GEOAssembly >> addJoint: geoJoint [ 
	geoJoint container: self.
	constraintSets add: geoJoint
]

{ #category : #accessing }
GEOAssembly >> addJoints: array [ 
	array do: [:joint | self addJoint: joint]
]

{ #category : #accessing }
GEOAssembly >> addKineIJ: geoKineIJ [ 
	geoKineIJ container: self.
	constraintSets add: geoKineIJ
]

{ #category : #accessing }
GEOAssembly >> addKinematicIJs: array [ 
	array do: [:kineIJ | self addKineIJ: kineIJ]
]

{ #category : #accessing }
GEOAssembly >> addLighting: aLighting [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aLighting removeSup.
	super addRefFrame: aLighting aRefFrame.
	self cLighting add: aLighting.
	aLighting aSup: self.
	self calcBoundingBox.
	^aLighting
]

{ #category : #accessing }
GEOAssembly >> addMarkersIn: set [ 
	super addMarkersIn: set.
	anyParts do: [:anyPart | anyPart addMarkersIn: set]
]

{ #category : #accessing }
GEOAssembly >> addMotion: geoMotion [ 
	geoMotion container: self.
	constraintSets add: geoMotion
]

{ #category : #accessing }
GEOAssembly >> addMotions: array [ 
	array do: [:item | self addMotion: item]
]

{ #category : #accessing }
GEOAssembly >> addParts: array [ 
	array do: [:part | self addAnyPart: part]
]

{ #category : #accessing }
GEOAssembly >> addTorque: geoTorque [ 
	geoTorque container: self.
	self forcesTorques add: geoTorque
]

{ #category : #accessing }
GEOAssembly >> addcAnyPart: cAnyPart [ 
	cAnyPart do: [:aAnyPart | self addAnyPart: aAnyPart]
]

{ #category : #accessing }
GEOAssembly >> animationData [
	| dataSeries answer nseries |
	dataSeries := self dataSeries.
	nseries := dataSeries isNil
				ifTrue: [0]
				ifFalse: [dataSeries size].
	answer := self triggerEvent: #getAnimationData.
	answer == nil
		ifTrue: 
			[answer := GEOAnimationData new.
			self animationData: answer].
	answer nframe: nseries.
	^answer
]

{ #category : #accessing }
GEOAssembly >> animationData1 [
	| dataSeries answer data |
	dataSeries := self dataSeries.
	(dataSeries isNil or: [dataSeries isEmpty])
		ifTrue: [self error: 'There is no simulation data for animation.'].
	answer := self triggerEvent: #getAnimationData.
	answer := answer == nil
				ifTrue: 
					[data := GEOAnimationData new: dataSeries size.
					self animationData: data.
					data]
				ifFalse: 
					[answer nframe: dataSeries size.
					answer].
	^answer
]

{ #category : #accessing }
GEOAssembly >> animationData: animationData [ 
	self removeActionsForEvent: #getAnimationData.
	animationData notNil ifTrue: [self
			when: #getAnimationData
			ask: animationData
			perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> anyParts [
	^anyParts
]

{ #category : #accessing }
GEOAssembly >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer children 
		addFirst: (self treeNodesBlock value: anyParts value: 'Parts').
	answer children 
		addFirst: (self treeNodesBlock value: self cLighting value: 'Lighting').
	answer children 
		addLast: (self treeNodesBlock value: constraintSets value: 'JointsMotions').
	answer children addLast: (self treeNodesBlock value: self forcesTorques
				value: 'ForcesTorques').
	answer children addLast: self gravity asTreeNode.
	^answer
]

{ #category : #accessing }
GEOAssembly >> asTreeNode1 [
	| answer |
	answer := super asTreeNode.
	answer children addFirst: (self treeNodesBlock value: anyParts value: 'Parts').
	answer children addLast: (self treeNodesBlock value: constraintSets value: 'JointsMotions').
	answer children addLast: (self treeNodesBlock value: self forcesTorques value: 'ForcesTorques').	"
	answer children addLast: self gravity asTreeNode."
	^answer
]

{ #category : #accessing }
GEOAssembly >> assembly [
	^self
]

{ #category : #accessing }
GEOAssembly >> assemblyList: collection [ 
	collection add: self.
	anyParts do: [:anyPart | anyPart assemblyList: collection]
]

{ #category : #accessing }
GEOAssembly >> boundingBox [
	| answer |
	answer := super boundingBox.
	anyParts do: [:part | answer merge: part boundingBoxF].
	^answer
]

{ #category : #accessing }
GEOAssembly >> cAnyPart [
	^anyParts
]

{ #category : #accessing }
GEOAssembly >> cForceTorque [
	^self triggerEvent: #getForcesTorques
]

{ #category : #accessing }
GEOAssembly >> cJoint [
	^(constraintSets select: [:set | set isJoint]) 
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> cLighting [

	| cLighting |
	cLighting := self triggerEvent: #getcLighting.
	cLighting == nil ifTrue: [ 
		cLighting := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
		self cLighting: cLighting.
		self addLighting:
			((AmbientLighting color: Polymorphic_Color veryDarkGray copy)
				 name: 'AmbientLighting';
				 yourself). "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
		self addLighting: ((ParallelLighting
				  color: Polymorphic_Color veryDarkGray copy
				  direction: #( 1 0 0 ))
				 name: 'ParallelLighting1';
				 yourself).
		self addLighting: ((ParallelLighting
				  color: Polymorphic_Color veryDarkGray copy
				  direction: #( 0 1 0 ))
				 name: 'ParallelLighting2';
				 yourself).
		self addLighting: ((ParallelLighting
				  color: Polymorphic_Color darkGray copy
				  direction: #( 0 0 -1 ))
				 name: 'ParallelLighting3';
				 yourself) ].
	^ cLighting
]

{ #category : #accessing }
GEOAssembly >> cLighting: cLighting [ 
	self removeActionsForEvent: #getcLighting.
	cLighting notNil 
		ifTrue: 
			[self 
				when: #getcLighting
				ask: cLighting
				perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> cMotion [
	^(constraintSets select: [:set | set isMotion]) 
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> cRobotAxis [
	^(constraintSets select: [:set | set isRobotAxis]) 
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #calc }
GEOAssembly >> calcBoundingBox [
	self notYetImplemented
]

{ #category : #DYN }
GEOAssembly >> calcCharacteristicDimensions [
	| unitMass unitLength unitTime unitAngle |
	unitTime := self calcCharacteristicTime.
	unitMass := self calcCharacteristicMass.
	unitLength := self calcCharacteristicLength.
	unitAngle := 1.0d.
"	self halt: 'For debug only'.
	unitTime := 1.0d.
	unitMass := 1.0d.
	unitLength := 1.0d.
	unitAngle := 1.0d."
	self interface mbdUnits: (Units
			time: unitTime
			mass: unitMass
			length: unitLength
			angle: unitAngle)
]

{ #category : #DYN }
GEOAssembly >> calcCharacteristicLength [
	| lengths sumOfSquares unitLength |
	lengths := OrderedCollection new.
	self interface connectorList
		do: 
			[:geoIJ | 
			lengths add: geoIJ aMarkerI rpmp length.
			lengths add: geoIJ aMarkerJ rpmp length].
	sumOfSquares := lengths inject: 0.0d into: [:subtotal :length | subtotal + (length * length)].
	unitLength := (sumOfSquares / (lengths size max: 1)) sqrt.
	unitLength <= 0 ifTrue: [unitLength := 1.0d].
	^unitLength
]

{ #category : #DYN }
GEOAssembly >> calcCharacteristicMass [
	| masses sumOfSquares unitMass |
	masses := self interface partList collect: [:part | part mass].
	sumOfSquares := masses inject: 0.0d into: [:subtotal :mass | subtotal + (mass * mass)].
	unitMass := (sumOfSquares / masses size) sqrt.
	unitMass <= 0 ifTrue: [unitMass := 1.0d].
	^unitMass
]

{ #category : #DYN }
GEOAssembly >> calcCharacteristicTime [
	^self aSimulationData hout abs
]

{ #category : #DYN }
GEOAssembly >> canUpdateForFrame: integer [ 
	(super canUpdateForFrame: integer)
		ifFalse: [^false].
	anyParts do: [:anyPart | (anyPart canUpdateForFrame: integer)
			ifFalse: [^false]].
	constraintSets do: [:constraintSet | (constraintSet canUpdateForFrame: integer)
			ifFalse: [^false]].
	self forcesTorques do: [:forceTorque | (forceTorque canUpdateForFrame: integer)
			ifFalse: [^false]].
	^true
]

{ #category : #accessing }
GEOAssembly >> connectorList [
	| answer |
	answer := OrderedCollection new.
	self jointList do: [:geoIJ | answer add: geoIJ].
	self motionList do: [:geoIJ | answer add: geoIJ].
	self kineIJList do: [:geoIJ | answer add: geoIJ].
	self forceTorqueList do: [:geoIJ | answer add: geoIJ].
	^answer
]

{ #category : #accessing }
GEOAssembly >> connectorList: collection [ 
	anyParts do: [:anyPart | anyPart connectorList: collection].
	constraintSets do: [:constraintSet | constraintSet connectorList: collection].
	self forcesTorques do: [:forceTorque | forceTorque connectorList: collection]
]

{ #category : #accessing }
GEOAssembly >> constraintSets [
	^constraintSets
]

{ #category : #DYN }
GEOAssembly >> createMbD [
	| simulationData mbdSystemSolver mbdUnits block |
	container isInterface 
		ifTrue: 
			[self gravity createMbD.
			self geoTime createMbD.
			self timesAtDiscontinuities: OrderedCollection new.
			simulationData := self aSimulationData.
			self timeSeries: OrderedCollection new.
			mbdSystemSolver := self interface mbdSystem mbdSystemSolver.
			mbdUnits := self mbdUnits.
			mbdSystemSolver errorTolPosKine: simulationData errorTolPosKine abs.
			mbdSystemSolver errorTolAccKine: simulationData errorTolAccKine abs.
			mbdSystemSolver iterMaxPosKine: simulationData iterMaxPosKine abs.
			mbdSystemSolver iterMaxAccKine: simulationData iterMaxAccKine abs.
			mbdSystemSolver tstart: simulationData tstart / mbdUnits time.
			mbdSystemSolver tend: simulationData tend / mbdUnits time.
			mbdSystemSolver hmin: simulationData hmin abs / mbdUnits time.
			mbdSystemSolver hmax: simulationData hmax abs / mbdUnits time.
			mbdSystemSolver hout: simulationData hout abs / mbdUnits time.
			mbdSystemSolver corAbsTol: simulationData corAbsTol abs.
			mbdSystemSolver corRelTol: simulationData corRelTol abs.
			mbdSystemSolver intAbsTol: simulationData intAbsTol abs.
			mbdSystemSolver intRelTol: simulationData intRelTol abs.
			mbdSystemSolver iterMaxDyn: simulationData iterMaxDyn abs.
			mbdSystemSolver orderMax: simulationData orderMax abs.
			mbdSystemSolver 
				translationLimit: simulationData translationLimit abs / mbdUnits length.
			mbdSystemSolver rotationLimit: simulationData rotationLimit abs]
		ifFalse: 
			[self gravity: nil.
			self mbdUnits: nil.
			self aSimulationData: nil.
			self geoTime: nil.
			self timeSeries: nil.
			self timesAtDiscontinuities: nil.
			self forcesTorques: nil].
	self animationData: nil.
	super createMbD.
	block := 
			[:collection | 
			(collection asSortedCollection: [:a :b | a name <= b name]) 
				do: [:item | item createMbD]].
	block value: anyParts.
	block value: constraintSets.
	block value: self forcesTorques
]

{ #category : #DYN }
GEOAssembly >> createMbD1 [
	| simulationData mbdSystemSolver mbdUnits |
	container isInterface
		ifTrue: 
			[self gravity createMbD.
			self geoTime createMbD.
			self timesAtDiscontinuities: OrderedCollection new.
			simulationData := self aSimulationData.
			self timeSeries: OrderedCollection new.
			mbdSystemSolver := self interface mbdSystem mbdSystemSolver.
			mbdUnits := self mbdUnits.
			mbdSystemSolver errorTolPosKine: simulationData errorTolPosKine abs.
			mbdSystemSolver errorTolAccKine: simulationData errorTolAccKine abs.
			mbdSystemSolver iterMaxPosKine: simulationData iterMaxPosKine abs.
			mbdSystemSolver iterMaxAccKine: simulationData iterMaxAccKine abs.
			mbdSystemSolver tstart: simulationData tstart / mbdUnits time.
			mbdSystemSolver tend: simulationData tend / mbdUnits time.
			mbdSystemSolver hmin: simulationData hmin abs / mbdUnits time.
			mbdSystemSolver hmax: simulationData hmax abs / mbdUnits time.
			mbdSystemSolver hout: simulationData hout abs / mbdUnits time.
			mbdSystemSolver corAbsTol: simulationData corAbsTol abs.
			mbdSystemSolver corRelTol: simulationData corRelTol abs.
			mbdSystemSolver intAbsTol: simulationData intAbsTol abs.
			mbdSystemSolver intRelTol: simulationData intRelTol abs.
			mbdSystemSolver iterMaxDyn: simulationData iterMaxDyn abs.
			mbdSystemSolver orderMax: simulationData orderMax abs.
			mbdSystemSolver translationLimit: simulationData translationLimit abs / mbdUnits length.
			mbdSystemSolver rotationLimit: simulationData rotationLimit abs]
		ifFalse: 
			[self gravity: nil.
			self mbdUnits: nil.
			self aSimulationData: nil.
			self geoTime: nil.
			self timeSeries: nil.
			self timesAtDiscontinuities: nil.
			self forcesTorques: nil].
	self animationData: nil.
	super createMbD.
	anyParts do: [:anyPart | anyPart createMbD].
	constraintSets do: [:constraintSet | constraintSet createMbD].
	self forcesTorques do: [:forceTorque | forceTorque createMbD]
]

{ #category : #accessing }
GEOAssembly >> cut [
	container cutAssembly: self.
	super cut
]

{ #category : #accessing }
GEOAssembly >> cutForce: geoForce [ 
	self forcesTorques remove: geoForce
]

{ #category : #accessing }
GEOAssembly >> cutForceTorque: geoForceTorque [ 
	self forcesTorques remove: geoForceTorque
]

{ #category : #accessing }
GEOAssembly >> cutJoint: geoJoint [ 
	constraintSets remove: geoJoint
]

{ #category : #accessing }
GEOAssembly >> cutKineIJ: geoKineIJ [ 
	constraintSets remove: geoKineIJ
]

{ #category : #accessing }
GEOAssembly >> cutMotion: geoMotion [ 
	constraintSets remove: geoMotion
]

{ #category : #accessing }
GEOAssembly >> cutPart: geoPart [ 
	anyParts remove: geoPart
]

{ #category : #accessing }
GEOAssembly >> cutTorque: geoTorque [ 
	self forcesTorques remove: geoTorque
]

{ #category : #accessing }
GEOAssembly >> defaultGravity [
	^GEOGravity new gX: 0.0d gY: 0.0d gZ: 0.0d.
]

{ #category : #DYN }
GEOAssembly >> deleteMbD [
	super deleteMbD.
	self gravity deleteMbD.
	self geoTime deleteMbD.
	anyParts do: [:anyPart | anyPart deleteMbD].
	constraintSets do: [:constraintSet | constraintSet deleteMbD].
	self forcesTorques do: [:forceTorque | forceTorque deleteMbD]
]

{ #category : #accessing }
GEOAssembly >> findMarkerNamed: nameComponents [ 
	| answer part newNameComponents |
	^self name = (nameComponents at: 1)
		ifTrue: 
			[answer := markers detect: [:marker | marker name = (nameComponents at: 2)]
						ifNone: nil.
			answer isNil
				ifTrue: 
					[part := anyParts detect: [:anyPart | anyPart name = (nameComponents at: 2)]
								ifNone: nil.
					part notNil
						ifTrue: 
							[newNameComponents := nameComponents asOrderedCollection.
							newNameComponents removeFirst.
							answer := part findMarkerNamed: newNameComponents]].
			answer]
		ifFalse: [nil]
]

{ #category : #accessing }
GEOAssembly >> forceList [
	^(self forcesTorques select: [:set | set isForce]) asList
]

{ #category : #accessing }
GEOAssembly >> forceList: collection [ 
	collection addAll: (self forcesTorques select: [:set | set isForce]).
	anyParts do: [:anyPart | anyPart forceList: collection]
]

{ #category : #accessing }
GEOAssembly >> forceTorqueList [
	^self forcesTorques asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> forceTorqueList: collection [ 
	collection addAll: self forcesTorques.
	anyParts do: [:anyPart | anyPart forceTorqueList: collection]
]

{ #category : #accessing }
GEOAssembly >> forcesTorques [
	^self triggerEvent: #getForcesTorques
]

{ #category : #accessing }
GEOAssembly >> forcesTorques: forcesTorques [ 
	self removeActionsForEvent: #getForcesTorques.
	forcesTorques notNil ifTrue: [self
			when: #getForcesTorques
			ask: forcesTorques
			perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> generalConstraintSetList [
	^(constraintSets select: [:set | set isGeneralConstraintSet])
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> generateUniqueNameFor: aString [ 
	| aDict aItemList nameList count newName |
	aDict := IdentityDictionary new.
	aDict at: 'Part' asSymbol put: #partList.
	aDict at: 'Joint' asSymbol put: #jointList.
	aDict at: 'Motion' asSymbol put: #motionList.
	aDict at: 'ForceTorque' asSymbol put: #forceTorqueList.
	aItemList := self perform: (aDict at: aString asSymbol).
	nameList := aItemList collect: 
					[:aItem | 
					(aItem name isKindOf: String) ifTrue: [aItem name asSymbol] ifFalse: [#'']].
	count := 0.
	
	[count := count + 1.
	newName := aString , count printString.
	nameList includes: newName asSymbol] 
			whileTrue.
	^newName
]

{ #category : #accessing }
GEOAssembly >> geoTime [
	| answer |
	^(container == nil or: [container isInterface])
		ifTrue: 
			[answer := self triggerEvent: #getTime.
			answer == nil
				ifTrue: 
					[answer := GEOTime new.
					self geoTime: answer].
			answer]
		ifFalse: [container geoTime]
]

{ #category : #accessing }
GEOAssembly >> geoTime1 [
	| answer |
	^container == nil
		ifTrue: [nil]
		ifFalse: [container isInterface
				ifTrue: 
					[answer := self triggerEvent: #getTime.
					answer == nil
						ifTrue: 
							[answer := GEOTime new.
							self geoTime: answer].
					answer]
				ifFalse: [container geoTime]]
]

{ #category : #accessing }
GEOAssembly >> geoTime: geoTime [ 
	self removeActionsForEvent: #getTime.
	geoTime notNil
		ifTrue: 
			[geoTime container: self.
			self
				when: #getTime
				ask: geoTime
				perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> gravity [
	| answer |
	answer := self triggerEvent: #getGravity.
	answer == nil 
		ifTrue: 
			[answer := self defaultGravity.
			self gravity: answer].
	^answer
]

{ #category : #accessing }
GEOAssembly >> gravity: gravity [ 
	self removeActionsForEvent: #getGravity.
	gravity notNil
		ifTrue: 
			[gravity container: self.
			self
				when: #getGravity
				ask: gravity
				perform: #yourself]
]

{ #category : #'initialize-release' }
GEOAssembly >> initialize [

	super initialize.
	anyParts := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	constraintSets := StCAD_Misc_OrderedSet new.
	self forcesTorques: StCAD_Misc_OrderedSet new
]

{ #category : #accessing }
GEOAssembly >> insertAssembly: aAssembly [
	| shiftXYZ block cNameMarker cNameAnyPart cNameConstraintSet cNameForceTorque nameBlock |
	shiftXYZ := FullColumn zero: 3.
	CADXYZDialog openOn: shiftXYZ.
	aAssembly translateBy: shiftXYZ.
	block :=
			[:aItem |
			(aItem name isKindOf: String)
				ifTrue: [aItem name asSymbol.]
				ifFalse: [#''.].].
	cNameMarker := self markers collect: block.
	cNameAnyPart := self anyParts collect: block.
	cNameConstraintSet := self constraintSets collect: block.
	cNameForceTorque := self forcesTorques collect: block.
	nameBlock :=
			[:nameList :item |
			| count newName |
			count := 0.
			
			[count := count + 1.
			newName := (item name , count printString) asSymbol.
			nameList includes: newName.]
					whileTrue.
			item name: newName.].
	aAssembly markers do: 
			[:aMarker |
			(cNameMarker includes: aMarker name asSymbol)
				ifTrue: [nameBlock value: cNameMarker value: aMarker.].
			self addMarker: aMarker.].
	aAssembly anyParts do: 
			[:aAnyPart |
			(cNameAnyPart includes: aAnyPart name asSymbol)
				ifTrue: [nameBlock value: cNameAnyPart value: aAnyPart.].
			self addAnyPart: aAnyPart.].
	aAssembly constraintSets do: 
			[:aConstraintSet |
			(cNameConstraintSet includes: aConstraintSet name asSymbol)
				ifTrue: [nameBlock value: cNameConstraintSet value: aConstraintSet.].
			self addJoint: aConstraintSet.].
	aAssembly forcesTorques do: 
			[:aForceTorque |
			(cNameForceTorque includes: aForceTorque name asSymbol)
				ifTrue: [nameBlock value: cNameForceTorque value: aForceTorque.].
			self addForceTorque: aForceTorque.].
]

{ #category : #testing }
GEOAssembly >> isAssembly [
	^true
]

{ #category : #accessing }
GEOAssembly >> jointList [
	^(constraintSets select: [:set | set isJoint])
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> jointList: collection [ 
	collection addAll: (constraintSets select: [:set | set isJoint]).
	anyParts do: [:anyPart | anyPart jointList: collection]
]

{ #category : #accessing }
GEOAssembly >> kineIJList [
	^(constraintSets select: [:set | set isKineIJ])
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> kineIJList: collection [ 
	collection addAll: (constraintSets select: [:set | set isKineIJ]).
	anyParts do: [:anyPart | anyPart kineIJList: collection]
]

{ #category : #ops }
GEOAssembly >> magnifySelf: aDouble [ 
	self inputData magnifySelf: aDouble.
	self aRefFrame magnifySelf: aDouble.
	self cMarker do: [:aMarker | aMarker magnifySelf: aDouble].
	self cAnyPart do: [:aAnyPart | aAnyPart magnifySelf: aDouble].
	self cJoint do: [:aJoint | aJoint magnifySelf: aDouble].
	self cMotion do: [:aMotion | aMotion magnifySelf: aDouble].
	self cForceTorque do: [:aForceTorque | aForceTorque magnifySelf: aDouble]
]

{ #category : #accessing }
GEOAssembly >> markerList: collection [ 
	super markerList: collection.
	anyParts do: [:anyPart | anyPart markerList: collection]
]

{ #category : #accessing }
GEOAssembly >> motionList [
	^(constraintSets select: [:set | set isMotion])
		asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> motionList: collection [ 
	collection addAll: (constraintSets select: [:set | set isMotion]).
	anyParts do: [:anyPart | anyPart motionList: collection]
]

{ #category : #accessing }
GEOAssembly >> newDataSeries [
	self timeSeries: OrderedCollection new.
	self animationData: nil.
	super newDataSeries.
	anyParts do: [:anyPart | anyPart newDataSeries].
	constraintSets do: [:constraintSet | constraintSet newDataSeries].
	self forcesTorques do: [:forceTorque | forceTorque newDataSeries]
]

{ #category : #accessing }
GEOAssembly >> part [
	^nil
]

{ #category : #accessing }
GEOAssembly >> partList [
	^anyParts asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAssembly >> partList: collection [ 
	anyParts do: [:anyPart | anyPart partList: collection]
]

{ #category : #copying }
GEOAssembly >> postCopy [
	| originalAnyParts |
	super postCopy.
	originalAnyParts := anyParts.
	anyParts := originalAnyParts class new.
	originalAnyParts do: [:anyPart | self addAnyPart: anyPart copy]
]

{ #category : #rendering }
GEOAssembly >> preRenderOn: renderingContext [ 
	self cLighting do: [:aLighting | aLighting shineOn: renderingContext]
]

{ #category : #copying }
GEOAssembly >> preSave [
	| forcesTorques |
	super preSave.
	anyParts do: [:anyPart | anyPart preSave].
	constraintSets do: [:constraintSet | constraintSet preSave].
	forcesTorques := self forcesTorques.
	forcesTorques notNil ifTrue: [forcesTorques do: [:forceTorque | forceTorque preSave]]
]

{ #category : #accessing }
GEOAssembly >> rOMarkerCenterO [
	| zeroColumn sumOfrOfOs nmarker |
	zeroColumn := (FullColumn zero: 3).
	sumOfrOfOs := markers inject: zeroColumn
				into: [:sum :marker | sum + marker rOfO].
	nmarker := markers size.
	^nmarker > 0 ifTrue: [sumOfrOfOs / nmarker] ifFalse: [sumOfrOfOs]
]

{ #category : #accessing }
GEOAssembly >> rOcenterO [
	| sumDiagonal sumMoment block |
	sumDiagonal := 0.0d.
	sumMoment := FullColumn zero: 3.
	block := 
			[:aBBox | 
			| diagonal |
			aBBox isDefined 
				ifTrue: 
					[diagonal := aBBox extent length.
					sumDiagonal := sumDiagonal + diagonal.
					sumMoment equalSelfPlus: aBBox center times: diagonal]].
	self aDXFBLOCK 
		ifNotNil: [:aDXFBlock | aDXFBlock aBoundingBox ifNotNil: block].
	anyParts do: [:aPart | block value: aPart aBoundingBoxF].
	^sumDiagonal > 0 
		ifTrue: [sumMoment times: sumDiagonal reciprocal]
		ifFalse: [self rOMarkerCenterO]
]

{ #category : #accessing }
GEOAssembly >> rOcenterO1 [
	| zeroColumn sumOfrOcenterOs nAnyPart |
	zeroColumn := FullColumn zero: 3.
	sumOfrOcenterOs := anyParts inject: zeroColumn
				into: [:sum :anyPart | sum + anyPart rOcenterO].
	nAnyPart := anyParts size.
	^nAnyPart > 0 
		ifTrue: [sumOfrOcenterOs / nAnyPart]
		ifFalse: [self rOMarkerCenterO]
]

{ #category : #accessing }
GEOAssembly >> rOcenterO2 [
	| nAnyPart |
	nAnyPart := anyParts size.
	^nAnyPart > 0 
		ifTrue: 
			[| sumDiagonal sumMoment block |
			sumDiagonal := 0.0d.
			sumMoment := FullColumn zero: 3.
			block := 
					[:aAnyPart | 
					| aBBox diagonal |
					aBBox := aAnyPart aBoundingBoxF.
					diagonal := aBBox extent length.
					sumDiagonal := sumDiagonal + diagonal.
					sumMoment equalSelfPlus: aBBox center times: diagonal].
			anyParts do: block.
			sumMoment times: sumDiagonal reciprocal]
		ifFalse: [self rOMarkerCenterO]
]

{ #category : #accessing }
GEOAssembly >> rPcmP [
	^FullColumn zero: 3
]

{ #category : #'initialize-release' }
GEOAssembly >> release [
	"
	Order of release: connectors, markers, anyParts. 
	"

	| forcesTorques |
	constraintSets do: [:constraintSet | constraintSet release].
	forcesTorques := self forcesTorques.
	forcesTorques notNil ifTrue: [forcesTorques do: [:forceTorque | forceTorque release]].
	markers do: [:marker | marker release].
	anyParts do: [:anyPart | anyPart release].
	refFrame release.
	container := nil.
	self triggerEvent: #release.
	self releaseEventTable
]

{ #category : #rendering }
GEOAssembly >> removeDisplayList [
	anyParts do: [:aAnyPart | aAnyPart removeDisplayList]
]

{ #category : #accessing }
GEOAssembly >> removeSup [
	self aSup ifNotNil: [:aaSup | aaSup removeSub: self]
]

{ #category : #rendering }
GEOAssembly >> renderOn1: aRenderingContext [ 
	self preRenderOn: aRenderingContext.
	aRenderingContext productTransformation: refFrame aMFf
		while: [anyParts do: [:anyPart | anyPart renderOn: aRenderingContext]]
]

{ #category : #rendering }
GEOAssembly >> renderOn2: aRenderingContext [ 
	self preRenderOn: aRenderingContext.
	aRenderingContext createDisplayList: 
			[aRenderingContext productTransformation: refFrame aMFf
				while: [anyParts do: [:anyPart | anyPart renderOn: aRenderingContext]]]
		displayImmediately: true
]

{ #category : #rendering }
GEOAssembly >> renderOn3: aRenderingContext [ 
	self preRenderOn: aRenderingContext.
	aRenderingContext productTransformation: refFrame aMFf
		while: 
			[anyParts do: [:anyPart | anyPart renderOn: aRenderingContext].
			markers do: [:marker | marker renderOn: aRenderingContext].
			constraintSets 
				do: [:constraintSet | constraintSet renderOn: aRenderingContext].
			self forcesTorques 
				do: [:forceTorque | forceTorque renderOn: aRenderingContext]]
]

{ #category : #rendering }
GEOAssembly >> renderOn: aRenderingContext [ 
	self preRenderOn: aRenderingContext.
	aRenderingContext pushTransformation: refFrame aMFf
		while: 
			[anyParts do: [:anyPart | anyPart renderOn: aRenderingContext].
			"(anyParts detect: [:anyPart | anyPart name = #sn5]) renderOn: aRenderingContext."
			markers do: [:marker | marker renderOn: aRenderingContext].
			constraintSets 
				do: [:constraintSet | constraintSet renderOn: aRenderingContext].
			self forcesTorques 
				do: [:forceTorque | forceTorque renderOn: aRenderingContext]]
]

{ #category : #accessing }
GEOAssembly >> simulationData1 [
	^self triggerEvent: #getSimulationData
]

{ #category : #accessing }
GEOAssembly >> sketchList: collection [ 
	anyParts do: [:anyPart | anyPart sketchList: collection]
]

{ #category : #DYN }
GEOAssembly >> storeInputFromMbD [
	super storeInputFromMbD.
	anyParts do: [:anyPart | anyPart storeInputFromMbD].
	constraintSets do: [:constraintSet | constraintSet storeInputFromMbD].
	self forcesTorques do: [:forceTorque | forceTorque storeInputFromMbD]
]

{ #category : #DYN }
GEOAssembly >> storeInputState [
	super storeInputState.
	anyParts do: [:anyPart | anyPart storeInputState].
	constraintSets do: [:constraintSet | constraintSet storeInputState].
	self forcesTorques do: [:forceTorque | forceTorque storeInputState]
]

{ #category : #printing }
GEOAssembly >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self nameString.
	aStream 
		storeLevel: level + 1
		title: 'Notes'
		object: (self notes ifNil: ['' asText]).
	aStream 
		storeLevel: level + 1
		title: 'Name'
		object: self name.
	self refFrame storeOn: aStream level: level + 1.
	self refFrame storeVelocityOn: aStream level: level + 1.
	aStream storeLevel: level + 1 title: 'RefPoints'.
	self refPoints do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'RefCurves'.
	self refCurves do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'RefSurfaces'.
	self refSurfaces do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'Parts'.
	self partList do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'KinematicIJs'.
	self kineIJList do: [:item | item storeOn: aStream level: level + 2].
	aStream storeLevel: level + 1 title: 'ConstraintSets'.
	aStream storeLevel: level + 2 title: 'Joints'.
	self jointList do: [:item | item storeOn: aStream level: level + 3].
	aStream storeLevel: level + 2 title: 'Motions'.
	self motionList do: [:item | item storeOn: aStream level: level + 3].
	aStream storeLevel: level + 2 title: 'GeneralConstraintSets'.
	self generalConstraintSetList 
		do: [:item | item storeOn: aStream level: level + 3].
	aStream storeLevel: level + 1 title: 'ForceTorques'.
	self forceTorqueList do: [:item | item storeOn: aStream level: level + 2].
	self gravity storeOn: aStream level: level + 1.
	self aSimulationData storeOn: aStream level: level + 1.
	self animationData storeOn: aStream level: level + 1
]

{ #category : #printing }
GEOAssembly >> storePOVOn: aStream level: level [ 
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: self fullNamePOV).
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
		title: '// RefSurfaces'.
	self partList 
		storePOVOn: aStream
		level: level + 1
		title: '// Parts'
]

{ #category : #printing }
GEOAssembly >> storePOVTimeSeriesOn: aStream [ 
	| timeSeries dataSeries ndata |
	timeSeries := self timeSeries.
	(timeSeries notNil and: [timeSeries isEmpty not]) 
		ifTrue: 
			[dataSeries := self dataSeries.
			ndata := dataSeries size.
			aStream storePOVTitle: 'Number' series: (1 to: ndata by: 1).
			aStream storePOVTitle: 'Time' series: (timeSeries copyFrom: 1 to: ndata).
			super storePOVTimeSeriesOn: aStream.
			self partList do: [:item | item storePOVTimeSeriesOn: aStream].
			self jointList do: [:item | item storePOVTimeSeriesOn: aStream].
			self motionList do: [:item | item storePOVTimeSeriesOn: aStream].
			self generalConstraintSetList 
				do: [:item | item storePOVTimeSeriesOn: aStream].
			self forceTorqueList do: [:item | item storePOVTimeSeriesOn: aStream]]
]

{ #category : #printing }
GEOAssembly >> storePOVdatCurrentOn: aStream [ 
	| timeSeries dataSeries ndata |
	timeSeries := Array with: 0.
	(timeSeries notNil and: [timeSeries isEmpty not]) 
		ifTrue: 
			[dataSeries := Array with: self dataFromCurrentState.
			ndata := dataSeries size.
			aStream storePOVTitle: 'Number' series: (1 to: ndata by: 1).
			aStream storePOVTitle: 'Time' series: (timeSeries copyFrom: 1 to: ndata).
			super storePOVdatCurrentOn: aStream.
			self partList do: [:item | item storePOVdatCurrentOn: aStream].
			self jointList do: [:item | item storePOVdatCurrentOn: aStream].
			self motionList do: [:item | item storePOVdatCurrentOn: aStream].
			self generalConstraintSetList 
				do: [:item | item storePOVdatCurrentOn: aStream].
			self forceTorqueList do: [:item | item storePOVdatCurrentOn: aStream]]
]

{ #category : #printing }
GEOAssembly >> storeRobotAxesOn: writeStream [
	| nAxisLimit cAxisSeries timeSeries nrec cRobotAxis nRobotAxis dataSeries eulerAngleszyxIJSeries titleBlock recordBlock nExtra |
	nAxisLimit := 6.
	cAxisSeries := (MathArray new: nAxisLimit) writeStream.
	timeSeries := self timeSeries.
	nrec := timeSeries size.
	cRobotAxis := self cRobotAxis.
	nRobotAxis := cRobotAxis size.
	cRobotAxis do: 
			[:aRobotAxis |
			dataSeries := aRobotAxis dataSeriesForChart.
			eulerAngleszyxIJSeries := dataSeries
						collect: [:kineIkineJ | kineIkineJ eulerAngleszyxIJ.].
			GEOEulerAngles conditionSeries: eulerAngleszyxIJSeries.
			cAxisSeries nextPut: eulerAngleszyxIJSeries.].
	cAxisSeries := cAxisSeries contents.
	titleBlock :=
			[:n |
			writeStream nextPutAll: 'Time'.
			1 to: n
				do: 
					[:i |
					writeStream
						tab;
						nextPutAll: (cRobotAxis at: i) name.].].
	recordBlock :=
			[:n :irec |
			writeStream nextPutAll: (timeSeries at: irec) printForExport.
			1 to: n
				do: 
					[:i |
					writeStream
						tab;
						nextPutAll: ((cAxisSeries at: i) at: irec) first printForExport.].].
	nRobotAxis > nAxisLimit
		ifTrue: 
			[titleBlock value: nAxisLimit.
			writeStream cr.
			1 to: nrec
				do: 
					[:i |
					recordBlock value: nAxisLimit value: i.
					writeStream cr.].]
		ifFalse: 
			[nExtra := nAxisLimit - nRobotAxis.
			titleBlock value: nRobotAxis.
			nExtra timesRepeat: 
					[writeStream
						tab;
						nextPutAll: 'dummy'.].
			writeStream cr.
			1 to: nrec
				do: 
					[:i |
					recordBlock value: nRobotAxis value: i.
					nExtra timesRepeat: 
							[writeStream
								tab;
								nextPutAll: 0.0d printForExport.].
					writeStream cr.].].
]

{ #category : #printing }
GEOAssembly >> storeTimeSeriesOn: aStream [ 
	| timeSeries dataSeries ndata |
	timeSeries := self timeSeries.
	(timeSeries notNil and: [timeSeries isEmpty not])
		ifTrue: 
			[aStream nextPutAll: 'TimeSeries'; cr.
			dataSeries := self dataSeries.
			ndata := dataSeries size.
			aStream
				storeTitle: 'Number'
				input: 'Input'
				series: (1 to: ndata by: 1).
			aStream
				storeTitle: 'Time'
				input: 'Input'
				series: (timeSeries copyFrom: 1 to: ndata).
			super storeTimeSeriesOn: aStream.
			self partList do: [:item | item storeTimeSeriesOn: aStream].
			self jointList do: [:item | item storeTimeSeriesOn: aStream].
			self motionList do: [:item | item storeTimeSeriesOn: aStream].
			self generalConstraintSetList do: [:item | item storeTimeSeriesOn: aStream].
			self forceTorqueList do: [:item | item storeTimeSeriesOn: aStream]]
]

{ #category : #accessing }
GEOAssembly >> timeSeries [
	^self triggerEvent: #getTimeSeries
]

{ #category : #accessing }
GEOAssembly >> timeSeries: timeSeries [ 
	self removeActionsForEvent: #getTimeSeries.
	timeSeries notNil ifTrue: [self
			when: #getTimeSeries
			ask: timeSeries
			perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> timesAtDiscontinuities [
	^self triggerEvent: #getTimesAtDiscontinuities
]

{ #category : #accessing }
GEOAssembly >> timesAtDiscontinuities: timesAtDiscontinuities [ 
	self removeActionsForEvent: #getTimesAtDiscontinuities.
	timesAtDiscontinuities notNil ifTrue: [self
			when: #getTimesAtDiscontinuities
			ask: timesAtDiscontinuities
			perform: #yourself]
]

{ #category : #accessing }
GEOAssembly >> translateBy: shiftXYZ [ 
	| block |
	block := [:item | item translateBy: shiftXYZ].
	self markers do: block.
	self anyParts do: block
]

{ #category : #accessing }
GEOAssembly >> uncut [
	container addAnyPart: self.
	super uncut
]

{ #category : #DYN }
GEOAssembly >> updateForFrame1: integer [ 
	super updateForFrame: integer.
	anyParts do: [:anyPart | anyPart updateForFrame: integer].
	constraintSets do: [:constraintSet | constraintSet updateForFrame: integer].
	self forcesTorques do: [:forceTorque | forceTorque updateForFrame: integer]
]

{ #category : #DYN }
GEOAssembly >> updateForFrame2: integer [ 
	super updateForFrame: integer.
	anyParts do: [:anyPart | anyPart updateForFrame: integer].
	constraintSets do: [:constraintSet | constraintSet updateForFrame: integer].
	self forcesTorques do: [:forceTorque | forceTorque updateForFrame: integer]
]

{ #category : #DYN }
GEOAssembly >> updateForFrame: integer [ 
	super updateForFrame: integer.
	anyParts do: [:anyPart | anyPart updateForFrame: integer].
	markers do: [:marker | marker updateForFrame: integer].
	constraintSets do: [:constraintSet | constraintSet updateForFrame: integer].
	self forcesTorques do: [:forceTorque | forceTorque updateForFrame: integer]
]

{ #category : #DYN }
GEOAssembly >> updateFromInitiallyAssembledState [
	super updateFromInitiallyAssembledState.
	anyParts do: [:anyPart | anyPart updateFromInitiallyAssembledState].
	constraintSets do: [:constraintSet | constraintSet updateFromInitiallyAssembledState].
	self forcesTorques do: [:forceTorque | forceTorque updateFromInitiallyAssembledState]
]

{ #category : #DYN }
GEOAssembly >> updateFromInputState [
	super updateFromInputState.
	anyParts do: [:anyPart | anyPart updateFromInputState].
	constraintSets do: [:constraintSet | constraintSet updateFromInputState].
	self forcesTorques do: [:forceTorque | forceTorque updateFromInputState]
]

{ #category : #DYN }
GEOAssembly >> updateFromMbD [
	super updateFromMbD.
	self timeSeries add: self geoTime value.
	anyParts do: [:anyPart | anyPart updateFromMbD].
	constraintSets do: [:constraintSet | constraintSet updateFromMbD].
	self forcesTorques do: [:forceTorque | forceTorque updateFromMbD]
]

{ #category : #accessing }
GEOAssembly >> vectorList: collection [ 
	"Do nothing for now."
]
