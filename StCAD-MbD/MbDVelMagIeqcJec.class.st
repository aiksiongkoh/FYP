Class {
	#name : #MbDVelMagIeqcJec,
	#superclass : #MbDVelMagIecJec,
	#instVars : [
		'pvIeJepEI',
		'pvIeJepXdotI',
		'pvIeJepEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelMagIeqcJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelMagIeqcJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #calc }
MbDVelMagIeqcJec >> calcPostDynCorrectorIteration [
	| mpvIeJeOpEI mpvIeJeOpEdotI muvIeJeO zeroRow |
	super calcPostDynCorrectorIteration.
	mpvIeJeOpEI := frmI pvOeOpE.
	mpvIeJeOpEdotI := frmI pvOeOpEdot.
	muvIeJeO := uvIeJeO negated.
	vIeJe = 0
		ifTrue: 
			["uvIeJeO := (StMFullColumn new: 3) zeroSelf."
			zeroRow := muvIeJeO.
			pvIeJepEI := zeroRow.
			pvIeJepXdotI := zeroRow.
			pvIeJepEdotI := zeroRow]
		ifFalse: 
			[pvIeJepEI := muvIeJeO dot: mpvIeJeOpEI.
			pvIeJepXdotI := muvIeJeO transpose.
			pvIeJepEdotI := muvIeJeO dot: mpvIeJeOpEdotI]
]

{ #category : #'initialize-release' }
MbDVelMagIeqcJec >> initialize [
	super initialize.
	pvIeJepEI := FullRow new: 4.
	pvIeJepXdotI := FullRow new: 3.
	pvIeJepEdotI := FullRow new: 4
]

{ #category : #accessing }
MbDVelMagIeqcJec >> pvaluepEI [
	^pvIeJepEI
]

{ #category : #accessing }
MbDVelMagIeqcJec >> pvaluepEdotI [
	^pvIeJepEdotI
]

{ #category : #accessing }
MbDVelMagIeqcJec >> pvaluepXdotI [
	^pvIeJepXdotI
]
