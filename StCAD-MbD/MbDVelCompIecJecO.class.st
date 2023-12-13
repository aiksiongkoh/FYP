Class {
	#name : #MbDVelCompIecJecO,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'axis',
		'vIeJeOi'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIecJecO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIecJecO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass
						withFrmI: afrmI
						frmJ: afrmJ
						axis: i.
			instance notNil ifTrue: [^instance]]
]

{ #category : #calc }
MbDVelCompIecJecO >> calcPostDynCorrectorIteration [
	vIeJeOi := (frmJ vOeO at: axis)
				- (frmI vOeO at: axis)
]

{ #category : #accessing }
MbDVelCompIecJecO >> value [
	^vIeJeOi
]

{ #category : #'initialize-release' }
MbDVelCompIecJecO >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
