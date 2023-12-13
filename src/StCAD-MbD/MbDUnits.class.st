"
This class is obselete. It is required to read *.asm created with 'freeCAD2' or earlier.
"
Class {
	#name : #MbDUnits,
	#superclass : #Units,
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'binary storage' }
MbDUnits class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Change order from 
	name mass length time aJ velocity omega acceleration alpha force torque 
	time mass aJ length angle velocity omega acceleration alpha force torque"

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := Units basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: oldObj size.
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 2).
			new at: 3 put: (oldObj at: 5).
			new at: 4 put: (oldObj at: 3).
			new at: 5 put: 1.0d.
			new
				replaceFrom: 6
				to: new size
				with: oldObj
				startingAt: 6.
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
MbDUnits class >> binaryRepresentationVersion [
	^30
]

{ #category : #'VisualWorks metadata' }
MbDUnits class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]
