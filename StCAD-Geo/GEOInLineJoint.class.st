Class {
	#name : #GEOInLineJoint,
	#superclass : #GEOJoint,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'binary storage' }
GEOInLineJoint class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"
	Change 
	StCAD.StGeo.GEOInLineJoint 
	(eventTable container constraints markerI markerJ) 
	to 
	StCAD.StGeo.GEOPointInLineJoint 
	(eventTable container constraints markerI markerJ)
	"

	oldVersion == nil 
		ifTrue: 
			[| inst |
			inst := GEOPointInLineJoint basicNew.
			^
			[:oldObj | 
			oldObj changeClassToThatOf: inst.
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'VisualWorks metadata' }
GEOInLineJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
