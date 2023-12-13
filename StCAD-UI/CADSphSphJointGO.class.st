Class {
	#name : #CADSphSphJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADSphSphJointGO class >> geoClass [
	^GEOSphSphJoint
]

{ #category : #resources }
CADSphSphJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADSphSphJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADSphSphJointGO >> handleLabel [
	^self handleLabel: 'sph2'
]

{ #category : #accessing }
CADSphSphJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADSphSphDialog openOn: geoObject
]
