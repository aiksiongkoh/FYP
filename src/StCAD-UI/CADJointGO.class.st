Class {
	#name : #CADJointGO,
	#superclass : #CADDependentLineGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADJointGO class >> askAssembly: assembly add: geoIJ [ 
	assembly addJoint: geoIJ
]

{ #category : #accessing }
CADJointGO class >> askInterface: interface promptUserForNameIn: assembly [ 
	^interface promptUserForJointNameIn: assembly
]

{ #category : #'instance creation' }
CADJointGO class >> issueWarning: anInterface [ 
	(Dialog confirm: 'Select a marker and drag to connect to another marker.\Do you wish to cancel the Joint Tool?' withCRs)
		ifTrue: [anInterface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
CADJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]
