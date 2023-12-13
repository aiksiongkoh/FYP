Class {
	#name : #CADGravityGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADGravityGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADGravityGO >> aGraphicViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addItemLabel: 'Edit' value: [interface insertGravity].
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #accessing }
CADGravityGO >> aTreeViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addItemLabel: 'Edit' value: [interface insertGravity].
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]
