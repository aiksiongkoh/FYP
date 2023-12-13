Class {
	#name : #CADApp,
	#superclass : #ApplicationModel,
	#instVars : [
		'adButton'
	],
	#category : #'StCAD-UI-CADApp'
}

{ #category : #documentation }
CADApp class >> docCADCoordinateSystems [
	"
	GEOItem is always in SI units (Double). 
	CADDrawing is always in pixel units (Integer). 
	Drawing origin and axes coincides with projection frame origin and axes. 
	x axis is to right. y axis is down. 
	Projection frame converts world coordinates to drawing coordinates with scale (pixelPerMetre) change 
	only. 
	ScrollArea uses positive x and y only (Integers). Therefore Drawing origin is offset from ScrollArea 
	origin. 
	Pixmap is the visible pane area. It uses positive x and y only (Integers). Therefore Drawing 
	origin is offset from Pixmap origin. 
	But Pixmap and Drawing axes coincide. 
	Drawing and pixmap use integer math only. 
	
	Transform: 
	(O) World > (P)rojectionFrame > (D)rawing > (S)crollArea 
	(O) World > (P)rojectionFrame > (D)rawing > Pixmap 
	rOpO (Double) > rPpP (Double) > rDpPx (Integer) > rSpPx (Integer). 
	rOpO is oriented and translated to rPpP. 
	rPpP is scaled only to rDpPx. 
	rDpPx is translated only to rSpPx. 
	rPpP := aAOPT*(rOpO - rOPO). 
	rDpPx := (rPpP - rPDP) / sPD := rDPD + sDP*rPpP := rPpP / sPD := sDP*rPpP. 
	rSpPx := (rDpPx - rDSPx) / sDS := rSDPx + sSD*rDpPx := (rDpPx - rDSPx) := (rSDPx + rDpPx). 
	
	Transform: 
	(S)crollArea > (D)rawing > (P)rojectionFrame > (O) World. 
	rSpPx > rDpPx > rPpP > rOpO. 
	rSpPx := displacement from ScrollArea origin to point p in ScrollArea (pixel) coordinates. 
	rSDPx := displacement from ScrollArea origin to Drawing origin in ScrollArea (pixel) coordinates. 
	rDpPx := (rSpPx - rSDPx) / sSD := rDSPx + sDS*rSpPx := rSpPx - rSDPx := rDSPx + rSpPx. 
	rPpP := (rDpPx - rDPD) / sDP := rPDP + sPD*rDpPx := rDpPx / sDP := sPD*rDpPx. 
	With an arbitrary zPpP: 
	rOpO := rOPO + aAOP*rPpP 
	"

	self commentOnly
]

{ #category : #documentation }
CADApp class >> docCADCoordinateSystems1 [
	"
	GEOItem is always in SI units (Double). 
	CADDrawing is always in pixel units (Integer). 
	Drawing origin and axes coincides with projection frame origin and axes. 
	x axis is to right. y axis is down. 
	Projection frame converts world coordinates to drawing coordinates with scale (pixelPerMetre) change 
	only. 
	CADPixmap uses positive x and y only (Integers). Therefore Drawing origin is offset from Pixmap 
	origin. 
	But Pixmap and Drawing axes coincide. 
	Drawing and pixmap use integer math only. 
	
	Transform: 
	(O) World > (P)rojectionFrame > (D)rawing > (S)creen 
	rOpO (Double) > rPpP (Double) > rDpD (Integer) > rSpS (Integer). 
	rOpO is oriented and translated to rPpP. 
	rPpP is scaled only to rDpD. 
	rDpD is translated only to rSpS. 
	rPpP := aAOPT*(rOpO - rOPO). 
	rDpD := (rPpP - rPDP) / sPD := rDPD + sDP*rPpP := rPpP / sPD := sDP*rPpP. 
	rSpS := (rDpD - rDSD) / sDS := rSDS + sSD*rDpD := (rDpD - rDSD) := (rSDS + rDpD). 
	
	Transform: 
	(S)creen > (D)rawing > (P)rojectionFrame > (O) World. 
	rSpS > rDpD > rPpP > rOpO. 
	rSpS := displacement from Screen origin to point p in Screen (pixel) coordinates. 
	rSDS := displacement from Screen origin to Drawing origin in Screen (pixel) coordinates. 
	rDpD := (rSpS - rSDS) / sSD := rDSD + sDS*rSpS := rSpS - rSDS := rDSD + rSpS. 
	rPpP := (rDpD - rDPD) / sDP := rPDP + sPD*rDpD := rDpD / sDP := sPD*rDpD. 
	With an arbitrary zPpP: 
	rOpO := rOPO + aAOP*rPpP 
	"

	self commentOnly
]

{ #category : #documentation }
CADApp class >> docGEOCoordinateSystems [
	"
	GEOItem is always in SI units (Double). 
	
	Transform: 
	(O) World > (A) Assembly > (P) Part > (Sk) Sketch > (G) Graphics > (E) GraphicElement 
	(O) World > (A) Assembly > (P) Part > (Sk) Sketch > GEOLine 

	(O) World > (A) Assembly > (P) Part > (G) Graphics > (E) GraphicElement 
	(O) World > (A) Assembly > (P) Part > GEOLine 
	
	"

	self commentOnly
]

{ #category : #documentation }
CADApp class >> docPrinciples [
	"
	Create part. 
	_ Insert sketch. 
	_ _ Line, polyline, circle. 
	_ _ Variational constraints on graphic elements. 
	_ Extrude or revolve. 
	"
	"
	Create assembly. 
	_ Insert parts and/or assemblys. 
	_ Create additional parts and/or assemblys. 
	_ Assembly constraints on parts. 
	_ Do dynamics. 
	_ _ Add masses, moment of inertias, motions, forces. 
	_ _ Add integration parameters. 
	_ _ Simulate, animate, plot. 
	"

	self commentOnly
]

{ #category : #documentation }
CADApp class >> docTiltAndRotate [
	"
	Tilt is the angle away from the normal to the screen. 
	Rotate is the spin about the normal to the screen. 
	Where to select the pivot point? 
	_ Origin of world frame, assembly frame, part frame, sketch frame or element frame. 
	_ Center of 3D object. 
	_ User selected corner. 
	When pivot point is selected: 
	_ Pan screen to so that pivot point is at center of screen. 
	_ For tilt: 
	_ _ Initialize a handle over pivot point. 
	_ _ Draw concentric circles for 90deg and 180deg. 
	_ _ Tilt away from pivot point in direction of cursor. 
	_ For rotate: 
	_ _ Draw reference line from pivot and parallel to x axis. 
	_ _ Initialize a handle at a point on the reference line. 
	_ _ Counter clockwise is positive. 
	
	Rotate frame f to f'. Let 
	rFpvF := pivot point in reference frame (F) of f. 
	n := direction of rotation axis. 
	theta := right rotation about n. 
	Define euler parameters: 
	E1 := nx*sin(theta/2). 
	E2 := ny*sin(theta/2). 
	E3 := nz*sin(theta/2). 
	E4 := cos(theta/2). 
	Form transformation matrix aAff' from euler parameters. 
	rFfF := origin of f before rotation. 
	rFf'F := origin of f after rotation. 
	rFf'F := rFfvF + aAff'T*(rFfF - rFpvF). 
	aAOf' := aAOf*aAff' 
	"

	self commentOnly
]

{ #category : #documentation }
CADApp class >> readMe [
	"
	CADApp is an attempt to bring 3D CAD capabilities to Smalltalk. It can then be the front end of 
	many engineering/scientific applications. 
	
	I will enhance and document based on user feedback. Please email your comments and 
	improvements to me. 
	
	Sincerely, 
	Aik-Siong Koh 
	askoh@alumni.princeton.edu 
	"

	self commentOnly
]

{ #category : #'VisualWorks metadata' }
CADApp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #ad }
CADApp >> adButton [
	^adButton
]

{ #category : #ad }
CADApp >> adOpportunity [
	self changeAdxxxBy32.
	self changeAdTitle
]

{ #category : #ad }
CADApp >> adTitle [
	^AdData adTitle title
]

{ #category : #'initialize-release' }
CADApp >> adaptorFor: aspect [ 
	^(AspectAdaptor subjectChannel: self subject)
		forAspect: aspect
]

{ #category : #ad }
CADApp >> changeAdTitle [
	"Do nothing."
]

{ #category : #ad }
CADApp >> changeAdxxxBy32 [
	adButton changeAdxxxBy32
]

{ #category : #'initialize-release' }
CADApp >> initialize [
	super initialize.
	adButton := AdButton new
]

{ #category : #binding }
CADApp >> labelFor: aKey [ 
	"Return an instance of a non-abstract subclass of CharacterArray, 
	that will be used as a label for a widget. Check the label registry 
	if no implementation has been provided."

	^[self perform: aKey]
		on: self application messageNotUnderstoodSignal
		do: 
			[:ex | 
			| sel |
			sel := ex parameter selector.
			sel == aKey
				ifTrue: [ex return: (self application labelFor: aKey)]
				ifFalse: [ex pass]]
]

{ #category : #validation }
CADApp >> validateDouble: aController [ 
	| array |
	array := #(-1.0d100 #< #double #< 1.0d100) copy.
	array at: 3 put: aController.
	^self validateDoubleWithArguments: array
]

{ #category : #validation }
CADApp >> validateDoubleGreaterThanZero: aController [ 
	| array |
	array := #(0.0d #< #double #< 1.0d100) copy.
	array at: 3 put: aController.
	^self validateDoubleWithArguments: array
]

{ #category : #validation }
CADApp >> validateDoubleWithArguments: array [ 
	| lowerLimit lowerOp aController upperOp upperLimit entry |
	lowerLimit := array at: 1.
	lowerOp := array at: 2.
	aController := array at: 3.
	upperOp := array at: 4.
	upperLimit := array at: 5.
	(aController hasEditValue
		and: 
			[entry := aController editValue.
			entry isKindOf: Number])
		ifTrue: 
			[entry := entry asPrettyDouble.
			aController selectEntireText; deselect; replaceSelectionWith: entry printString; select]
		ifFalse: 
			[aController selectEntireText.
			Dialog warn: 'Enter a number like -5 or -5.5 or -55.555d-55.'.
			^false].
	(lowerLimit perform: lowerOp with: entry)
		& (entry perform: upperOp with: upperLimit)
		ifFalse: 
			[aController selectEntireText.
			Dialog warn: ('Enter a number such that <n><1p> <2s> number <4s> <5p> ' expandMacrosWithArguments: array).
			^false].
	^true
]

{ #category : #validation }
CADApp >> validateDoubleZeroAndGreater: aController [ 
	| array |
	array := #(0.0d #<= #double #< 1.0d100) copy.
	array at: 3 put: aController.
	^self validateDoubleWithArguments: array
]

{ #category : #validation }
CADApp >> validateIntegerWithArguments: array [ 
	| lowerLimit lowerOp aController upperOp upperLimit entry |
	lowerLimit := array at: 1.
	lowerOp := array at: 2.
	aController := array at: 3.
	upperOp := array at: 4.
	upperLimit := array at: 5.
	(aController hasEditValue
		and: 
			[entry := aController editValue.
			entry isInteger])
		ifFalse: 
			[Dialog warn: 'Enter an integer.'.
			^false].
	(lowerLimit perform: lowerOp with: entry)
		& (entry perform: upperOp with: upperLimit)
		ifFalse: 
			[Dialog warn: 'Enter an integer such that ' , lowerLimit printString , ' ' , lowerOp , ' integer ' , upperOp , ' ' , upperLimit printString , '.'.
			^false].
	^true
]

{ #category : #binding }
CADApp >> visualFor: aKey [ 
	"Return an instance of any non-abstract subclass of 
	VisualComponent (in practice usually either ComposedText or 
	Image) for use as a label for a widget."

	^[self perform: aKey]
		on: self application messageNotUnderstoodSignal
		do: 
			[:ex | 
			| sel |
			sel := ex parameter selector.
			sel == aKey
				ifTrue: [ex return: (self application visualFor: aKey)]
				ifFalse: [ex pass]]
]
