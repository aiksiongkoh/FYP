"
Interpolation has the same formulation as Extrapolation.
Only its use is different.
Extrapolation evaluates at a time outside the intervals of the timeNodes.
Interpolation evaluates at a time inside the intervals of the timeNodes.
"
Class {
	#name : #Interpolator,
	#superclass : #Extrapolator,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'VisualWorks metadata' }
Interpolator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]
