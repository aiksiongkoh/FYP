"
r(s(t))
prpt := prps*pspt
pprptpt := psptT*pprpsps*pspt + prps*ppsptpt
"
Class {
	#name : #BasicCurveOnSurface,
	#superclass : #BasicCurve,
	#instVars : [
		'aSurface',
		'uvCurve'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicCurveOnSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> aJun3dPolylineu: u [ 
	| acPoint |
	acPoint := u collect: [:au | self rFpF_u: au].
	^Jun3dPolyline points: acPoint
]

{ #category : #accessing }
BasicCurveOnSurface >> aSurface [
	^aSurface
]

{ #category : #accessing }
BasicCurveOnSurface >> aSurface: anObject [
	aSurface := anObject
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> asJunOpenGL3dObject [
	^(self aJun3dPolylineu: (0.0d to: 1.0d nStep: 100)) asJunOpenGL3dObject
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> csguess [
	| n |
	n := 2.
	aSurface csguess do: [:acs | n := n max: acs size - 1].
	uvCurve csguess do: [:acs | n := n max: acs size - 1].
	^Array with: (0.0d to: 1.0d nStep: n)
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> pprfpfpupu_u: t [ 
	"
	r(s(t))
	prpt := prps*pspt
	pprptpt := psptT*pprpsps*pspt + prps*ppsptpt
	"

	| pspt ppsptpt uv prfpfps pprfpfpsps pprpsps_pspt ai1 psptT_pprpsps_pspt prps_ppsptpt |
	pspt := uvCurve prfpfpu_u: t.
	ppsptpt := uvCurve pprfpfpupu_u: t.
	uv := uvCurve rfpf_u: t.
	prfpfps := aSurface prFpFps_s: uv.
	pprfpfpsps := aSurface pprFpFpsps_s: uv.
	pprpsps_pspt := FullMatrix new: 2 by: 1.
	1 to: 2
		do: 
			[:i | 
			ai1 := (pprfpfpsps at: i and: 1) 
						times: (pspt at: 1)
						plusFullColumn: (pprfpfpsps at: i and: 2)
						times: (pspt at: 2).
			pprpsps_pspt 
				at: i
				and: 1
				put: ai1].
	psptT_pprpsps_pspt := FullMatrix new: 1 by: 1.
	psptT_pprpsps_pspt := (pprpsps_pspt at: 1 and: 1) 
				times: (pspt at: 1)
				plusFullColumn: (pprpsps_pspt at: 2 and: 1)
				times: (pspt at: 2).
	prps_ppsptpt := FullMatrix new: 1 by: 1.
	prps_ppsptpt := prfpfps timesFullColumn: ppsptpt.
	^psptT_pprpsps_pspt plusFullColumn: prps_ppsptpt
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> prfpfpu_u: t [ 
	"prfpfpt := prfpfps*pspt"

	| pspt uv prfpfps |
	pspt := uvCurve prfpfpu_u: t.
	uv := uvCurve rfpf_u: t.
	prfpfps := aSurface prFpFps_s: uv.
	^prfpfps timesFullColumn: pspt
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> rOpO_s: s [ 
	| uv |
	uv := uvCurve rfpf_u: s first.
	^aSurface rOpO_s: uv
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> rfpfNurbs [
	^BasicNURBSCurve fromcDataPoint: (self cPoint_n: 32) uDegree: 3
]

{ #category : #'As yet unclassified' }
BasicCurveOnSurface >> rfpf_u: u [ 
	| uv |
	uv := uvCurve rfpf_u: u.
	^aSurface rFpF_s: uv
]

{ #category : #accessing }
BasicCurveOnSurface >> uvCurve [
	^uvCurve
]

{ #category : #accessing }
BasicCurveOnSurface >> uvCurve: anObject [
	uvCurve := anObject
]
