Class {
	#name : #'AXIS2_PLACEMENT_3D',
	#superclass : #PLACEMENT,
	#instVars : [
		'axis',
		'ref_direction'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> aAFf [

	^ StCAD_Math_FullMatrix
		  rotationMatrixFromzDir: self zDir
		  xDir: self xDir "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
]

{ #category : #'As yet unclassified' }
AXIS2_PLACEMENT_3D >> aRefFrame [

	| aRefFrame |
	aRefFrame := StCAD_Geo_CartesianFrame new. "VW_TRANSLATION:StCAD.Geo.CartesianFrame:StCAD_Geo_CartesianFrame"
	aRefFrame rFfF: self rFfF copy.
	aRefFrame aAFf: self aAFf copy.
	^ aRefFrame
]

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> axis [
	^axis
]

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> axis: anObject [
	axis := anObject
]

{ #category : #printing }
AXIS2_PLACEMENT_3D >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'location = ';
		printVerbose: location;
		cr;
		nextPutAll: 'axis = ';
		printVerbose: axis;
		cr;
		nextPutAll: 'ref_direction = ';
		printVerbose: ref_direction
]

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> ref_direction [
	^ref_direction
]

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> ref_direction: anObject [
	ref_direction := anObject
]

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> xDir [

	| rootOneThird zDir xDir |
	^ ref_direction
		  ifNil: [ 
			  rootOneThird := (1.0 d / 3.0 d) sqrt.
			  zDir := self zDir normalizeSelf.
			  1 to: 3 do: [ :i | 
				  xDir := StCAD_Math_FullColumn zero: 3. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
				  xDir at: i put: 1.0 d.
				  (xDir dot: zDir) abs < rootOneThird ifTrue: [ ^ xDir ] ] ]
		  ifNotNil: [ ref_direction aDir ]
]

{ #category : #accessing }
AXIS2_PLACEMENT_3D >> zDir [

	^ axis
		  ifNil: [ 
			  StCAD_Math_FullColumn with: 0.0 d with: 0.0 d with: 1.0 d "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn" ]
		  ifNotNil: [ axis aDir ]
]
