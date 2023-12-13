Class {
	#name : #GEOTime,
	#superclass : #GEOFunction,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOTime class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #printing }
GEOTime >> cadStringOn: aStream [ 
	aStream nextPutAll: self name
]

{ #category : #DYN }
GEOTime >> createMbD [
	| mbdTime geoTime |
	mbdTime := self interface mbdSystem mbdTime.
	x == mbdTime
		ifFalse: 
			[geoTime := mbdTime * self mbdUnits time.
			self x: mbdTime expression: geoTime simplified]
]

{ #category : #DYN }
GEOTime >> createPOVRay [
	"Do nothing."
]

{ #category : #DYN }
GEOTime >> deleteMbD [
	x := nil.
	expression := nil
]

{ #category : #accessing }
GEOTime >> dimension [
	^'time'
]

{ #category : #accessing }
GEOTime >> name [
	^'time'
]
