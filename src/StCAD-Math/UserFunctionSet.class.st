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

{ #category : #'initialize-release' }
UserFunctionSet >> initialize [
	functions := Set new
]
