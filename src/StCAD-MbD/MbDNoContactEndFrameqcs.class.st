Class {
	#name : #MbDNoContactEndFrameqcs,
	#superclass : #MbDContactEndFrameqcs,
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'VisualWorks metadata' }
MbDNoContactEndFrameqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> bePerturbed: delta fillqsulam: col [ 
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDNoContactEndFrameqcs >> becomeContactEndFrame [
	self changeClassToThatOf: MbDContactEndFrameqcs basicNew
]

{ #category : #'initialize-release' }
MbDNoContactEndFrameqcs >> becomeNoContactEndFrame [
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillContactEndFrames: set [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillpqsumu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillpqsumudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsuWeights: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsuddotlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsudotPlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsudotPlamDeriv: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsudotWeights: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> fillqsulam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setpqsumu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setpqsumuddot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setpqsumudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsu: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsuddotlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsudot: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsudotPlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsudotPlamDeriv: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsudotlam: col [ 
	"Do nothing."
]

{ #category : #accessing }
MbDNoContactEndFrameqcs >> setqsulam: col [ 
	"Do nothing."
]
