Class {
	#name : #MbDVelRadIeqcJec,
	#superclass : #MbDVelRadIecJec,
	#instVars : [
		'pvIeJepXI',
		'pvIeJepEI',
		'pvIeJepXdotI',
		'pvIeJepEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelRadIeqcJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelRadIeqcJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #calc }
MbDVelRadIeqcJec >> calcPostDynCorrectorIteration [
	| muIeJeO mprIeJeOpEIT mpvIeJeOpEIT prIeJepXI prIeJepEI muIeJeOT mprIeJeOpEI |
	super calcPostDynCorrectorIteration.
	rIeJe = 0.0d ifTrue: [^self].
	muIeJeO := uIeJeO negated.
	mprIeJeOpEI := frmI prOeOpE.
	mprIeJeOpEIT := mprIeJeOpEI transpose.
	mpvIeJeOpEIT := frmI pvOeOpE transpose.
	muIeJeOT := muIeJeO transpose.
	prIeJepXI := muIeJeOT.
	prIeJepEI := muIeJeOT timesFullMatrix: mprIeJeOpEI.
	1 to: 3 do: [:i | pvIeJepXI at: i put: 0.0d - (vIeJe * (prIeJepXI at: i)) - (vIeJeO at: i) / rIeJe].
	1 to: 4 do: [:i | pvIeJepEI at: i put: 0.0d - (vIeJe * (prIeJepEI at: i)) - ((mpvIeJeOpEIT at: i)
					dot: rIeJeO) - ((mprIeJeOpEIT at: i)
					dot: vIeJeO) / rIeJe].
	pvIeJepXdotI := prIeJepXI.
	pvIeJepEdotI := prIeJepEI
]

{ #category : #'initialize-release' }
MbDVelRadIeqcJec >> initialize [
	pvIeJepXI := FullRow new: 3.
	pvIeJepEI := FullRow new: 4.
	pvIeJepXdotI := FullRow new: 3.
	pvIeJepEdotI := FullRow new: 4
]

{ #category : #accessing }
MbDVelRadIeqcJec >> pvaluepEI [
	^pvIeJepEI
]

{ #category : #accessing }
MbDVelRadIeqcJec >> pvaluepEdotI [
	^pvIeJepEdotI
]

{ #category : #accessing }
MbDVelRadIeqcJec >> pvaluepXI [
	^pvIeJepXI
]

{ #category : #accessing }
MbDVelRadIeqcJec >> pvaluepXdotI [
	^pvIeJepXdotI
]
