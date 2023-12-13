Class {
	#name : #'StCAD_XYChartController',
	#superclass : #ControllerWithMenu,
	#category : #'StCAD-UI-StCAD'
}

{ #category : #resources }
StCAD_XYChartController class >> menu [

	"MenuEditor new openOnClass: self andSelector: #menu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Fit All' #value: #menuFitAll )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Zoom In' #value: #menuZoomIn )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Zoom Out' #value:
	           #menuZoomOut )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Equal Scale'
	           #nameKey: #menuEqualScaleID #value: #menuEqualScale ) )
	     #( 3 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
StCAD_XYChartController class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'initialize-release' }
StCAD_XYChartController >> initializeMenu [
	"Initialize the receiver's menu holder."

	menuHolder := self class menu asValue
]

{ #category : #'menu items' }
StCAD_XYChartController >> menu [
	| answer |
	answer := self class menu.
	(answer atNameKey: #menuEqualScaleID)
		indication: view isEqualScale.
	^answer
]

{ #category : #'menu items' }
StCAD_XYChartController >> menuEqualScale [
	view isEqualScale: view isEqualScale not.
	view invalidate
]

{ #category : #'menu items' }
StCAD_XYChartController >> menuFitAll [
	view grid x autoScale.
	view grid y autoScale.
	view invalidate
]

{ #category : #'menu items' }
StCAD_XYChartController >> menuZoomIn [
	| zoomRectScreen rPaneTLRectTLPx rPaneTLRectBRPx rDataZoom1Data rDataZoom2Data minPt maxPt xaxis yaxis |
	zoomRectScreen := Rectangle fromUser.
	rPaneTLRectTLPx := view globalPointToLocal: (zoomRectScreen origin translatedBy: view topComponent globalOrigin negated).
	rPaneTLRectBRPx := view globalPointToLocal: (zoomRectScreen corner translatedBy: view topComponent globalOrigin negated).
	rDataZoom1Data := view grid applyInverseTo: rPaneTLRectTLPx.
	rDataZoom2Data := view grid applyInverseTo: rPaneTLRectBRPx.
	minPt := rDataZoom1Data min: rDataZoom2Data.
	maxPt := rDataZoom1Data max: rDataZoom2Data.
	xaxis := view grid x.
	yaxis := view grid y.
	xaxis manualScale.
	xaxis scale autoMin: minPt x max: maxPt x.
	yaxis manualScale.
	yaxis scale autoMin: minPt y max: maxPt y.
	view invalidate
]

{ #category : #'menu items' }
StCAD_XYChartController >> menuZoomOut [
	| xaxis yaxis |
	xaxis := view grid x.
	xaxis manualScale.
	xaxis scale zoomOut.
	yaxis := view grid y.
	yaxis manualScale.
	yaxis scale zoomOut.
	view invalidate
]

{ #category : #'menu items' }
StCAD_XYChartController >> menuZoomOut1 [
	| xaxis xscale halfRange yaxis yscale |
	xaxis := view grid x.
	xaxis manualScale.
	xscale := xaxis scale.
	halfRange := xscale sourceMax - xscale sourceMin / 3.
	xscale autoMin: xscale sourceMin - halfRange max: xscale sourceMax + halfRange.
	yaxis := view grid y.
	yaxis manualScale.
	yscale := yaxis scale.
	halfRange := yscale sourceMax - yscale sourceMin / 3.
	yscale autoMin: yscale sourceMin - halfRange max: yscale sourceMax + halfRange.
	view invalidate
]
