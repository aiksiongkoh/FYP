Class {
	#name : #EDGE,
	#superclass : #'TOPOLOGICAL_REPRESENTATION_ITEM',
	#instVars : [
		'edge_start',
		'edge_end'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
EDGE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]
