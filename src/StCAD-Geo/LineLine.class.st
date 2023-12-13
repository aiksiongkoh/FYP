"

	Find the minimum distance between two lines. 
	Line is a(ap) = a0 + ap*ad. 
	Line is b(bp) = b0 + bp*bd. 
	Minimize a(ap) - b(bp). 
	Therefore 
	ap = bd*(a0 - b0) ad*bd - ad*(a0 - b0) bd*bd / (ad*ad bd*bd - ad*bd ad*bd). 
	bp = bd*(a0 - b0) ad*ad - ad*(a0 - b0) bd*ad / (ad*ad bd*bd - ad*bd ad*bd). 
	
"
Class {
	#name : #LineLine,
	#superclass : #Combination,
	#instVars : [
		'a0',
		'aDir',
		'aPar',
		'aClosestPoint',
		'b0',
		'bDir',
		'bPar',
		'bClosestPoint',
		'tolParallel',
		'aMinDist',
		'tolDist',
		'aCrossPoint'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'instance creation' }
LineLine class >> a0: a3DPoint aDir: aDir b0: b3DPoint bDir: bDir tolParallel: tolParallel tolDist: tolDist [ 
	^(super new)
		a0: a3DPoint
			aDir: aDir
			b0: b3DPoint
			bDir: bDir
			tolParallel: tolParallel
			tolDist: tolDist;
		calc;
		yourself
]

{ #category : #'instance creation' }
LineLine class >> aStartPoint: aStartPoint aEndPoint: aEndPoint bStartPoint: bStartPoint bEndPoint: bEndPoint tolParallel: tolParallel tolDist: tolDist [ 
	^self 
		a0: aStartPoint
		aDir: aEndPoint - aStartPoint
		b0: bStartPoint
		bDir: bEndPoint - bStartPoint
		tolParallel: tolParallel
		tolDist: tolDist
]

{ #category : #'VisualWorks metadata' }
LineLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
LineLine >> a0 [
	^a0
]

{ #category : #accessing }
LineLine >> a0: aFullColumn aDir: aaFullColumn b0: bFullColumn bDir: bbFullColumn tolParallel: aDouble tolDist: aaDouble [ 
	a0 := aFullColumn.
	aDir := aaFullColumn.
	b0 := bFullColumn.
	bDir := bbFullColumn.
	tolParallel := aDouble.
	tolDist := aaDouble
]

{ #category : #accessing }
LineLine >> aClosestPoint [
	^aClosestPoint
]

{ #category : #accessing }
LineLine >> aCrossPoint [
	^aCrossPoint
]

{ #category : #accessing }
LineLine >> aDir [
	^aDir
]

{ #category : #accessing }
LineLine >> aMinDist [
	^aMinDist
]

{ #category : #accessing }
LineLine >> aPar [
	^aPar
]

{ #category : #accessing }
LineLine >> b0 [
	^b0
]

{ #category : #accessing }
LineLine >> bClosestPoint [
	^bClosestPoint
]

{ #category : #accessing }
LineLine >> bDir [
	^bDir
]

{ #category : #accessing }
LineLine >> bPar [
	^bPar
]

{ #category : #'initialize-release' }
LineLine >> calc [
	"See class comments."

	| a0mb0 adsq bdsq adbd ada0mb0 bda0mb0 denominator |
	a0mb0 := a0 - b0.
	adsq := aDir sumOfSquares.
	bdsq := bDir sumOfSquares.
	adbd := aDir dot: bDir.
	ada0mb0 := aDir dot: a0mb0.
	bda0mb0 := bDir dot: a0mb0.
	denominator := adsq * bdsq - (adbd * adbd).
	1.0d - ((aDir normalized dot: bDir normalized) raisedTo: 2) > tolParallel 
		ifTrue: 
			[aPar := (bda0mb0 * adbd - (ada0mb0 * bdsq)) / denominator.
			bPar := (bda0mb0 * adsq - (ada0mb0 * adbd)) / denominator.
			aClosestPoint := a0 plus: aDir times: aPar.
			bClosestPoint := b0 plus: bDir times: bPar.
			aMinDist := (aClosestPoint minusFullColumn: bClosestPoint) length.
			aCrossPoint := aMinDist < tolDist 
						ifTrue: [(aClosestPoint plusFullColumn: bClosestPoint) times: 0.5d]]
		ifFalse: ['Lines are parallel.']
]

{ #category : #accessing }
LineLine >> tolParallel [
	^tolParallel
]
