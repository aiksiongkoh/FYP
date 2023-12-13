Class {
	#name : #CADAllowZRotationGO,
	#superclass : #CADMotionOnJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADAllowZRotationGO class >> findJointIn: anInterface [ 
	^anInterface zRotationalJointAt: anInterface cursorPoint
]

{ #category : #accessing }
CADAllowZRotationGO class >> geoClass [
	^GEOAllowZRotation
]

{ #category : #'instance creation' }
CADAllowZRotationGO class >> issueWarning: interface [ 
	(Dialog confirm: 'Select a Revolute or Cylindrical joint.\Do you wish to cancel the Motion Tool?' withCRs)
		ifTrue: [interface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
CADAllowZRotationGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADAllowZRotationGO >> handleLabel [
	^self handleLabel: 'aro'
]
