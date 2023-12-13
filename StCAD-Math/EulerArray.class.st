"
Subclasses encapsulate the behavior of Euler angles and Euler parameters.
"
Class {
	#name : #EulerArray,
	#superclass : #FullColumn,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #'VisualWorks metadata' }
EulerArray class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
EulerArray class >> zero: n [ 
	self shouldNotImplement
]

{ #category : #'basic ops' }
EulerArray >> transpose [
	"Return a row with the same elements."

	| n answer |
	n := self size.
	answer := FullRow new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)].
	^answer
]
