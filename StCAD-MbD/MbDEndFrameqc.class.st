"
prOeOpX is the identity matrix. No need to store it. Instances makes use of that knowledge in their methods.
"
Class {
	#name : #MbDEndFrameqc,
	#superclass : #MbDEndFramec,
	#instVars : [
		'prOeOpE',
		'pprOeOpEpE',
		'pAOepE',
		'ppAOepEpE'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'VisualWorks metadata' }
MbDEndFrameqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDEndFrameqc >> aAdotjOe: j [ 
	^markerFrame aAdotjOm: j
]

{ #category : #accessing }
MbDEndFrameqc >> aBOp [
	^markerFrame aBOp
]

{ #category : #accessing }
MbDEndFrameqc >> aOeO [
	^markerFrame aOmO
]

{ #category : #calc }
MbDEndFrameqc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	prOeOpE := markerFrame prOmOpE.
	pAOepE := markerFrame pAOmpE
]

{ #category : #converting }
MbDEndFrameqc >> floatsOn: aEndFrame [ 
	| selfmFrm basemFrm newSelf |
	selfmFrm := self markerFrame.
	basemFrm := aEndFrame markerFrame.
	selfmFrm rpmp: basemFrm rpmp.
	selfmFrm aApm: basemFrm aApm.
	newSelf := MbDEndFrameqcs new.
	newSelf name: name.
	newSelf markerFrame: selfmFrm.
	self become: newSelf
]

{ #category : #converting }
MbDEndFrameqc >> followEndFrame: aEndFrame [ 
	"Do not use 'self become: endFrm' because receiver might be used in kinematic objects."

	| endFrm |
	endFrm := MbDEndFrameqccq new.
	endFrm name: name.
	endFrm isOn: markerFrame.
	endFrm targetFrame: aEndFrame.
	^endFrm
]

{ #category : #'initialize-release' }
MbDEndFrameqc >> initialize [
	prOeOpE := FullMatrix new: 3 by: 4.
	pprOeOpEpE := FullMatrix new: 4 by: 4.
	pAOepE := FullColumn new: 4.
	ppAOepEpE := FullMatrix new: 4 by: 4
]

{ #category : #'initialize-release' }
MbDEndFrameqc >> initializeGlobally [
	"Theses are constants."

	pprOeOpEpE := markerFrame pprOmOpEpE.
	ppAOepEpE := markerFrame ppAOmpEpE
]

{ #category : #accessing }
MbDEndFrameqc >> iqE [
	^markerFrame iqE
]

{ #category : #accessing }
MbDEndFrameqc >> iqX [
	^markerFrame iqX
]

{ #category : #accessing }
MbDEndFrameqc >> is: count [ 
	"There is no s parameter except for a curve or surface."

	^count
]

{ #category : #accessing }
MbDEndFrameqc >> markerFrame: frame [ 
	markerFrame := frame
]

{ #category : #accessing }
MbDEndFrameqc >> omeOeO [
	^markerFrame omeOmO
]

{ #category : #accessing }
MbDEndFrameqc >> pAOepE [ 
	^pAOepE
]

{ #category : #accessing }
MbDEndFrameqc >> pAOppE [
	^markerFrame pAOppE
]

{ #category : #accessing }
MbDEndFrameqc >> pAdotjOepE: axis [ 
	^markerFrame pAdotjOmpE: axis
]

{ #category : #accessing }
MbDEndFrameqc >> pAdotjOepET: axis [ 
	^markerFrame pAdotjOmpET: axis
]

{ #category : #accessing }
MbDEndFrameqc >> pAeOpE [
	| pAeOpE |
	pAeOpE := FullColumn new: 4.
	1 to: 4 do: [:i | pAeOpE at: i put: (pAOepE at: i) transpose].
	^pAeOpE
]

{ #category : #accessing }
MbDEndFrameqc >> pAjOepE: jj [ 
	| answer answeri pAOepEj answerij |
	answer := FullMatrix new: 3 by: 4.
	1 to: 3 do: [:i | 
			answeri := answer at: i.
			1 to: 4 do: [:j | 
					pAOepEj := pAOepE at: j.
					answerij := pAOepEj at: i and: jj.
					answeri at: j put: answerij]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqc >> pAjOepET: jj [ 
	| answer answeri pAOepEi answerij |
	answer := FullMatrix new: 4 by: 3.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			pAOepEi := pAOepE at: i.
			1 to: 3 do: [:j | 
					answerij := pAOepEi at: j and: jj.
					answeri at: j put: answerij]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqc >> pkeOpE [
	^self pAjOepE: 3
]

{ #category : #accessing }
MbDEndFrameqc >> pomeOeOpE [
	^markerFrame pomeOmOpE
]

{ #category : #accessing }
MbDEndFrameqc >> pomeOeOpEdot [
	^markerFrame pomeOmOpEdot
]

{ #category : #accessing }
MbDEndFrameqc >> ppAOepEpE [ 
	^ppAOepEpE
]

{ #category : #accessing }
MbDEndFrameqc >> ppAjOepEpE: jj [ 
	| answer answeri ppAOepEipE |
	answer := FullMatrix new: 4 by: 4.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			ppAOepEipE := ppAOepEpE at: i.
			i to: 4 do: [:j | answeri at: j put: ((ppAOepEipE at: j) column: jj)]].
	^answer symLowerWithUpper
]

{ #category : #accessing }
MbDEndFrameqc >> pprOeOpEpE [ 
	^pprOeOpEpE
]

{ #category : #accessing }
MbDEndFrameqc >> ppriOeOpEpE: ii [ 
	| answer answeri pprOeOpEipE |
	answer := FullMatrix new: 4 by: 4.
	1 to: 4 do: [:i | 
			answeri := answer at: i.
			pprOeOpEipE := pprOeOpEpE at: i.
			1 to: 4 do: [:j | answeri at: j put: ((pprOeOpEipE at: j) at: ii)]].
	^answer
]

{ #category : #accessing }
MbDEndFrameqc >> prOeOpE [ 
	^prOeOpE
]

{ #category : #accessing }
MbDEndFrameqc >> priOeOpE: i [ 
	^prOeOpE at: i
]

{ #category : #accessing }
MbDEndFrameqc >> pvOeOpE [
	^markerFrame pvOmOpE
]

{ #category : #accessing }
MbDEndFrameqc >> pvOeOpEdot [
	^self prOeOpE
]

{ #category : #accessing }
MbDEndFrameqc >> pvOeOpXdot [
	^self prOeOpX
]

{ #category : #accessing }
MbDEndFrameqc >> qEddot [
	^markerFrame qEddot
]

{ #category : #accessing }
MbDEndFrameqc >> qEdot [
	^markerFrame qEdot
]

{ #category : #accessing }
MbDEndFrameqc >> qX [
	^markerFrame qX
]

{ #category : #accessing }
MbDEndFrameqc >> qXddot [
	^markerFrame qXddot
]

{ #category : #accessing }
MbDEndFrameqc >> qXdot [
	^markerFrame qXdot
]

{ #category : #accessing }
MbDEndFrameqc >> rpep [
	^markerFrame rpmp
]

{ #category : #accessing }
MbDEndFrameqc >> vOeO [
	^markerFrame vOmO
]
