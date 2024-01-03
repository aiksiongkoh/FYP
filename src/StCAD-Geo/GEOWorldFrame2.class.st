Class {
	#name : #GEOWorldFrame2,
	#superclass : #GEOCartesianFrame2,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOWorldFrame2 >> axisLength [
	| answer |
	answer := self triggerEvent: #getaxisLength.
	answer == nil 
		ifTrue: 
			[answer := 1.0d.
			self axisLength: answer].
	^answer
]

{ #category : #accessing }
GEOWorldFrame2 >> axisLength: axisLength [ 
	self removeActionsForEvent: #getaxisLength.
	axisLength notNil 
		ifTrue: 
			[self 
				when: #getaxisLength
				ask: axisLength
				perform: #yourself]
]

{ #category : #accessing }
GEOWorldFrame2 >> boundingBox [
	| axisLength |
	axisLength := self axisLength.
	^Jun3dBoundingBox origin: 0 , 0 , 0
		corner: axisLength , axisLength , axisLength
]

{ #category : #accessing }
GEOWorldFrame2 >> container [
	^refFrame
]

{ #category : #'initialize-release' }
GEOWorldFrame2 >> cut [
	"Do nothing."
]

{ #category : #accessing }
GEOWorldFrame2 >> fixedAtRef [
	super fixedAtRef.
	rOfO := (FullColumn zero: 3).
	aAOf := (FullMatrix identity: 3)
]

{ #category : #testing }
GEOWorldFrame2 >> isInterface [
	^true
]

{ #category : #accessing }
GEOWorldFrame2 >> lineWidth [
	| answer |
	answer := self triggerEvent: #getlineWidth.
	answer == nil 
		ifTrue: 
			[answer := 1.
			self lineWidth: answer].
	^answer
]

{ #category : #accessing }
GEOWorldFrame2 >> lineWidth: lineWidth [ 
	self removeActionsForEvent: #getlineWidth.
	lineWidth notNil 
		ifTrue: 
			[self 
				when: #getlineWidth
				ask: lineWidth
				perform: #yourself]
]

{ #category : #accessing }
GEOWorldFrame2 >> refFrame: aFrame [ 
	"WorldFrame refFrame should be aCADInterface."

	refFrame := aFrame
]

{ #category : #'initialize-release' }
GEOWorldFrame2 >> release [
	body releaseRefFrame.
	body := nil
]

{ #category : #rendering }
GEOWorldFrame2 >> renderOn1: aRenderingContext [

	| pt000 pt100 pt010 pt001 |
	pt000 := 0 , 0 , 0.
	pt100 := 1 , 0 , 0.
	pt010 := 0 , 1 , 0.
	pt001 := 0 , 0 , 1.
	aRenderingContext lineWidth: self lineWidth.
	aRenderingContext paint: Polymorphic_Color red. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
	aRenderingContext displayLine: (Array with: pt000 with: pt100).
	aRenderingContext paint: Polymorphic_Color green.
	aRenderingContext displayLine: (Array with: pt000 with: pt010).
	aRenderingContext paint: Polymorphic_Color blue.
	aRenderingContext displayLine: (Array with: pt000 with: pt001)
]

{ #category : #rendering }
GEOWorldFrame2 >> renderOn: aRenderingContext [

	| length pt000 pt100 pt010 pt001 |
	self cadObject notNil ifTrue: [ 
		length := self cadObject axisLength.
		pt000 := 0.0 d yd: 0.0 d zd: 0.0 d.
		pt100 := length yd: 0.0 d zd: 0.0 d.
		pt010 := 0.0 d yd: length zd: 0.0 d.
		pt001 := 0.0 d yd: 0.0 d zd: length.
		aRenderingContext lineWidth: self lineWidth.
		aRenderingContext paint: Polymorphic_Color red. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
		aRenderingContext displayLine: (Array with: pt000 with: pt100).
		aRenderingContext paint: Polymorphic_Color green.
		aRenderingContext displayLine: (Array with: pt000 with: pt010).
		aRenderingContext paint: Polymorphic_Color blue.
		aRenderingContext displayLine: (Array with: pt000 with: pt001) ]
]

{ #category : #'initialize-release' }
GEOWorldFrame2 >> uncut [
	"Do nothing."
]
