Class {
	#name : #CADRackPinJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADRackPinJointGO class >> geoClass [
	^GEORackPinJoint
]

{ #category : #resources }
CADRackPinJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADRackPinJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADRackPinJointGO >> handleLabel [
	^self handleLabel: 'rpn'
]

{ #category : #handles }
CADRackPinJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADRackPinDialog openOn: geoObject
]
