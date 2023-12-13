Class {
	#name : #CurveMarker,
	#superclass : #Marker,
	#instVars : [
		's'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
CurveMarker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #displaying }
CurveMarker >> canUpdateForFrame: integer [ 
	^[(self dataSeries at: integer) notNil] 
		on: Object subscriptOutOfBoundsSignal
		do: [:ex | ex return: false]
]

{ #category : #accessing }
CurveMarker >> s [
	^s
]

{ #category : #accessing }
CurveMarker >> s: col [ 
	s := col
]

{ #category : #accessing }
CurveMarker >> trigs: double [ 
	| rFfFEqn aAFf1 aAFf2 aAFf3 aAFf rFfF |
	s := double.
	rFfFEqn := aSup rfCurvef.
	rFfF := rFfFEqn y: s.
	aAFf1 := (rFfFEqn dydx: s) normalizeSelf.
	aAFf2 := FullColumn 
				with: 0.0d
				with: 0.0d
				with: 1.0d.
	aAFf3 := aAFf1 cross: aAFf2.
	aAFf := FullMatrix new: 3 by: 3.
	aAFf 
		at: 1
		and: 1
		putFullColumn: aAFf1.
	aAFf 
		at: 1
		and: 2
		putFullColumn: aAFf2.
	aAFf 
		at: 1
		and: 3
		putFullColumn: aAFf3.
	aRefFrame quietlyrFfF: rFfF aAFf: aAFf
]

{ #category : #accessing }
CurveMarker >> updateForFrame: integer [ 
	| data |
	data := self dataSeries at: integer.
	self trigs: (data s at: 1)
]
