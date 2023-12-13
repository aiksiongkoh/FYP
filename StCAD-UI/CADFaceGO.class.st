Class {
	#name : #CADFaceGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADFaceGO class >> standardMenu [

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
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Color' #value: #aColorDialog ) )
	     #( 3 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADFaceGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADFaceGO >> aCADPartGO [
	^container aCADPartGO
]

{ #category : #accessing }
CADFaceGO >> aColor [
	^container aColor
]

{ #category : #calc }
CADFaceGO >> aColorDialog [
	self aCADPartGO aColorDialog
]

{ #category : #accessing }
CADFaceGO >> defaultHandles [
	^Array with: self tiltPartHandle with: self rotatePartHandle
]

{ #category : #accessing }
CADFaceGO >> defaultPositionHandle [
	| posHandle |
	posHandle := super defaultPositionHandle.
	posHandle releaseAction: 
			[self interface shiftDown 
				ifTrue: [self interface followPart: self metaObject part]].
	^posHandle
]

{ #category : #accessing }
CADFaceGO >> dimension [
	^2
]

{ #category : #accessing }
CADFaceGO >> geoObject: geoFace [ 
	| cadPolyline interface |
	super geoObject: geoFace.
	interface := geoFace interface.
	cadPolyline := interface createGOfor: geoFace polyline.
	cadPolyline color: self aColor.
	self when: #select
		do: 
			["There is a bug is in moveToLast. Do moveToFirst to 
			make moveToLast reliable."

			container moveToFirst.
			container moveToLast.
			self moveToFirst.
			self moveToLast.
			cadPolyline color: Color magenta.
			self solidModel ifNotNil: [:aSolidModel | aSolidModel removeDisplayList].
			cadPolyline damaged].
	self when: #deselect
		do: 
			["Transcript cr; show: 'face deselect.'."

			cadPolyline color: self aColor.
			self solidModel ifNotNil: [:aSolidModel | aSolidModel removeDisplayList].
			cadPolyline damaged].
	self hideVisibleAreaIndicator.
	self enableDefaultInteraction
]

{ #category : #calc }
CADFaceGO >> graphicsIntersecting: rDpD collectIn: set [ 
	"Select me if polyline is selected. Remove polyline selection."

	super graphicsIntersecting: rDpD collectIn: set.
	(set remove: self metaObject polyline cadObject ifAbsent: nil) notNil ifTrue: [set add: self]
]

{ #category : #accessing }
CADFaceGO >> polyline [
	^graphicObjects at: 1
]

{ #category : #calc }
CADFaceGO >> posAngDialog [
	CADPartBryantAnglesDialog openOn: self metaObject part
]

{ #category : #calc }
CADFaceGO >> positionDialog [
	CADPartDirectionDialog openOn: self metaObject part
]

{ #category : #accessing }
CADFaceGO >> positionMemento [
	"	Transcript cr; show: 'CADFaceGO>positionMemento.'."
	| geoFace partRefFrame aMemento |
	geoFace := self metaObject.
	partRefFrame := geoFace part refFrame.
	aMemento := GFMemento originator: self.
	aMemento
		addActionReceiver: partRefFrame
		selector: #rFfF:aAFf:
		arguments: (Array with: partRefFrame rFfF copy with: partRefFrame aAFf copy).
	aMemento addActionReceiver: container selector: #updateFromGEO.
	^aMemento
]

{ #category : #accessing }
CADFaceGO >> rDoriginPx [
	^self metaObject polyline refFrame rDoriginPx
]

{ #category : #accessing }
CADFaceGO >> rDvertex1Px [
	| geoPolyline rOvertex1O |
	geoPolyline := self metaObject polyline.
	rOvertex1O := geoPolyline refFrame rOpOfromrfpf: (geoPolyline rfpointsf at: 1).
	^self interface projectionFrame rDpPxfromrOpO: rOvertex1O
]

{ #category : #accessing }
CADFaceGO >> rotatePartHandle [
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
CADFaceGO >> solidModel [
	^self metaObject solidModel
]

{ #category : #accessing }
CADFaceGO >> tiltPartHandle [
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

{ #category : #accessing }
CADFaceGO >> tiltPartHandle1 [
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
					axisPF := aAFP timesFullColumn: (projectionFrame rPpPfromrDpPx: tiltVector).
					thetaF := (radialVector r / pixelPerDegree) degreesToRadians.
					newFrame := frozenPartFrame shallowCopy.
					rfcenterf := frozenPartFrame body center.
					rFcenterF := frozenPartFrame rFpFfromrfpf: rfcenterf.
					newFrame
						rotateAt: rFcenterF
						axisF: axisPF
						theta: thetaF negated.
					partFrame copyrFfFandAFfFrom: newFrame]].
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
CADFaceGO >> velocityDialog [
	CADPartVelocityDialog openOn: self metaObject part
]
