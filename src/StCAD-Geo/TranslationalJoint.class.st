Class {
	#name : #TranslationalJoint,
	#superclass : #Joint,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
TranslationalJoint class >> mbdClass [
	^MbDTranslationalJoint
]

{ #category : #accessing }
TranslationalJoint class >> nameString [
	^'TranslationalJoint'
]

{ #category : #'VisualWorks metadata' }
TranslationalJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
