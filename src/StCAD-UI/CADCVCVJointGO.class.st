Class {
	#name : #CADCVCVJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADCVCVJointGO class >> createNotifying: anInterface [ 
	| faceIGO ijHandle |
	faceIGO := anInterface faceGOat: anInterface cursorPoint.
	faceIGO notNil
		ifTrue: 
			[ijHandle := self ijHandleOn: faceIGO.
			ijHandle mementoType: nil.
			anInterface addHandle: ijHandle.
			self class gfCursorClass crossHair change.
			ijHandle invoke: anInterface.
			self class gfCursorClass normal change.
			anInterface removeHandle: ijHandle.
			^ijHandle cadConnection]
		ifFalse: 
			[(Dialog confirm: 'Select a face and drag to connect to another face.\Do you wish to cancel the Contact Tool?' withCRs)
				ifTrue: [anInterface setDefaultTool].
			^nil]
]

{ #category : #accessing }
CADCVCVJointGO class >> geoClass [
	^GEOCVCVJoint
]

{ #category : #handle }
CADCVCVJointGO class >> ijHandleOn: faceIGO [ 
	| ijHandle |
	ijHandle := CADConnectionHandle on: faceIGO at: #rDvertex1Px.
	ijHandle
		setFindTargetAction: 
			[:interface :point | 
			| faceGO |
			faceGO := interface faceGOat: point.
			(faceGO isNil or: [faceGO == faceIGO or: [faceGO container == faceIGO container]])
				ifTrue: [nil]
				ifFalse: [faceGO]].
	ijHandle setTargetPositionAction: [:toGO | toGO rDvertex1Px].
	ijHandle setLocatorGenerationAction: [:toGO :point | GFLocator on: toGO at: #rDvertex1Px].
	ijHandle
		setConnectAction: 
			[:startLocator :stopLocator | 
			| faceI faceJ interface assembly ijName geoIJ |
			faceI := startLocator receiver metaObject.
			faceJ := stopLocator receiver metaObject.
			interface := faceI interface.
			assembly := (faceI fullpath size <= faceJ fullpath size
						ifTrue: [faceI]
						ifFalse: [faceJ]) assembly.
			ijName := self askInterface: interface promptUserForNameIn: assembly.
			ijName isEmpty not
				ifTrue: 
					[| cadIJ |
					geoIJ := self geoClass faceI: faceI faceJ: faceJ.
					geoIJ name: ijName.
					self askAssembly: assembly add: geoIJ.
					cadIJ := interface createUpdateSelectGOfor: geoIJ.
					cadIJ promptForFunction.
					cadIJ]].
	ijHandle setConnectedAction: [:connectionGO :toGO | connectionGO interface soleSelection: connectionGO metaObject].
	^ijHandle
]

{ #category : #resources }
CADCVCVJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADCVCVJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADCVCVJointGO >> handleLabel [
	^self handleLabel: 'cvcv'
]

{ #category : #accessing }
CADCVCVJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADCVCVDialog openOn: geoObject
]
