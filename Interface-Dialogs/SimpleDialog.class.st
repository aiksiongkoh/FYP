Class {
	#name : #SimpleDialog,
	#superclass : #ApplicationModel,
	#instVars : [
		'close',
		'accept',
		'cancel',
		'preBuildBlock',
		'postBuildBlock',
		'postOpenBlock',
		'escapeIsCancel',
		'parentView',
		'useParentColors'
	],
	#category : #'Interface-Dialogs'
}

{ #category : #'VisualWorks metadata' }
SimpleDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]
