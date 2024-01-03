Class {
	#name : #BasicSurface,
	#superclass : #BasicGeometry,
	#category : #'StCAD-Geo'
}

{ #category : #accessing }
BasicSurface >> pprfpfpsps_s: s [ 
	| answer u v pprfpfpupu pprfpfpupv pprfpfpvpv |
	answer := FullMatrix new: 2 by: 2.
	u := s at: 1.
	v := s at: 2.
	pprfpfpupu := self pprfpfpupu_u: u v: v.
	pprfpfpupv := self pprfpfpupv_u: u v: v.
	pprfpfpvpv := self pprfpfpvpv_u: u v: v.
	answer 
		at: 1
		and: 1
		put: pprfpfpupu.
	answer 
		at: 1
		and: 2
		put: pprfpfpupv.
	answer 
		at: 2
		and: 2
		put: pprfpfpvpv.
	^answer symLowerWithUpper
]

{ #category : #accessing }
BasicSurface >> rfpf_s: s [ 
	^self rfpf_u: (s at: 1) v: (s at: 2)
]
