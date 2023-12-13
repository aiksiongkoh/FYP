Class {
	#name : #SingularMatrixError,
	#superclass : #Exception,
	#category : #'StCAD-Math-Exception'
}

{ #category : #'class initialization' }
SingularMatrixError class >> initialize [
	"SingularMatrixError initialize"
	SingularMatrixError
		notifierString: #'Singular Matrix Error' << #'StCAD.UI'
				>> 'Singular Matrix Error'
]

{ #category : #testing }
SingularMatrixError class >> mayResume [
	^true
]

{ #category : #'VisualWorks metadata' }
SingularMatrixError class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]
