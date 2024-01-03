"
General like Array. Elements can store anything. This class encapsulate StM methods without affecting the base class Array.
"
Class {
	#name : #MathArray,
	#superclass : #Array,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #'basic ops' }
MathArray >> * aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #'basic ops' }
MathArray >> + array [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ (array at: i)].
	^answer
]

{ #category : #'basic ops' }
MathArray >> - array [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- (array at: i)].
	^answer
]

{ #category : #'basic ops' }
MathArray >> / aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				/ aNumber].
	^answer
]

{ #category : #testing }
MathArray >> < aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) < (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #testing }
MathArray >> <= aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) <= (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #testing }
MathArray >> = aObject [ 
	^self == aObject or: 
			[self class == aObject class and: 
					[self basicSize == aObject basicSize and: 
							[1 to: self size do: [:i | (self at: i) = (aObject at: i) ifFalse: [^false]].
							true]]]
]

{ #category : #testing }
MathArray >> > aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) > (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #testing }
MathArray >> >= aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) >= (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : #norms }
MathArray >> addTo: cNumber [ 
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal 
		ifTrue: [cNumber addAll: self]
		ifFalse: [1 to: self size do: [:i | (self at: i) addTo: cNumber]]
]

{ #category : #'basic ops' }
MathArray >> arrangeElementsAccordingTo: arrayOfOriginalPositions [ 
	| n answer elementi |
	n := self size.
	answer := self class new: n.
	1 to: n
		do: 
			[:i | 
			elementi := self at: (arrayOfOriginalPositions at: i).
			answer at: i put: elementi].
	^answer
]

{ #category : #converting }
MathArray >> asFullColumn [
	^self shallowCopy changeClassToThatOf: (FullColumn new: 0)
]

{ #category : #converting }
MathArray >> asFullMatrix [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asFullRow [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asSparseColumn [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asSparseMatrix [
	self subclassResponsibility
]

{ #category : #converting }
MathArray >> asSparseRow [
	self subclassResponsibility
]

{ #category : #'ops on self' }
MathArray >> at: i times: aNumber [ 
	self at: i put: ((self at: i)
			times: aNumber)
]

{ #category : #'ops on self' }
MathArray >> conditionSelf [
	"Answer a self with insignificant elements set to zeros."

	| tol |
	tol := self maxElement * MachineAccuracy OfDouble.
	self conditionSelfWithTol: tol
]

{ #category : #'ops on self' }
MathArray >> conditionSelfVectorWithTol: tol [ 
	| element |
	1 to: self size
		do: 
			[:i | 
			element := self at: i.
			element < 0.0d ifTrue: [element := 0.0d - element].
			element < tol ifTrue: [self at: i put: 0.0d]]
]

{ #category : #'ops on self' }
MathArray >> conditionSelfWithTol: tol [ 
	(self at: 1) isReal
		ifTrue: [self conditionSelfVectorWithTol: tol]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					conditionSelfWithTol: tol]]
]

{ #category : #'basic ops' }
MathArray >> conditioned [
	"Answer a fresh vector with insignificant elements set to zeros."

	^self copy conditionSelf
]

{ #category : #'basic ops' }
MathArray >> conditionedWithTol: tol [ 
	"Answer a fresh vector with insignificant elements set to zeros."

	^self copy conditionSelfWithTol: tol
]

{ #category : #'basic ops' }
MathArray >> differentiateWRT: aVar [ 
	^self collect: [:item | item differentiateWRT: aVar]
]

{ #category : #'basic ops' }
MathArray >> dot1: stmArray [ 
	"Either receiver or argument must be a one dimensional array."
	"Assume the same first dimensions."

	| array1D array answer |
	(self at: 1) isReal
		ifTrue: 
			[array1D := self.
			array := stmArray]
		ifFalse: [(stmArray at: 1) isReal
				ifTrue: 
					[array1D := stmArray.
					array := self]
				ifFalse: [self error: 'Dot product requires either receiver or argument to be one dimensional.']].
	answer := (array at: 1)
				* (array1D at: 1).
	answer isReal
		ifTrue: [2 to: array1D size do: [:i | answer := answer + ((array at: i)
								* (array1D at: i))]]
		ifFalse: [2 to: array1D size do: [:i | answer equalSelfPlus: (array at: i)
						* (array1D at: i)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> dot: stmArray [ 
	"Either receiver or argument must be a one dimensional array."

	"Assume the same first dimensions."

	| array1D array answer |
	self is1D 
		ifTrue: 
			[array1D := self.
			array := stmArray]
		ifFalse: 
			[stmArray is1D 
				ifTrue: 
					[array1D := stmArray.
					array := self]
				ifFalse: 
					[self 
						error: 'Dot product requires either receiver or argument to be one dimensional.']].
	answer := (array at: 1) * (array1D at: 1).
	answer isSequenceable 
		ifTrue: 
			[2 to: array1D size
				do: [:i | answer equalSelfPlus: (array at: i) * (array1D at: i)]]
		ifFalse: 
			[2 to: array1D size
				do: [:i | answer := answer + ((array at: i) * (array1D at: i))]].
	^answer
]

{ #category : #accessing }
MathArray >> elementClass [
	"Vector and Matrix are intended to store numbers of the same class."

	^Double
]

{ #category : #'basic ops' }
MathArray >> elementTimesElementOf: stmArray [ 
	"Element by element multiplication."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* (stmArray at: i)].
	^answer
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: i)]]
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: iiOffset + i)]]
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equal: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
MathArray >> equal: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (stmArray at: i)
						* number]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: i)
					times: number]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						- (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfMinus: (stmArray at: i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (self at: i)
						- (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equalSelfMinus: (stmArray at: iiOffset + i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfMinus: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
MathArray >> equalSelfMinus: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	self equalSelfPlus: stmArray times: number negated
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						+ (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (self at: i)
						+ (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: iiOffset + i)]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfPlus: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
MathArray >> equalSelfPlus: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						+ ((stmArray at: i)
								* number)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: i)
					times: number]]
]

{ #category : #'ops on self' }
MathArray >> equalSelfTimes: alpha minus: stmArray times: beta [ 
	self
		equalSelfTimes: alpha
		plus: stmArray
		times: beta negated
]

{ #category : #'ops on self' }
MathArray >> equalSelfTimes: alpha plus: stmArray times: beta [ 
	"Assume self and stmArray are same type and dimensions."
	"alpha and beta are numbers."

	(self at: 1) isReal
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						* alpha + ((stmArray at: i)
							* beta)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfTimes: alpha
					plus: (stmArray at: i)
					times: beta]]
]

{ #category : #testing }
MathArray >> is1D [
	"^first isSequenceable not"

	| first |
	first := self at: 1.
	^first isReal or: [first isSymbolic]
]

{ #category : #testing }
MathArray >> isZero [
	1 to: self size do: [:i | (self at: i) isZero ifFalse: [^false]].
	^true
]

{ #category : #norms }
MathArray >> length [
	"Euclidean norm."
	"Square root of the sum of squares."

	^self sumOfSquares sqrt
]

{ #category : #'ops on self' }
MathArray >> magnifySelf: aNumber [ 
	"Magnify every number in the receiver by aNumber."

	aNumber = 1 ifTrue: [^self].
	(self at: 1) isReal
		ifTrue: [self magnifySelfVector: aNumber]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					magnifySelf: aNumber]]
]

{ #category : #'ops on self' }
MathArray >> magnifySelfVector: aNumber [ 
	"Magnify every number in the receiver by aNumber."

	aNumber = 1 ifTrue: [^self].
	1 to: self size do: [:i | self at: i put: (self at: i)
				* aNumber]
]

{ #category : #'basic ops' }
MathArray >> max: array [ 
	| answer |
	answer := self shallowCopy.
	1 to: self size do: [:i | answer at: i put: ((self at: i)
				max: (array at: i))].
	^answer
]

{ #category : #norms }
MathArray >> maxElement [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self maxElementOfVector]
		ifFalse: 
			[| answer |
			answer := selfAt1 maxElement.
			2 to: self size
				do: 
					[:i | 
					| element |
					element := (self at: i) maxElement.
					answer < element ifTrue: [answer := element]].
			answer]
]

{ #category : #norms }
MathArray >> maxElementOfVector [
	| selfAt1 answer |
	selfAt1 := self at: 1.
	selfAt1 < 0.0d ifTrue: [selfAt1 := 0.0d - selfAt1].
	answer := selfAt1.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			selfAti < 0.0d ifTrue: [selfAti := 0.0d - selfAti].
			answer < selfAti ifTrue: [answer := selfAti]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> min: array [ 
	| answer |
	answer := self shallowCopy.
	1 to: self size do: [:i | answer at: i put: ((self at: i)
				min: (array at: i))].
	^answer
]

{ #category : #norms }
MathArray >> minAndMaxValues [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self minAndMaxValuesOfVector]
		ifFalse: 
			[| rowMinAndMaxValues min max |
			rowMinAndMaxValues := selfAt1 minAndMaxValues.
			min := rowMinAndMaxValues at: 1.
			max := rowMinAndMaxValues at: 2.
			2 to: self size
				do: 
					[:i | 
					| rowMin rowMax |
					rowMinAndMaxValues := (self at: i) minAndMaxValues.
					rowMin := rowMinAndMaxValues at: 1.
					rowMax := rowMinAndMaxValues at: 2.
					min < rowMin ifFalse: [min := rowMin].
					max > rowMax ifFalse: [max := rowMax]].
			Array with: min with: max]
]

{ #category : #norms }
MathArray >> minAndMaxValuesOfVector [
	"Answer array of min value and max value."

	| min max |
	min := self at: 1.
	max := min.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			min < selfAti ifFalse: [min := selfAti].
			max > selfAti ifFalse: [max := selfAti]].
	^Array with: min with: max
]

{ #category : #accessing }
MathArray >> minValue [

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self minValueOfVector]
		ifFalse: 
			[| answer |
			answer := selfAt1 minValue.
			2 to: self size
				do: 
					[:i |
					| element |
					element := (self at: i) minValue.
					answer > element ifTrue: [answer := element]].
			answer]
]

{ #category : #accessing }
MathArray >> minValueOfVector [

	| answer |
	answer := self at: 1.
	2 to: self size
		do: 
			[:i |
			| selfAti |
			selfAti := self at: i.
			answer > selfAti ifTrue: [answer := selfAti]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> minus: stmArray times: aNumber [ 
	^self plus: stmArray times: aNumber negated
]

{ #category : #'basic ops' }
MathArray >> minusNumber: aNumber [ 
	"Minus aNumber from each element."

	^self plusNumber: aNumber negated
]

{ #category : #'ops on self' }
MathArray >> mostNegativeSelf [
	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) mostNegativeSelf]]
		ifFalse: [self mostNegativeSelfOfVector]
]

{ #category : #'ops on self' }
MathArray >> mostNegativeSelfOfVector [
	| largestNegative |
	largestNegative := MachineAccuracy OfLargestDouble negated.
	1 to: self size do: [:i | self at: i put: largestNegative]
]

{ #category : #'ops on self' }
MathArray >> mostPositiveSelf [
	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) mostPositiveSelf]]
		ifFalse: [self mostPositiveSelfOfVector]
]

{ #category : #'ops on self' }
MathArray >> mostPositiveSelfOfVector [
	| largest |
	largest := MachineAccuracy OfLargestDouble.
	1 to: self size do: [:i | self at: i put: largest]
]

{ #category : #'basic ops' }
MathArray >> moveElementsToPositionsSpecifiedBy: arrayOfNewPositions [ 
	| n answer newi |
	n := self size.
	answer := self class new: n.
	1 to: n
		do: 
			[:i | 
			newi := arrayOfNewPositions at: i.
			answer at: newi put: (self at: i)].
	^answer
]

{ #category : #'ops on self' }
MathArray >> negateSelf [
	"Negate every number in the array."

	self magnifySelf: -1.0d
]

{ #category : #'basic ops' }
MathArray >> negated [
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i) negated].
	^answer
]

{ #category : #accessing }
MathArray >> numberClass [
	"Vector and Matrix are intended to store numbers of the same class."

	^Double
]

{ #category : #accessing }
MathArray >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfNonZeros [
	"Answer the number of non-zeros in the full vector or matrix."

	self subclassResponsibility
]

{ #category : #norms }
MathArray >> numberOfNumbers [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal 
		ifTrue: [self size]
		ifFalse: 
			[| sum |
			sum := selfAt1 numberOfNumbers.
			2 to: self size do: [:i | sum := sum + (self at: i) numberOfNumbers].
			sum]
]

{ #category : #accessing }
MathArray >> numberOfStorageLocations [
	"Answer the total number of numbers 'values' can hold."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfStoredElements [
	"Answer the actual number of numbers 'values' is holding."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfStoredNonZeros [
	"Vector or matrix must store all the non zeros."

	self numberOfNonZeros
]

{ #category : #accessing }
MathArray >> numberOfStoredZeros [
	"Answer the actual number of zeros 'values' is holding."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> numberOfZeros [
	"Answer the number of zeros in the full vector or matrix."

	self subclassResponsibility
]

{ #category : #'basic ops' }
MathArray >> plus: stmArray times: aNumber [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						plus: (stmArray at: i)
						times: aNumber)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						+ ((stmArray at: i)
								* aNumber)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> plusNumber: aNumber [ 
	"Plus aNumber from each element."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						plusNumber: aNumber)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						+ aNumber]].
	^answer
]

{ #category : #testing }
MathArray >> positive [
	1 to: self size do: [:i | (self at: i) positive ifFalse: [^false]].
	^true
]

{ #category : #copying }
MathArray >> postCopy [
	(self at: 1) isReal ifFalse: [1 to: self size do: [:i | self at: i put: (self at: i) copy]]
]

{ #category : #printing }
MathArray >> printOn: aStream [ 
	"Append to the argument, aStream, the elements of the Array 
	enclosed by parentheses."

	| tooMany |
	tooMany := aStream position + self maxPrint.
	aStream
		nextPutAll: self class veryShortName;
		nextPutAll: '('.
	self do: 
			[:element | 
			element isSequenceable ifTrue: [aStream cr].
			aStream position > tooMany 
				ifTrue: 
					[aStream nextPutAll: '...(more)...)'.
					^self].
			element printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #'basic ops' }
MathArray >> productFromDouble: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #'basic ops' }
MathArray >> productFromInteger: aInteger [ 
	^self productFromDouble: aInteger asDouble
]

{ #category : #'basic ops' }
MathArray >> productFromSmallDouble: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #norms }
MathArray >> rootMeanSquare [
	"(sumOfSquares / numberOfElements) sqrt"

	^(self sumOfSquares / self numberOfElements) sqrt
]

{ #category : #'basic ops' }
MathArray >> roundTo: aDouble [ 
	^self collect: [:arg | arg roundTo: aDouble]
]

{ #category : #'basic ops' }
MathArray >> rounded [
	^self collect: [:item | item rounded]
]

{ #category : #'ops on self' }
MathArray >> scaleSelfBy: aFullColumn [ 
	"Magnify every element in the receiver by corresponding element in aFullColumn."

	(self at: 1) isReal 
		ifTrue: [1 to: self size do: [:i | self at: i times: (aFullColumn at: i)]]
		ifFalse: 
			[1 to: self size do: [:i | (self at: i) magnifySelf: (aFullColumn at: i)]]
]

{ #category : #'basic ops' }
MathArray >> simplified [
	^self collect: [:item | item simplified]
]

{ #category : #accessing }
MathArray >> standardDeviation [
	"
	sigma := sqrt(sum((x - xbar)^2)/n)
	sigma := sqrt(sum((x^2 - 2*x*xbar + xbar^2))/n)
	sigma := sqrt((sum(x^2) - sum(2*x*xbar) + sum(xbar^2))/n)
	sigma := sqrt((sum(x^2) - 2*sum(x)*xbar + n*xbar^2)/n)
	sigma := sqrt((sum(x^2) - 2*sum(x)^2/n + n*sum(x)^2/n^2)/n)
	sigma := sqrt((sum(x^2) - sum(x)^2/n)/n)
	sigma := sqrt((n*sum(x^2) - sum(x)^2)/n^2)
	"

	| n cNumber sum ssq aNumber |
	n := self numberOfNumbers.
	cNumber := (SortedCollection new: n) sortBlock: [:x :y | x abs <= y abs].
	self addTo: cNumber.
	sum := ssq := 0.0d.
	1 to: n
		do: 
			[:i | 
			aNumber := cNumber at: i.
			sum := sum + aNumber.
			ssq := ssq + (aNumber * aNumber)].
	^((n * ssq - (sum * sum)) / (n * n)) sqrt
]

{ #category : #norms }
MathArray >> sumOfAbsElements [
	"Sum of all element abs values."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfAbsElementsOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfAbsElements.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfAbsElements].
			sum]
]

{ #category : #norms }
MathArray >> sumOfAbsElementsOfVector [
	| sum selfAt1 |
	selfAt1 := self at: 1.
	sum := selfAt1 > 0.0d
				ifTrue: [selfAt1]
				ifFalse: [0.0d - selfAt1].
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			sum := selfAti > 0.0d
						ifTrue: [sum + selfAti]
						ifFalse: [sum - selfAti]].
	^sum
]

{ #category : #norms }
MathArray >> sumOfElements [
	"Sum of all elements."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfElementsOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfElements.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfElements].
			sum]
]

{ #category : #norms }
MathArray >> sumOfElementsOfVector [
	| sum |
	sum := self at: 1.
	2 to: self size do: [:i | sum := sum + (self at: i)].
	^sum
]

{ #category : #norms }
MathArray >> sumOfElementsOfVectorRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| selfAt1 sum |
	selfAt1 := self at: 1.
	selfAt1 < 0.0d ifTrue: [selfAt1 := 0.0d - selfAt1].
	sum := selfAt1 raisedTo: number.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			selfAti < 0.0d ifTrue: [selfAti := 0.0d - selfAti].
			sum := sum + (selfAti raisedTo: number)].
	^sum
]

{ #category : #norms }
MathArray >> sumOfElementsRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfElementsOfVectorRaisedTo: number]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfElementsRaisedTo: number.
			2 to: self size do: [:i | sum := sum + ((self at: i)
								sumOfElementsRaisedTo: number)].
			sum]
]

{ #category : #norms }
MathArray >> sumOfSquares [
	"Sum of squares of all elements."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isReal
		ifTrue: [self sumOfSquaresOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfSquares.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfSquares].
			sum]
]

{ #category : #norms }
MathArray >> sumOfSquaresOfVector [
	"Sum of squares of all elements."

	| selfAt1 sum |
	selfAt1 := self at: 1.
	sum := selfAt1 * selfAt1.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			sum := sum + (selfAti * selfAti)].
	^sum
]

{ #category : #'basic ops' }
MathArray >> times: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: ((self at: i)
				times: aNumber)].
	^answer
]

{ #category : #'basic ops' }
MathArray >> times: alpha minus: stmArray [ 
	"a*alpha - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						times: alpha minus: (stmArray at: i))]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						* alpha - (stmArray at: i)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> times: beta minus: stmArray times: alpha [ 
	^self
		times: beta
		plus: stmArray
		times: alpha negated
]

{ #category : #'basic ops' }
MathArray >> times: alpha plus: stmArray [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	^stmArray plus: self times: alpha
]

{ #category : #'basic ops' }
MathArray >> times: beta plus: stmArray times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						times: beta
						plus: (stmArray at: i)
						times: alpha)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						* beta + ((stmArray at: i)
							* alpha)]].
	^answer
]

{ #category : #'basic ops' }
MathArray >> transpose [
	"Answer the transpose of self."

	self subclassResponsibility
]

{ #category : #accessing }
MathArray >> u [
	^self at: 1
]

{ #category : #accessing }
MathArray >> u: object [ 
	^self at: 1 put: object
]

{ #category : #accessing }
MathArray >> v [
	^self at: 2
]

{ #category : #accessing }
MathArray >> v: object [ 
	^self at: 2 put: object
]

{ #category : #accessing }
MathArray >> w [
	^self at: 3
]

{ #category : #accessing }
MathArray >> x [
	^self at: 1
]

{ #category : #accessing }
MathArray >> x: object [ 
	^self at: 1 put: object
]

{ #category : #accessing }
MathArray >> xy [

	^self copyFrom: 1 to: 2
]

{ #category : #accessing }
MathArray >> y [
	^self at: 2
]

{ #category : #accessing }
MathArray >> y: object [ 
	^self at: 2 put: object
]

{ #category : #accessing }
MathArray >> z [
	^self at: 3
]

{ #category : #accessing }
MathArray >> z: object [ 
	^self at: 3 put: object
]

{ #category : #'basic ops' }
MathArray >> zeroCopy [
	^(self at: 1) isReal
		ifTrue: [self zeroCopyOfVector]
		ifFalse: 
			[| answer |
			answer := self shallowCopy.
			1 to: answer size do: [:i | answer at: i put: (answer at: i) zeroCopy].
			answer]
]

{ #category : #'basic ops' }
MathArray >> zeroCopyOfVector [
	| answer |
	answer := self shallowCopy.
	1 to: answer size do: [:i | answer at: i put: 0.0d].
	^answer
]

{ #category : #'ops on self' }
MathArray >> zeroSelf [
	"Zero all stored numbers in array."

	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) zeroSelf]]
		ifFalse: [self zeroSelfOfVector]
]

{ #category : #'ops on self' }
MathArray >> zeroSelfOfVector [
	"Zero all stored numbers in array."

	1 to: self size do: [:i | self at: i put: 0.0d]
]
