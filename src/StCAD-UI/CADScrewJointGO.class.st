Class {
	#name : #CADScrewJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADScrewJointGO class >> geoClass [
	^GEOScrewJoint
]

{ #category : #resources }
CADScrewJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADScrewJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADScrewJointGO >> handleLabel [
	^self handleLabel: 'scr'
]

{ #category : #accessing }
CADScrewJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADScrewDialog openOn: geoObject
]
