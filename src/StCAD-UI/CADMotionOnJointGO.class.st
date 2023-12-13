Class {
	#name : #CADMotionOnJointGO,
	#superclass : #CADMotionGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'instance creation' }
CADMotionOnJointGO class >> createNotifying: anInterface [ 
	| cadJoint |
	cadJoint := self findJointIn: anInterface.
	^cadJoint notNil 
		ifTrue: 
			[| markerI markerJ interface assembly motionName geoMotion |
			markerI := cadJoint startObject metaObject.
			markerJ := cadJoint stopObject metaObject.
			interface := markerI interface.
			assembly := interface geoRootItem.
			motionName := interface promptUserForMotionNameIn: assembly.
			motionName isEmpty not 
				ifTrue: 
					[| cadMotion |
					geoMotion := self geoClass markerI: markerI markerJ: markerJ.
					geoMotion name: motionName.
					assembly addMotion: geoMotion.
					cadMotion := interface createUpdateSelectGOfor: geoMotion.
					cadMotion promptForFunction.
					cadMotion]
				ifFalse: 
					[self issueWarning: anInterface.
					nil]]
		ifFalse: 
			[self issueWarning: anInterface.
			nil]
]

{ #category : #'VisualWorks metadata' }
CADMotionOnJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]
