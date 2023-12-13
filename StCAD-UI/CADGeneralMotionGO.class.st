Class {
	#name : #CADGeneralMotionGO,
	#superclass : #CADMotionGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADGeneralMotionGO class >> geoClass [
	^GEOGeneralMotion
]

{ #category : #'instance creation' }
CADGeneralMotionGO class >> issueWarning: anInterface [ 
	(Dialog 
		confirm: 'Select a marker and drag to connect to another marker.\Do you wish to cancel the GeneralMotion Tool?' 
				withCRs) 
			ifTrue: [anInterface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
CADGeneralMotionGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADGeneralMotionGO >> angleIJJ [
	| cadUnits angleIJJ |
	cadUnits := self cadUnits.
	angleIJJ := self metaObject angleIJJ.
	^angleIJJ collect: 
			[:angleIJJi | 
			angleIJJi isNil 
				ifTrue: 
					[BasicUserFunction 
						with: ''
						myUnit: cadUnits length
						units: cadUnits]
				ifFalse: [angleIJJi]]
]

{ #category : #handles }
CADGeneralMotionGO >> handleLabel [
	^self handleLabel: 'gmo'
]

{ #category : #accessing }
CADGeneralMotionGO >> promptForFunction [
	GeneralMotionDialog openOn: self.
]

{ #category : #accessing }
CADGeneralMotionGO >> rIJI [
	| cadUnits rIJI |
	cadUnits := self cadUnits.
	rIJI := self metaObject rIJI.
	^rIJI collect: 
			[:rIJIi | 
			rIJIi isNil 
				ifTrue: 
					[BasicUserFunction 
						with: ''
						myUnit: cadUnits length
						units: cadUnits]
				ifFalse: [rIJIi]]
]

{ #category : #accessing }
CADGeneralMotionGO >> rotOrder [
	| rotOrder rotOrderi |
	rotOrder := self metaObject rotOrder.
	^rotOrder isNil 
		ifTrue: 
			[Array 
				with: 1
				with: 2
				with: 3]
		ifFalse: 
			[1 to: 3
				do: 
					[:i | 
					rotOrderi := rotOrder at: i.
					rotOrderi isNil ifTrue: [rotOrder at: i put: i]].
			rotOrder]
]
