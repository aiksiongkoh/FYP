Class {
	#name : #BlockClosure,
	#superclass : #Object,
	#instVars : [
		'method',
		'outerContext',
		'copiedValues'
	],
	#category : #'Kernel-Methods'
}

{ #category : #'VisualWorks metadata' }
BlockClosure class >> visualWorksMetadata [

	^ #(
		'namespace' 'Kernel'
	)

]
