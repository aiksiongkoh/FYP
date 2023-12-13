Class {
	#name : #ParagraphEditor,
	#superclass : #ControllerWithMenu,
	#instVars : [
		'beginTypeInIndex',
		'anchorIndex',
		'emphasisHere',
		'dispatchTable',
		'charComposer',
		'textHasChanged',
		'feelPolicy',
		'supportCodeEditingFeels',
		'localMenuItems',
		'extendingDown'
	],
	#category : #'UIBasics-Support'
}

{ #category : #'VisualWorks metadata' }
ParagraphEditor class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]
