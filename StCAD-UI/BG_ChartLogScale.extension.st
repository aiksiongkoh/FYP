Extension { #name : #'BG_ChartLogScale' }

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartLogScale >> applyTo: aNumber [ 
	| rate |
	aNumber <= 0 ifTrue: [^0].
	rate := (((self filter: aNumber) log: base) - (sourceMin log: base)) 
				/ self logSourceLength.
	^(increase ifTrue: [rate] ifFalse: [1 - rate]) * self destLength + destMin
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartLogScale >> getScaleMin: min max: max [ 
	min <= 0 
		ifTrue: 
			[^Array 
				with: 1.0d-30
				with: (base raisedTo: (max log: base) ceiling)
				with: 5]
		ifFalse: 
			[^Array 
				with: (base raisedTo: (min log: base) floor)
				with: (base raisedTo: (max log: base) ceiling)
				with: 5]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartLogScale >> maxOfCollection: aCollection [ 
	| res |
	res := aCollection inject: nil
				into: 
					[:i :j | 
					i == nil 
						ifTrue: [j > 0 ifTrue: [j] ifFalse: [i]]
						ifFalse: [j > 0 ifTrue: [i max: j] ifFalse: [i]]].
	^res isNil ifTrue: [100] ifFalse: [res]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartLogScale >> minOfCollection: aCollection [ 
	| res |
	res := aCollection inject: nil
				into: 
					[:i :j | 
					i == nil 
						ifTrue: [j > 0 ifTrue: [j] ifFalse: [i]]
						ifFalse: [j > 0 ifTrue: [i min: j] ifFalse: [i]]].
	^res isNil ifTrue: [1] ifFalse: [res]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartLogScale >> zoomOut [
	| factor |
	factor := 1.5.
	self autoMin: sourceMin / factor max: sourceMax * factor
]
