Class {
	#name : #CADPartViaMarkerBryantAnglesDialog,
	#superclass : #CADFrameBryantAnglesDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'instance creation' }
CADPartViaMarkerBryantAnglesDialog class >> openOn: geoItem withSpec: aSymbol [ 
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
CADPartViaMarkerBryantAnglesDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADPartViaMarkerBryantAnglesDialog >> dialogTitle [
	^'Position Part via Marker                 CADSM'
]

{ #category : #private }
CADPartViaMarkerBryantAnglesDialog >> updateDomainObjects [
	"
	rOmO := rOPO + aAOP*rPmP. 
	aAOm := aAOP*aAPm. 
	
	aAOP := aAOm*aAPmT. 
	rOPO := rOmO - aAOP*rPmP. 
	"

	| rOmO eulerAnglesxyz markerRefFrame partRefFrame aAOm aAOP rOPO |
	rOmO := FullColumn new: 3.
	rOmO at: 1 put: rGfGx value.
	rOmO at: 2 put: rGfGy value.
	rOmO at: 3 put: rGfGz value.
	eulerAnglesxyz := GEOEulerAnglesxyz new.
	eulerAnglesxyz at: 1 put: the1fx value degreesToRadians.
	eulerAnglesxyz at: 2 put: the2fy value degreesToRadians.
	eulerAnglesxyz at: 3 put: the3fz value degreesToRadians.
	markerRefFrame := refFrame value.
	partRefFrame := markerRefFrame refFrame.
	partRefFrame storeMemento: partRefFrame positionMemento for: partRefFrame.
	aAOm := eulerAnglesxyz aA.
	aAOP := aAOm timesFullMatrix: markerRefFrame aAFf transpose.
	rOPO := rOmO - (aAOP timesFullColumn: markerRefFrame rFfF).
	partRefFrame
		refFrame: partRefFrame refFrame
		rFfF: rOPO
		aAFf: aAOP
]
