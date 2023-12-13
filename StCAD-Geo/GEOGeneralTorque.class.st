Class {
	#name : #GEOGeneralTorque,
	#superclass : #Obsolete,
	#category : #'StCAD-Geo-Obsolete classes'
}

{ #category : #'binary storage' }
GEOGeneralTorque class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Change 
	StCAD.StGeo.GEOSpringDamperTorque 
	(eventTable container markerI markerJ markerK aTIeKe) 
	to 
	StCAD.StGeo.ForceTorqueGeneral 
	(eventTable container markerI markerJ markerK aFIeKe aTIeKe)"

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := GEOForceTorqueGeneral basicNew.
			^
			[:oldObj | 
			| new markerk aTIeKe |
			new := Array new: 7.
			new
				replaceFrom: 1
				to: 4
				with: oldObj
				startingAt: 1.
			Units new.
			markerk := oldObj at: oldObj size - 1.
			aTIeKe := oldObj at: oldObj size.
			oldObj become: new.
			oldObj changeClassToThatOf: inst.
			oldObj markerK: markerk.
			oldObj aFIeKe: (FullColumn new: 3).
			oldObj aTIeKe: aTIeKe.
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
GEOGeneralTorque class >> binaryRepresentationVersion [
	^40
]

{ #category : #'VisualWorks metadata' }
GEOGeneralTorque class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
