Class {
	#name : #ForceTorqueItemGO,
	#superclass : #CADDependentLineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
ForceTorqueItemGO class >> askAssembly: assembly add: geoIJ [ 
	assembly addForceTorque: geoIJ
]

{ #category : #accessing }
ForceTorqueItemGO class >> askInterface: interface promptUserForNameIn: assembly [ 
	^interface promptUserForForceTorqueNameIn: assembly
]

{ #category : #resources }
ForceTorqueItemGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
ForceTorqueItemGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'initialize-release' }
ForceTorqueItemGO >> initialize [
	"Private - Initialize to default values"

	super initialize.
	width := 2
]
