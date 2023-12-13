Class {
	#name : #CADRotationalMotionGO,
	#superclass : #CADMotionOnJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADRotationalMotionGO class >> findJointIn: anInterface [ 
	^anInterface zRotationalJointAt: anInterface cursorPoint
]

{ #category : #accessing }
CADRotationalMotionGO class >> geoClass [
	^GEORotationalMotion
]

{ #category : #'instance creation' }
CADRotationalMotionGO class >> issueWarning: interface [ 
	(Dialog confirm: 'Select a Revolute or Cylindrical joint.\Do you wish to cancel the Motion Tool?' withCRs)
		ifTrue: [interface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
CADRotationalMotionGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADRotationalMotionGO >> handleLabel [
	^self handleLabel: 'rmo'
]

{ #category : #accessing }
CADRotationalMotionGO >> phiIJ [
	| cadUnits phiIJ geoTime phiIJ1 set |
	cadUnits := self cadUnits.
	phiIJ := self metaObject phiIJ.
	^phiIJ isNil
		ifTrue: [BasicUserFunction
				with: ''
				myUnit: cadUnits angle
				units: cadUnits]
		ifFalse: [phiIJ isUserFunction
				ifTrue: [phiIJ]
				ifFalse: 
					["For backward compatibility"
					geoTime := self geoTime.
					phiIJ1 := (phiIJ substitute: geoTime with: geoTime / cadUnits time)
								/ cadUnits angle.
					set := Set new.
					set add: geoTime.
					phiIJ1 := phiIJ1 expandUntil: set.
					phiIJ1 := phiIJ1 simplifyUntil: set.
					BasicUserFunction
						with: phiIJ1 cadString
						myUnit: cadUnits angle
						units: cadUnits]]
]

{ #category : #all }
CADRotationalMotionGO >> promptForFunction [
	RotationZDialog openOn: self.
]
