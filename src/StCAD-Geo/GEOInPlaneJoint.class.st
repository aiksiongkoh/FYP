Class {
	#name : #GEOInPlaneJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'offset'
	],
	#category : #'StCAD-Geo-GEO'
}

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
