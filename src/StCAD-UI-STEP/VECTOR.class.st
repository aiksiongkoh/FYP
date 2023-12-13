Class {
	#name : #VECTOR,
	#superclass : #Item,
	#instVars : [
		'orientation',
		'magnitude'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
VECTOR class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
VECTOR >> aDir [
	^orientation aDir
]

{ #category : #accessing }
VECTOR >> magnitude [
	^magnitude
]

{ #category : #accessing }
VECTOR >> magnitude: anObject [
	magnitude := anObject
]

{ #category : #accessing }
VECTOR >> orientation [
	^orientation
]

{ #category : #accessing }
VECTOR >> orientation: anObject [
	orientation := anObject
]

{ #category : #printing }
VECTOR >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'VECTOR';
		cr;
		nextPutAll: 'orientation = ';
		printVerbose: orientation;
		cr;
		nextPutAll: 'magnitude = ';
		printVerbose: magnitude
]
