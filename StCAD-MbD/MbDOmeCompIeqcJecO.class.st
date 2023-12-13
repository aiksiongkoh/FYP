Class {
	#name : #MbDOmeCompIeqcJecO,
	#superclass : #MbDOmeCompIecJecO,
	#instVars : [
		'pomeIeJeOipEI',
		'pomeIeJeOipEdotI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDOmeCompIeqcJecO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDOmeCompIeqcJecO class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: aaxis]
		ifFalse: [nil]
]

{ #category : #calc }
MbDOmeCompIeqcJecO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pomeIeJeOipEI := (frmI pomeOeOpE at: axis) negated.
	pomeIeJeOipEdotI := (frmI pomeOeOpEdot at: axis) negated
]

{ #category : #'initialize-release' }
MbDOmeCompIeqcJecO >> initialize [
	super initialize.
	pomeIeJeOipEI := FullRow new: 4.
	pomeIeJeOipEdotI := FullRow new: 4
]

{ #category : #accessing }
MbDOmeCompIeqcJecO >> pvaluepEI [
	^pomeIeJeOipEI
]

{ #category : #accessing }
MbDOmeCompIeqcJecO >> pvaluepEdotI [
	^pomeIeJeOipEdotI
]
