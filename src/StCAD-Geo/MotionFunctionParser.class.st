Class {
	#name : #MotionFunctionParser,
	#superclass : #FunctionParser,
	#category : #'StCAD-Geo-CAD'
}

{ #category : #'VisualWorks metadata' }
MotionFunctionParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
MotionFunctionParser >> functions [
	^self intrinsicFunctions
]
