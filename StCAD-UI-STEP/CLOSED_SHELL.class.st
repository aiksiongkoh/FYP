Class {
	#name : #'CLOSED_SHELL',
	#superclass : #'CONNECTED_FACE_SET',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CLOSED_SHELL class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CLOSED_SHELL >> buildIn1: aNMTModel [ 
	| aOutsideRegion |
	aOutsideRegion := aNMTModel aOutsideRegion.
	cfs_faces do: [:face | face buildInRegion: aOutsideRegion]
]

{ #category : #accessing }
CLOSED_SHELL >> buildIn2: aNMTModel [

	| aOutsideRegion |
	aOutsideRegion := aNMTModel aOutsideRegion.
	self halt.
	(cfs_faces at: 2) buildInRegion: aOutsideRegion
]

{ #category : #accessing }
CLOSED_SHELL >> buildIn3: aNMTModel [

	| aOutsideRegion |
	aOutsideRegion := aNMTModel aOutsideRegion.
	1 to: cfs_faces size
		do: 
			[:i |
			Transcript
				cr;
				show: 'CLOSED_SHELL>>buildIn: ';
				show: i;
				space;
				show: [(cfs_faces at: i) buildInRegion: aOutsideRegion] millisecondsToRun]
]

{ #category : #accessing }
CLOSED_SHELL >> buildIn: aNMTModel [

	| aOutsideRegion debug |
	aOutsideRegion := aNMTModel aOutsideRegion.
	debug := false.
	debug
		ifTrue: 
			[self halt.
			(cfs_faces at: 1) buildInRegion: aOutsideRegion.
			(cfs_faces at: 2) buildInRegion: aOutsideRegion.
			(cfs_faces at: 3) buildInRegion: aOutsideRegion.
			(cfs_faces at: 4) buildInRegion: aOutsideRegion.
			(cfs_faces at: 5) buildInRegion: aOutsideRegion.
			(cfs_faces at: 6) buildInRegion: aOutsideRegion.
			(cfs_faces at: 7) buildInRegion: aOutsideRegion.
			(cfs_faces at: 8) buildInRegion: aOutsideRegion.
			(cfs_faces at: 9) buildInRegion: aOutsideRegion.
			(cfs_faces at: 10) buildInRegion: aOutsideRegion.
			(cfs_faces at: 11) buildInRegion: aOutsideRegion.
			(cfs_faces at: 12) buildInRegion: aOutsideRegion.
			(cfs_faces at: 13) buildInRegion: aOutsideRegion.
			(cfs_faces at: 14) buildInRegion: aOutsideRegion.
			(cfs_faces at: 15) buildInRegion: aOutsideRegion.
			(cfs_faces at: 16) buildInRegion: aOutsideRegion.
			(cfs_faces at: 17) buildInRegion: aOutsideRegion.
			(cfs_faces at: 18) buildInRegion: aOutsideRegion.
			(cfs_faces at: 19) buildInRegion: aOutsideRegion.
			(cfs_faces at: 20) buildInRegion: aOutsideRegion.
			(cfs_faces at: 21) buildInRegion: aOutsideRegion.
			(cfs_faces at: 22) buildInRegion: aOutsideRegion.
			(cfs_faces at: 23) buildInRegion: aOutsideRegion.
			(cfs_faces at: 24) buildInRegion: aOutsideRegion.
			(cfs_faces at: 25) buildInRegion: aOutsideRegion.
			(cfs_faces at: 26) buildInRegion: aOutsideRegion]
		ifFalse: [cfs_faces do: [:face | face buildInRegion: aOutsideRegion]]
]

{ #category : #accessing }
CLOSED_SHELL >> startPoint [
	^cfs_faces first startPoint
]
