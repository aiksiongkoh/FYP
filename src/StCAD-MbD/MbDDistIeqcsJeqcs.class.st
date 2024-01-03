Class {
	#name : #MbDDistIeqcsJeqcs,
	#superclass : #MbDDistIeqcsJeqc,
	#instVars : [
		'sSizeJ',
		'prIeJepsJ',
		'pprIeJepXIpsJ',
		'pprIeJepEIpsJ',
		'pprIeJepXJpsJ',
		'pprIeJepEJpsJ',
		'pprIeJepsIpsJ',
		'pprIeJepsJpsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #calc }
MbDDistIeqcsJeqcs >> calcLocalSeparationDistance [
	super calcLocalSeparationDistance
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> calcLocalSeparationDistance1 [
	"Iterate for points with parallel normals."

	
	[newtonRaphson run.
	sepDist := rIeJeO dot: frmI keO]
		on: MaximumIterationError
		do: 
			[:ex | 
			"Solution not found."
			sepDist := 0.0d.
			ex return]
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> calcLocalSeparationDistance2 [
	"Iterate for points with parallel normals."

	
	[| sepDist2 |
	newtonRaphson run.
	sepDist := rIeJeO dot: frmI keO.
	sepDist2 := (rIeJeO sumOfSquares - (rIeJeO dot: frmI jeO) squared) sqrt.
	((sepDist / sepDist2) abs - 1.0d) abs > 0.01 ifTrue: [self halt]]
		on: MaximumIterationError
		do: 
			[:ex | 
			"Solution not found."
			sepDist := 0.0d.
			ex return]
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> calcPrivate [
	| prIeJeOpsJ prIeJeOpsJT pprIeJeOpEJpsJ pprIeJeOpsJpsJ pprIeJepXIipsJ prIeJepXIi prIeJeOipsJ element pprIeJepEIipsJ prIeJepEIi mprIeJeOpEIiT pprIeJepsIipsJ prIeJepsIi mprIeJeOpsIiT pprIeJepXJipsJ prIeJepXJi pprIeJepEJipsJ prIeJepEJi pprIeJeOpEJipsJ prIeJeOpEJiT pprIeJepsJipsJ prIeJepsJi pprIeJeOpsJipsJ prIeJeOpsJiT |
	super calcPrivate.
	rIeJe = 0.0d ifTrue: [^self].
	prIeJeOpsJ := frmJ prOeOps.
	prIeJeOpsJT := prIeJeOpsJ transpose.
	pprIeJeOpEJpsJ := frmJ pprOeOpEps.
	pprIeJeOpsJpsJ := frmJ pprOeOpsps.
	prIeJepsJ := uIeJeO transpose timesFullMatrix: prIeJeOpsJ.
	1 to: 3
		do: 
			[:i | 
			pprIeJepXIipsJ := pprIeJepXIpsJ at: i.
			prIeJepXIi := prIeJepXI at: i.
			prIeJeOipsJ := prIeJeOpsJ at: i.
			1 to: sSizeJ
				do: 
					[:j | 
					element := 0.0d - (prIeJeOipsJ at: j) - (prIeJepXIi * (prIeJepsJ at: j)).
					pprIeJepXIipsJ at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEIipsJ := pprIeJepEIpsJ at: i.
			prIeJepEIi := prIeJepEI at: i.
			mprIeJeOpEIiT := mprIeJeOpEIT at: i.
			1 to: sSizeJ
				do: 
					[:j | 
					element := 0.0d - (mprIeJeOpEIiT dot: (prIeJeOpsJT at: j)) - (prIeJepEIi * (prIeJepsJ at: j)).
					pprIeJepEIipsJ at: j put: element / rIeJe]].
	1 to: sSizeI
		do: 
			[:i | 
			pprIeJepsIipsJ := pprIeJepsIpsJ at: i.
			prIeJepsIi := prIeJepsI at: i.
			mprIeJeOpsIiT := mprIeJeOpsIT at: i.
			1 to: sSizeJ
				do: 
					[:j | 
					element := 0.0d - (mprIeJeOpsIiT dot: (prIeJeOpsJT at: j)) - (prIeJepsIi * (prIeJepsJ at: j)).
					pprIeJepsIipsJ at: j put: element / rIeJe]].
	1 to: 3
		do: 
			[:i | 
			pprIeJepXJipsJ := pprIeJepXJpsJ at: i.
			prIeJepXJi := prIeJepXJ at: i.
			prIeJeOipsJ := prIeJeOpsJ at: i.
			1 to: sSizeJ
				do: 
					[:j | 
					element := (prIeJeOipsJ at: j)
								- (prIeJepXJi * (prIeJepsJ at: j)).
					pprIeJepXJipsJ at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEJipsJ := pprIeJepEJpsJ at: i.
			prIeJepEJi := prIeJepEJ at: i.
			pprIeJeOpEJipsJ := pprIeJeOpEJpsJ at: i.
			prIeJeOpEJiT := prIeJeOpEJT at: i.
			1 to: sSizeJ
				do: 
					[:j | 
					element := (prIeJeOpEJiT dot: (prIeJeOpsJT at: j))
								+ ((pprIeJeOpEJipsJ at: j)
										dot: rIeJeO) - (prIeJepEJi * (prIeJepsJ at: j)).
					pprIeJepEJipsJ at: j put: element / rIeJe]].
	1 to: sSizeJ
		do: 
			[:i | 
			pprIeJepsJipsJ := pprIeJepsJpsJ at: i.
			prIeJepsJi := prIeJepsJ at: i.
			pprIeJeOpsJipsJ := pprIeJeOpsJpsJ at: i.
			prIeJeOpsJiT := prIeJeOpsJT at: i.
			1 to: sSizeJ
				do: 
					[:j | 
					element := (prIeJeOpsJiT dot: (prIeJeOpsJT at: j))
								+ ((pprIeJeOpsJipsJ at: j)
										dot: rIeJeO) - (prIeJepsJi * (prIeJepsJ at: j)).
					pprIeJepsJipsJ at: j put: element / rIeJe]]
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> calcSeparationDistance [
	"Do coarse global search, then accurate local search."

	"Use original data points as discretization points."

	"For each J point, determine whether it is outside solid I or inside 
	hole I."

	"Also find its closest I point."

	| sIs sJs rJmJeJms indicesI indicesJ penetrations minSep rJmJeJm rOJeO answerArray minDist indexI angleSwept nPIswept penetration minSepI minSepJ maxDepth maxDepthI maxDepthJ onExterior |
	sIs := frmI ss.
	sJs := frmJ ss.
	rJmJeJms := frmJ rmems.
	indicesI := OrderedCollection new.
	indicesJ := OrderedCollection new.
	penetrations := OrderedCollection new.
	minSep := 1.0d300.
	onExterior := frmI onExterior.
	1 to: rJmJeJms size
		do: 
			[:j | 
			rJmJeJm := rJmJeJms at: j.
			rOJeO := frmJ markerFrame rOeOOFrmem: rJmJeJm.
			answerArray := frmI roughSepDistFromrOeO: rOJeO.
			minDist := answerArray at: 1.
			indexI := answerArray at: 2.
			angleSwept := answerArray at: 3.
			nPIswept := (angleSwept / Double pi) rounded.
			penetration := (onExterior and: [nPIswept = 2]) 
						or: [onExterior not and: [nPIswept = 0]].
			penetration 
				ifTrue: 
					[indicesI add: indexI.
					indicesJ add: j.
					penetrations add: minDist]
				ifFalse: 
					[minDist < minSep 
						ifTrue: 
							[minSep := minDist.
							minSepI := indexI.
							minSepJ := j]]].
	penetrations isEmpty 
		ifTrue: 
			[self 
				sepDist: minSep
				sI: (sIs at: minSepI)
				sJ: (sJs at: minSepJ)
				dsI: ((sIs last - sIs first) / sIs size) abs
				dsJ: ((sJs last - sJs first) / sJs size) abs]
		ifFalse: 
			[maxDepth := 0.0d.
			1 to: penetrations size
				do: 
					[:i | 
					maxDepth < (penetrations at: i) 
						ifTrue: 
							[maxDepth := penetrations at: i.
							maxDepthI := indicesI at: i.
							maxDepthJ := indicesJ at: i]].
			self 
				depth: maxDepth
				sI: (sIs at: maxDepthI)
				sJ: (sJs at: maxDepthJ)
				dsI: ((sIs last - sIs first) / sIs size) abs
				dsJ: ((sJs last - sJs first) / sJs size) abs]
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> calcSeparationDistance1 [
	"Do coarse global search, then accurate local search."
	"Use original data points as discretization points."
	"For each J point, determine whether it is outside solid I or inside 
	hole I."
	"Also find its closest I point."

	| sIs sJs rJmJeJms indicesI indicesJ penetrations minSep rJmJeJm rOJeO answerArray minDist indexI angleSwept nPIswept penetration minSepI minSepJ maxDepth maxDepthI maxDepthJ onExterior |
	sIs := frmI ss.
	sJs := frmJ ss.
	rJmJeJms := frmJ rmems.
	indicesI := OrderedCollection new.
	indicesJ := OrderedCollection new.
	penetrations := OrderedCollection new.
	minSep := 1.0d300.
	onExterior := frmI onExterior.
	1 to: rJmJeJms size
		do: 
			[:j | 
			rJmJeJm := rJmJeJms at: j.
			rOJeO := frmJ markerFrame rOeOOFrmem: rJmJeJm.
			answerArray := frmI roughSepDistFromrOeO: rOJeO.
			minDist := answerArray at: 1.
			indexI := answerArray at: 2.
			angleSwept := answerArray at: 3.
			nPIswept := (angleSwept / Double pi) rounded.
			penetration := onExterior notNil
						ifTrue: [onExterior
								ifTrue: [nPIswept = 2]
								ifFalse: [nPIswept = 0]]
						ifFalse: [false].
			penetration
				ifTrue: 
					[indicesI add: indexI.
					indicesJ add: j.
					penetrations add: minDist]
				ifFalse: [minDist < minSep
						ifTrue: 
							[minSep := minDist.
							minSepI := indexI.
							minSepJ := j]]].
	penetrations isEmpty
		ifTrue: [self
				sepDistsI: (sIs at: minSepI)
				sJ: (sJs at: minSepJ)
				dsI: (sIs last - sIs first / sIs size) abs
				dsJ: (sJs last - sJs first / sJs size) abs]
		ifFalse: 
			[maxDepth := 0.0d.
			1 to: penetrations size do: [:i | maxDepth < (penetrations at: i)
					ifTrue: 
						[maxDepth := penetrations at: i.
						maxDepthI := indicesI at: i.
						maxDepthJ := indicesJ at: i]].
			self
				sepDistsI: (sIs at: maxDepthI)
				sJ: (sJs at: maxDepthJ)
				dsI: (sIs last - sIs first / sIs size) abs
				dsJ: (sJs last - sJs first / sJs size) abs]
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> depth: depth sI: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	"No need to check for intersections of curves since the 
	MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."

	frmI sNumber: sI.
	frmJ sNumber: sJ.
	(MinSepMaxPenIeJeNewtonRaphson2 new) system: self; run.
	sepDist := rIeJeO dot: frmI keO.
	^sepDist
]

{ #category : #'initialize-release' }
MbDDistIeqcsJeqcs >> initializeGlobally [
	| sSize |
	sSize := sSizeI + sSizeJ.
	s := FullColumn new: sSize.
	prIeJeps := FullColumn new: sSize.
	pprIeJepsps := FullMatrix new: sSize by: sSize
]

{ #category : #'initialize-release' }
MbDDistIeqcsJeqcs >> initializeLocally [
	super initializeLocally.
	sSizeJ := frmJ sSize.
	s := FullColumn new: sSizeI + sSizeJ.
	prIeJepsJ := FullRow new: sSizeJ.
	pprIeJepXIpsJ := FullMatrix new: 3 by: sSizeJ.
	pprIeJepEIpsJ := FullMatrix new: 4 by: sSizeJ.
	pprIeJepXJpsJ := FullMatrix new: 3 by: sSizeJ.
	pprIeJepEJpsJ := FullMatrix new: 4 by: sSizeJ.
	pprIeJepsIpsJ := FullMatrix new: sSizeI by: sSizeJ.
	pprIeJepsJpsJ := FullMatrix new: sSizeJ by: sSizeJ
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> postLocalSepDistIteration [
	| sSizeI1 |
	super postLocalSepDistIteration.
	sSizeI1 := sSizeI + 1.
	prIeJeps at: sSizeI1 putFullColumn: prIeJepsJ.
	pprIeJepsps
		at: 1
		and: sSizeI1
		putFullMatrix: pprIeJepsIpsJ.
	pprIeJepsps
		at: sSizeI1
		and: sSizeI1
		putFullMatrix: pprIeJepsJpsJ.
	pprIeJepsps symLowerWithUpper
]

{ #category : #accessing }
MbDDistIeqcsJeqcs >> ppvaluepsIpsJ [
	^pprIeJepsIpsJ
]

{ #category : #accessing }
MbDDistIeqcsJeqcs >> ppvaluepsJpsJ [
	^pprIeJepsJpsJ
]

{ #category : #accessing }
MbDDistIeqcsJeqcs >> prIeJepsJ [
	^prIeJepsJ
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> preLocalSepDist [
	| sSizeI1 |
	super preLocalSepDist.
	sSizeI1 := sSizeI + 1.
	s at: sSizeI1 putFullColumn: frmJ s.
	prIeJeps at: sSizeI1 putFullColumn: prIeJepsJ.
	pprIeJepsps at: 1 and: sSizeI1 putFullMatrix: pprIeJepsIpsJ.
	pprIeJepsps at: sSizeI1 and: sSizeI1 putFullMatrix: pprIeJepsJpsJ.
	pprIeJepsps symLowerWithUpper
]

{ #category : #accessing }
MbDDistIeqcsJeqcs >> pvaluepsJ [
	^prIeJepsJ
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDist: minDist sI: sI sJ: sJ dsI: dsI dsJ1: dsJ [ 
	"minDist is upper bound of sepDist."

	"Use MbDMinDistIeJeNewtonRaphson2 first. 
	When sepDist is nearly zero (intersection) or less than zero 
	(penetration) use MinSepMaxPenNewtonRaphson. 
	No need to check for intersections of curves since the 
	MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."

	"MinSepMaxPenNewtonRaphson cannot be used all the time 
	because it has a problem of minimizing 
	rIeJeIe3 instead of rIeJe when small curves are far apart."

	"When all NewtonRaphson fails use minDist from roughMinSep."

	| rIeJeIe |
	frmI sNumber: sI.
	frmJ sNumber: sJ.
	self calcLocalSeparationDistance.
	sepDist < 1.0d-6 
		ifTrue: 
			[frmI sNumber: sI.
			frmJ sNumber: sJ.
			(MinSepMaxPenIeJeNewtonRaphson2 new)
				system: self;
				run.
			rIeJeIe := self rIeJeIe.
			sepDist := ((rIeJeIe at: 1) / (rIeJeIe at: 3)) abs < 0.01d 
						ifTrue: [rIeJeIe at: 3]
						ifFalse: [((rIeJeIe at: 1) squared + (rIeJeIe at: 3) squared) sqrt]].
	sepDist abs > minDist 
		ifTrue: 
			[frmI sNumber: sI.
			frmJ sNumber: sJ.
			self endFramesCalc.
			self calcPostDynCorrectorIteration.
			sepDist := minDist].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDist: minDist sI: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	"minDist is upper bound of sepDist."

	"Use MbDMinDistIeJeNewtonRaphson2 first. 
	When sepDist is nearly zero (intersection) or less than zero 
	(penetration) use MinSepMaxPenNewtonRaphson. 
	No need to check for intersections of curves since the 
	MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."

	"MinSepMaxPenNewtonRaphson cannot be used all the time 
	because it has a problem of minimizing 
	rIeJeIe3 instead of rIeJe when small curves are far apart."

	"When all NewtonRaphson fails use minDist from roughMinSep."

	| rIeJeIe |
	frmI sNumber: sI.
	frmJ sNumber: sJ.
	self calcLocalSeparationDistance.
	sepDist < 1.0d-6 
		ifTrue: 
			[frmI sNumber: sI.
			frmJ sNumber: sJ.
			(MinSepMaxPenIeJeNewtonRaphson2 new)
				system: self;
				run.
			rIeJeIe := self rIeJeIe.
			sepDist := rIeJeIe at: 3].
	sepDist abs > minDist 
		ifTrue: 
			[frmI sNumber: sI.
			frmJ sNumber: sJ.
			self endFramesCalc.
			self calcPostDynCorrectorIteration.
			sepDist := minDist].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI1: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	| tol sIs sJs sIintersect1 sJintersect1 sIintersect2 sJintersect2 |
	frmI sNumber: sI.
	frmJ sNumber: sJ.
	self calcLocalSeparationDistance.
	tol := MachineAccuracy OfDoubleTimesFour.
	sepDist abs > tol ifTrue: [^sepDist].
	sIs := Array
				with: sI - dsI
				with: sI
				with: sI + dsI.
	sJs := Array
				with: sJ - dsJ
				with: sJ
				with: sJ + dsJ.
	sIintersect1 := nil.
	1 to: sIs size do: [:i | 1 to: sJs size
			do: 
				[:j | 
				"Set s in frmI everytime because s is changed by calcLocalSeparationDistance."
				frmI sNumber: (sIs at: i).
				frmJ sNumber: (sJs at: j).
				self calcLocalSeparationDistance.
				sepDist abs > tol
					ifTrue: [^sepDist]
					ifFalse: [sIintersect1 == nil
							ifTrue: 
								[sIintersect1 := frmI sAt1.
								sJintersect1 := frmJ sAt1]
							ifFalse: 
								[self halt.
								sIintersect2 := frmI sAt1.
								sJintersect2 := frmJ sAt1.
								(sIintersect1 - sIintersect2) abs > 1.0d-6
									ifTrue: 
										["Maximum 
										penetration should 
										be midpoint of the 
										intersection points."
										frmI sNumber: sIintersect1 + sIintersect2 / 2.0d.
										frmJ sNumber: sJintersect1 + sJintersect2 / 2.0d.
										self calcLocalSeparationDistance.
										^sepDist]]]]].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI2: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	| tol sIs sJs |
	frmI sNumber: sI.
	frmJ sNumber: sJ.
	self calcLocalSeparationDistance.
	tol := MachineAccuracy OfDoubleTimesFour.
	sepDist abs > tol ifTrue: [^sepDist].
	sIs := Array
				with: sI - dsI
				with: sI
				with: sI + dsI.
	sJs := Array
				with: sJ - dsJ
				with: sJ
				with: sJ + dsJ.
	1 to: sIs size do: [:i | 1 to: sJs size
			do: 
				[:j | 
				"Set s in frmI everytime because s is changed by calcLocalSeparationDistance."
				frmI sNumber: (sIs at: i).
				frmJ sNumber: (sJs at: j).
				self calcLocalSeparationDistance.
				sepDist abs > tol ifTrue: [^sepDist]]].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI3: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	| tol sIs sJs sIi sJj |
	frmI sNumber: sI.
	frmJ sNumber: sJ.
	self calcLocalSeparationDistance.
	tol := MachineAccuracy OfDoubleTimesFour.
	sepDist abs > tol ifTrue: [^sepDist].
	self halt.
	sIs := Array
				with: sI - dsI
				with: sI
				with: sI + dsI.
	sJs := Array
				with: sJ - dsJ
				with: sJ
				with: sJ + dsJ.
	1 to: sIs size do: [:i | 1 to: sJs size
			do: 
				[:j | 
				sIi := sIs at: i.
				sJj := sJs at: j.
				(sIi = sI and: [sJj = sJ])
					ifFalse: 
						["Set s in frmI everytime because s is changed by 
						calcLocalSeparationDistance."
						frmI sNumber: sIi.
						frmJ sNumber: sJj.
						self calcLocalSeparationDistance.
						sepDist abs > tol ifTrue: [^sepDist]]]].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI4: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	"No need to check for intersections of curves since the MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."

	frmI sNumber: sI.
	frmJ sNumber: sJ.
	self calcLocalSeparationDistance.
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI5: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	"No need to check for intersections of curves since the 
	MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."
	"MinSepMaxPenNewtonRaphson has a problem of minimizing 
	rIeJeIe3 instead of rIeJe when small curves are far apart. Check 
	that sepDist ~= sepDist2. Otherwise use plain 
	MbDMinDistIeJeNewtonRaphson2."

	| sepDist2 |
	frmI sNumber: sI.
	frmJ sNumber: sJ.
	newtonRaphson run.
	sepDist := rIeJeO dot: frmI keO.
sepDist < 0 ifTrue: [self halt].
	sepDist2 := (rIeJeO sumOfSquares - (rIeJeO dot: frmI jeO) squared) sqrt.
	((sepDist / sepDist2) abs - 1.0d) abs > 0.01d
		ifTrue: 
			[self halt.
			frmI sNumber: sI.
			frmJ sNumber: sJ.
			(MbDMinDistIeJeNewtonRaphson2 new) system: self; run.
			sepDist := rIeJeO dot: frmI keO].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI6: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	"Use MbDMinDistIeJeNewtonRaphson2 first. 
	When sepDist is nearly zero (intersection) or less than zero 
	(penetration) use MinSepMaxPenNewtonRaphson. 
	No need to check for intersections of curves since the 
	MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."
	"MinSepMaxPenNewtonRaphson cannot be used all the time 
	because it has a problem of minimizing 
	rIeJeIe3 instead of rIeJe when small curves are far apart."

	frmI sNumber: sI.
	frmJ sNumber: sJ.
	newtonRaphson run.
	sepDist := rIeJeO dot: frmI keO.
	sepDist < 1.0d-6
		ifTrue: 
			[self halt.
			frmI sNumber: sI.
			frmJ sNumber: sJ.
			(MinSepMaxPenIeJeNewtonRaphson2 new) system: self; run.
			sepDist := rIeJeO dot: frmI keO].
	^sepDist
]

{ #category : #calc }
MbDDistIeqcsJeqcs >> sepDistsI: sI sJ: sJ dsI: dsI dsJ: dsJ [ 
	"Use MbDMinDistIeJeNewtonRaphson2 first. 
	When sepDist is nearly zero (intersection) or less than zero 
	(penetration) use MinSepMaxPenNewtonRaphson. 
	No need to check for intersections of curves since the 
	MinSepMaxPenNewtonRaphson solver will 
	not find intersects of curves."
	"MinSepMaxPenNewtonRaphson cannot be used all the time 
	because it has a problem of minimizing 
	rIeJeIe3 instead of rIeJe when small curves are far apart."

	frmI sNumber: sI.
	frmJ sNumber: sJ.
	newtonRaphson run.
	sepDist := rIeJeO dot: frmI keO.
	sepDist < 1.0d-6
		ifTrue: 
			[self halt.
			frmI sNumber: sI.
			frmJ sNumber: sJ.
			(MinSepMaxPenIeJeNewtonRaphson2 new) system: self; run.
			sepDist := rIeJeO dot: frmI keO].
	^sepDist
]

{ #category : #accessing }
MbDDistIeqcsJeqcs >> setEndFramess [
	super setEndFramess.
	frmJ s equalFullColumn: s at: sSizeI + 1
]

{ #category : #dynamic }
MbDDistIeqcsJeqcs >> storeDynState [
	frmI storeDynState.
	frmJ storeDynState
]

{ #category : #'initialize-release' }
MbDDistIeqcsJeqcs >> withFrmI: afrmI frmJ: afrmJ [ 
	super withFrmI: afrmI frmJ: afrmJ.
	newtonRaphson := MbDMinDistIeJeNewtonRaphson2 new.
	newtonRaphson system: self
]
