Class {
	#name : #CADAngleJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADAngleJointGO class >> geoClass [
	^GEOAngleJoint
]

{ #category : #resources }
CADAngleJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADAngleJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADAngleJointGO >> handleLabel [
	^self handleLabel: 'ang'
]

{ #category : #accessing }
CADAngleJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADAngleDialog openOn: geoObject
]
