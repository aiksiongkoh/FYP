Class {
	#name : #DataSSdotSddot,
	#superclass : #Data,
	#instVars : [
		's',
		'sdot',
		'sddot'
	],
	#category : #'StCAD-Misc'
}

{ #category : #'VisualWorks metadata' }
DataSSdotSddot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'StCAD.Misc'
	)

]

{ #category : #'initialize-release' }
DataSSdotSddot >> initialize [
	"Do nothing."
]

{ #category : #accessing }
DataSSdotSddot >> s [
	^s
]

{ #category : #accessing }
DataSSdotSddot >> s: col [ 
	s := col
]

{ #category : #accessing }
DataSSdotSddot >> sddot [
	^sddot
]

{ #category : #accessing }
DataSSdotSddot >> sddot: col [ 
	sddot := col
]

{ #category : #accessing }
DataSSdotSddot >> sdot [
	^sdot
]

{ #category : #accessing }
DataSSdotSddot >> sdot: col [ 
	sdot := col
]
