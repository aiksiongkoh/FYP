Class {
	#name : #CADFunction,
	#superclass : #ExpressionX,
	#instVars : [
		'container'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #comparing }
CADFunction >> = anObject [ 
	^self == anObject
]

{ #category : #accessing }
CADFunction >> aSup: aaSup [ 
	container := aaSup.
	^aaSup
]

{ #category : #copying }
CADFunction >> copy [
	"A CADFunction is immutable so it is ok to reuse."
	"Do nothing."
]

{ #category : #accessing }
CADFunction >> dimension [
	self subclassResponsibility
]

{ #category : #evaluating }
CADFunction >> expandUntil: set [ 
	"Do nothing."
]

{ #category : #evaluating }
CADFunction >> simplifyUntil: set [ 
	"Do nothing."
]
