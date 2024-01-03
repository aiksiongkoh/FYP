Class {
	#name : #GEOGravity,
	#superclass : #GEOContainedItem,
	#instVars : [
		'gXYZ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'initialize-release' }
GEOGravity >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer displayString: 'Gravity'.
	^answer
]

{ #category : #DYN }
GEOGravity >> createMbD [
	| mbdGravity |
	mbdGravity := MbDConstantGravity new.
	mbdGravity gXYZ: gXYZ / self mbdUnits acceleration.
	mbdGravity submitToSystem.
	self mbdObject: mbdGravity
]

{ #category : #DYN }
GEOGravity >> deleteMbD [
	self mbdObject: nil
]

{ #category : #'initialize-release' }
GEOGravity >> gX: gX gY: gY gZ: gZ [ 
	""

	gXYZ := FullColumn new: 3.
	gXYZ at: 1 put: gX.
	gXYZ at: 2 put: gY.
	gXYZ at: 3 put: gZ
]

{ #category : #'initialize-release' }
GEOGravity >> gXYZ [
	^gXYZ
]

{ #category : #'initialize-release' }
GEOGravity >> gXYZ: col [ 
	gXYZ := col
]

{ #category : #accessing }
GEOGravity >> rDfD [
	^container rDfD
]

{ #category : #printing }
GEOGravity >> storeOn: aStream level: level [ 
	aStream
		storeLevel: level
		title: 'ConstantGravity'
		object: gXYZ
]

{ #category : #printing }
GEOGravity >> storePOVOn: aStream level: level [ 
	"Do nothing."
]
