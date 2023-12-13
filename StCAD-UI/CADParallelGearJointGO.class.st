Class {
	#name : #CADParallelGearJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADParallelGearJointGO class >> geoClass [
	^GEOParallelGearJoint
]

{ #category : #resources }
CADParallelGearJointGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #promptForFunction )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADParallelGearJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADParallelGearJointGO >> handleLabel [
	^self handleLabel: 'gear'
]

{ #category : #accessing }
CADParallelGearJointGO >> promptForFunction [
	| geoObject |
	geoObject := self metaObject.
	CADParallelGearDialog openOn: geoObject
]
