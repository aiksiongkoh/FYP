Class {
	#name : #MbDNonlinearCoupler,
	#superclass : #MbDCouplerConstraint,
	#instVars : [
		'couplerFunction',
		'n',
		'iqXIs',
		'iqEIs',
		'iqXJs',
		'iqEJs',
		'pGpXIs',
		'pGpEIs',
		'pGpXJs',
		'pGpEJs'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDNonlinearCoupler class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDNonlinearCoupler >> calcPostDynCorrectorIteration [
	"ppGpqpq is too complicated to store and will be computed on the fly."

	| kineIJs pfuncpkineIJs kineIJi pfuncpkineIJi pvaluepXI pvaluepEI pvaluepXJ pvaluepEJ |
	aG := couplerFunction func.
	kineIJs := couplerFunction kineIJs.
	pfuncpkineIJs := couplerFunction pfuncpkineIJs.
	1 to: n do: [:i | 
			kineIJi := kineIJs at: i.
			pfuncpkineIJi := pfuncpkineIJs at: i.
			pvaluepXI := kineIJi pvaluepXI.
			pvaluepXI == nil ifFalse: [(pGpXIs at: i) equalFullRow: pvaluepXI times: pfuncpkineIJi].
			pvaluepEI := kineIJi pvaluepEI.
			pvaluepEI == nil ifFalse: [(pGpEIs at: i) equalFullRow: pvaluepEI times: pfuncpkineIJi].
			pvaluepXJ := kineIJi pvaluepXJ.
			pvaluepXJ == nil ifFalse: [(pGpXJs at: i) equalFullRow: pvaluepXJ times: pfuncpkineIJi].
			pvaluepEJ := kineIJi pvaluepEJ.
			pvaluepEJ == nil ifFalse: [(pGpEJs at: i) equalFullRow: pvaluepEJ times: pfuncpkineIJi]]
]

{ #category : #accIC }
MbDNonlinearCoupler >> fillAccICIterError: col [ 
	| kineIJs sum kineIJi pFrmIi pFrmJi pGpXIi pGpEIi pGpXJi pGpEJi |
	kineIJs := couplerFunction kineIJs.
	sum := 0.0d.
	1 to: n
		do: 
			[:i | 
			kineIJi := kineIJs at: i.
			pFrmIi := kineIJi partFrameI.
			pFrmJi := kineIJi partFrameJ.
			col at: (iqXIs at: i) plusFullColumn: (pGpXIi := pGpXIs at: i) times: lam.
			col at: (iqEIs at: i) plusFullColumn: (pGpEIi := pGpEIs at: i) times: lam.
			col at: (iqXJs at: i) plusFullColumn: (pGpXJi := pGpXJs at: i) times: lam.
			col at: (iqEJs at: i) plusFullColumn: (pGpEJi := pGpEJs at: i) times: lam.
			sum := sum + (pGpXIi timesFullColumn: pFrmIi qXddot).
			sum := sum + (pGpEIi timesFullColumn: pFrmIi qEddot).
			sum := sum + (pGpXJi timesFullColumn: pFrmJi qXddot).
			sum := sum + (pGpEJi timesFullColumn: pFrmJi qEddot)].
	col at: iG plusNumber: sum.
	self fillAccICIterErrorppGpqpq: col
]

{ #category : #accIC }
MbDNonlinearCoupler >> fillAccICIterErrorppGpqpq: col [ 
	| kineIJs pfuncpkineIJs ppfuncpkineIJpkineIJs kineIJi pfuncpkineIJi ppfuncpkineIJpkineIJi ppfuncpkineIJpkineIJii kineIJj ppfuncpkineIJpkineIJij |
	kineIJs := couplerFunction kineIJs.
	pfuncpkineIJs := couplerFunction pfuncpkineIJs.
	ppfuncpkineIJpkineIJs := couplerFunction ppfuncpkineIJpkineIJs.
	1 to: n
		do: 
			[:i | 
			kineIJi := kineIJs at: i.
			pfuncpkineIJi := pfuncpkineIJs at: i.
			pfuncpkineIJi == 0 ifFalse: [self
					fillAccICIterErrorppGpqpq: col
					kineIJ: kineIJi
					pfuncpkineIJ: pfuncpkineIJi].
			ppfuncpkineIJpkineIJi := ppfuncpkineIJpkineIJs at: i.
			ppfuncpkineIJpkineIJii := ppfuncpkineIJpkineIJi at: i.
			ppfuncpkineIJpkineIJii == 0 ifFalse: [self
					fillAccICIterErrorppGpqpq: col
					kineIJ: kineIJi
					ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJii].
			i + 1 to: n
				do: 
					[:j | 
					kineIJj := kineIJs at: j.
					ppfuncpkineIJpkineIJij := ppfuncpkineIJpkineIJi at: j.
					ppfuncpkineIJpkineIJij == 0 ifFalse: [self
							fillAccICIterErrorppGpqpq: col
							kineIJi: kineIJi
							kineIJj: kineIJj
							ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJij]]]
]

{ #category : #accIC }
MbDNonlinearCoupler >> fillAccICIterErrorppGpqpq: col kineIJ: kineIJ pfuncpkineIJ: pfuncpkineIJ [ 
	| sum qXdotI qEdotI qXdotJ qEdotJ ppvaluepXIpXI term ppvaluepXIpEI ppvaluepXIpXJ ppvaluepXIpEJ ppvaluepEIpEI ppvaluepEIpXJ ppvaluepEIpEJ ppvaluepXJpXJ ppvaluepXJpEJ ppvaluepEJpEJ pfrmI pfrmJ |
	pfuncpkineIJ == 0
		ifFalse: 
			[sum := 0.0d.
			pfrmI := kineIJ partFrameI.
			pfrmJ := kineIJ partFrameJ.
			qXdotI := pfrmI qXdot.
			qEdotI := pfrmI qEdot.
			qXdotJ := pfrmJ qXdot.
			qEdotJ := pfrmJ qEdot.
			(ppvaluepXIpXI := kineIJ ppvaluepXIpXI) == nil
				ifFalse: 
					[term := pfuncpkineIJ * (qXdotI dot: (ppvaluepXIpXI timesFullColumn: qXdotI)).
					sum := sum + term].
			(ppvaluepXIpEI := kineIJ ppvaluepXIpEI) == nil
				ifFalse: 
					[term := 2.0d * pfuncpkineIJ * (qXdotI dot: (ppvaluepXIpEI timesFullColumn: qEdotI)).
					sum := sum + term].
			(ppvaluepXIpXJ := kineIJ ppvaluepXIpXJ) == nil
				ifFalse: 
					[term := 2.0d * pfuncpkineIJ * (qXdotI dot: (ppvaluepXIpXJ timesFullColumn: qXdotJ)).
					sum := sum + term].
			(ppvaluepXIpEJ := kineIJ ppvaluepXIpEJ) == nil
				ifFalse: 
					[term := 2.0d * pfuncpkineIJ * (qXdotI dot: (ppvaluepXIpEJ timesFullColumn: qEdotJ)).
					sum := sum + term].
			(ppvaluepEIpEI := kineIJ ppvaluepEIpEI) == nil
				ifFalse: 
					[term := pfuncpkineIJ * (qEdotI dot: (ppvaluepEIpEI timesFullColumn: qEdotI)).
					sum := sum + term].
			(ppvaluepEIpXJ := kineIJ ppvaluepEIpXJ) == nil
				ifFalse: 
					[term := 2.0d * pfuncpkineIJ * (qEdotI dot: (ppvaluepEIpXJ timesFullColumn: qXdotJ)).
					sum := sum + term].
			(ppvaluepEIpEJ := kineIJ ppvaluepEIpEJ) == nil
				ifFalse: 
					[term := 2.0d * pfuncpkineIJ * (qEdotI dot: (ppvaluepEIpEJ timesFullColumn: qEdotJ)).
					sum := sum + term].
			(ppvaluepXJpXJ := kineIJ ppvaluepXJpXJ) == nil
				ifFalse: 
					[term := pfuncpkineIJ * (qXdotJ dot: (ppvaluepXJpXJ timesFullColumn: qXdotJ)).
					sum := sum + term].
			(ppvaluepXJpEJ := kineIJ ppvaluepXJpEJ) == nil
				ifFalse: 
					[term := 2.0d * pfuncpkineIJ * (qXdotJ dot: (ppvaluepXJpEJ timesFullColumn: qEdotJ)).
					sum := sum + term].
			(ppvaluepEJpEJ := kineIJ ppvaluepEJpEJ) == nil
				ifFalse: 
					[term := pfuncpkineIJ * (qEdotJ dot: (ppvaluepEJpEJ timesFullColumn: qEdotJ)).
					sum := sum + term]].
	col at: iG plusNumber: sum
]

{ #category : #accIC }
MbDNonlinearCoupler >> fillAccICIterErrorppGpqpq: col kineIJ: kineIJ ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJ [ 
	| sum pvaluepXI pvaluepEI pvaluepXJ pvaluepEJ pvaluepXIqXdotI pvaluepEIqEdotI pvaluepXJqXdotJ pvaluepEJqEdotJ term |
	ppfuncpkineIJpkineIJ == 0
		ifFalse: 
			[sum := 0.0d.
			pvaluepXI := kineIJ pvaluepXI.
			pvaluepEI := kineIJ pvaluepEI.
			pvaluepXJ := kineIJ pvaluepXJ.
			pvaluepEJ := kineIJ pvaluepEJ.
			pvaluepXIqXdotI := pvaluepXI == nil ifFalse: [pvaluepXI dot: kineIJ qXdotI].
			pvaluepEIqEdotI := pvaluepEI == nil ifFalse: [pvaluepEI dot: kineIJ qEdotI].
			pvaluepXJqXdotJ := pvaluepXJ == nil ifFalse: [pvaluepXJ dot: kineIJ qXdotJ].
			pvaluepEJqEdotJ := pvaluepEJ == nil ifFalse: [pvaluepEJ dot: kineIJ qEdotJ].
			pvaluepXI == nil
				ifFalse: 
					[term := ppfuncpkineIJpkineIJ * pvaluepXIqXdotI * pvaluepXIqXdotI.
					sum := sum + term.
					pvaluepEI == nil
						ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotI * pvaluepEIqEdotI.
							sum := sum + term].
					pvaluepXJ == nil
						ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotI * pvaluepXJqXdotJ.
							sum := sum + term].
					pvaluepEJ == nil
						ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotI * pvaluepEJqEdotJ.
							sum := sum + term]].
			pvaluepEI == nil
				ifFalse: 
					[term := ppfuncpkineIJpkineIJ * pvaluepEIqEdotI * pvaluepEIqEdotI.
					sum := sum + term.
					pvaluepXJ == nil
						ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEIqEdotI * pvaluepXJqXdotJ.
							sum := sum + term].
					pvaluepEJ == nil
						ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEIqEdotI * pvaluepEJqEdotJ.
							sum := sum + term]].
			pvaluepXJ == nil
				ifFalse: 
					[term := ppfuncpkineIJpkineIJ * pvaluepXJqXdotJ * pvaluepXJqXdotJ.
					sum := sum + term.
					pvaluepEJ == nil
						ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXJqXdotJ * pvaluepEJqEdotJ.
							sum := sum + term]].
			pvaluepEJ == nil
				ifFalse: 
					[term := ppfuncpkineIJpkineIJ * pvaluepEJqEdotJ * pvaluepEJqEdotJ.
					sum := sum + term]].
	col at: iG plusNumber: sum
]

