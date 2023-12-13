Class {
	#name : #SelectionTool,
	#superclass : #Tool,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
SelectionTool class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'initialize-release' }
SelectionTool >> initialize [
	name := 'Selection'.
	aIcon := nil.
	aCursor := Cursor normal
]

{ #category : #accessing }
SelectionTool >> selectionTracker [
	^(SelectionToolTracker new)
		aTool: self;
		yourself
]
