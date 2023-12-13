Class {
	#name : #MbDCouplerConstraint,
	#superclass : #MbDConstraint,
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDCouplerConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDCouplerConstraint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: one coupler constraint '
]
