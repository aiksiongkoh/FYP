Class {
	#name : #ScrollWrapper,
	#superclass : #TranslatingWrapper,
	#instVars : [
		'dependents',
		'preferredBoundsBlock'
	],
	#category : #'Interface-Support'
}

{ #category : #'VisualWorks metadata' }
ScrollWrapper class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'Graphics'
	)

]
