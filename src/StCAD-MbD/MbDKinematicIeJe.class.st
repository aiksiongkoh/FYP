"
	J	Jq	Js	Jt	Jqs	Jqt	Jst Jqst
I	x	-	-	-	-	-	-	-
Iq	x	x	-	-	-	-	-	-
Is	x	x	x	-	-	-	-	-
It	x	x	x	x	-	-	-	-
Iqs	x	x	x	x	x	-	-	-
Iqt	x	x	x	x	x	x	-	-
Ist	x	x	x	x	x	x	x	-
Iqst	x	x	x	x	x	x	x	x
Inherit down first then right.
- may use negated version of x.
IJ
	IqcJc
		IqcsJc
			IqcstJc
				IqcstJqc
					IqcstJqsc
						IqcstJqcst
					IqcstJqct
				IqcstJcs
					IqcstJcst
				IqcstJct
			IqcsJqc
				IqcsJqsc
			IqcsJcs
			IqcsJct
		IqctJc
			IqctJqc
				IqctJqcs
				IqctJqct
			IqctJcs
			IqctJct
		IqcJqc
	IcsJc
		IcstJc
			IcstJqc
				IcstJqcs
				IcstJqct
			IcstJcs
				IcstJcst
			IcstJct
		IcsJqc
		IcsJcs
	IctJc
		IctJqc
		IctJcs
		IctJct
"
Class {
	#name : #MbDKinematicIeJe,
	#superclass : #MbDItem,
	#instVars : [
		'frmI',
		'frmJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDKinematicIeJe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDKinematicIeJe >> differentiateWRT: variable [ 
	^self == variable
		ifTrue: [Constant with: 1]
		ifFalse: [Constant with: 0]
]

{ #category : #accessing }
MbDKinematicIeJe >> endFrameI [
	^frmI
]

{ #category : #accessing }
MbDKinematicIeJe >> endFrameJ [
	^frmJ
]

{ #category : #calc }
MbDKinematicIeJe >> endFramesCalc [
	"New design requires all frames to be updated by parts."
	"Used for separation calculation."

	frmI calcPostDynCorrectorIteration.
	frmJ calcPostDynCorrectorIteration
]

{ #category : #accessing }
MbDKinematicIeJe >> frmI [
	^frmI
]

{ #category : #accessing }
MbDKinematicIeJe >> frmI: frm [ 
	frmI := frm
]

{ #category : #accessing }
MbDKinematicIeJe >> frmJ [
	^frmJ
]

{ #category : #accessing }
MbDKinematicIeJe >> frmJ: frm [ 
	frmJ := frm
]

{ #category : #accessing }
MbDKinematicIeJe >> isKineIJ [
	^true
]

{ #category : #accessing }
MbDKinematicIeJe >> partFrameI [
	^frmI partFrame
]

{ #category : #accessing }
MbDKinematicIeJe >> partFrameJ [
	^frmJ partFrame
]

{ #category : #accessing }
MbDKinematicIeJe >> partFrameK [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepEIpEI [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepEIpEJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepEIpXJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepEJpEJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepXIpEI [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepXIpEJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepXIpXI [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepXIpXJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepXJpEJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> ppvaluepXJpXJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> pvaluepEI [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> pvaluepEJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> pvaluepEK [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> pvaluepXI [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> pvaluepXJ [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> pvaluepXK [
	^nil
]

{ #category : #accessing }
MbDKinematicIeJe >> value [
	^nil
]

{ #category : #'initialize-release' }
MbDKinematicIeJe >> withFrmI: afrmI frmJ: afrmJ [ 
	frmI := afrmI.
	frmJ := afrmJ
]
