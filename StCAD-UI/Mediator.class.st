Class {
	#name : #Mediator,
	#superclass : #Item,
	#instVars : [
		'eventHandlers',
		'aEditor',
		'aUniverse',
		'aTool',
		'cSelectedItem',
		'cHandle',
		'cMemento',
		'aSketch',
		'aProcess',
		'aTextCollector',
		'aFilename',
		'isDirty'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
Mediator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
Mediator >> aEditor [
	^aEditor
]

{ #category : #accessing }
Mediator >> aEditor: anObject [
	aEditor := anObject
]

{ #category : #accessing }
Mediator >> aFilename [
	^aFilename
]

{ #category : #accessing }
Mediator >> aFilename: anObject [
	aFilename := anObject
]

{ #category : #accessing }
Mediator >> aTool [
	^aTool
]

{ #category : #accessing }
Mediator >> aTool: anObject [
	aTool := anObject
]

{ #category : #accessing }
Mediator >> aUniverse [
	^aUniverse
]

{ #category : #accessing }
Mediator >> aUniverse: anObject [ 
	aUniverse := anObject.
	anObject aSup: self
]

{ #category : #accessing }
Mediator >> animateFrame: integer [ 
	aUniverse updateForFrame: integer.
	aUniverse aRefFrame quietlyChanged.
	aEditor cadView redisplay
]

{ #category : #accessing }
Mediator >> animationData [
	^aUniverse animationData
]

{ #category : #accessing }
Mediator >> cSelectedItem [
	^cSelectedItem
]

{ #category : #accessing }
Mediator >> cSelectedItem: anObject [
	cSelectedItem := anObject
]

{ #category : #accessing }
Mediator >> cadAnimateSeries: series [ 
	series do: 
			[:i | 
			(aUniverse canUpdateForFrame: i) 
				ifFalse: 
					[self halt.
					^false]].
	^true
]

{ #category : #accessing }
Mediator >> cadApp [
	^aEditor
]

{ #category : #calc }
Mediator >> calcBoundingBox [
	"Do nothing."
]

{ #category : #accessing }
Mediator >> canUpdateForFrame: integer [ 
	^aUniverse canUpdateForFrame: integer
]

{ #category : #GEO }
Mediator >> deleteGEORootItem [
	| geoRootItem |
	geoRootItem := self geoRootItem.
	geoRootItem == nil ifTrue: [^self].
	self noSelections.
	geoRootItem release.
	aUniverse aAssembly: nil.
	aSketch := nil.
	self triggerEvent: #geoRootItemDeleted
]

{ #category : #'menubar items' }
Mediator >> doTiltRotateUniverseInView: aView [ 
	| aTiltUniverseHandle aRotateUniverseHandle |
	aView clearcHandle.
	aView fit: aUniverse aBoundingBox.
	aTiltUniverseHandle := TiltUniverseHandle new.
	aTiltUniverseHandle aSpatialItem: aUniverse.
	aView addHandle: aTiltUniverseHandle.
	aRotateUniverseHandle := RotateUniverseHandle new.
	aRotateUniverseHandle aSpatialItem: aUniverse.
	aView addHandle: aRotateUniverseHandle.
	aView calcBoundsAndRedisplay: aUniverse
]

{ #category : #'menubar items' }
Mediator >> doYupQuadmpmInView: aView [ 
	aView clearcHandle.
	aView menuViewYupQuadmpm.
	aView calcBoundsAndRedisplay: aUniverse
]

{ #category : #'menubar items' }
Mediator >> doYupXrightInView: aView [ 
	aView clearcHandle.
	aView menuViewYupXright.
	aView calcBoundsAndRedisplay: aUniverse
]

{ #category : #'menubar items' }
Mediator >> doZoomIn [
	self aTool: ((ZoomInTool new)
				name: 'Zoom In';
				aIcon: (Tool stockIconFor: 'Line');
				aCursor: Cursor crossHair;
				yourself)
]

{ #category : #'menubar items' }
Mediator >> doZupQuadmmpInView: aView [ 
	aView clearcHandle.
	aView menuViewZupQuadmmp.
	aView calcBoundsAndRedisplay: aUniverse
]

{ #category : #accessing }
Mediator >> geoRootItem [
	^aUniverse aAssembly
]

{ #category : #accessing }
Mediator >> geoRootItem: aAssembly [ 
	aUniverse aAssembly: aAssembly
]

{ #category : #displaying }
Mediator >> hideHandles [
	self notYetImplemented
]

{ #category : #'initialize-release' }
Mediator >> initialize [

	super initialize.
	self aUniverse: StCAD_Geo_Universe new. "VW_TRANSLATION:StCAD.Geo.Universe:StCAD_Geo_Universe"
	aTool := StCAD_UI_SelectionTool new. "VW_TRANSLATION:StCAD.UI.SelectionTool:StCAD_UI_SelectionTool"
	aTool aMediator: self.
	cSelectedItem := GEOSelections new.
	cMemento := Polymorphic_GFBoundedStack bound: 15. "VW_TRANSLATION:Polymorphic.GFBoundedStack:Polymorphic_GFBoundedStack"
	aTextCollector := TextCollector new.
	isDirty := false
]

{ #category : #accessing }
Mediator >> isDirty: boolean [ 
	isDirty := boolean
]

{ #category : #'menubar items' }
Mediator >> menuFileOpenAssembly [

	| titleString filterArray aFilenameString newName prompt originalDir newDir readStream bos geoAssembly stack |
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Open an Assembly'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter
					 filter: '*.asm*'
					 description: '*.asm*  (Assembly)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			aFilenameString := self aFilename.
			aFilenameString := aFilenameString isNil
				                   ifTrue: [ '' ]
				                   ifFalse: [ aFilenameString asFilename tail ].
			newName := CommonFileSelectionDialog
				           openTitle: titleString
				           filters: filterArray
				           filename: aFilenameString
				           mustExist: true ]
		ifFalse: [ 
			prompt := 'Enter aFilename to read a Assembly.  Use wildcards (*.asm) to get list of relevant Assembly files.'.
			newName := self fileName.
			newName := newName isNil
				           ifTrue: [ 
				           Dialog requestFileName: prompt default: '*.asm*' ]
				           ifFalse: [ 
					           originalDir := Filename currentDirectory directory.
					           newDir := newName asFilename directory.
					           newDir beCurrentDirectory.
					           [ Dialog requestFileName: prompt default: '*.asm*' ] 
						           ensure: [ originalDir beCurrentDirectory ] ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self aFilename: newName.

		[ 
		readStream := newName asFilename readStream.

		[ 
		bos := StCAD_Misc_BinaryObjectStorage onOldNoScan: readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
		geoAssembly := bos contents at: 1 ] valueNowOrOnUnwindDo: [ 
			readStream close ] ]
			on: Error
			do: [ :ex | ex return ].
		geoAssembly isNil ifTrue: [ 
			readStream := newName asFilename readStream.

			[ 
			stack := ASMTextParser
				         parse: readStream contents cleanSourceFromSelf
				         as: #asmt.
			geoAssembly := stack last ] valueNowOrOnUnwindDo: [ 
				readStream close ] ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				self deleteGEORootItem.
				self geoRootItem: geoAssembly.
				self changed: #object.
				self isDirty: false ]
			ifFalse: [ Dialog warn: 'Error reading an assembly from file.' ] ]
]

{ #category : #'menubar items' }
Mediator >> menuViewPresentationHideLine [
	aUniverse viewAsHideLine
]

{ #category : #'menubar items' }
Mediator >> menuViewPresentationSolid [
	aUniverse viewAsSolid
]

{ #category : #'menubar items' }
Mediator >> menuViewPresentationWireframe [
	aUniverse viewAsWireframe
]

{ #category : #GEO }
Mediator >> noSelections [
	self hideHandles.
	cSelectedItem do: [:each | each deselect].
	cSelectedItem emptySelf.
	self triggerEvent: #deselect
]

{ #category : #displaying }
Mediator >> renderOn: aRenderingContext [ 
	aUniverse renderOn: aRenderingContext
]

{ #category : #'menubar items' }
Mediator >> scrollView: aView by: aPoint [ 
	aView scrollCameraBy: aPoint.
	aView preferredBounds moveBy: aPoint.
	aView calcBoundsAndRedisplay: aUniverse
]

{ #category : #accessing }
Mediator >> selections [
	^cSelectedItem
]

{ #category : #accessing }
Mediator >> timeSeries [
	^aUniverse timeSeries
]

{ #category : #displaying }
Mediator >> unhideHandles [
	self notYetImplemented
]

{ #category : #displaying }
Mediator >> updateForFrame: integer [ 
	aUniverse updateForFrame: integer.
	aUniverse aRefFrame calcAll
]
