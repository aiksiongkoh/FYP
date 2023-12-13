Class {
	#name : #MbDAtPointJoint,
	#superclass : #MbDSphericalJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #'VisualWorks metadata' }
MbDAtPointJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDAtPointJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: AtPoint Joint '
]
