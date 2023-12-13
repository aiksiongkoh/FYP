Class {
	#name : #CADPartViaMarkerDirectionDialog,
	#superclass : #CADFrameDirectionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'instance creation' }
CADPartViaMarkerDirectionDialog class >> openOn: geoItem withSpec: aSymbol [ 
	| newDialog |
	newDialog := super new.
	newDialog geoItem value: geoItem.
	newDialog refFrame value: geoItem refFrame.
	^geoItem part notNil
		ifTrue: 
			[newDialog guideFrame value: geoItem part guideFrame.
			newDialog openInterface: aSymbol]
		ifFalse: [Dialog warn: 'Marker is not on a part.']
]

{ #category : #'VisualWorks metadata' }
CADPartViaMarkerDirectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADPartViaMarkerDirectionDialog >> dialogTitle [
	^'Position Part via Marker                 CADSM'
]

{ #category : #private }
CADPartViaMarkerDirectionDialog >> updateDomainObjects [
	"
	rOmO := rOPO + aAOP*rPmP. 
	aAOm := aAOP*aAPm. 
	
	aAOP := aAOm*aAPmT. 
	rOPO := rOmO - aAOP*rPmP. 
	"

	| rOmO rmzptO rmxptO markerRefFrame partRefFrame aAOm aAOP rOPO |
	rOmO := FullColumn new: 3.
	rOmO at: 1 put: rGfGx value.
	rOmO at: 2 put: rGfGy value.
	rOmO at: 3 put: rGfGz value.
	rmzptO := FullColumn new: 3.
	rmxptO := FullColumn new: 3.
	rmzptO at: 1 put: rfzptGx value.
	rmzptO at: 2 put: rfzptGy value.
	rmzptO at: 3 put: rfzptGz value.
	rmxptO at: 1 put: rfxptGx value.
	rmxptO at: 2 put: rfxptGy value.
	rmxptO at: 3 put: rfxptGz value.
	markerRefFrame := refFrame value.
	partRefFrame := markerRefFrame refFrame.
	partRefFrame storeMemento: partRefFrame positionMemento for: partRefFrame.
	aAOm := FullMatrix
				rotationMatrixFromOrigin: rOmO
				zPoint: rOmO + rmzptO
				xPoint: rOmO + rmxptO.
	aAOP := aAOm timesFullMatrix: markerRefFrame aAFf transpose.
	rOPO := rOmO - (aAOP timesFullColumn: markerRefFrame rFfF).
	partRefFrame
		refFrame: partRefFrame refFrame
		rFfF: rOPO
		aAFf: aAOP
]
