Class {
	#name : #CADCylSphJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADCylSphJointGO class >> geoClass [
	^GEOCylSphJoint
]

{ #category : #resources }
CADCylSphJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADCylSphJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADCylSphJointGO >> handleLabel [
	^self handleLabel: 'cysh'
]

{ #category : #accessing }
CADCylSphJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADCylSphDialog openOn: geoObject
]
