Class {
	#name : #CADPartGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADPartGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Position' #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Direction'
	                    #value: #positionDialog )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Angle' #value:
	                    #posAngDialog ) )
	              #( 2 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Velocity' #value:
	           #velocityDialog )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Color' #value: #aColorDialog )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Size' #value: #aSizeDialog ) )
	     #( 4 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADPartGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADPartGO >> aCADPartGO [
	^self
]

{ #category : #accessing }
CADPartGO >> aColor [
	^self metaObject aColor
]

{ #category : #calc }
CADPartGO >> aColorDialog [
	| geoObject aColor dialogResponse |
	geoObject := self metaObject.
	aColor := geoObject aColor.
	dialogResponse := CADColorDialog openOn: aColor.
	dialogResponse 
		ifTrue: 
			[geoObject removeDisplayList.
			self damaged]
]

{ #category : #calc }
CADPartGO >> aSizeDialog [
	| magnification geoObject |
	magnification := Dialog prompt: 'Magnify Part by'
				defaultExpression: 1.0d printString.
	magnification isNil ifTrue: [^self].
	(magnification isReal and: [magnification positive]) 
		ifTrue: 
			[magnification ~= 1 
				ifTrue: 
					[geoObject := self metaObject.
					geoObject magnifySelf: magnification asDouble.
					self damaged.
					self interface cadApp menuViewRegen]]
		ifFalse: [Dialog warn: 'Magnification must be a positive number.']
]

{ #category : #accessing }
CADPartGO >> defaultHandles [
	| answer |
	answer := OrderedCollection new: 10.
	answer add: (self positionHandleAt: #topLeft).
	answer add: (self positionHandleAt: #topRight).
	answer add: (self positionHandleAt: #bottomLeft).
	answer add: (self positionHandleAt: #bottomRight).
	answer add: self tiltPartHandle.
	answer add: self rotatePartHandle.
	^answer
]

{ #category : #accessing }
CADPartGO >> defaultHandles1 [
	^(super defaultHandles) add: self defaultPositionHandle; yourself
]

{ #category : #accessing }
CADPartGO >> dimension [
	^3
]

{ #category : #accessing }
CADPartGO >> geoObject: geoPart [ 
	| interface block |
	super geoObject: geoPart.
	interface := geoPart interface.
	block := [:item | interface createGOfor: item].
	geoPart solidModel ifNotNil: block.
	geoPart massMarker ifNotNil: block.
	geoPart markers do: block.
	geoPart aDXFBLOCK ifNotNil: block.
	geoPart aNMT ifNotNil: block
]

{ #category : #calc }
CADPartGO >> posAngDialog [
	CADPartBryantAnglesDialog openOn: self metaObject
]

{ #category : #calc }
CADPartGO >> positionDialog [
	CADPartDirectionDialog openOn: self metaObject
]

{ #category : #accessing }
CADPartGO >> positionHandleAt: symbol [ 
	| posHandle |
	posHandle := super positionHandleAt: symbol.
	posHandle releaseAction: 
			[self interface shiftDown 
				ifTrue: [self interface followPart: self metaObject part]].
	^posHandle
]

{ #category : #accessing }
CADPartGO >> positionMemento [
	"	Transcript cr; show: 'CADPartGO>positionMemento.'."

	| partRefFrame aMemento |
	partRefFrame := self metaObject refFrame.
	aMemento := GFMemento originator: self.
	aMemento
		addActionReceiver: partRefFrame
		selector: #rFfF:aAFf:
		arguments: (Array with: partRefFrame rFfF copy with: partRefFrame aAFf copy).
	aMemento addActionReceiver: container selector: #updateFromGEO.
	^aMemento
]

{ #category : #accessing }
CADPartGO >> releaseSolidModel [
	| cadSolidModel |
	cadSolidModel := graphicObjects detect: [:cad | cad isSolidModel]
				ifNone: nil.
	cadSolidModel notNil ifTrue: [cadSolidModel release]
]

{ #category : #accessing }
CADPartGO >> rotatePartHandle [
	"
	Show rotate handle at 100@0 from part center. 
	Draw line from center to right as reference. 
	Track mouse, use angle from center to cursor and reference for rotation. 
	The F frame is the frame supporting the part refFrame. 
	It is either an assembly refFrame or the world frame. 
	"
	| aPartFrame projectionFrame aAOP rotateHandle lines block compositeGO |
	aPartFrame := self metaObject part refFrame.
	projectionFrame := aPartFrame interface projectionFrame.
	aAOP := projectionFrame aAOf.
	rotateHandle := CADTrackHandle on: aPartFrame at: #rDbodycenterPx.
	rotateHandle hotSpot: [:handle | handle origin + (100 @ 0).].
	rotateHandle setSense: nil
		change: 
			[:partFrame :frozenPartFrame :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx |
			| radialVector zP aAFP axiszPF thetaF newFrame rfcenterf rFcenterF |
			radialVector := 100 @ 0 + rDnewPx - rDfirstPx.
			radialVector isZero
				ifFalse: 
					[zP := FullColumn with: 0.0d with: 0.0d with: 1.0d.
					aAFP := frozenPartFrame aAOF transpose timesFullMatrix: aAOP.
					axiszPF := aAFP timesFullColumn: zP.
					thetaF := radialVector theta asDouble.
					newFrame := frozenPartFrame copy.
					rfcenterf := frozenPartFrame body center.
					rFcenterF := frozenPartFrame rFpFfromrfpf: rfcenterf.
					newFrame rotateAt: rFcenterF axisF: axiszPF theta: thetaF.
					partFrame copyrFfFandAFfFrom: newFrame.
					self interface shiftDown
						ifTrue: [self interface followPart: self metaObject part.].].].
	rotateHandle releaseAction: 
			[self interface shiftDown
				ifTrue: [self interface followPart: self metaObject part.].].
	rotateHandle mementoType: #positionMemento.
	rotateHandle description: 'rotate world'.
	lines := OrderedCollection new.
	block :=
			[:deg |
			| radius theta tip lineGO |
			radius := 100.
			theta := deg negated asDouble degreesToRadians.
			tip := (Point r: radius theta: theta) rounded.
			lineGO := CADLineGO start: 0 @ 0 stop: tip.
			lines addLast: lineGO.].
	block value: 0.
	compositeGO := GFCompositeGO graphicObjects: lines.
	compositeGO hideVisibleAreaIndicator.
	compositeGO disableInteraction.
	rotateHandle displayImage: compositeGO.
	^rotateHandle.
]

{ #category : #accessing }
CADPartGO >> tiltPartHandle [
	"
	Show tilt handle at center of part. 
	Draw circles for 90deg and 180deg tilt away from screen normal. 
	Track mouse, use vector from center to cursor for tilt direction and magnitude. 
	The F frame is the frame supporting the part refFrame. 
	It is either an assembly refFrame or the world frame. 
	"

	| aPartFrame projectionFrame aAOP tiltHandle pixelPerDegree |
	aPartFrame := self metaObject part refFrame.
	projectionFrame := aPartFrame interface projectionFrame.
	aAOP := projectionFrame aAOf.
	tiltHandle := CADTrackHandle on: aPartFrame at: #rDbodycenterPx.
	tiltHandle hotSpot: [:handle | handle origin].
	pixelPerDegree := 1.0d.
	tiltHandle setSense: nil
		change: 
			[:partFrame :frozenPartFrame :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx | 
			| radialVector tiltVector aAFP axisPF thetaF newFrame rfcenterf rFcenterF |
			radialVector := rDnewPx - rDfirstPx.
			radialVector isZero 
				ifFalse: 
					[tiltVector := radialVector y negated @ radialVector x.
					aAFP := frozenPartFrame aAOF transpose timesFullMatrix: aAOP.
					axisPF := aAFP 
								timesFullColumn: (projectionFrame rPpPfromrDpPx: tiltVector).
					thetaF := (radialVector r / pixelPerDegree) degreesToRadians.
					newFrame := frozenPartFrame shallowCopy.
					rfcenterf := frozenPartFrame body center.
					rFcenterF := frozenPartFrame rFpFfromrfpf: rfcenterf.
					newFrame 
						rotateAt: rFcenterF
						axisF: axisPF
						theta: thetaF negated.
					partFrame copyrFfFandAFfFrom: newFrame.
					self interface shiftDown 
						ifTrue: [self interface followPart: self metaObject part]]].
	tiltHandle releaseAction: 
			[self interface shiftDown 
				ifTrue: [self interface followPart: self metaObject part]].
	tiltHandle mementoType: #positionMemento.
	tiltHandle description: 'tilt world'.	"	circles := OrderedCollection new. 
	block := 
	[:deg | 
	| radius rect ellipse string text | 
	radius := (deg * pixelPerDegree) rounded. 
	rect := radius negated @ radius negated corner: radius @ radius. 
	ellipse := GFEllipseGO ellipse: rect. 
	ellipse fillColor: nil. 
	ellipse disableInteraction. 
	circles addLast: ellipse. 
	string := deg asString , 'deg'. 
	text := GFTextGO text: string. 
	text translateBy: 0 @ radius. 
	text disableInteraction. 
	circles addLast: text]. 
	block value: 90. 
	block value: 180. 
	compositeGO := GFCompositeGO graphicObjects: circles. 
	compositeGO hideVisibleAreaIndicator. 
	compositeGO disableInteraction. 
	tiltHandle displayImage: compositeGO. 
	"
	^tiltHandle
]

{ #category : #calc }
CADPartGO >> velocityDialog [
	CADPartVelocityDialog openOn: self metaObject
]
