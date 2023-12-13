Class {
	#name : #'SHAPE_REPRESENTATION_RELATIONSHIP',
	#superclass : #'REPRESENTATION_RELATIONSHIP',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
SHAPE_REPRESENTATION_RELATIONSHIP class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
SHAPE_REPRESENTATION_RELATIONSHIP >> aPart [
	^(rep_1 isMemberOf: ADVANCED_BREP_SHAPE_REPRESENTATION) 
		ifTrue: 
			[(rep_1 aPart)
				name: rep_1 name;
				yourself]
		ifFalse: 
			[(rep_2 aPart)
				name: rep_2 name;
				yourself]
]

{ #category : #'As yet unclassified' }
SHAPE_REPRESENTATION_RELATIONSHIP >> cPart [
	^(rep_1 isMemberOf: ADVANCED_BREP_SHAPE_REPRESENTATION) 
		ifTrue: [rep_1 cPart]
		ifFalse: [rep_2 cPart]
]

{ #category : #accessing }
SHAPE_REPRESENTATION_RELATIONSHIP >> lengthFactor [
	^rep_1 lengthFactor
]
