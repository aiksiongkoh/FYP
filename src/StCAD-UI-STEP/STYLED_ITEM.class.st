Class {
	#name : #'STYLED_ITEM',
	#superclass : #Item,
	#instVars : [
		'styles',
		'item'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
STYLED_ITEM class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
STYLED_ITEM >> aPart [
	| aPart |
	aPart := item aPart.
	aPart aColor: styles first aColor.
	^aPart
]

{ #category : #accessing }
STYLED_ITEM >> item [
	^item
]

{ #category : #accessing }
STYLED_ITEM >> item: anObject [
	item := anObject
]

{ #category : #accessing }
STYLED_ITEM >> styles [
	^styles
]

{ #category : #accessing }
STYLED_ITEM >> styles: anObject [
	styles := anObject
]
