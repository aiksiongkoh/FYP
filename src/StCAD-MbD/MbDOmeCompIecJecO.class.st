Class {
	#name : #MbDOmeCompIecJecO,
	#superclass : #MbDKinematicDotIeJe,
	#instVars : [
		'axis',
		'omeIeJeOi'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDOmeCompIecJecO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOmeCompIecJecO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
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
MbDOmeCompIecJecO >> calcPostDynCorrectorIteration [
	omeIeJeOi := (frmJ omeOeO at: axis)
				- (frmI omeOeO at: axis)
]

{ #category : #accessing }
MbDOmeCompIecJecO >> value [
	^omeIeJeOi
]

{ #category : #'initialize-release' }
MbDOmeCompIecJecO >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axis := aaxis
]
