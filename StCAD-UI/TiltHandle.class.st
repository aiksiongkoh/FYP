Class {
	#name : #TiltHandle,
	#superclass : #Handle,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
TiltHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
TiltHandle >> renderOn: aRenderingContext [ 
	self halt
]
