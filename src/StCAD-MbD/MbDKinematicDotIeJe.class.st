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
	#name : #MbDKinematicDotIeJe,
	#superclass : #MbDKinematicIeJe,
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDKinematicDotIeJe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDKinematicDotIeJe >> isKinedotIJ [
	^true
]

{ #category : #collision }
MbDKinematicDotIeJe >> postCollisionCorrectorIteration [
	self calcPostDynCorrectorIteration
]

{ #category : #collision }
MbDKinematicDotIeJe >> postCollisionPredictor [
	self calcPostDynCorrectorIteration
]

{ #category : #static }
MbDKinematicDotIeJe >> postStaticIteration [
	"Do nothing."
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepEI [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepEJ [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepEK [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepEdotI [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepEdotJ [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepEdotK [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepXI [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepXJ [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepXK [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepXdotI [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepXdotJ [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> pvaluepXdotK [
	^nil
]

{ #category : #accessing }
MbDKinematicDotIeJe >> value [
	self subclassResponsibility
]
