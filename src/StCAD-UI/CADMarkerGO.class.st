Class {
	#name : #CADMarkerGO,
	#superclass : #CADFrameGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADMarkerGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Position' #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Direction'
	                    #value: #positionDialog )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Angle' #value:
	                    #posAngDialog )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Rotate'
	                    #value: #rotateDialog ) )
	              #( 3 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'PositionPart'
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Direction' #value: #positionPartDialog )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Angle' #value:
	                    #posAnglePartDialog ) )
	              #( 2 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Velocity' #value:
	           #velocityDialog )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #cadPlot )
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
	              #( 3 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Size' #value: #aSizeDialog ) )
	     #( 6 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADMarkerGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADMarkerGO >> aSizeDialog [
	self interface editMarkerSize
]

{ #category : #accessing }
CADMarkerGO >> defaultHandles [
	^Array with: self defaultPositionHandle
]

{ #category : #accessing }
CADMarkerGO >> defaultHandles1 [
	^Array with: self rotateAboutZHandle
]

{ #category : #calc }
CADMarkerGO >> posAngDialog [
	CADMarkerBryantAnglesDialog openOn: self metaObject
]

{ #category : #calc }
CADMarkerGO >> posAnglePartDialog [
	CADPartViaMarkerBryantAnglesDialog openOn: self metaObject
]

{ #category : #calc }
CADMarkerGO >> positionDialog [
	CADMarkerDirectionDialog openOn: self metaObject
]

{ #category : #accessing }
CADMarkerGO >> positionMemento [
	"	Transcript cr; show: 'CADFaceGO>positionMemento.'."

	| geoMarker markerRefFrame aMemento |
	geoMarker := self metaObject.
	markerRefFrame := geoMarker refFrame.
	aMemento := GFMemento originator: self.
	aMemento
		addActionReceiver: markerRefFrame
		selector: #rFfF:aAFf:
		arguments: (Array with: markerRefFrame rFfF copy with: markerRefFrame aAFf copy).
	aMemento addActionReceiver: container selector: #updateFromGEO.
	^aMemento
]

{ #category : #calc }
CADMarkerGO >> positionPartDialog [
	CADPartViaMarkerDirectionDialog openOn: self metaObject
]

{ #category : #accessing }
CADMarkerGO >> rDoriginPx1 [
	| geo rOoriginO |
	geo := self metaObject.
	rOoriginO := geo refFrame rOfO.
	^self interface projectionFrame rDpPxfromrOpO: rOoriginO
]

{ #category : #accessing }
CADMarkerGO >> rotateAboutZHandle [
	"Rotate marker about its z axis depending on screen x displacement."

	| aMarkerFrame rotateHandle degreePerPixel unitz |
	aMarkerFrame := self metaObject refFrame.
	unitz := (FullColumn zero: 3).
	unitz at: 3 put: axisLength.
	rotateHandle := CADTrackHandle
				on: aMarkerFrame
				at: #rDpPxfromrfpf:
				with: unitz.
	rotateHandle hotSpot: [:handle | handle origin].
	degreePerPixel := 1.0d.
	rotateHandle setSense: nil
		change: 
			[:bMarkerFrame :frozenMarkerFrame :rDoriginD :rDfirstD :rDoldD :rDnewD | 
			| radialVector axiszfF theta newFrame |
			radialVector := rDnewD - rDfirstD.
			radialVector isZero
				ifFalse: 
					[axiszfF := frozenMarkerFrame aAFf column: 3.
					theta := radialVector x * degreePerPixel degreesToRadians.
					newFrame := frozenMarkerFrame copy.
					newFrame
						rotateAt: frozenMarkerFrame rFfF
						axisF: axiszfF
						theta: theta.
					bMarkerFrame copyrFfFandAFfFrom: newFrame]].
	rotateHandle mementoType: #positionMemento.
	rotateHandle description: 'rotate about z'.
	^rotateHandle
]

{ #category : #calc }
CADMarkerGO >> rotateDialog [
	| array axisf theta markerRefFrame |
	axisf := 3.
	theta := 90.0d.
	array := Array with: axisf with: theta.
	(CADRotateMarkerDialog openOn: array)
		ifTrue: 
			[axisf := array at: 1.
			theta := (array at: 2) degreesToRadians.
			markerRefFrame := self geoRefFrame.
			markerRefFrame rotateAxisf: axisf theta: theta.
			self updateFromGEO]
]

{ #category : #calc }
CADMarkerGO >> velocityDialog [
	CADMarkerVelocityDialog openOn: self metaObject
]
