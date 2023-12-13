Extension { #name : #'BG_ChartScale' }

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> applyTo: aNumber [ 
	"Answer translated value in destination coodinates"

	| rate answer |
	self sourceLength = 0 ifTrue: [^destMin].
	rate := (self filter: aNumber)
				- sourceMin / self sourceLength.
	answer := (increase
				ifTrue: [rate]
				ifFalse: [1 - rate])
				* self destLength + destMin.
	answer := answer rounded.
	answer := answer min: 32767.
	answer := answer max: -32768.
	^answer
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> autoMin: min max: max [ 
	"Sets sources automatically from arguments"

	| amin amax factors |
	(min isNil or: [max isNil])
		ifFalse: 
			[amin := min min: max.
			amax := min max: max.
			factors := self getScaleMin: amin max: amax.
			self sourceMin: (factors at: 1)
				max: (factors at: 2).
			self step: (factors at: 3)]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> autoWith: xs [ 
	| min max |
	min := self minOfCollection: xs.
	max := self maxOfCollection: xs.
	self autoMin: min max: max
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> beEqualScaleTo: aScale [ 
	self rate < aScale rate
		ifTrue: 
			[self sourceMin: self sourceMin max: self sourceMin + (aScale rate * self destLength).
			self step: aScale step]
		ifFalse: 
			[aScale sourceMin: aScale sourceMin max: aScale sourceMin + (self rate * aScale destLength).
			aScale step: self step]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> getScaleMin: min max: max [ 
	"Find the best plot min, max and step for the axis given the data 
	min and max."

	| rawMin rawMax factor steps bestMin bestMax delta |
	(max - min) abs > 0
		ifTrue: 
			[rawMin := min min: max.
			rawMax := min max: max]
		ifFalse: 
			["min = max"
			delta := max isZero
						ifTrue: [1.0d-6]
						ifFalse: [1.0d-6 * max abs].
			rawMin := max - delta.
			rawMax := max + delta].
	step := rawMax - rawMin / 5.
	factor := 1.0d.
	[1 <= step and: [step < 10]]
		whileFalse: [step < 1
				ifTrue: 
					[factor := factor / 10.
					step := step * 10]
				ifFalse: 
					[factor := factor * 10.
					step := step / 10]].
	steps := #(1.0d 1.1d 1.2d 1.25d 1.5d 1.75d 2.0d 2.5d 3.0d 4.0d 5.0d 6.0d 7.5d 8.0d 10.0d).
	step := (steps detect: [:double | step <= (1.001d * double)])
				* factor.
	bestMin := rawMin // step * step.
	bestMax := (rawMax negated // step) negated * step.
	^Array
		with: bestMin
		with: bestMax
		with: step
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> maxOfCollection: aCollection [ 
	| res |
	res := aCollection inject: nil
				into: [:i :j | i == nil ifTrue: [j] ifFalse: [i max: j]].
	^res isNil ifTrue: [100] ifFalse: [res]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> minOfCollection: aCollection [ 
	| res |
	res := aCollection inject: nil
				into: [:i :j | i == nil ifTrue: [j] ifFalse: [i min: j]].
	^res isNil ifTrue: [0] ifFalse: [res]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> rate [
	^self sourceLength / self destLength
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartScale >> zoomOut [
	| halfRange |
	halfRange := (sourceMax - sourceMin) / 3.
	self autoMin: sourceMin - halfRange max: sourceMax + halfRange
]
