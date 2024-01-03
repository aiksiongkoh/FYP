"
ijk_I := dA * ijk_J
ijk_I := aAIeJe * ijk_J
Component of aAIeJe
aIJ, aIeJe, aAiIejJe or aAIeJeij
Axes axisI and axisJ
"
Class {
	#name : #MbDDirectionCosineIecJec,
	#superclass : #MbDKinematicIeJe,
	#instVars : [
		'aAijIeJe',
		'axisI',
		'axisJ',
		'aAjOIe',
		'aAjOJe'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #accessing }
MbDDirectionCosineIecJec >> aAijIeJe [
	^aAijIeJe
]

{ #category : #accessing }
MbDDirectionCosineIecJec >> axisI [
	^axisI
]

{ #category : #accessing }
MbDDirectionCosineIecJec >> axisI: integer [ 
	axisI := integer
]

{ #category : #accessing }
MbDDirectionCosineIecJec >> axisJ [
	^axisJ
]

{ #category : #accessing }
MbDDirectionCosineIecJec >> axisJ: integer [ 
	axisJ := integer
]

{ #category : #calc }
MbDDirectionCosineIecJec >> calcPostDynCorrectorIteration [
	aAjOIe := frmI aAjOe: axisI.
	aAjOJe := frmJ aAjOe: axisJ.
	aAijIeJe := aAjOIe dot: aAjOJe
]

{ #category : #accessing }
MbDDirectionCosineIecJec >> value [
	^aAijIeJe
]

{ #category : #'initialize-release' }
MbDDirectionCosineIecJec >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axisI := aaxisI.
	axisJ := aaxisJ
]
