Class {
	#name : #Gravity,
	#superclass : #SubItem,
	#instVars : [
		'gXYZ'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Force'
}

{ #category : #'VisualWorks metadata' }
Gravity class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
	)

]

{ #category : #'initialize-release' }
Gravity >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer displayString: 'Gravity'.
	^answer
]

{ #category : #DYN }
Gravity >> createMbD [
	| mbdGravity |
	mbdGravity := MbDConstantGravity new.
	mbdGravity gXYZ: gXYZ / self mbdUnits acceleration.
	mbdGravity submitToSystem.
	self mbdObject: mbdGravity
]

{ #category : #DYN }
Gravity >> deleteMbD [
	self mbdObject: nil
]

{ #category : #'initialize-release' }
Gravity >> gX: gX gY: gY gZ: gZ [ 
	""

	gXYZ := FullColumn new: 3.
	gXYZ at: 1 put: gX.
	gXYZ at: 2 put: gY.
	gXYZ at: 3 put: gZ
]

{ #category : #'initialize-release' }
Gravity >> gXYZ [
	^gXYZ
]

{ #category : #'initialize-release' }
Gravity >> gXYZ: col [ 
	gXYZ := col
]

{ #category : #printing }
Gravity >> storeOn: aStream level: level [ 
	aStream
		storeLevel: level
		title: 'ConstantGravity'
		object: gXYZ
]

{ #category : #printing }
Gravity >> storePOVOn: aStream level: level [ 
	"Do nothing."
]
