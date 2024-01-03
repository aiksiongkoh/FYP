Class {
	#name : #ForceBasicqccqComp,
	#superclass : #ForceBasicqcComp,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #dynamic }
ForceBasicqccqComp >> fillpFpy: mat aFTOi: aFTOi [ 
	| axis pprOeOpEpEaction iqEm1 iqEactionm1 pprOeOpEpEactioni mati pprOeOpEpEactionij |
	super fillpFpy: mat aFTOi: aFTOi.
	axis := parent axis.
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
					mati at: iqEactionm1 + j plusNumber: (pprOeOpEpEactionij at: axis)
							* aFTOi]]
]
