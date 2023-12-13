Class {
	#name : #LINE,
	#superclass : #Item,
	#instVars : [
		'pnt',
		'dir'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
LINE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
LINE >> dir [
	^dir
]

{ #category : #accessing }
LINE >> dir: anObject [
	dir := anObject
]

{ #category : #accessing }
LINE >> pnt [
	^pnt
]

{ #category : #accessing }
LINE >> pnt: anObject [
	pnt := anObject
]

{ #category : #printing }
LINE >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'LINE';
		cr;
		nextPutAll: 'pnt = ';
		printVerbose: pnt;
		cr;
		nextPutAll: 'dir = ';
		printVerbose: dir
]

{ #category : #accessing }
LINE >> xyzCurveFrom: aEDGE_CURVE [

	| rFstartF rFendF |
	aEDGE_CURVE same_sense
		ifTrue: [ 
			rFstartF := aEDGE_CURVE xyzStart.
			rFendF := aEDGE_CURVE xyzEnd ]
		ifFalse: [ 
			rFstartF := aEDGE_CURVE xyzEnd.
			rFendF := aEDGE_CURVE xyzStart ].
	^ StCAD_Geo_Line new
		  rfstartf: rFstartF;
		  rfendf: rFendF;
		  yourself "VW_TRANSLATION:StCAD.Geo.Line:StCAD_Geo_Line"
]
