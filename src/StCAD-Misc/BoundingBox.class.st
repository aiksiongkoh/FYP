Class {
	#name : #BoundingBox,
	#superclass : #Item,
	#instVars : [
		'minCorner',
		'maxCorner'
	],
	#category : #'StCAD-Misc'
}

{ #category : #'instance creation' }
BoundingBox class >> origin: originPoint corner: cornerPoint [ 
	^self new origin: originPoint corner: cornerPoint
]

{ #category : #'VisualWorks metadata' }
BoundingBox class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
BoundingBox >> cCorner [
	"Collection of corners of box."

	| answer x y z |
	answer := OrderedCollection new: 10.
	1 to: 2
		do: 
			[:i | 
			x := i = 1 ifTrue: [minCorner at: 1] ifFalse: [maxCorner at: 1].
			1 to: 2
				do: 
					[:j | 
					y := j = 1 ifTrue: [minCorner at: 2] ifFalse: [maxCorner at: 2].
					1 to: 2
						do: 
							[:k | 
							z := k = 1 ifTrue: [minCorner at: 3] ifFalse: [maxCorner at: 3].
							answer add: (FullColumn 
										with: x
										with: y
										with: z)]]].
	^answer
]

{ #category : #'initialize-release' }
BoundingBox >> center [
	^minCorner + maxCorner / 2.0d
]

{ #category : #testing }
BoundingBox >> contains: aBoundingBox [ 
	"Answer whether the receiver is equal to aBoundingBox or whether aBoundingBox
	is contained within the receiver."

	^minCorner <= aBoundingBox minCorner 
		and: [aBoundingBox maxCorner <= maxCorner]
]

{ #category : #testing }
BoundingBox >> containsPoint: aPoint [

	^minCorner <= aPoint and: [aPoint <= maxCorner]
]

{ #category : #accessing }
BoundingBox >> corner [
	^maxCorner
]

{ #category : #accessing }
BoundingBox >> diagonal_length [
	^(maxCorner - minCorner) length
]

{ #category : #accessing }
BoundingBox >> dx [
	^(maxCorner at: 1) - (minCorner at: 1)
]

{ #category : #accessing }
BoundingBox >> dy [
	^(maxCorner at: 2) - (minCorner at: 2)
]

{ #category : #accessing }
BoundingBox >> dz [
	^(maxCorner at: 3) - (minCorner at: 3)
]

{ #category : #'initialize-release' }
BoundingBox >> expandToBound1: point [ 
	minCorner := minCorner min: point.
	maxCorner := maxCorner max: point
]

{ #category : #'initialize-release' }
BoundingBox >> expandToBound: aPointOrBox [ 
	aPointOrBox fitSelfInBox: self
]

{ #category : #accessing }
BoundingBox >> extent [
	^maxCorner - minCorner
]

{ #category : #'ops on self' }
BoundingBox >> fitSelfInBox: aBoundingBox [ 
	self isDefined 
		ifTrue: 
			[aBoundingBox isDefined 
				ifTrue: 
					[aBoundingBox origin: (minCorner min: aBoundingBox minCorner)
						corner: (maxCorner max: aBoundingBox maxCorner)]
				ifFalse: [aBoundingBox origin: minCorner copy corner: maxCorner copy]]
]

{ #category : #'ops on self' }
BoundingBox >> inRefFrame: aFrame [ 
	"I am f frame. Transform to F frame."

	| answer |
	^self isDefined 
		ifTrue: 
			[answer := self class new.
			self cCorner inject: answer
				into: [:bbox :corner | bbox expandToBound: (aFrame rFpFfromrfpf: corner)].
			answer]
		ifFalse: [self]
]

{ #category : #'initialize-release' }
BoundingBox >> initialize [
	minCorner := FullColumn new: 3.
	maxCorner := FullColumn new: 3
]

{ #category : #testing }
BoundingBox >> isDefined [
	^(minCorner at: 1) isReal
]

{ #category : #'ops on self' }
BoundingBox >> magnifySelf: aDouble [ 
	self isDefined 
		ifTrue: 
			[minCorner magnifySelf: aDouble.
			maxCorner magnifySelf: aDouble]
]

{ #category : #accessing }
BoundingBox >> maxCorner [
	^maxCorner
]

{ #category : #accessing }
BoundingBox >> maxx [
	^maxCorner at: 1
]

{ #category : #accessing }
BoundingBox >> maxxmaxymaxz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (maxCorner at: 1).
	answer at: 2 put: (maxCorner at: 2).
	answer at: 3 put: (maxCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> maxxmaxyminz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (maxCorner at: 1).
	answer at: 2 put: (maxCorner at: 2).
	answer at: 3 put: (minCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> maxxminymaxz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (maxCorner at: 1).
	answer at: 2 put: (minCorner at: 2).
	answer at: 3 put: (maxCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> maxxminyminz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (maxCorner at: 1).
	answer at: 2 put: (minCorner at: 2).
	answer at: 3 put: (minCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> maxy [
	^maxCorner at: 2
]

{ #category : #accessing }
BoundingBox >> maxz [
	^maxCorner at: 3
]

{ #category : #'ops on self' }
BoundingBox >> merge: aBoundingBox [ 
	"Answer a BoundingBox that contains both the receiver and  the
	argument aBoundingBox."

	^self species origin: (minCorner min: aBoundingBox minCorner)
		corner: (maxCorner max: aBoundingBox maxCorner)
]

{ #category : #accessing }
BoundingBox >> minCorner [
	^minCorner
]

{ #category : #accessing }
BoundingBox >> minx [
	^minCorner at: 1
]

{ #category : #accessing }
BoundingBox >> minxmaxymaxz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (minCorner at: 1).
	answer at: 2 put: (maxCorner at: 2).
	answer at: 3 put: (maxCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> minxmaxyminz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (minCorner at: 1).
	answer at: 2 put: (maxCorner at: 2).
	answer at: 3 put: (minCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> minxminymaxz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (minCorner at: 1).
	answer at: 2 put: (minCorner at: 2).
	answer at: 3 put: (maxCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> minxminyminz [
	| answer |
	answer := FullColumn new: 3.
	answer at: 1 put: (minCorner at: 1).
	answer at: 2 put: (minCorner at: 2).
	answer at: 3 put: (minCorner at: 3).
	^answer
]

{ #category : #accessing }
BoundingBox >> miny [
	^minCorner at: 2
]

{ #category : #accessing }
BoundingBox >> minz [
	^minCorner at: 3
]

{ #category : #accessing }
BoundingBox >> origin [
	^minCorner
]

{ #category : #accessing }
BoundingBox >> origin: originPoint corner: cornerPoint [ 
	minCorner := originPoint.
	maxCorner := cornerPoint
]

{ #category : #copying }
BoundingBox >> postCopy [
	minCorner := minCorner copy.
	maxCorner := maxCorner copy
]

{ #category : #printing }
BoundingBox >> printOn: aStream [ 
	aStream
		print: self class;
		nextPut: $(;
		cr;
		print: minCorner;
		cr;
		print: maxCorner;
		cr;
		nextPut: $)
]

{ #category : #'ops on self' }
BoundingBox >> reverseSelf [
	| aPoint bPoint |
	aPoint := minCorner.
	bPoint := maxCorner.
	self initialize.
	aPoint y: aPoint y negated.
	bPoint y: bPoint y negated.
	self expandToBound: aPoint.
	self expandToBound: bPoint
]

{ #category : #accessing }
BoundingBox >> umax [
	^maxCorner at: 1
]

{ #category : #accessing }
BoundingBox >> umin [
	^minCorner at: 1
]

{ #category : #accessing }
BoundingBox >> uvwOfPoint: aPoint [ 
	| answer min max x range u |
	answer := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			min := minCorner at: i.
			max := maxCorner at: i.
			x := aPoint at: i.
			range := max - min.
			u := range < MachineAccuracy OfDoubleTimesFour 
						ifTrue: [0.0d]
						ifFalse: [(x - min) / range].
			answer at: i put: u].
	^answer
]

{ #category : #accessing }
BoundingBox >> uvwScale [
	| answer range scale |
	answer := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			range := (maxCorner at: i) - (minCorner at: i).
			scale := range < MachineAccuracy OfDoubleTimesFour 
						ifTrue: [0.0d]
						ifFalse: [1.0d / range].
			answer at: i put: scale].
	^answer
]

{ #category : #accessing }
BoundingBox >> vmax [
	^maxCorner at: 2
]

{ #category : #accessing }
BoundingBox >> vmin [
	^minCorner at: 2
]

{ #category : #accessing }
BoundingBox >> wmax [
	^maxCorner at: 3
]

{ #category : #accessing }
BoundingBox >> wmin [
	^minCorner at: 3
]

{ #category : #'initialize-release' }
BoundingBox >> zeroSelf [
	minCorner zeroSelf.
	maxCorner zeroSelf
]

{ #category : #'ops on self' }
BoundingBox >> zeroZcoord [
	minCorner at: 3 put: 0.0d.
	maxCorner at: 3 put: 0.0d
]
