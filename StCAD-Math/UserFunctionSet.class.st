Class {
	#name : #UserFunctionSet,
	#superclass : #UserFunction,
	#instVars : [
		'parent',
		'current',
		'functions'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'instance creation' }
UserFunctionSet class >> new [
	^super new initialize
]

{ #category : #'VisualWorks metadata' }
UserFunctionSet class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'initialize-release' }
UserFunctionSet >> initialize [
	functions := Set new
]
