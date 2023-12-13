Class {
	#name : #CartesianFrame,
	#superclass : #AbstractCartesianFrame,
	#instVars : [
		'vFfF',
		'omeFfF',
		'vOfO',
		'omeOfO',
		'aFfF',
		'alpFfF',
		'aOfO',
		'alpOfO'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
CartesianFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
CartesianFrame >> aAOF [
	^aSup aAOf
]

{ #category : #accessing }
CartesianFrame >> aAddotOF [
	^aSup aAddotOf
]

{ #category : #accessing }
CartesianFrame >> aAdotOF [
	^aSup aAdotOf
]

{ #category : #accessing }
CartesianFrame >> aOFO [
	^aSup aOfO
]

{ #category : #accessing }
CartesianFrame >> aOfO [
	^aOfO
]

{ #category : #accessing }
CartesianFrame >> aOfO: anObject [
	aOfO := anObject
]

{ #category : #accessing }
CartesianFrame >> aTime [
	^aSup aTime
]

{ #category : #accessing }
CartesianFrame >> alpOFO [
	^aSup alpOfO
]

{ #category : #accessing }
CartesianFrame >> alpOfO [
	^alpOfO
]

{ #category : #accessing }
CartesianFrame >> alpOfO: anObject [
	alpOfO := anObject
]

{ #category : #accessing }
CartesianFrame >> omeFfF [
	^omeFfF
]

{ #category : #accessing }
CartesianFrame >> omeFfF: anObject [
	omeFfF := anObject
]

{ #category : #accessing }
CartesianFrame >> omeOFO [
	^aSup omeOfO
]

{ #category : #accessing }
CartesianFrame >> omeOfO [
	^omeOfO
]

{ #category : #accessing }
CartesianFrame >> omeOfO: anObject [
	omeOfO := anObject
]

{ #category : #accessing }
CartesianFrame >> rOFO [
	^aSup rOfO
]

{ #category : #accessing }
CartesianFrame >> rOfO [
	^rOfO
]

{ #category : #accessing }
CartesianFrame >> vFfF [
	^vFfF
]

{ #category : #accessing }
CartesianFrame >> vFfF: anObject [
	vFfF := anObject
]

{ #category : #accessing }
CartesianFrame >> vOFO [
	^aSup vOfO
]

{ #category : #accessing }
CartesianFrame >> vOfO [
	^vOfO
]

{ #category : #accessing }
CartesianFrame >> vOfO: anObject [
	vOfO := anObject
]
