Class {
	#name : #'SHELL_BASED_SURFACE_MODEL',
	#superclass : #'GEOMETRIC_REPRESENTATION_ITEM',
	#instVars : [
		'sbsm_boundary'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
SHELL_BASED_SURFACE_MODEL >> aNMT [

	| aNMT |
	aNMT := StCAD_NMT_Model new. "VW_TRANSLATION:StCAD.NMT.Model:StCAD_NMT_Model"
	sbsm_boundary first buildIn: aNMT.
	self assert: [ aNMT cSub size = 2 ].
	^ aNMT
]

{ #category : #accessing }
SHELL_BASED_SURFACE_MODEL >> sbsm_boundary [

	^sbsm_boundary
]

{ #category : #accessing }
SHELL_BASED_SURFACE_MODEL >> sbsm_boundary: anObject [

	sbsm_boundary := anObject
]