{ #category : #accIC }
MbDNonlinearCoupler >> fillAccICIterErrorppGpqpq: col kineIJi: kineIJi kineIJj: kineIJj ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJ [ 
	| sum pvaluepXIi pvaluepEIi pvaluepXJi pvaluepEJi pvaluepXIqXdotIi pvaluepEIqEdotIi pvaluepXJqXdotJi pvaluepEJqEdotJi pvaluepXIj pvaluepEIj pvaluepXJj pvaluepEJj pvaluepXIqXdotIj pvaluepEIqEdotIj pvaluepXJqXdotJj pvaluepEJqEdotJj term |
	ppfuncpkineIJpkineIJ == 0
		ifFalse: 
			[sum := 0.0d.
			pvaluepXIi := kineIJi pvaluepXI.
			pvaluepEIi := kineIJi pvaluepEI.
			pvaluepXJi := kineIJi pvaluepXJ.
			pvaluepEJi := kineIJi pvaluepEJ.
			pvaluepXIqXdotIi := pvaluepXIi == nil ifFalse: [pvaluepXIi dot: kineIJi qXdotI].
			pvaluepEIqEdotIi := pvaluepEIi == nil ifFalse: [pvaluepEIi dot: kineIJi qEdotI].
			pvaluepXJqXdotJi := pvaluepXJi == nil ifFalse: [pvaluepXJi dot: kineIJi qXdotJ].
			pvaluepEJqEdotJi := pvaluepEJi == nil ifFalse: [pvaluepEJi dot: kineIJi qEdotJ].
			pvaluepXIj := kineIJj pvaluepXI.
			pvaluepEIj := kineIJj pvaluepEI.
			pvaluepXJj := kineIJj pvaluepXJ.
			pvaluepEJj := kineIJj pvaluepEJ.
			pvaluepXIqXdotIj := pvaluepXIj == nil ifFalse: [pvaluepXIj dot: kineIJj qXdotI].
			pvaluepEIqEdotIj := pvaluepEIj == nil ifFalse: [pvaluepEIj dot: kineIJj qEdotI].
			pvaluepXJqXdotJj := pvaluepXJj == nil ifFalse: [pvaluepXJj dot: kineIJj qXdotJ].
			pvaluepEJqEdotJj := pvaluepEJj == nil ifFalse: [pvaluepEJj dot: kineIJj qEdotJ].
			pvaluepXIi == nil ifFalse: 
					[pvaluepXIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotIi * pvaluepXIqXdotIj.
							sum := sum + term].
					pvaluepEIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotIi * pvaluepEIqEdotIj.
							sum := sum + term].
					pvaluepXJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotIi * pvaluepXJqXdotJj.
							sum := sum + term].
					pvaluepEJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXIqXdotIi * pvaluepEJqEdotJj.
							sum := sum + term]].
			pvaluepEIi == nil ifFalse: 
					[pvaluepXIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEIqEdotIi * pvaluepXIqXdotIj.
							sum := sum + term].
					pvaluepEIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEIqEdotIi * pvaluepEIqEdotIj.
							sum := sum + term].
					pvaluepXJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEIqEdotIi * pvaluepXJqXdotJj.
							sum := sum + term].
					pvaluepEJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEIqEdotIi * pvaluepEJqEdotJj.
							sum := sum + term]].
			pvaluepXJi == nil ifFalse: 
					[pvaluepXIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXJqXdotJi * pvaluepXIqXdotIj.
							sum := sum + term].
					pvaluepEIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXJqXdotJi * pvaluepEIqEdotIj.
							sum := sum + term].
					pvaluepXJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXJqXdotJi * pvaluepXJqXdotJj.
							sum := sum + term].
					pvaluepEJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepXJqXdotJi * pvaluepEJqEdotJj.
							sum := sum + term]].
			pvaluepEJi == nil ifFalse: 
					[pvaluepXIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEJqEdotJi * pvaluepXIqXdotIj.
							sum := sum + term].
					pvaluepEIj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEJqEdotJi * pvaluepEIqEdotIj.
							sum := sum + term].
					pvaluepXJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEJqEdotJi * pvaluepXJqXdotJj.
							sum := sum + term].
					pvaluepEJj == nil ifFalse: 
							[term := 2.0d * ppfuncpkineIJpkineIJ * pvaluepEJqEdotJi * pvaluepEJqEdotJj.
							sum := sum + term]]].
	col at: iG plusNumber: sum
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosICError: col [ 
	super fillPosICError: col.
	1 to: n do: [:i | 
			col at: (iqXIs at: i) plusFullColumn: (pGpXIs at: i) times: lam.
			col at: (iqXJs at: i) plusFullColumn: (pGpXJs at: i) times: lam.
			col at: (iqEIs at: i) plusFullColumn: (pGpEIs at: i) times: lam.
			col at: (iqEJs at: i) plusFullColumn: (pGpEJs at: i) times: lam]
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosICJacob: mat [ 
	| iqXIi pGpXIi iqXJi pGpXJi iqEIi pGpEIi iqEJi pGpEJi |
	1 to: n do: [:i | 
			mat at: iG and: (iqXIi := iqXIs at: i) plusFullRow: (pGpXIi := pGpXIs at: i).
			mat at: iqXIi and: iG plusFullColumn: pGpXIi transpose.
			mat at: iG and: (iqXJi := iqXJs at: i) plusFullRow: (pGpXJi := pGpXJs at: i).
			mat at: iqXJi and: iG plusFullColumn: pGpXJi transpose.
			mat at: iG and: (iqEIi := iqEIs at: i) plusFullRow: (pGpEIi := pGpEIs at: i).
			mat at: iqEIi and: iG plusFullColumn: pGpEIi transpose.
			mat at: iG and: (iqEJi := iqEJs at: i) plusFullRow: (pGpEJi := pGpEJs at: i).
			mat at: iqEJi and: iG plusFullColumn: pGpEJi transpose].
	self fillPosICJacobppGpqpq: mat
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosICJacobppGpqpq: mat [ 
	| kineIJs pfuncpkineIJs ppfuncpkineIJpkineIJs kineIJi pfuncpkineIJi ppfuncpkineIJpkineIJi ppfuncpkineIJpkineIJii kineIJj ppfuncpkineIJpkineIJij |
	kineIJs := couplerFunction kineIJs.
	pfuncpkineIJs := couplerFunction pfuncpkineIJs.
	ppfuncpkineIJpkineIJs := couplerFunction ppfuncpkineIJpkineIJs.
	1 to: n
		do: 
			[:i | 
			kineIJi := kineIJs at: i.
			pfuncpkineIJi := pfuncpkineIJs at: i.
			pfuncpkineIJi == 0 ifFalse: [self
					fillPosICJacobppGpqpq: mat
					kineIJ: kineIJi
					pfuncpkineIJ: pfuncpkineIJi].
			ppfuncpkineIJpkineIJi := ppfuncpkineIJpkineIJs at: i.
			ppfuncpkineIJpkineIJii := ppfuncpkineIJpkineIJi at: i.
			ppfuncpkineIJpkineIJii == 0 ifFalse: [self
					fillPosICJacobppGpqpq: mat
					kineIJ: kineIJi
					ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJii].
			i + 1 to: n
				do: 
					[:j | 
					kineIJj := kineIJs at: j.
					ppfuncpkineIJpkineIJij := ppfuncpkineIJpkineIJi at: j.
					ppfuncpkineIJpkineIJij == 0 ifFalse: [self
							fillPosICJacobppGpqpq: mat
							kineIJi: kineIJi
							kineIJj: kineIJj
							ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJij]]]
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosICJacobppGpqpq: mat kineIJ: kineIJ pfuncpkineIJ: pfuncpkineIJ [ 
	| pfrmI pfrmJ iqXI iqEI iqXJ iqEJ factor ppvaluepXIpXI ppvaluepXIpEI ppGpXIpEIlam ppvaluepXIpXJ ppGpXIpXJlam ppvaluepXIpEJ ppGpXIpEJlam ppvaluepEIpEI ppvaluepEIpXJ ppGpEIpXJlam ppvaluepEIpEJ ppGpEIpEJlam ppvaluepXJpXJ ppvaluepXJpEJ ppGpXJpEJlam ppvaluepEJpEJ |
	pfuncpkineIJ == 0
		ifFalse: 
			[pfrmI := kineIJ partFrameI.
			pfrmJ := kineIJ partFrameJ.
			iqXI := pfrmI iqX.
			iqEI := pfrmI iqE.
			iqXJ := pfrmJ iqX.
			iqEJ := pfrmJ iqE.
			factor := pfuncpkineIJ * lam.
			(ppvaluepXIpXI := kineIJ ppvaluepXIpXI) == nil
				ifFalse: 
					[mat at: iqXI and: iqXI plusFullMatrix: ppvaluepXIpXI times: factor].
			(ppvaluepXIpEI := kineIJ ppvaluepXIpEI) == nil
				ifFalse: 
					[mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppvaluepXIpEI times: factor).
					mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam].
			(ppvaluepXIpXJ := kineIJ ppvaluepXIpXJ) == nil
				ifFalse: 
					[mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJlam := ppvaluepXIpXJ times: factor).
					mat at: iqXJ and: iqXI plusTransposeFullMatrix: ppGpXIpXJlam].
			(ppvaluepXIpEJ := kineIJ ppvaluepXIpEJ) == nil
				ifFalse: 
					[mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJlam := ppvaluepXIpEJ times: factor).
					mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam].
			(ppvaluepEIpEI := kineIJ ppvaluepEIpEI) == nil
				ifFalse: 
					[mat at: iqEI and: iqEI plusFullMatrix: ppvaluepEIpEI times: factor].
			(ppvaluepEIpXJ := kineIJ ppvaluepEIpXJ) == nil
				ifFalse: 
					[mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJlam := ppvaluepEIpXJ times: factor).
					mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam].
			(ppvaluepEIpEJ := kineIJ ppvaluepEIpEJ) == nil
				ifFalse: 
					[mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJlam := ppvaluepEIpEJ times: factor).
					mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam].
			(ppvaluepXJpXJ := kineIJ ppvaluepXJpXJ) == nil
				ifFalse: 
					[mat at: iqXJ and: iqXJ plusFullMatrix: ppvaluepXJpXJ times: factor].
			(ppvaluepXJpEJ := kineIJ ppvaluepXJpEJ) == nil
				ifFalse: 
					[mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJlam := ppvaluepXJpEJ times: factor).
					mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam].
			(ppvaluepEJpEJ := kineIJ ppvaluepEJpEJ) == nil
				ifFalse: 
					[mat at: iqEJ and: iqEJ plusFullMatrix: ppvaluepEJpEJ times: factor]]
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosICJacobppGpqpq: mat kineIJ: kineIJ ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJ [ 
	| pfrmI pfrmJ iqXI iqEI iqXJ iqEJ pvaluepXI pvaluepEI pvaluepXJ pvaluepEJ factor ppGpXIpEIlam ppGpXIpXJlam ppGpXIpEJlam ppGpEIpXJlam ppGpEIpEJlam ppGpXJpEJlam |
	ppfuncpkineIJpkineIJ == 0
		ifFalse: 
			[pfrmI := kineIJ partFrameI.
			pfrmJ := kineIJ partFrameJ.
			iqXI := pfrmI iqX.
			iqEI := pfrmI iqE.
			iqXJ := pfrmJ iqX.
			iqEJ := pfrmJ iqE.
			pvaluepXI := kineIJ pvaluepXI asFullRow.
			pvaluepEI := kineIJ pvaluepEI asFullRow.
			pvaluepXJ := kineIJ pvaluepXJ asFullRow.
			pvaluepEJ := kineIJ pvaluepEJ asFullRow.
			factor := ppfuncpkineIJpkineIJ * lam.
			pvaluepXI == nil
				ifFalse: 
					[mat at: iqXI and: iqXI plusFullMatrix: (pvaluepXI transposeTimesFullRow: pvaluepXI) times: factor.
					pvaluepEI == nil
						ifFalse: 
							[ppGpXIpEIlam := (pvaluepXI transposeTimesFullRow: pvaluepEI) times: factor.
							mat at: iqXI and: iqEI plusFullMatrix: ppGpXIpEIlam.
							mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam].
					pvaluepXJ == nil
						ifFalse: 
							[ppGpXIpXJlam := (pvaluepXI transposeTimesFullRow: pvaluepXJ) times: factor.
							mat at: iqXI and: iqXJ plusFullMatrix: ppGpXIpXJlam.
							mat at: iqXJ and: iqXI plusTransposeFullMatrix: ppGpXIpXJlam].
					pvaluepEJ == nil
						ifFalse: 
							[ppGpXIpEJlam := (pvaluepXI transposeTimesFullRow: pvaluepEJ) times: factor.
							mat at: iqXI and: iqEJ plusFullMatrix: ppGpXIpEJlam.
							mat at: iqEJ and: iqXI plusTransposeFullMatrix: ppGpXIpEJlam]].
			pvaluepEI == nil
				ifFalse: 
					[mat at: iqEI and: iqEI plusFullMatrix: (pvaluepEI transposeTimesFullRow: pvaluepEI) times: factor.
					pvaluepXJ == nil
						ifFalse: 
							[ppGpEIpXJlam := (pvaluepEI transposeTimesFullRow: pvaluepXJ) times: factor.
							mat at: iqEI and: iqXJ plusFullMatrix: ppGpEIpXJlam.
							mat at: iqXJ and: iqEI plusTransposeFullMatrix: ppGpEIpXJlam].
					pvaluepEJ == nil
						ifFalse: 
							[ppGpEIpEJlam := (pvaluepEI transposeTimesFullRow: pvaluepEJ) times: factor.
							mat at: iqEI and: iqEJ plusFullMatrix: ppGpEIpEJlam.
							mat at: iqEJ and: iqEI plusTransposeFullMatrix: ppGpEIpEJlam]].
			pvaluepXJ == nil
				ifFalse: 
					[mat at: iqXJ and: iqXJ plusFullMatrix: (pvaluepXJ transposeTimesFullRow: pvaluepXJ) times: factor.
					pvaluepEJ == nil
						ifFalse: 
							[ppGpXJpEJlam := (pvaluepXJ transposeTimesFullRow: pvaluepEJ) times: factor.
							mat at: iqXJ and: iqEJ plusFullMatrix: ppGpXJpEJlam.
							mat at: iqEJ and: iqXJ plusTransposeFullMatrix: ppGpXJpEJlam]].
			pvaluepEJ == nil
				ifFalse: 
					[mat at: iqEJ and: iqEJ plusFullMatrix: (pvaluepEJ transposeTimesFullRow: pvaluepEJ) times: factor]]
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosICJacobppGpqpq: mat kineIJi: kineIJi kineIJj: kineIJj ppfuncpkineIJpkineIJ: ppfuncpkineIJpkineIJ [ 
	| pfrmIi pfrmJi iqXIi iqEIi iqXJi iqEJi pvaluepXIi pvaluepEIi pvaluepXJi pvaluepEJi iqXIj pfrmIj pfrmJj iqEIj iqXJj iqEJj pvaluepXIj pvaluepEIj pvaluepXJj pvaluepEJj factor ppGpXIpXIijlam ppGpXIpEIijlam ppGpXIpXJijlam ppGpXIpEJijlam ppGpEIpXIijlam ppGpEIpEIijlam ppGpEIpXJijlam ppGpEIpEJijlam ppGpXJpXIijlam ppGpXJpEIijlam ppGpXJpXJijlam ppGpXJpEJijlam ppGpEJpXIijlam ppGpEJpEIijlam ppGpEJpXJijlam ppGpEJpEJijlam |
	ppfuncpkineIJpkineIJ == 0
		ifFalse: 
			[pfrmIi := kineIJi partFrameI.
			pfrmJi := kineIJi partFrameJ.
			iqXIi := pfrmIi iqX.
			iqEIi := pfrmIi iqE.
			iqXJi := pfrmJi iqX.
			iqEJi := pfrmJi iqE.
			pvaluepXIi := kineIJi pvaluepXI asFullRow.
			pvaluepEIi := kineIJi pvaluepEI asFullRow.
			pvaluepXJi := kineIJi pvaluepXJ asFullRow.
			pvaluepEJi := kineIJi pvaluepEJ asFullRow.
			pfrmIj := kineIJj partFrameI.
			pfrmJj := kineIJj partFrameJ.
			iqXIj := pfrmIj iqX.
			iqEIj := pfrmIj iqE.
			iqXJj := pfrmJj iqX.
			iqEJj := pfrmJj iqE.
			pvaluepXIj := kineIJj pvaluepXI asFullRow.
			pvaluepEIj := kineIJj pvaluepEI asFullRow.
			pvaluepXJj := kineIJj pvaluepXJ asFullRow.
			pvaluepEJj := kineIJj pvaluepEJ asFullRow.
			factor := ppfuncpkineIJpkineIJ * lam.
			pvaluepXIi == nil
				ifFalse: 
					[pvaluepXIj == nil
						ifFalse: 
							[ppGpXIpXIijlam := (pvaluepXIi transposeTimesFullRow: pvaluepXIj) times: factor.
							mat at: iqXIi and: iqXIj plusFullMatrix: ppGpXIpXIijlam.
							mat at: iqXIj and: iqXIi plusTransposeFullMatrix: ppGpXIpXIijlam].
					pvaluepEIj == nil
						ifFalse: 
							[ppGpXIpEIijlam := (pvaluepXIi transposeTimesFullRow: pvaluepEIj) times: factor.
							mat at: iqXIi and: iqEIj plusFullMatrix: ppGpXIpEIijlam.
							mat at: iqEIj and: iqXIi plusTransposeFullMatrix: ppGpXIpEIijlam].
					pvaluepXJj == nil
						ifFalse: 
							[ppGpXIpXJijlam := (pvaluepXIi transposeTimesFullRow: pvaluepXJj) times: factor.
							mat at: iqXIi and: iqXJj plusFullMatrix: ppGpXIpXJijlam.
							mat at: iqXJj and: iqXIi plusTransposeFullMatrix: ppGpXIpXJijlam].
					pvaluepEJj == nil
						ifFalse: 
							[ppGpXIpEJijlam := (pvaluepXIi transposeTimesFullRow: pvaluepEJj) times: factor.
							mat at: iqXIi and: iqEJj plusFullMatrix: ppGpXIpEJijlam.
							mat at: iqEJj and: iqXIi plusTransposeFullMatrix: ppGpXIpEJijlam]].
			pvaluepEIi == nil
				ifFalse: 
					[pvaluepXIj == nil
						ifFalse: 
							[ppGpEIpXIijlam := (pvaluepEIi transposeTimesFullRow: pvaluepXIj) times: factor.
							mat at: iqEIi and: iqXIj plusFullMatrix: ppGpEIpXIijlam.
							mat at: iqXIj and: iqEIi plusTransposeFullMatrix: ppGpEIpXIijlam].
					pvaluepEIj == nil
						ifFalse: 
							[ppGpEIpEIijlam := (pvaluepEIi transposeTimesFullRow: pvaluepEIj) times: factor.
							mat at: iqEIi and: iqEIj plusFullMatrix: ppGpEIpEIijlam.
							mat at: iqEIj and: iqEIi plusTransposeFullMatrix: ppGpEIpEIijlam].
					pvaluepXJj == nil
						ifFalse: 
							[ppGpEIpXJijlam := (pvaluepEIi transposeTimesFullRow: pvaluepXJj) times: factor.
							mat at: iqEIi and: iqXJj plusFullMatrix: ppGpEIpXJijlam.
							mat at: iqXJj and: iqEIi plusTransposeFullMatrix: ppGpEIpXJijlam].
					pvaluepEJj == nil
						ifFalse: 
							[ppGpEIpEJijlam := (pvaluepEIi transposeTimesFullRow: pvaluepEJj) times: factor.
							mat at: iqEIi and: iqEJj plusFullMatrix: ppGpEIpEJijlam.
							mat at: iqEJj and: iqEIi plusTransposeFullMatrix: ppGpEIpEJijlam]].
			pvaluepXJi == nil
				ifFalse: 
					[pvaluepXIj == nil
						ifFalse: 
							[ppGpXJpXIijlam := (pvaluepXJi transposeTimesFullRow: pvaluepXIj) times: factor.
							mat at: iqXJi and: iqXIj plusFullMatrix: ppGpXJpXIijlam.
							mat at: iqXIj and: iqXJi plusTransposeFullMatrix: ppGpXJpXIijlam].
					pvaluepEIj == nil
						ifFalse: 
							[ppGpXJpEIijlam := (pvaluepXJi transposeTimesFullRow: pvaluepEIj) times: factor.
							mat at: iqXJi and: iqEIj plusFullMatrix: ppGpXJpEIijlam.
							mat at: iqEIj and: iqXJi plusTransposeFullMatrix: ppGpXJpEIijlam].
					pvaluepXJj == nil
						ifFalse: 
							[ppGpXJpXJijlam := (pvaluepXJi transposeTimesFullRow: pvaluepXJj) times: factor.
							mat at: iqXJi and: iqXJj plusFullMatrix: ppGpXJpXJijlam.
							mat at: iqXJj and: iqXJi plusTransposeFullMatrix: ppGpXJpXJijlam].
					pvaluepEJj == nil
						ifFalse: 
							[ppGpXJpEJijlam := (pvaluepXJi transposeTimesFullRow: pvaluepEJj) times: factor.
							mat at: iqXJi and: iqEJj plusFullMatrix: ppGpXJpEJijlam.
							mat at: iqEJj and: iqXJi plusTransposeFullMatrix: ppGpXJpEJijlam]].
			pvaluepEJi == nil
				ifFalse: 
					[pvaluepXIj == nil
						ifFalse: 
							[ppGpEJpXIijlam := (pvaluepEJi transposeTimesFullRow: pvaluepXIj) times: factor.
							mat at: iqEJi and: iqXIj plusFullMatrix: ppGpEJpXIijlam.
							mat at: iqXIj and: iqEJi plusTransposeFullMatrix: ppGpEJpXIijlam].
					pvaluepEIj == nil
						ifFalse: 
							[ppGpEJpEIijlam := (pvaluepEJi transposeTimesFullRow: pvaluepEIj) times: factor.
							mat at: iqEJi and: iqEIj plusFullMatrix: ppGpEJpEIijlam.
							mat at: iqEIj and: iqEJi plusTransposeFullMatrix: ppGpEJpEIijlam].
					pvaluepXJj == nil
						ifFalse: 
							[ppGpEJpXJijlam := (pvaluepEJi transposeTimesFullRow: pvaluepXJj) times: factor.
							mat at: iqEJi and: iqXJj plusFullMatrix: ppGpEJpXJijlam.
							mat at: iqXJj and: iqEJi plusTransposeFullMatrix: ppGpEJpXJijlam].
					pvaluepEJj == nil
						ifFalse: 
							[ppGpEJpEJijlam := (pvaluepEJi transposeTimesFullRow: pvaluepEJj) times: factor.
							mat at: iqEJi and: iqEJj plusFullMatrix: ppGpEJpEJijlam.
							mat at: iqEJj and: iqEJi plusTransposeFullMatrix: ppGpEJpEJijlam]]]
]

{ #category : #posIC }
MbDNonlinearCoupler >> fillPosKineJacob: mat [ 
	1 to: n
		do: 
			[:i | 
			mat at: iG and: (iqXIs at: i) plusFullRow: (pGpXIs at: i).
			mat at: iG and: (iqXJs at: i) plusFullRow: (pGpXJs at: i).
			mat at: iG and: (iqEIs at: i) plusFullRow: (pGpEIs at: i).
			mat at: iG and: (iqEJs at: i) plusFullRow: (pGpEJs at: i)]
]

{ #category : #velIC }
MbDNonlinearCoupler >> fillVelICJacob: mat [ 
	| iqXIi pGpXIi iqXJi pGpXJi iqEIi pGpEIi iqEJi pGpEJi |
	1 to: n do: [:i | 
			mat at: iG and: (iqXIi := iqXIs at: i) plusFullRow: (pGpXIi := pGpXIs at: i).
			mat at: iqXIi and: iG plusFullColumn: pGpXIi transpose.
			mat at: iG and: (iqXJi := iqXJs at: i) plusFullRow: (pGpXJi := pGpXJs at: i).
			mat at: iqXJi and: iG plusFullColumn: pGpXJi transpose.
			mat at: iG and: (iqEIi := iqEIs at: i) plusFullRow: (pGpEIi := pGpEIs at: i).
			mat at: iqEIi and: iG plusFullColumn: pGpEIi transpose.
			mat at: iG and: (iqEJi := iqEJs at: i) plusFullRow: (pGpEJi := pGpEJs at: i).
			mat at: iqEJi and: iG plusFullColumn: pGpEJi transpose]
]

{ #category : #dynamic }
MbDNonlinearCoupler >> fillpFpy: mat [ 
	1 to: n do: [:i | 
			mat at: iG and: (iqXIs at: i) plusFullRow: (pGpXIs at: i).
			mat at: iG and: (iqXJs at: i) plusFullRow: (pGpXJs at: i).
			mat at: iG and: (iqEIs at: i) plusFullRow: (pGpEIs at: i).
			mat at: iG and: (iqEJs at: i) plusFullRow: (pGpEJs at: i)].
	self fillPosICJacobppGpqpq: mat
]

{ #category : #dynamic }
MbDNonlinearCoupler >> fillpFpydot: mat [ 
	1 to: n do: [:i | 
			mat at: (iqXIs at: i) and: iG plusFullColumn: (pGpXIs at: i) transpose.
			mat at: (iqXJs at: i) and: iG plusFullColumn: (pGpXJs at: i) transpose.
			mat at: (iqEIs at: i) and: iG plusFullColumn: (pGpEIs at: i) transpose.
			mat at: (iqEJs at: i) and: iG plusFullColumn: (pGpEJs at: i) transpose]
]

{ #category : #accessing }
MbDNonlinearCoupler >> funcBlk: funcBlk [ 
	couplerFunction funcBlk: funcBlk
]

{ #category : #'initialize-release' }
MbDNonlinearCoupler >> initialize [
	super initialize.
	couplerFunction := MbDCouplerFunction new
]

{ #category : #'initialize-release' }
MbDNonlinearCoupler >> initializeGlobally [
	couplerFunction initializeGlobally
]

{ #category : #'initialize-release' }
MbDNonlinearCoupler >> initializeLocally [
	couplerFunction initializeLocally.
	n := couplerFunction n.
	iqXIs := Array new: n.
	iqEIs := Array new: n.
	iqXJs := Array new: n.
	iqEJs := Array new: n.
	pGpXIs := Array new: n.
	pGpEIs := Array new: n.
	pGpXJs := Array new: n.
	pGpEJs := Array new: n.
	1 to: n do: [:i | 
			pGpXIs at: i put: (FullRow zero: 3).
			pGpEIs at: i put: (FullRow zero: 4).
			pGpXJs at: i put: (FullRow zero: 3).
			pGpEJs at: i put: (FullRow zero: 4)]
]

{ #category : #accessing }
MbDNonlinearCoupler >> kineIJs [
	^couplerFunction kineIJs
]

{ #category : #accessing }
MbDNonlinearCoupler >> n [
	^n
]

{ #category : #accessing }
MbDNonlinearCoupler >> pGpEIs [
	^pGpEIs
]

{ #category : #accessing }
MbDNonlinearCoupler >> pGpEJs [
	^pGpEJs
]

{ #category : #accessing }
MbDNonlinearCoupler >> pGpXIs [
	^pGpXIs
]

{ #category : #accessing }
MbDNonlinearCoupler >> pGpXJs [
	^pGpXJs
]

{ #category : #dynamic }
MbDNonlinearCoupler >> postDynCorrectorIteration [
	couplerFunction postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
MbDNonlinearCoupler >> postDynOutput [
	couplerFunction postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
MbDNonlinearCoupler >> postDynPredictor [
	couplerFunction postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
MbDNonlinearCoupler >> postInput [
	couplerFunction postInput.
	super postInput
]

{ #category : #posIC }
MbDNonlinearCoupler >> postPosICIteration [
	couplerFunction postPosICIteration.
	super postPosICIteration
]

{ #category : #static }
MbDNonlinearCoupler >> postStaticIteration [
	couplerFunction postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
MbDNonlinearCoupler >> preAccIC [
	couplerFunction preAccIC.
	super preAccIC
]

{ #category : #dynamic }
MbDNonlinearCoupler >> preDynOutput [
	couplerFunction preDynOutput.
	super preDynOutput
]

{ #category : #posIC }
MbDNonlinearCoupler >> prePosIC [
	couplerFunction prePosIC.
	super prePosIC
]

{ #category : #static }
MbDNonlinearCoupler >> preStatic [
	couplerFunction preStatic.
	super preStatic
]

{ #category : #velIC }
MbDNonlinearCoupler >> preVelIC [
	couplerFunction preVelIC.
	super preVelIC
]

{ #category : #dynamic }
MbDNonlinearCoupler >> simUpdateAll [
	couplerFunction simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
MbDNonlinearCoupler >> useEquationNumbers [
	| kineIJs kineIJi pfrmIi pfrmJi |
	couplerFunction useEquationNumbers.
	kineIJs := couplerFunction kineIJs.
	1 to: n do: [:i | 
			kineIJi := kineIJs at: i.
			pfrmIi := kineIJi partFrameI.
			pfrmJi := kineIJi partFrameJ.
			iqXIs at: i put: pfrmIi iqX.
			iqEIs at: i put: pfrmIi iqE.
			iqXJs at: i put: pfrmJi iqX.
			iqEJs at: i put: pfrmJi iqE]
]
