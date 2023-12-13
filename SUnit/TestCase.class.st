Class {
	#name : #TestCase,
	#superclass : #TestAsserter,
	#instVars : [
		'testSelector'
	],
	#category : #SUnit
}

{ #category : #'VisualWorks metadata' }
TestCase class >> visualWorksMetadata [

	^ #(
		'namespace' 'XProgramming.SUnit'
		'superclassNamespace' 'XProgramming.SUnit'
	)

]
