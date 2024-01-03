Class {
	#name : #GEONotDoneFeature,
	#superclass : #GEOFeatureDecorator,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEONotDoneFeature >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer displayString: 'NotDoneFeature'.
	^answer
]

{ #category : #building }
GEONotDoneFeature >> buildIn: solidModel [ 
	"Do nothing."
]

{ #category : #testing }
GEONotDoneFeature >> isDone [
	^false
]

{ #category : #accessing }
GEONotDoneFeature >> renderOn: aRenderingContext [ 
	feature renderOn: aRenderingContext
]
