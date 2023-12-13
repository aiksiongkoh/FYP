Class {
	#name : #BasicGeometry,
	#superclass : #Item,
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicGeometry class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
BasicGeometry >> pprFpFpsps_s: s [ 
	^self pprfpfpsps_s: s
]

{ #category : #accessing }
BasicGeometry >> pprOpOpsps_s: s [ 
	^self pprfpfpsps_s: s
]

{ #category : #accessing }
BasicGeometry >> prFpFps_s: s [ 
	^self prfpfps_s: s
]

{ #category : #accessing }
BasicGeometry >> prOpOps_s: s [ 
	^self prfpfps_s: s
]

{ #category : #accessing }
BasicGeometry >> rFpFNurbs [
	^self rfpfNurbs
]

{ #category : #accessing }
BasicGeometry >> rFpF_s: s [ 
	^self rfpf_s: s
]

{ #category : #show }
BasicGeometry >> show [
	self rFpFNurbs show
]
