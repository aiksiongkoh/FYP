Class {
	#name : #CADLightingGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADLightingGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Edit' #value: #popupMenuEdit ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADLightingGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADLightingGO >> aGraphicViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addPart: self menu.
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #accessing }
CADLightingGO >> aTreeViewPopupMenu [
	| interface answerMenu drawingMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addPart: self menu.
	drawingMenu := Menu new.
	drawingMenu addItemLabel: '&Undo' value: [interface undo].
	answerMenu addItemGroup: (Array 
				with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
	^answerMenu
]

{ #category : #accessing }
CADLightingGO >> popupMenuEdit [
	| aLighting dialogResponse |
	aLighting := self metaObject.
	dialogResponse := aLighting aDialog.
	dialogResponse ifTrue: [self interface cadApp cadView invalidate]
]

{ #category : #calc }
CADLightingGO >> updateProjection: projectionFrame [ 
	| geoLighting |
	geoLighting := self metaObject.
	self visibleArea: (geoLighting rDfD extent: 0 @ 0)
]
