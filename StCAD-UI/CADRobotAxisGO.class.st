Class {
	#name : #CADRobotAxisGO,
	#superclass : #CADKineIJGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADRobotAxisGO class >> createNotifying: anInterface [ 
	| cadJoint |
	cadJoint := self findJointIn: anInterface.
	^cadJoint notNil 
		ifTrue: 
			[| markerI markerJ interface assembly aRobotAxisName aGEORobotAxis |
			markerI := cadJoint startObject metaObject.
			markerJ := cadJoint stopObject metaObject.
			interface := markerI interface.
			assembly := interface geoRootItem.
			aRobotAxisName := interface promptUserForRobotAxisNameIn: assembly.
			aRobotAxisName isEmpty not 
				ifTrue: 
					[| aCADRobotAxisGO |
					aGEORobotAxis := self geoClass markerI: markerI markerJ: markerJ.
					aGEORobotAxis name: aRobotAxisName.
					assembly addKineIJ: aGEORobotAxis.
					aCADRobotAxisGO := interface createUpdateSelectGOfor: aGEORobotAxis.
					aCADRobotAxisGO]
				ifFalse: 
					[self issueWarning: anInterface.
					nil]]
		ifFalse: 
			[self issueWarning: anInterface.
			nil]
]

{ #category : #'instance creation' }
CADRobotAxisGO class >> findJointIn: anInterface [ 
	^anInterface aRevoluteJointAt: anInterface cursorPoint
]

{ #category : #accessing }
CADRobotAxisGO class >> geoClass [
	^GEORobotAxis
]

{ #category : #'instance creation' }
CADRobotAxisGO class >> issueWarning: interface [ 
	(Dialog 
		confirm: 'Select a Revolute joint.\Do you wish to cancel the RobotAxis Tool?' 
				withCRs) 
			ifTrue: [interface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
CADRobotAxisGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADRobotAxisGO >> handleLabel [
	^self handleLabel: 'rob'
]
