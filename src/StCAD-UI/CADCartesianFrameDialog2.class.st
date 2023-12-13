Class {
	#name : #CADCartesianFrameDialog2,
	#superclass : #CADDialog,
	#instVars : [
		'geoItem',
		'refFrame',
		'guideFrame',
		'rGfGx',
		'rGfGy',
		'rGfGz'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'instance creation' }
CADCartesianFrameDialog2 class >> openOn: geoItem [ 
	^self openOn: geoItem withSpec: #windowSpec
]

{ #category : #'instance creation' }
CADCartesianFrameDialog2 class >> openOn: geoItem withSpec: aSymbol [ 
	| newDialog |
	newDialog := super new.
	newDialog geoItem value: geoItem.
	newDialog refFrame value: geoItem refFrame.
	newDialog guideFrame value: geoItem guideFrame.
	^newDialog openInterface: aSymbol
]

{ #category : #'VisualWorks metadata' }
CADCartesianFrameDialog2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADCartesianFrameDialog2 >> adaptorrGfGat: i [ 
	| plugAdap rGfG |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			rGfG := guideFrame value rfpffromrOpO: refFrame value rOfO.
			rGfG at: i]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #private }
CADCartesianFrameDialog2 >> closeAccept [
	accept value ifTrue: [(self requestForWindowClose and: [self hasInputValid])
			ifTrue: 
				[self updateDomainObjects.
				close value: true.
				builder window checkForEvents]
			ifFalse: [accept value: false]]
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> geoItem [
	^geoItem
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> guideFrame [
	^guideFrame
]

{ #category : #'initialize-release' }
CADCartesianFrameDialog2 >> initialize [
	super initialize.
	geoItem := nil asValue.
	refFrame := nil asValue.
	guideFrame := nil asValue.
	rGfGx := self adaptorrGfGat: 1.
	rGfGy := self adaptorrGfGat: 2.
	rGfGz := self adaptorrGfGat: 3
]

{ #category : #'interface opening' }
CADCartesianFrameDialog2 >> postBuildWith: aBuilder [ 
	aBuilder window label: self dialogTitle
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> rGfGx [
	^rGfGx
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> rGfGy [
	^rGfGy
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> rGfGz [
	^rGfGz
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> refFrame [
	^refFrame
]

{ #category : #accessing }
CADCartesianFrameDialog2 >> subject [
	^geoItem
]
