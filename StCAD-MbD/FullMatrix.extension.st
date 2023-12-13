Extension { #name : #FullMatrix }

{ #category : #'*StCAD-MbD-StCAD-MbD' }
FullMatrix >> mbdEulerParameters [
	"Given [A], compute Euler parameter."

	| traceA qE OneMinusTraceDivFour dumSq dum max num maxE FourE |
	traceA := self trace.
	qE := MbDEulerParameters new.
	OneMinusTraceDivFour := 1.0d - traceA / 4.0d.
	1 to: 3
		do: 
			[:i | 
			dumSq := (self at: i and: i)
						/ 2.0d + OneMinusTraceDivFour.
			dum := dumSq > 0.0d
						ifTrue: [dumSq sqrt]
						ifFalse: [0.0d].
			qE at: i put: dum].
	dumSq := 1.0d + traceA / 4.0d.
	dum := dumSq > 0.0d
				ifTrue: [dumSq sqrt]
				ifFalse: [0.0d].
	qE at: 4 put: dum.
	max := 0.0d.
	1 to: 4
		do: 
			[:i | 
			num := qE at: i.
			max < num
				ifTrue: 
					[max := num.
					maxE := i]].
	maxE = 1
		ifTrue: 
			[FourE := 4.0d * (qE at: 1).
			qE at: 2 put: (self at: 1 and: 2)
					+ (self at: 2 and: 1) / FourE.
			qE at: 3 put: (self at: 1 and: 3)
					+ (self at: 3 and: 1) / FourE.
			qE at: 4 put: (self at: 3 and: 2)
					- (self at: 2 and: 3) / FourE].
	maxE = 2
		ifTrue: 
			[FourE := 4.0d * (qE at: 2).
			qE at: 1 put: (self at: 1 and: 2)
					+ (self at: 2 and: 1) / FourE.
			qE at: 3 put: (self at: 2 and: 3)
					+ (self at: 3 and: 2) / FourE.
			qE at: 4 put: (self at: 1 and: 3)
					- (self at: 3 and: 1) / FourE].
	maxE = 3
		ifTrue: 
			[FourE := 4.0d * (qE at: 3).
			qE at: 1 put: (self at: 1 and: 3)
					+ (self at: 3 and: 1) / FourE.
			qE at: 2 put: (self at: 2 and: 3)
					+ (self at: 3 and: 2) / FourE.
			qE at: 4 put: (self at: 2 and: 1)
					- (self at: 1 and: 2) / FourE].
	maxE = 4
		ifTrue: 
			[FourE := 4.0d * (qE at: 4).
			qE at: 1 put: (self at: 3 and: 2)
					- (self at: 2 and: 3) / FourE.
			qE at: 2 put: (self at: 1 and: 3)
					- (self at: 3 and: 1) / FourE.
			qE at: 3 put: (self at: 2 and: 1)
					- (self at: 1 and: 2) / FourE].
	^qE conditionSelf calc
]
