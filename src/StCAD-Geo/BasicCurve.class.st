Class {
	#name : #BasicCurve,
	#superclass : #BasicGeometry,
	#category : #'StCAD-Geo'
}

{ #category : #accessing }
BasicCurve >> cPoint_n: n [ 
	| delta answer |
	delta := 1.0d / (n - 1).
	answer := OrderedCollection new: n.
	0 to: n - 1 do: [:i | answer add: (self rfpf_u: i * delta)].
	^answer asArray
]

{ #category : #accessing }
BasicCurve >> crOpO_nStep: nStep withFirst: withFirst withLast: withLast [ 
	| iFirst iLast delta answer |
	iFirst := withFirst ifTrue: [0] ifFalse: [1].
	iLast := withLast ifTrue: [nStep] ifFalse: [nStep - 1].
	delta := 1.0d / nStep.
	answer := MathArray new: iLast - iFirst + 1.
	iFirst to: iLast
		do: [:i | answer at: i - iFirst + 1 put: (self rfpf_u: i * delta)].
	^answer
]

{ #category : #'As yet unclassified' }
BasicCurve >> pprfpfpsps_s: s [ 
	| answer u pprfpfpupu |
	answer := FullMatrix new: 1 by: 1.
	u := s at: 1.
	pprfpfpupu := self pprfpfpupu_u: u.
	answer 
		at: 1
		and: 1
		put: pprfpfpupu.
	^answer
]

{ #category : #'As yet unclassified' }
BasicCurve >> prfpfps_s: s [ 
	| prfpfpu |
	prfpfpu := self prfpfpu_u: (s at: 1).
	^prfpfpu asFullMatrix
]

{ #category : #'As yet unclassified' }
BasicCurve >> rFpF_u: u [ 
	^self rfpf_u: u
]

{ #category : #'As yet unclassified' }
BasicCurve >> rfpf_s: s [ 
	^self rfpf_u: (s at: 1)
]

{ #category : #'As yet unclassified' }
BasicCurve >> uv_connectTo: aCurve [ 
	self assert: [self uvend equal: aCurve uvstart lTol: 1.0d-3]
]
