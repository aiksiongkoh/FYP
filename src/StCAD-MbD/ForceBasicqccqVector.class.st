Class {
	#name : #ForceBasicqccqVector,
	#superclass : #ForceBasicqcVector,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #dynamic }
ForceBasicqccqVector >> fillpFpy: mat aFTO: aFTO [ 
	| pprOeOpEpEaction iqEm1 iqEactionm1 pprOeOpEpEactioni mati pprOeOpEpEactionij |
	super fillpFpy: mat aFTO: aFTO.
	pprOeOpEpEaction := endFrame pprOeOpEpEtarget.
	iqEm1 := iqE - 1.
	iqEactionm1 := endFrame iqEtarget - 1.
	1 to: 4
		do: 
			[:i | 
			pprOeOpEpEactioni := pprOeOpEpEaction at: i.
			mati := mat at: iqEm1 + i.
			1 to: 4
				do: 
					[:j | 
					pprOeOpEpEactionij := pprOeOpEpEactioni at: j.
					mati at: iqEactionm1 + j plusNumber: (pprOeOpEpEactionij dot: aFTO)]]
]
