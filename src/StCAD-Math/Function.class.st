Class {
	#name : #Function,
	#superclass : #Symbolic,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'binary storage' }
Function class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value' from StMSymbolic."
	"Remove the instance variable 'dependents' from StMFunction."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: oldObj size - 2.
			new
				replaceFrom: 1
				to: new size
				with: oldObj
				startingAt: 3.
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
Function class >> binaryRepresentationVersion [
	^30
]

{ #category : #accessing }
Function class >> functionSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
Function class >> functionTemplate [
	self subclassResponsibility
]

{ #category : #'instance creation' }
Function class >> new [
	^super new initialize
]

{ #category : #'VisualWorks metadata' }
Function class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
