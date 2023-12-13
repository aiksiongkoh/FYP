Class {
	#name : #KinematicIJ,
	#superclass : #Item,
	#instVars : [
		'aEndI',
		'aEndJ'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'instance creation' }
KinematicIJ class >> aEndI: aEndi aEndJ: aEndj [ 
	^super new aEndI: aEndi aEndJ: aEndj
]

{ #category : #'VisualWorks metadata' }
KinematicIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
	)

]

{ #category : #comparing }
KinematicIJ >> = aObject [
	" *** This method was defined by Item as a subclass responsibility.
	Replace its body with a proper implementation. *** "

	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
KinematicIJ >> aEndI [
	^aEndI
]

{ #category : #accessing }
KinematicIJ >> aEndI: anObject [
	aEndI := anObject
]

{ #category : #accessing }
KinematicIJ >> aEndI: aEndi aEndJ: aEndj [ 
	aEndI := aEndi.
	aEndJ := aEndj
]

{ #category : #accessing }
KinematicIJ >> aEndJ [
	^aEndJ
]

{ #category : #accessing }
KinematicIJ >> aEndJ: anObject [
	aEndJ := anObject
]

{ #category : #'initialize-release' }
KinematicIJ >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	" *** Edit the following to properly initialize instance variables ***"
	aEndI := nil.
	aEndJ := nil.
	" *** And replace this comment with additional initialization code *** "
	^self
]
