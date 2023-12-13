Extension { #name : #ArithmeticValue }

{ #category : #'*StCAD-Math-StCAD-Math' }
ArithmeticValue >> asConstant [

	^ StCAD_Math_Constant with: self "VW_TRANSLATION:StCAD.Math.Constant:StCAD_Math_Constant"
]

{ #category : #'*StCAD-Math-StCAD-Math' }
ArithmeticValue >> length [
	^self abs
]
