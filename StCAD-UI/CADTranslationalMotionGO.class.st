Class {
	#name : #CADTranslationalMotionGO,
	#superclass : #CADMotionOnJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADTranslationalMotionGO class >> findJointIn: anInterface [ 
	^anInterface zTranslationalJointAt: anInterface cursorPoint
]

{ #category : #accessing }
CADTranslationalMotionGO class >> geoClass [
	^GEOTranslationalMotion
]

{ #category : #'instance creation' }
CADTranslationalMotionGO class >> issueWarning: interface [ 
	(Dialog confirm: 'Select a Translational or Cylindrical joint.\Do you wish to cancel the Motion Tool?' withCRs)
		ifTrue: [interface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
CADTranslationalMotionGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADTranslationalMotionGO >> handleLabel [
	^self handleLabel: 'tmo'
]

{ #category : #all }
CADTranslationalMotionGO >> promptForFunction [
	TranslationZDialog openOn: self.
]

{ #category : #accessing }
CADTranslationalMotionGO >> zIJ [
	| cadUnits zIJ geoTime zIJ1 set |
	cadUnits := self cadUnits.
	zIJ := self metaObject zIJ.
	^zIJ isNil
		ifTrue: [BasicUserFunction
				with: ''
				myUnit: cadUnits length
				units: cadUnits]
		ifFalse: [zIJ isUserFunction
				ifTrue: [zIJ]
				ifFalse: 
					["For backward compatibility"
					geoTime := self geoTime.
					zIJ1 := (zIJ substitute: geoTime with: geoTime / cadUnits time)
								/ cadUnits length.
					set := Set new.
					set add: geoTime.
					zIJ1 := zIJ1 expandUntil: set.
					zIJ1 := zIJ1 simplifyUntil: set.
					BasicUserFunction
						with: zIJ1 cadString
						myUnit: cadUnits length
						units: cadUnits]]
]
