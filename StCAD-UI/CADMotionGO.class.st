Class {
	#name : #CADMotionGO,
	#superclass : #CADDependentLineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADMotionGO class >> askAssembly: assembly add: geoIJ [ 
	assembly addMotion: geoIJ
]

{ #category : #accessing }
CADMotionGO class >> askInterface: interface promptUserForNameIn: assembly [ 
	^interface promptUserForMotionNameIn: assembly
]

{ #category : #resources }
CADMotionGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADMotionGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]
