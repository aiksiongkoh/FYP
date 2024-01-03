"
For GEOLine, its refFrame is equal to sketch refFrame. No need to introduce a new GEOCartesianFrame.

Instance Variables:

startPoint	<ClassOfVariable>	description of variable's function
endPoint	<ClassOfVariable>	description of variable's function
"
Class {
	#name : #GEOLine,
	#superclass : #GEOCurve,
	#instVars : [
		'startPoint',
		'endPoint'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #calc }
GEOLine >> dataIntersectLine: geoLine tolerance: tol [ 
	"
	Find the minimum distance to any axis. 
	General formula: 
	Line is P(t) = P0 + tv. 
	Line is Q(u) = Q0 + uw. 
	Minimize P(t) - Q(u). 
	Therefore 
	t = w*(P0 - Q0) v*w - v*(P0 - Q0) w*w / (v*v w*w - v*w v*w). 
	u = w*(P0 - Q0) v*v - v*(P0 - Q0) w*v / (v*v w*w - v*w v*w). 
	"

	| p0 v q0 w p0mq0 vdotv wdotw vdotw vdotp0mq0 wdotp0mq0 denominator t u px qx rpxqxO rpxqx |
	p0 := self rOstartO.
	v := self rOendO - p0.
	q0 := geoLine rOstartO.
	w := geoLine rOendO - q0.
	p0mq0 := p0 - q0.
	vdotv := v sumOfSquares.
	wdotw := w sumOfSquares.
	vdotw := v dot: w.
	vdotp0mq0 := v dot: p0mq0.
	wdotp0mq0 := w dot: p0mq0.
	denominator := vdotv * wdotw - (vdotw * vdotw).
	denominator > MachineAccuracy OfDoubleTimesFour
		ifTrue: 
			[t := wdotp0mq0 * vdotw - (vdotp0mq0 * wdotw) / denominator.
			u := wdotp0mq0 * vdotv - (vdotp0mq0 * vdotw) / denominator.
			px := p0 plus: v times: t.
			qx := q0 plus: w times: u.
			rpxqxO := qx - px.
			rpxqx := rpxqxO length.
			rpxqx <= tol ifTrue: [^Array
					with: true
					with: t
					with: u]].
	^Array with: false
]

{ #category : #accessing }
GEOLine >> end: bPoint [ 
	endPoint := bPoint.
	self changed
]

{ #category : #accessing }
GEOLine >> endPoint [
	^endPoint
]

{ #category : #accessing }
GEOLine >> rOendO [
	^refFrame rOfO + (refFrame aAOf timesFullColumn: endPoint)
]

{ #category : #accessing }
GEOLine >> rOstartO [
	^refFrame rOfO + (refFrame aAOf timesFullColumn: startPoint)
]

{ #category : #transforming }
GEOLine >> scaledBy: aFullColumn [ 
	startPoint scaleSelfBy: aFullColumn.
	endPoint scaleSelfBy: aFullColumn
]

{ #category : #accessing }
GEOLine >> start: bPoint [ 
	startPoint := bPoint.
	self changed
]

{ #category : #accessing }
GEOLine >> start: aPoint end: bPoint [ 
	startPoint := aPoint.
	endPoint := bPoint.
	self changed
]

{ #category : #accessing }
GEOLine >> startPoint [
	^startPoint
]

{ #category : #accessing }
GEOLine >> translateSelfBy: delta [ 
	startPoint := startPoint + delta.
	endPoint := endPoint + delta.
	self changed
]
