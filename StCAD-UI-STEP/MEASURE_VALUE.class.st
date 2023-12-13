Class {
	#name : #'MEASURE_VALUE',
	#superclass : #Item,
	#instVars : [
		'value'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
MEASURE_VALUE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
MEASURE_VALUE >> value [
	^value
]

{ #category : #accessing }
MEASURE_VALUE >> value: anObject [
	value := anObject
]
