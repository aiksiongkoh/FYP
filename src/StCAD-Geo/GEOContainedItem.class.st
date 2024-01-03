Class {
	#name : #GEOContainedItem,
	#superclass : #NewEventModel,
	#instVars : [
		'container'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOContainedItem >> aSup [
	^container
]

{ #category : #accessing }
GEOContainedItem >> aSup: aaSup [ 
	container := aaSup.
	^aaSup
]

{ #category : #accessing }
GEOContainedItem >> addCurrentStateToDataSeries [
	| data |
	data := self dataFromCurrentState.
	self dataSeries add: data
]

{ #category : #accessing }
GEOContainedItem >> addMarkersIn: set [ 
	"Do nothing."
]

{ #category : #accessing }
GEOContainedItem >> anyPart [
	^container anyPart
]

{ #category : #accessing }
GEOContainedItem >> asTreeNode [
	| answer |
	answer := GEOTreeNode new.
	answer geoItem: self.
	answer children: List new.
	answer displayString: self name.
	^answer
]

{ #category : #accessing }
GEOContainedItem >> assembly [
	^container assembly
]

{ #category : #accessing }
GEOContainedItem >> boundingBox [
	self subclassResponsibility
]

{ #category : #calc }
GEOContainedItem >> calcBoundingBox [
	self notYetImplemented
]

{ #category : #accessing }
GEOContainedItem >> chartTypes [
	^self triggerEvent: #getChartTypes
]

{ #category : #accessing }
GEOContainedItem >> chartTypes: chartTypes [ 
	self removeActionsForEvent: #getChartTypes.
	chartTypes notNil ifTrue: [self
			when: #getChartTypes
			ask: chartTypes
			perform: #yourself]
]

{ #category : #accessing }
GEOContainedItem >> connectorList: collection [ 
	"Do nothing."
]

{ #category : #accessing }
GEOContainedItem >> container [
	^container
]

{ #category : #accessing }
GEOContainedItem >> container: geoItem [ 
	container := geoItem
]

{ #category : #accessing }
GEOContainedItem >> dataSeries [
	| answer |
	answer := self triggerEvent: #getDataSeries.
	answer isNil 
		ifTrue: 
			[answer := OrderedCollection new.
			self dataSeries: answer].
	^answer
]

{ #category : #accessing }
GEOContainedItem >> dataSeries: dataSeries [ 
	self removeActionsForEvent: #getDataSeries.
	dataSeries notNil ifTrue: [self
			when: #getDataSeries
			ask: dataSeries
			perform: #yourself]
]

{ #category : #accessing }
GEOContainedItem >> discontinuities [
	^self triggerEvent: #getDiscontinuities
]

{ #category : #accessing }
GEOContainedItem >> discontinuities: discontinuities [ 
	self removeActionsForEvent: #getDiscontinuities.
	discontinuities notNil ifTrue: [self
			when: #getDiscontinuities
			ask: discontinuities
			perform: #yourself]
]

{ #category : #copying }
GEOContainedItem >> frozenCopy [
	"Used in handle tracking."

	^self copy
]

{ #category : #accessing }
GEOContainedItem >> fullName [
	| stream |
	stream := WriteStream on: (String new: 256).
	self fullpath do: [:node | (node respondsTo: #name)
			ifTrue: [node name isString
					ifTrue: 
						[stream nextPut: $/.
						stream nextPutAll: node name]]].
	^stream contents asSymbol
]

{ #category : #accessing }
GEOContainedItem >> fullNamePOV [
	| stream |
	stream := WriteStream on: (String new: 256).
	self fullpath do: 
			[:node | 
			(node respondsTo: #name) 
				ifTrue: 
					[node name isString 
						ifTrue: 
							[stream nextPut: $_.
							stream nextPutAll: node name]]].
	^stream contents asSymbol
]

{ #category : #accessing }
GEOContainedItem >> fullpath [
	| fullpath |
	fullpath := container isNil
				ifTrue: [OrderedCollection new]
				ifFalse: [container fullpath].
	fullpath add: self.
	^fullpath
]

{ #category : #accessing }
GEOContainedItem >> functionParser [
	| parser |
	parser := FunctionParser new.
	parser container: self.
	parser initVariables.
	parser initgeoIJs.
	^parser
]

{ #category : #accessing }
GEOContainedItem >> geoTime [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container geoTime]
]

{ #category : #'initialize-release' }
GEOContainedItem >> initialize [
	"Do nothing is default."
]

{ #category : #accessing }
GEOContainedItem >> inputData [
	| answer |
	answer := self triggerEvent: #getInputData.
	^answer notNil 
		ifTrue: [answer]
		ifFalse: 
			[self storeInputState.
			self triggerEvent: #getInputData]
]

{ #category : #accessing }
GEOContainedItem >> inputData: inputData [ 
	self removeActionsForEvent: #getInputData.
	inputData notNil ifTrue: [self
			when: #getInputData
			ask: inputData
			perform: #yourself]
]

{ #category : #accessing }
GEOContainedItem >> interface [
	container == nil ifTrue: [^nil].
	^container interface
]

{ #category : #testing }
GEOContainedItem >> isAssembly [
	^false
]

{ #category : #testing }
GEOContainedItem >> isCutable [
	^true
]

{ #category : #testing }
GEOContainedItem >> isFace [
	^false
]

{ #category : #testing }
GEOContainedItem >> isGeneralConstraintSet [
	^false
]

{ #category : #testing }
GEOContainedItem >> isInterface [
	^false
]

{ #category : #testing }
GEOContainedItem >> isJoint [
	^false
]

{ #category : #testing }
GEOContainedItem >> isKineIJ [
	^false
]

{ #category : #testing }
GEOContainedItem >> isMotion [
	^false
]

{ #category : #testing }
GEOContainedItem >> isPart [
	^false
]

{ #category : #testing }
GEOContainedItem >> isPlanar [
	^false
]

{ #category : #testing }
GEOContainedItem >> isRobotAxis [
	^false
]

{ #category : #testing }
GEOContainedItem >> isSketch [
	^false
]

{ #category : #accessing }
GEOContainedItem >> logString: string [ 
	container logString: string
]

{ #category : #accessing }
GEOContainedItem >> mbdClass [
	^self class mbdClass
]

{ #category : #accessing }
GEOContainedItem >> mbdObject [
	| answer |
	^(answer := self triggerEvent: #getMbDObject) notNil
		ifTrue: [answer]
		ifFalse: 
			[self createMbD.
			self mbdObject]
]

{ #category : #accessing }
GEOContainedItem >> mbdObject: mbdObject [ 
	self removeActionsForEvent: #getMbDObject.
	mbdObject notNil ifTrue: [self
			when: #getMbDObject
			ask: mbdObject
			perform: #yourself]
]

{ #category : #accessing }
GEOContainedItem >> mbdUnits [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container mbdUnits]
]

{ #category : #accessing }
GEOContainedItem >> nameString [
	^self class nameString
]

{ #category : #accessing }
GEOContainedItem >> newDataSeries [
	self dataSeries: OrderedCollection new
]

{ #category : #accessing }
GEOContainedItem >> notes [
	^self triggerEvent: #getNotes
]

{ #category : #accessing }
GEOContainedItem >> notes: notes [ 
	self removeActionsForEvent: #getNotes.
	notes notNil ifTrue: [self
			when: #getNotes
			ask: notes
			perform: #yourself]
]

{ #category : #accessing }
GEOContainedItem >> part [
	^container part
]

{ #category : #accessing }
GEOContainedItem >> plotTypes [
	^self triggerEvent: #getChartTypes
]

{ #category : #modeling }
GEOContainedItem >> postBuildSolidModelFrom: geoPart [ 
	container postBuildSolidModelFrom: geoPart
]

{ #category : #modeling }
GEOContainedItem >> preBuildSolidModelFrom: geoPart [ 
	container notNil ifTrue: [container preBuildSolidModelFrom: geoPart]
]

{ #category : #copying }
GEOContainedItem >> preSave [
	| go mbd |
	go := self triggerEvent: #getCADObject.
	self removeActionsForEvent: #getCADObject.
	go notNil ifTrue: [self removeAllActionsWithReceiver: go].
	mbd := self triggerEvent: #getMbDObject.
	self removeActionsForEvent: #getMbDObject.
	mbd notNil ifTrue: [self removeAllActionsWithReceiver: mbd]
]

{ #category : #'ops on self' }
GEOContainedItem >> refFrameChanged [
	self triggerEvent: #refFrameChanged
]

{ #category : #'initialize-release' }
GEOContainedItem >> release [
	container := nil.
	super release
]

{ #category : #accessing }
GEOContainedItem >> removeSup [
	self aSup ifNotNil: [:aaSup | aaSup removeSub: self]
]

{ #category : #memento }
GEOContainedItem >> storeMemento: aMemento for: anObject [ 
	container notNil ifTrue: [container storeMemento: aMemento for: anObject]
]

{ #category : #printing }
GEOContainedItem >> storeOn: aStream level: level [ 
	self subclassResponsibility
]

{ #category : #printing }
GEOContainedItem >> storePOVOn: aStream level: level [ 
	self subclassResponsibility
]

{ #category : #accessing }
GEOContainedItem >> timeSeries [
	container == nil ifTrue: [^nil].
	^container timeSeries
]

{ #category : #accessing }
GEOContainedItem >> treeNodesBlock [
	^
	[:items :displayString | 
	| child list |
	child := GEOTreeNode new.
	child geoItem: items.
	list := List new: items size.
	items do: [:item | list add: item asTreeNode].
	list sortWith: 
			[:node1 :node2 | 
			node1 geoItem name ifNil: [true] ifNotNil: [:a | a <= node2 geoItem name]].
	child children: list.
	child displayString: displayString.
	child]
]

{ #category : #accessing }
GEOContainedItem >> withUnits: argUnits [ 
	"Do nothing."
]
