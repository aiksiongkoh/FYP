Class {
	#name : #CADCurveMarkerGO,
	#superclass : #CADFrameGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADCurveMarkerGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Plot' #value: #cadPlot )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Trace' #enabled:
	           false #hidden: true #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Position'
	                    #nameKey: #tracePositonID #value: #tracePositon
	                    #indication: false )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Velocity'
	                    #nameKey: #traceVelocityID #value: #traceVelocity
	                    #indication: false )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Acceleration'
	                    #nameKey: #traceAccelerationID
	                    #value: #traceAcceleration #indication:
	                    false ) )
	              #( 3 ) nil ) ) )
	     #( 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADCurveMarkerGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADCurveMarkerGO >> geoObject: geoMarker [ 
	| cadCurve |
	super geoObject: geoMarker.
	cadCurve := geoMarker interface createGOfor: geoMarker rFfFCurve.
	cadCurve color: Color cyan copy.
	self disableHandles.
	self disablePositionHandle
]

{ #category : #calc }
CADCurveMarkerGO >> projectOn: projectionFrame animateWith: aPen [ 
	super basicUpdateProjection: projectionFrame.
	(graphicObjects at: 4)
		basicUpdateProjection: projectionFrame.
	graphicObjects do: [:each | each displayWith: aPen]
]

{ #category : #calc }
CADCurveMarkerGO >> quietlyUpdateProjection: projectionFrame [ 
	super basicUpdateProjection: projectionFrame.
	(graphicObjects at: 4)
		quietlyUpdateProjection: projectionFrame.
	self quietlyResetVisibleArea
]

{ #category : #calc }
CADCurveMarkerGO >> updateProjection: projectionFrame [ 
	super basicUpdateProjection: projectionFrame.
	(graphicObjects at: 4)
		updateProjection: projectionFrame.
	self resetVisibleArea
]
