"
Missing comment
"
Class {
	#name : #EndFrames,
	#superclass : #EndFrame,
	#instVars : [
		's',
		'vs',
		'as'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
EndFrames class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
EndFrames >> pAFfps [
	^aAFf pvalueps
]

{ #category : #accessing }
EndFrames >> pAOfps [
	^aAOf pvalueps
]

{ #category : #accessing }
EndFrames >> ppAFfpsps [
	^aAFf ppvaluepsps
]

{ #category : #accessing }
EndFrames >> ppAOfpEps [
	^aAOf ppvaluepEps
]

{ #category : #accessing }
EndFrames >> ppAOfpsps [
	^aAOf ppvaluepsps
]

{ #category : #accessing }
EndFrames >> ppAOfptps [
	^aAOf ppvalueptps
]

{ #category : #accessing }
EndFrames >> ppprFfFpspsps [
	^rFfF pppvaluepspsps
]

{ #category : #accessing }
EndFrames >> pprFfFpsps [
	^rFfF ppvaluepsps
]

{ #category : #accessing }
EndFrames >> pprOfOpsps [
	^rOfO ppvaluepsps
]

{ #category : #accessing }
EndFrames >> pprOfOptps [
	^rOfO ppvalueptps
]

{ #category : #accessing }
EndFrames >> prFfFps [
	^rFfF pvalueps
]

{ #category : #accessing }
EndFrames >> prOfOps [
	^rOfO pvalueps
]
