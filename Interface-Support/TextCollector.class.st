Class {
	#name : #TextCollector,
	#superclass : #ValueHolder,
	#instVars : [
		'entryStream',
		'characterLimit',
		'writeSequencer',
		'nextEntry',
		'autoFlush'
	],
	#category : #'Interface-Support'
}

{ #category : #'VisualWorks metadata' }
TextCollector class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]
