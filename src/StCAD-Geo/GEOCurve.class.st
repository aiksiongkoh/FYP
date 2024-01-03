Class {
	#name : #GEOCurve,
	#superclass : #GEOAnyGraphic,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOCurve >> aColor [
	^(self triggerEvent: #getColor) ifNil: 
			[| answer |
			answer := ColorValue black copy.
			self aColor: answer.
			answer]
]

{ #category : #accessing }
GEOCurve >> aColor: aColor [ 
	self removeActionsForEvent: #getColor.
	aColor notNil 
		ifTrue: 
			[self 
				when: #getColor
				ask: aColor
				perform: #yourself]
]

{ #category : #accessing }
GEOCurve >> alpha [
	| answer |
	answer := self triggerEvent: #getalpha.
	answer == nil 
		ifTrue: 
			[answer := 1.0d.
			self alpha: answer].
	^answer
]

{ #category : #accessing }
GEOCurve >> alpha: alpha [ 
	self removeActionsForEvent: #getalpha.
	alpha notNil 
		ifTrue: 
			[self 
				when: #getalpha
				ask: alpha
				perform: #yourself]
]

{ #category : #accessing }
GEOCurve >> asPolyline [
	| polyline |
	polyline := GEOPolyline new.
	polyline container: container.
	polyline refFrame: refFrame copy.
	polyline rfpointsf: self rfpointsf.
	^polyline
]

{ #category : #accessing }
GEOCurve >> cut [
	container cutCurve: self.
	super cut
]

{ #category : #testing }
GEOCurve >> hasAlpha [
	^self alpha notNil
]

{ #category : #testing }
GEOCurve >> hasPaint [
	^self paint notNil
]

{ #category : #testing }
GEOCurve >> hasStipple [
	^self stipplePattern notNil
]

{ #category : #testing }
GEOCurve >> isClosed [
	^false
]

{ #category : #accessing }
GEOCurve >> lineWidth [
	| answer |
	answer := self triggerEvent: #getlineWidth.
	answer == nil 
		ifTrue: 
			[answer := 1.0d.
			self lineWidth: answer].
	^answer
]

{ #category : #accessing }
GEOCurve >> lineWidth: lineWidth [ 
	self removeActionsForEvent: #getlineWidth.
	lineWidth notNil 
		ifTrue: 
			[self 
				when: #getlineWidth
				ask: lineWidth
				perform: #yourself]
]

{ #category : #accessing }
GEOCurve >> paint [

	| answer |
	answer := self cadObject color.
	answer = Polymorphic_Color black ifTrue: [ 
		answer := Polymorphic_Color cyan copy ]. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
	^ answer
]

{ #category : #accessing }
GEOCurve >> paint1 [

	| answer |
	answer := self triggerEvent: #getpaint.
	answer == nil ifTrue: [ 
		answer := self cadObject color.
		answer = Polymorphic_Color black ifTrue: [ 
			answer := Polymorphic_Color green ]. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
		self paint: answer ].
	^ answer
]

{ #category : #accessing }
GEOCurve >> paint: paint [ 
	self removeActionsForEvent: #getpaint.
	paint notNil 
		ifTrue: 
			[self 
				when: #getpaint
				ask: paint
				perform: #yourself]
]

{ #category : #copying }
GEOCurve >> postCopy [
	| aColor |
	aColor := self aColor.
	super postCopy.
	self aColor: aColor copy
]

{ #category : #accessing }
GEOCurve >> rOpointsO [
	^self rfpointsf collect: [:rfpointf | refFrame rOpOfromrfpf: rfpointf]
]

{ #category : #accessing }
GEOCurve >> rPpointsP [
	| partRefFrame |
	partRefFrame := self part refFrame.
	^self rOpointsO collect: [:rOpO | partRefFrame rfpffromrOpO: rOpO]
]

{ #category : #accessing }
GEOCurve >> rSkpointsSk [
	^self rfpointsf collect: [:rfpointf | refFrame rFpFfromrfpf: rfpointf]
]

{ #category : #rendering }
GEOCurve >> renderOn: aRenderingContext [ 
	self cadObject notNil 
		ifTrue: 
			[aRenderingContext pushTransformation: refFrame aMFf
				while: 
					[self hasPaint ifTrue: [aRenderingContext paint: self paint].
					self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
					aRenderingContext lineWidth: self lineWidth.
					self hasStipple 
						ifTrue: 
							[aRenderingContext lineStippleFactor: self stippleFactor
								pattern: self stipplePattern.
							aRenderingContext enableLineStipple].
					aRenderingContext displayLines: self rfpointsf.
					self hasStipple ifTrue: [aRenderingContext disableLineStipple]]]
]

{ #category : #rendering }
GEOCurve >> renderPolygonOn: aRenderingContext [ 
	self cadObject notNil 
		ifTrue: 
			[aRenderingContext pushTransformation: refFrame aMFf
				while: 
					[self hasPaint ifTrue: [aRenderingContext paint: self paint].
					self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
					aRenderingContext lineWidth: self lineWidth.
					self hasStipple 
						ifTrue: 
							[aRenderingContext lineStippleFactor: self stippleFactor
								pattern: self stipplePattern.
							aRenderingContext enableLineStipple].
					aRenderingContext displayPolygon: self rfpointsf.
					self hasStipple ifTrue: [aRenderingContext disableLineStipple]]]
]

{ #category : #accessing }
GEOCurve >> stipplePattern [
	| answer |
	answer := self triggerEvent: #getstipplePattern.
	^answer
]

{ #category : #accessing }
GEOCurve >> stipplePattern: stipplePattern [ 
	self removeActionsForEvent: #getstipplePattern.
	stipplePattern notNil 
		ifTrue: 
			[self 
				when: #getstipplePattern
				ask: stipplePattern
				perform: #yourself]
]

{ #category : #accessing }
GEOCurve >> theta: angle [ 
	| aA cosAngle sinAngle |
	aA := (FullMatrix zero: 3 by: 3).
	cosAngle := angle cos.
	sinAngle := angle sin.
	aA at: 1 and: 1 put: cosAngle.
	aA at: 1 and: 2 put: sinAngle negated.
	aA at: 2 and: 1 put: sinAngle.
	aA at: 2 and: 2 put: cosAngle.
	aA at: 3 and: 3 put: 1.0d.
	refFrame aAFf: aA.
	self changed
]

{ #category : #accessing }
GEOCurve >> uncut [
	container addGraphic: self.
	super uncut
]
