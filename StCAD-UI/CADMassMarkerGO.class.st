Class {
	#name : #CADMassMarkerGO,
	#superclass : #CADMarkerGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADMassMarkerGO class >> standardMenu [
	"MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Position' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Direction' 
							#value: #positionDialog ) 
						#(#MenuItem 
							#rawLabel: 'Angle' 
							#value: #posAngDialog ) ) #(2 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'PositionPart' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Direction' 
							#value: #positionPartDialog ) 
						#(#MenuItem 
							#rawLabel: 'Angle' 
							#value: #posAnglePartDialog ) ) #(2 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'Velocity' 
				#value: #velocityDialog ) 
			#(#MenuItem 
				#rawLabel: 'Plot' 
				#value: #cadPlot ) ) #(4 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADMassMarkerGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADMassMarkerGO >> aGraphicViewPopupMenu [
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
CADMassMarkerGO >> aTreeViewPopupMenu [
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
CADMassMarkerGO >> defaultHandles [
	"Answer the default handles of the receiver"

	^GFSelectionTrackHandle allCornersOf: self
]

{ #category : #accessing }
CADMassMarkerGO >> geoObject: geoMarker [ 
	super geoObject: geoMarker.
"	self disableHandles."
	self disablePositionHandle
]

{ #category : #calc }
CADMassMarkerGO >> posAngDialog [
	CADMassMarkerBryantAnglesDialog openOn: self metaObject withSpec: #massMarkerWindowSpec
]

{ #category : #calc }
CADMassMarkerGO >> positionDialog [
	CADMassMarkerDirectionDialog openOn: self metaObject withSpec: #massMarkerWindowSpec
]
