Class {
	#name : #'GLOBAL_UNIT_ASSIGNED_CONTEXT',
	#superclass : #'REPRESENTATION_CONTEXT',
	#instVars : [
		'units'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
GLOBAL_UNIT_ASSIGNED_CONTEXT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
GLOBAL_UNIT_ASSIGNED_CONTEXT >> angleFactor [
	units do: [:a | a do: [:aa | aa angleFactor ifNotNil: [:aaa | ^aaa]]].
	^1.0d
]

{ #category : #accessing }
GLOBAL_UNIT_ASSIGNED_CONTEXT >> lengthFactor [
	units do: [:a | a do: [:aa | aa lengthFactor ifNotNil: [:aaa | ^aaa]]].
	^1.0d
]

{ #category : #accessing }
GLOBAL_UNIT_ASSIGNED_CONTEXT >> units [
	^units
]

{ #category : #accessing }
GLOBAL_UNIT_ASSIGNED_CONTEXT >> units: anObject [
	units := anObject
]
