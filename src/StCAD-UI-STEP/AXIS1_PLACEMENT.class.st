Class {
	#name : #'AXIS1_PLACEMENT',
	#superclass : #PLACEMENT,
	#instVars : [
		'axis'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
AXIS1_PLACEMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
AXIS1_PLACEMENT >> axis [
	^axis
]

{ #category : #accessing }
AXIS1_PLACEMENT >> axis: anObject [
	axis := anObject
]

{ #category : #printing }
AXIS1_PLACEMENT >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'location = ';
		printVerbose: location;
		cr;
		nextPutAll: 'axis = ';
		printVerbose: axis
]

{ #category : #accessing }
AXIS1_PLACEMENT >> zDir [

	^ axis
		  ifNil: [ 
			  StCAD_Math_FullColumn with: 0.0 d with: 0.0 d with: 1.0 d "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn" ]
		  ifNotNil: [ axis aDir ]
]
