Class {
	#name : #'OPEN_SHELL',
	#superclass : #'CONNECTED_FACE_SET',
	#category : #'StCAD-UI-STEP'
}

{ #category : #ops }
OPEN_SHELL >> buildIn: aNMTModel [ 
	| aOutsideRegion |
	aOutsideRegion := aNMTModel aOutsideRegion.
	cfs_faces do: [:face | face buildInRegion: aOutsideRegion]

	"@__markp	11/14/2009 08:57:35 pm"
]
