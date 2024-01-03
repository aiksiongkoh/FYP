Class {
	#name : #GEOKineIForceIKineJ,
	#superclass : #GEOKineIKineJ,
	#instVars : [
		'forceI'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOKineIForceIKineJ >> dataTypes [
	| answer |
	answer := super dataTypes.
	answer add: #forceIO1.
	answer add: #forceIO2.
	answer add: #forceIO3.
	answer add: #forceI.
	answer add: #torqueIO1.
	answer add: #torqueIO2.
	answer add: #torqueIO3.
	answer add: #torqueI.
	^answer
]

{ #category : #accessing }
GEOKineIForceIKineJ >> forceI [
	^self forceIO length
]

{ #category : #accessing }
GEOKineIForceIKineJ >> forceI: geoData [ 
	forceI := geoData
]

{ #category : #accessing }
GEOKineIForceIKineJ >> forceIO [
	^forceI aFIO
]

{ #category : #accessing }
GEOKineIForceIKineJ >> forceIO1 [
	^self forceIO at: 1
]

{ #category : #accessing }
GEOKineIForceIKineJ >> forceIO2 [
	^self forceIO at: 2
]

{ #category : #accessing }
GEOKineIForceIKineJ >> forceIO3 [
	^self forceIO at: 3
]

{ #category : #accessing }
GEOKineIForceIKineJ >> torqueI [
	^self torqueIO length
]

{ #category : #accessing }
GEOKineIForceIKineJ >> torqueIO [
	^forceI aTIO
]

{ #category : #accessing }
GEOKineIForceIKineJ >> torqueIO1 [
	^self torqueIO at: 1
]

{ #category : #accessing }
GEOKineIForceIKineJ >> torqueIO2 [
	^self torqueIO at: 2
]

{ #category : #accessing }
GEOKineIForceIKineJ >> torqueIO3 [
	^self torqueIO at: 3
]
