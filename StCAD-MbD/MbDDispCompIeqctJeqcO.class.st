Class {
	#name : #MbDDispCompIeqctJeqcO,
	#superclass : #MbDDispCompIeqcJeqcO,
	#instVars : [
		'priIeJeOpt',
		'ppriIeJeOpEIpt',
		'ppriIeJeOptpt'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDispCompIeqctJeqcO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDispCompIeqctJeqcO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
	^(afrmI isMemberOf: MbDEndFrameqct)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: i]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDispCompIeqctJeqcO >> calcPostDynCorrectorIteration [
	"ppriIeJeOpEIpEI is not a constant now."

	super calcPostDynCorrectorIteration.
	ppriIeJeOpEIpEI := (frmI ppriOeOpEpE: axis) negated
]

{ #category : #'initialize-release' }
MbDDispCompIeqctJeqcO >> initializeGlobally [
	ppriIeJeOpEJpEJ := frmJ ppriOeOpEpE: axis
]

{ #category : #accessing }
MbDDispCompIeqctJeqcO >> ppriIeJeOpEIpt [
	^ppriIeJeOpEIpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcO >> ppriIeJeOptpt [
	^ppriIeJeOptpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcO >> ppvaluepEIpt [
	^ppriIeJeOpEIpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcO >> ppvalueptpt [
	^ppriIeJeOptpt
]

{ #category : #accIC }
MbDDispCompIeqctJeqcO >> preAccIC [
	super preAccIC.
	ppriIeJeOpEIpt := (frmI ppriOeOpEpt: axis) negated.
	ppriIeJeOptpt := (frmI ppriOeOptpt: axis) negated
]

{ #category : #velIC }
MbDDispCompIeqctJeqcO >> preVelIC [
	super preVelIC.
	priIeJeOpt := (frmI priOeOpt: axis) negated
]

{ #category : #accessing }
MbDDispCompIeqctJeqcO >> priIeJeOpt [
	^priIeJeOpt
]

{ #category : #accessing }
MbDDispCompIeqctJeqcO >> pvaluept [
	^priIeJeOpt
]
