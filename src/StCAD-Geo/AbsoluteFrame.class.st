Class {
	#name : #AbsoluteFrame,
	#superclass : #CartesianFrame,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
AbsoluteFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
AbsoluteFrame >> axisLength [
	^1.0d
]

{ #category : #accessing }
AbsoluteFrame >> boundingBox [
	| axisLength |
	axisLength := self axisLength.
	^BoundingBox origin: (FullColumn zero: 3)
		corner: (FullColumn 
				with: axisLength
				with: axisLength
				with: axisLength)
]

{ #category : #accessing }
AbsoluteFrame >> fixedAtRef [
	super fixedAtRef.
	rOfO := FullColumn zero: 3.
	aAOf := FullMatrix identity: 3.
]

{ #category : #'initialize-release' }
AbsoluteFrame >> initialize [
	super initialize.
	self fixedAtRef
]

{ #category : #accessing }
AbsoluteFrame >> lineWidth [
	| answer |
	answer := self triggerEvent: #getlineWidth.
	answer == nil 
		ifTrue: 
			[answer := 1.
			self lineWidth: answer].
	^answer
]

{ #category : #accessing }
AbsoluteFrame >> lineWidth: lineWidth [ 
	self removeActionsForEvent: #getlineWidth.
	lineWidth notNil 
		ifTrue: 
			[self 
				when: #getlineWidth
				ask: lineWidth
				perform: #yourself]
]

{ #category : #displaying }
AbsoluteFrame >> renderOn: aRenderingContext [ 
	| pt000 pt100 pt010 pt001 |
	aRenderingContext 
		pushName: self name
		transformation: nil
		while: 
			[pt000 := 0 , 0 , 0.
			pt100 := 1 , 0 , 0.
			pt010 := 0 , 1 , 0.
			pt001 := 0 , 0 , 1.
			aRenderingContext lineWidth: self lineWidth.
			aRenderingContext paint: ColorValue red.
			aRenderingContext displayLine: (Array with: pt000 with: pt100).
			aRenderingContext paint: ColorValue green.
			aRenderingContext displayLine: (Array with: pt000 with: pt010).
			aRenderingContext paint: ColorValue blue.
			aRenderingContext displayLine: (Array with: pt000 with: pt001)]
]
