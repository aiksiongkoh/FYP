Class {
	#name : #CADRevCylJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADRevCylJointGO class >> geoClass [
	^GEORevCylJoint
]

{ #category : #resources }
CADRevCylJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADRevCylJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADRevCylJointGO >> handleLabel [
	^self handleLabel: 'rvcy'
]

{ #category : #accessing }
CADRevCylJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADRevCylDialog openOn: geoObject
]
