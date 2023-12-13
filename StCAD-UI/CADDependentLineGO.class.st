Class {
	#name : #CADDependentLineGO,
	#superclass : #GFDependentLineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADDependentLineGO class >> createNotifying: anInterface [ 
	| markerIGO ijHandle |
	markerIGO := anInterface markerGOat: anInterface cursorPoint.
	^markerIGO notNil
		ifTrue: 
			[ijHandle := self ijHandleOn: markerIGO.
			ijHandle mementoType: nil.
			anInterface addHandle: ijHandle.
			self class gfCursorClass crossHair change.
			ijHandle invoke: anInterface.
			self class gfCursorClass normal change.
			anInterface removeHandle: ijHandle.
			ijHandle cadConnection]
		ifFalse: 
			[self issueWarning: anInterface.
			nil]
]

{ #category : #handle }
CADDependentLineGO class >> ijHandleOn: markerIGO [ 
	| ijHandle |
	ijHandle := CADConnectionHandle on: markerIGO at: #rDoriginPx.
	ijHandle
		setFindTargetAction: 
			[:interface :point | 
			| markerGO |
			markerGO := interface markerGOat: point.
			(markerGO isNil or: [markerGO == markerIGO or: [markerGO container == markerIGO container]])
				ifTrue: [nil]
				ifFalse: [markerGO]].
	ijHandle setTargetPositionAction: [:toGO | toGO rDoriginPx].
	ijHandle setLocatorGenerationAction: [:toGO :point | GFLocator on: toGO at: #rDoriginPx].
	ijHandle
		setConnectAction: 
			[:startLocator :stopLocator | 
			| markerI markerJ interface assembly ijName geoIJ |
			markerI := startLocator receiver metaObject.
			markerJ := stopLocator receiver metaObject.
			interface := markerI interface.
			assembly := (markerI fullpath size <= markerJ fullpath size
						ifTrue: [markerI]
						ifFalse: [markerJ]) assembly.
			ijName := self askInterface: interface promptUserForNameIn: assembly.
			ijName isEmpty not
				ifTrue: 
					[| cadIJ |
					geoIJ := self geoClass markerI: markerI markerJ: markerJ.
					geoIJ name: ijName.
					self askAssembly: assembly add: geoIJ.
					cadIJ := interface createUpdateSelectGOfor: geoIJ.
					cadIJ promptForFunction.
					cadIJ]].
	ijHandle setConnectedAction: [:connectionGO :toGO | connectionGO interface soleSelection: connectionGO metaObject].
	^ijHandle
]

{ #category : #'instance creation' }
CADDependentLineGO class >> issueWarning: anInterface [ 
	self subclassResponsibility
]

{ #category : #resources }
CADDependentLineGO class >> standardMenu [
	"MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Plot' 
				#value: #cadPlot ) ) #(1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADDependentLineGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADDependentLineGO >> aGraphicViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addPart: self menu.
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	drawingMenu addItemLabel: 'Cu&t' value: [interface cut].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #accessing }
CADDependentLineGO >> aTreeViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addItemLabel: 'Rename'
		value: [interface treeView controller inplaceEdit].
	answerMenu addLine.
	answerMenu addPart: self menu.
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	drawingMenu addItemLabel: 'Cu&t' value: [interface cut].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #accessing }
CADDependentLineGO >> cadPlot [
	self interface cadApp openPlotOn: self metaObject withSpec: #windowSpec
]

{ #category : #handles }
CADDependentLineGO >> defaultHandles [
	| rDID rDJD rIJD |
	rDID := startConstraint locator receiver rDoriginPx.
	rDJD := stopConstraint locator receiver rDoriginPx.
	rIJD := rDJD - rDID.
	^rIJD r < 5
		ifTrue: [Array with: self handleLabel]
		ifFalse: [Array
				with: self handleI
				with: self handleJ
				with: self handleLabel]
]

{ #category : #accessing }
CADDependentLineGO >> dimension [
	^1
]

{ #category : #'error handling' }
CADDependentLineGO >> doesNotUnderstand: aMessage [ 
	^self metaObject perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #accessing }
CADDependentLineGO >> geoObject: geoObject [ 
	"Trigger #release to remove old cadGO from geoObject."

	| interface markerIGO markerJGO markerIGOLocator markerJGOLocator |
	geoObject triggerEvent: #release.
	interface := geoObject interface.
	interface bindGEO: geoObject toCAD: self.
	geoObject container cadObject add: self.
	self when: #damaged do: [self container visibleAreaMergeWith: self displayBox].
	markerIGO := geoObject aMarkerI cadObject.
	markerIGO isNil
		ifTrue: 
			[markerIGO := interface createGOfor: geoObject aMarkerI.
			markerIGO updateProjection: interface projectionFrame].
	markerJGO := geoObject aMarkerJ cadObject.
	markerJGO isNil
		ifTrue: 
			[markerJGO := interface createGOfor: geoObject aMarkerJ.
			markerJGO updateProjection: interface projectionFrame].
	markerIGOLocator := GFLocator on: markerIGO at: #rDoriginPx.
	markerJGOLocator := GFLocator on: markerJGO at: #rDoriginPx.
	self start: markerIGOLocator asPoint stop: markerJGOLocator asPoint.
	self setStartConstraint: (GFPositionConstraint
			location: markerIGOLocator
			receiver: self
			sending: #constrainStartPoint:).
	self setStopConstraint: (GFPositionConstraint
			location: markerJGOLocator
			receiver: self
			sending: #constrainStopPoint:).
	markerIGO when: #damaged evaluate: self startConstraint.
	markerJGO when: #damaged evaluate: self stopConstraint
]

{ #category : #accessing }
CADDependentLineGO >> graphicsIntersecting: rDpD collectIn: set [ 
	| data depth |
	(((start rectangleWith: stop)
		expandByScalar: 4)
		containsPoint: rDpD)
		ifTrue: 
			[data := self metaObject dataIntersectLine: (self interface projectorAt: rDpD)
						tolerance: self metrePerPixel * 4.
			(data at: 1)
				ifTrue: 
					[depth := data at: 3.
					set add: self -> depth]]
]

{ #category : #handles }
CADDependentLineGO >> handleI [
	| handle |
	handle := GFHandle on: self at: #handleIposition.
	handle displayImage: (GFTextGO text: 'i').
	^handle
]

{ #category : #handles }
CADDependentLineGO >> handleIposition [
	| rDID rDJD rIJD theta dx dy |
	rDID := startConstraint locator receiver rDoriginPx.
	rDJD := stopConstraint locator receiver rDoriginPx.
	rIJD := rDJD - rDID.
	theta := rIJD theta.
	dx := (4 * theta cos) rounded.
	dy := (4 * theta sin) rounded.
	^rDID - (dx @ dy)
]

{ #category : #handles }
CADDependentLineGO >> handleJ [
	| handle |
	handle := GFHandle on: self at: #handleJposition.
	handle displayImage: (GFTextGO text: 'j').
	^handle
]

{ #category : #handles }
CADDependentLineGO >> handleJposition [
	| rDID rDJD rIJD theta dx dy |
	rDID := startConstraint locator receiver rDoriginPx.
	rDJD := stopConstraint locator receiver rDoriginPx.
	rIJD := rDJD - rDID.
	theta := rIJD theta.
	dx := (4 * theta cos) rounded.
	dy := (4 * theta sin) rounded.
	^rDJD + (dx @ dy)
]

{ #category : #handles }
CADDependentLineGO >> handleLabel: string [ 
	| handle |
	handle := GFHandle on: self at: #center.
	handle displayImage: (GFTextGO text: string).
	handle releaseAction: [self promptForFunction].
	^handle
]

{ #category : #accessing }
CADDependentLineGO >> metrePerPixel [
	^self interface metrePerPixel
]

{ #category : #display }
CADDependentLineGO >> projectOn: projectionFrame animateWith: aPen [ 
	startConstraint evaluate.
	stopConstraint evaluate.
	self displayWith: aPen
]

{ #category : #accessing }
CADDependentLineGO >> promptForFunction [
	"Do nothing."
]

{ #category : #display }
CADDependentLineGO >> quietlyUpdateProjection: projectionFrame [ 
	startConstraint evaluate.
	stopConstraint evaluate
]

{ #category : #releasing }
CADDependentLineGO >> release [
	| interface |
	interface := self interface.
	interface unbindGEO: self metaObject fromCAD: self.
	container remove: self.
	interface removeAllActionsWithReceiver: self.
	container removeAllActionsWithReceiver: self.
	super release
]

{ #category : #accessing }
CADDependentLineGO >> standardMenu [
	^self class standardMenu
]

{ #category : #display }
CADDependentLineGO >> updateProjection: projectionFrame [ 
	self damaged
]
