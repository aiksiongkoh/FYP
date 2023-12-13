Class {
	#name : #GEOInPlaneJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'offset'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'binary storage' }
GEOInPlaneJoint class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"
	Change 
	StCAD.StGeo.GEOInPlaneJoint 
	(eventTable container constraints markerI markerJ ) 
	to 
	StCAD.StGeo.GEOPointInPlaneJoint 
	(eventTable container constraints markerI markerJ offset)
	"

	oldVersion == nil 
		ifTrue: 
			[| inst |
			inst := GEOPointInPlaneJoint basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 6.
			new 
				replaceFrom: 1
				to: 5
				with: oldObj
				startingAt: 1.
			oldObj become: new.
			oldObj changeClassToThatOf: inst.
			oldObj offset: 0.0d.
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
GEOInPlaneJoint class >> binaryRepresentationVersion [
	^40
]

{ #category : #'VisualWorks metadata' }
GEOInPlaneJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOInPlaneJoint >> createMbD [
	| mbdInPlaneJoint |
	super createMbD.
	mbdInPlaneJoint := self mbdObject.
	mbdInPlaneJoint offset: offset / self mbdUnits length
]

{ #category : #'initialize-release' }
GEOInPlaneJoint >> initialize [
	offset := 0.0d.
	super initialize
]

{ #category : #accessing }
GEOInPlaneJoint >> offset [
	^offset
]

{ #category : #accessing }
GEOInPlaneJoint >> offset: anObject [
	offset := anObject
]

{ #category : #printing }
GEOInPlaneJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream 
		storeLevel: level + 1
		title: 'offset'
		object: offset
]
