Class {
	#name : #GEOAnyMarker,
	#superclass : #GEOAnyGraphic,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAnyMarker >> addMarkersIn: set [ 
	set add: self
]

{ #category : #accessing }
GEOAnyMarker >> axisLength [
	| answer |
	answer := self triggerEvent: #getaxisLength.
	answer == nil 
		ifTrue: 
			[answer := 0.2d.
			self axisLength: answer].
	^answer
]

{ #category : #accessing }
GEOAnyMarker >> axisLength: axisLength [ 
	self removeActionsForEvent: #getaxisLength.
	axisLength notNil 
		ifTrue: 
			[self 
				when: #getaxisLength
				ask: axisLength
				perform: #yourself]
]

{ #category : #accessing }
GEOAnyMarker >> cut [
	container cutMarker: self.
	super cut
]

{ #category : #accessing }
GEOAnyMarker >> dataClass [
	^GEOTimePosVelAccData
]

{ #category : #accessing }
GEOAnyMarker >> dataTypes [
	^self dataClass new dataTypes
]

{ #category : #DYN }
GEOAnyMarker >> deleteMbD [
	self mbdObject: nil
]

{ #category : #accessing }
GEOAnyMarker >> lineWidth [
	| answer |
	answer := self triggerEvent: #getlineWidth.
	answer == nil 
		ifTrue: 
			[answer := 2.
			self lineWidth: answer].
	^answer
]

{ #category : #accessing }
GEOAnyMarker >> lineWidth: lineWidth [ 
	self removeActionsForEvent: #getlineWidth.
	lineWidth notNil 
		ifTrue: 
			[self 
				when: #getlineWidth
				ask: lineWidth
				perform: #yourself]
]

{ #category : #accessing }
GEOAnyMarker >> rOfO [
	^refFrame rOfO
]

{ #category : #rendering }
GEOAnyMarker >> renderOn: aRenderingContext [

	| length pt000 pt100 pt010 pt001 |
	self cadObject notNil ifTrue: [ 
		aRenderingContext pushTransformation: refFrame aMFf while: [ 
			length := self cadObject axisLength.
			pt000 := 0.0 d yd: 0.0 d zd: 0.0 d.
			pt100 := length yd: 0.0 d zd: 0.0 d.
			pt010 := 0.0 d yd: length zd: 0.0 d.
			pt001 := 0.0 d yd: 0.0 d zd: length.
			aRenderingContext lineWidth: self lineWidth.
			aRenderingContext paint: Polymorphic_Color red. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
			aRenderingContext displayLine: (Array with: pt000 with: pt100).
			aRenderingContext paint: Polymorphic_Color green.
			aRenderingContext displayLine: (Array with: pt000 with: pt010).
			aRenderingContext paint: Polymorphic_Color blue.
			aRenderingContext displayLine: (Array with: pt000 with: pt001) ] ]
]

{ #category : #DYN }
GEOAnyMarker >> storeInputState [
	"Do nothing."
]

{ #category : #printing }
GEOAnyMarker >> storePOVOn: aStream level1: level [ 
	| fullNamePOV |
	fullNamePOV := self fullNamePOV.
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level title: 'box{<0,0,0>,<0.1,0.1,0.1>'.
	aStream storePOVLevel: level + 1 title: 'texture {pigment { color Blue }}'.
	aStream storePOVLevel: level + 1
		title: ('rotate %<<1s>_RotX[clock],<1s>_RotY[clock],<1s>_RotZ[clock]>' 
				expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level + 1
		title: ('translate %<<1s>_X[clock],<1s>_Y[clock],<1s>_Z[clock]>' 
				expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level title: '}'
]

{ #category : #printing }
GEOAnyMarker >> storePOVOn: aStream level: level [ 
	| fullNamePOV |
	fullNamePOV := self fullNamePOV.
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level title: 'MARKER('.
	aStream storePOVLevel: level + 1
		title: ('<1s>_RotX[clock], <1s>_RotY[clock], <1s>_RotZ[clock], ' 
				expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level + 1
		title: ('<1s>_X[clock], <1s>_Y[clock], <1s>_Z[clock], ' 
				expandMacrosWith: fullNamePOV).
	aStream storePOVLevel: level + 1
		title: self cadObject axisLength asFloat printForExport.
	aStream storePOVLevel: level title: ')'
]

{ #category : #printing }
GEOAnyMarker >> storePOVTimeSeriesOn: aStream [
	| dataSeries fullNamePOV series |
	dataSeries := self dataSeriesForChart.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data rOfO.].
	aStream storePOVTitle: fullNamePOV , '_X'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_Y'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_Z'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries
				collect: [:data | GEOEulerAngleszyx fromA: data aAOf.].
	aStream storePOVTitle: fullNamePOV , '_RotX'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotZ'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	series := dataSeries collect: [:data | data vOfO.].
	aStream storePOVTitle: fullNamePOV , '_VX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_VY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_VZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data omeOfO.].
	aStream storePOVTitle: fullNamePOV , '_OmegaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	series := dataSeries collect: [:data | data aOfO.].
	aStream storePOVTitle: fullNamePOV , '_AX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_AY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_AZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data alpOfO.].
	aStream storePOVTitle: fullNamePOV , '_AlphaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
]

{ #category : #printing }
GEOAnyMarker >> storePOVdatCurrentOn: aStream [
	| dataSeries fullNamePOV series |
	dataSeries := Array with: self dataFromCurrentState.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data rOfO.].
	aStream storePOVTitle: fullNamePOV , '_X'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_Y'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_Z'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries
				collect: [:data | GEOEulerAngleszyx fromA: data aAOf.].
	aStream storePOVTitle: fullNamePOV , '_RotX'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotZ'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	series := dataSeries collect: [:data | data vOfO.].
	aStream storePOVTitle: fullNamePOV , '_VX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_VY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_VZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data omeOfO.].
	aStream storePOVTitle: fullNamePOV , '_OmegaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	series := dataSeries collect: [:data | data aOfO.].
	aStream storePOVTitle: fullNamePOV , '_AX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_AY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_AZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data alpOfO.].
	aStream storePOVTitle: fullNamePOV , '_AlphaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
]

{ #category : #accessing }
GEOAnyMarker >> uncut [
	container addMarker: self.
	super uncut
]

{ #category : #DYN }
GEOAnyMarker >> updateFromInputState [
	"Do nothing."
]
