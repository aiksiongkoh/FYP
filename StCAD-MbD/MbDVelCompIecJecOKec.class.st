Class {
	#name : #MbDVelCompIecJecOKec,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'efrmK',
		'axisK',
		'viIeJeOKe',
		'aAjOKe',
		'vIeJeO'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIecJecOKec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIecJecOKec class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass
						withFrmI: afrmI
						frmJ: afrmJ
						frmK: afrmK
						axisK: integer.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDVelCompIecJecOKec >> calcPostDynCorrectorIteration [
	aAjOKe := efrmK aAjOe: axisK.
	vIeJeO := frmJ vOeO minusFullColumn: frmI vOeO.
	viIeJeOKe := aAjOKe dot: vIeJeO
]

{ #category : #accessing }
MbDVelCompIecJecOKec >> partFrameK [
	^efrmK partFrame
]

{ #category : #accessing }
MbDVelCompIecJecOKec >> value [
	^viIeJeOKe
]

{ #category : #'initialize-release' }
MbDVelCompIecJecOKec >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	frmI := afrmI.
	frmJ := afrmJ.
	efrmK := afrmK.
	axisK := integer
]
