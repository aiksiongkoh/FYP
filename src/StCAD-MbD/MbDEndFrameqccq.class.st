Class {
	#name : #MbDEndFrameqccq,
	#superclass : #MbDEndFrameqc,
	#instVars : [
		'targetFrame',
		'rpep',
		'pprOeOpEpEtarget'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #calc }
MbDEndFrameqccq >> calcPostDynCorrectorIteration [
	| partFrame aAOp rpeO pAOppE prOeOpEi prOeOpEij prpeppEi prpeppEij pprOeOpEipE pAOppEi pprOeOpEipEj prpeppE prpeppEtarget pprOeOpEipEtarget |
	targetFrame partFrame calcPostDynCorrectorIteration.
	targetFrame markerFrame calcPostDynCorrectorIteration.
	targetFrame calcPostDynCorrectorIteration.
	rOeO := targetFrame rOeO.
	partFrame := markerFrame partFrame.
	rpeO := rOeO - partFrame rOpO.
	aAOp := partFrame aAOp.
	rpep := aAOp transposeTimesFullColumn: rpeO.
	pAOppE := partFrame pAOppE.
	prpeppE := FullMatrix new: 3 by: 4.
	1 to: 3
		do: 
			[:i | 
			prpeppEi := prpeppE at: i.
			1 to: 4
				do: 
					[:j | 
					prpeppEij := 0.0d.
					1 to: 3 do: [:k | prpeppEij := prpeppEij + (((pAOppE at: j)
										at: k and: i)
										* (rpeO at: k))].
					prpeppEi at: j put: prpeppEij]].
	1 to: 3
		do: 
			[:i | 
			prOeOpEi := prOeOpE at: i.
			1 to: 4
				do: 
					[:j | 
					prOeOpEij := ((pAOppE at: j)
								at: i)
								timesFullColumn: rpep.
					prOeOpEi at: j put: prOeOpEij]].
	prpeppEtarget := aAOp transposeTimesFullMatrix: targetFrame prOeOpE.
	pprOeOpEpE := MbDEulerParameters ppApEpEtimesColumn: rpep.
	1 to: 4
		do: 
			[:i | 
			pprOeOpEipE := pprOeOpEpE at: i.
			pprOeOpEipEtarget := pprOeOpEpEtarget at: i.
			pAOppEi := pAOppE at: i.
			1 to: 4
				do: 
					[:j | 
					pprOeOpEipEj := pprOeOpEipE at: j.
					pprOeOpEipEj equalSelfPlusFullColumn: (pAOppEi timesFullColumn: (prpeppE column: j)).
					pprOeOpEipEtarget at: j put: (pAOppEi timesFullColumn: (prpeppEtarget column: j))]]
]

{ #category : #'initialize-release' }
MbDEndFrameqccq >> initialize [
	super initialize.
	pprOeOpEpEtarget := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDEndFrameqccq >> initializeGlobally [
	"Do nothing."
]

{ #category : #accessing }
MbDEndFrameqccq >> iqEtarget [
	^targetFrame iqE
]

{ #category : #accessing }
MbDEndFrameqccq >> pprOeOpEpEtarget [
	^pprOeOpEpEtarget
]

{ #category : #accessing }
MbDEndFrameqccq >> qEOe [
	^targetFrame qEOe
]

{ #category : #accessing }
MbDEndFrameqccq >> rOeO [
	^targetFrame rOeO
]

{ #category : #accessing }
MbDEndFrameqccq >> rpep [
	^rpep
]

{ #category : #accessing }
MbDEndFrameqccq >> targetFrame: aMarker [ 
	targetFrame := aMarker
]
