Class {
	#name : #CADKineIJGO,
	#superclass : #CADDependentLineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADKineIJGO class >> askAssembly: assembly add: geoIJ [ 
	assembly addKineIJ: geoIJ
]

{ #category : #accessing }
CADKineIJGO class >> askInterface: interface promptUserForNameIn: assembly [ 
	^interface promptUserForKineIJNameIn: assembly
]

{ #category : #accessing }
CADKineIJGO class >> geoClass [
	^GEOKineIJ
]

{ #category : #handle }
CADKineIJGO class >> ijHandleOn: markerIGO [ 
	| ijHandle |
	ijHandle := CADConnectionHandle on: markerIGO at: #rDoriginPx.
	ijHandle setFindTargetAction: 
			[:interface :point | 
			| markerGO |
			markerGO := interface markerGOat: point.
			(markerGO isNil or: [markerGO == markerIGO]) 
				ifTrue: [nil]
				ifFalse: [markerGO]].
	ijHandle setTargetPositionAction: [:toGO | toGO rDoriginPx].
	ijHandle 
		setLocatorGenerationAction: [:toGO :point | GFLocator on: toGO at: #rDoriginPx].
	ijHandle setConnectAction: 
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
	ijHandle setConnectedAction: 
			[:connectionGO :toGO | 
			connectionGO interface soleSelection: connectionGO metaObject].
	^ijHandle
]

{ #category : #'instance creation' }
CADKineIJGO class >> issueWarning: anInterface [ 
	(Dialog confirm: 'Select a marker and drag to connect to another marker.\Do you wish to cancel the KinematicIJ Tool?' withCRs)
		ifTrue: [anInterface setDefaultTool]
]

{ #category : #handle }
CADKineIJGO class >> kineIJHandleOn: markerIGO [ 
	| kineIJHandle |
	kineIJHandle := CADConnectionHandle on: markerIGO at: #rDoriginPx.
	kineIJHandle
		setFindTargetAction: 
			[:interface :point | 
			| markerGO |
			markerGO := interface markerGOat: point.
			(markerGO isNil or: [markerGO == markerIGO])
				ifTrue: [nil]
				ifFalse: [markerGO]].
	kineIJHandle setTargetPositionAction: [:toGO | toGO rDoriginPx].
	kineIJHandle setLocatorGenerationAction: [:toGO :point | GFLocator on: toGO at: #rDoriginPx].
	kineIJHandle
		setConnectAction: 
			[:startLocator :stopLocator | 
			| markerI markerJ interface assembly kineIJName geoKineIJ |
			markerI := startLocator receiver metaObject.
			markerJ := stopLocator receiver metaObject.
			interface := markerI interface.
			assembly := (markerI fullpath size <= markerJ fullpath size
						ifTrue: [markerI]
						ifFalse: [markerJ]) assembly.
			kineIJName := interface promptUserForKineIJNameIn: assembly.
			kineIJName isEmpty not
				ifTrue: 
					[geoKineIJ := self geoClass markerI: markerI markerJ: markerJ.
					geoKineIJ name: kineIJName.
					assembly addKineIJ: geoKineIJ.
					interface createUpdateSelectGOfor: geoKineIJ.
					geoKineIJ cadObject]].
	kineIJHandle setConnectedAction: [:connectionGO :toGO | connectionGO interface soleSelection: connectionGO metaObject].
	^kineIJHandle
]

{ #category : #'VisualWorks metadata' }
CADKineIJGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADKineIJGO >> handleLabel [
	^self handleLabel: 'kin'
]
