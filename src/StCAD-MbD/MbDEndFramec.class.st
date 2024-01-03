Class {
	#name : #MbDEndFramec,
	#superclass : #MbDCartesianFrame,
	#instVars : [
		'markerFrame',
		'rOeO',
		'aAOe'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #accessing }
MbDEndFramec >> aAOe [
	^aAOe
]

{ #category : #accessing }
MbDEndFramec >> aAeO [
	^aAOe transpose
]

{ #category : #accessing }
MbDEndFramec >> aAjOe: j [ 
	^aAOe column: j
]

{ #category : #accessing }
MbDEndFramec >> aApm: mat [ 
	markerFrame aApm: mat
]

{ #category : #calc }
MbDEndFramec >> calcPostDynCorrectorIteration [
	rOeO := markerFrame rOmO.
	aAOe := markerFrame aAOm
]

{ #category : #accessing }
MbDEndFramec >> fillContactEndFrames: set [ 
	"Do nothing."
]

{ #category : #accessing }
MbDEndFramec >> ieO [
	^aAOe column: 1
]

{ #category : #accessing }
MbDEndFramec >> isOn: mFrm [ 
	markerFrame := mFrm.
	markerFrame endFrames add: self
]

{ #category : #accessing }
MbDEndFramec >> jeO [
	^aAOe column: 2
]

{ #category : #accessing }
MbDEndFramec >> keO [
	^aAOe column: 3
]

{ #category : #accessing }
MbDEndFramec >> markerFrame [
	^markerFrame
]

{ #category : #accessing }
MbDEndFramec >> markerFrame: frame [ 
	markerFrame := frame
]

{ #category : #converting }
MbDEndFramec >> newCopyEndFrameqc [
	| answer |
	answer := MbDEndFrameqc new.
	answer isOn: markerFrame.
	^answer
]

{ #category : #accessing }
MbDEndFramec >> part: aPart [ 
	markerFrame partFrame: aPart partFrame
]

{ #category : #accessing }
MbDEndFramec >> partFrame [
	^markerFrame partFrame
]

{ #category : #accessing }
MbDEndFramec >> qEOe [
	^aAOe mbdEulerParameters
]

{ #category : #accessing }
MbDEndFramec >> rOeO [ 
	^rOeO
]

{ #category : #accessing }
MbDEndFramec >> rOeO: aFullColumn [ 
	rOeO := aFullColumn.
	markerFrame rOmO: aFullColumn
]

{ #category : #accessing }
MbDEndFramec >> riOeO: i [ 
	^rOeO at: i
]

{ #category : #accessing }
MbDEndFramec >> rmeO [
	^rOeO - markerFrame rOmO
]

{ #category : #accessing }
MbDEndFramec >> rpmp: col [ 
	markerFrame rpmp: col
]

{ #category : #'initialize-release' }
MbDEndFramec >> submitToSystem [
	self registerName
]

{ #category : #'initialize-release' }
MbDEndFramec >> swapXandZaxes [
	markerFrame swapXandZaxes
]
