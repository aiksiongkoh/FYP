Class {
	#name : #Function,
	#superclass : #Symbolic,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #comparing }
Function >> = anObject [ 
	^self class == anObject class
]

{ #category : #accessing }
Function >> arguments: array [ 
	self subclassResponsibility
]

{ #category : #'initialize-release' }
Function >> initialize [
	"Do nothing."
]

{ #category : #printing }
Function >> outputOn: filename interval: interval [ 
	| writeStream |
	Transcript cr; show: 'Tabulated data is in ' , filename.
	writeStream := filename asFilename writeStream.
	writeStream nextPut: $x; nextPut: $,; nextPutAll: 'func'; cr.
	interval
		do: 
			[:x | 
			| fvalue |
			writeStream print: x asFloat; nextPut: $,.
			self x: x.
			fvalue := self value.
			fvalue isSequenceable
				ifTrue: [fvalue do: [:fvaluei | writeStream print: fvaluei asFloat; nextPut: $,]]
				ifFalse: [writeStream print: fvalue asFloat].
			writeStream cr].
	writeStream flush; close
]

{ #category : #printing }
Function >> printFuntionNameOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
Function >> printOn: aStream [ 
	self printFuntionNameOn: aStream.
	aStream nextPut: $(.
	self print_cArgumentOn: aStream.
	aStream nextPut: $)
]

{ #category : #printing }
Function >> print_cArgumentOn: aStream [
	self subclassResponsibility
]

{ #category : #evaluating }
Function >> value: xx [ 
	self x: xx.
	^self value
]
