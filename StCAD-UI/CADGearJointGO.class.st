Class {
	#name : #CADGearJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADGearJointGO class >> geoClass [
	^GEOGearJoint
]

{ #category : #resources }
CADGearJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADGearJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADGearJointGO >> handleLabel [
	^self handleLabel: 'gear'
]

{ #category : #accessing }
CADGearJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADGearDialog openOn: geoObject
]
