Class {
	#name : #InverseOfSpectralDensity,
	#superclass : #FunctionFromData,
	#instVars : [
		'deriveOrder',
		'nfreq',
		'freqMax',
		'freqScale',
		'densityScale',
		'seed',
		'spline'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
InverseOfSpectralDensity class >> functionSymbol [
	^'invSD'
]

{ #category : #accessing }
InverseOfSpectralDensity class >> functionTemplate [
	^self functionSymbol 
		, '(time, derivOrderOfSpectrum, nfreq, freqMax, freqScale, densityScale, seed, freq1, den1, freq2, den2, ...)'
]

{ #category : #'VisualWorks metadata' }
InverseOfSpectralDensity class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
InverseOfSpectralDensity >> arguments: array [ 
	| n |
	x := array at: 1.
	deriveOrder := (array at: 2) value.
	nfreq := (array at: 3) value.
	freqMax := (array at: 4) value asDouble.
	freqScale := (array at: 5) value.
	densityScale := (array at: 6) value.
	seed := (array at: 7) value.
	n := (array size - 7) / 2.
	xs := Array new: n.
	ys := Array new: n.
	1 to: n
		do: 
			[:i | 
			xs at: i put: (array at: 2 * i + 6) value asDouble.
			ys at: i put: (array at: 2 * i + 7) value asDouble].
	self computeSpline
]

{ #category : #calculation }
InverseOfSpectralDensity >> computeSpline [
	| splineSD df reals ims random twopi f amp phase real im ii fourier timeSeries ts xxs |
	splineSD := GeneralSpline 
				with: x
				order: 1
				xs: (xs collect: [:element | element perform: freqScale])
				ys: (ys collect: [:element | element perform: densityScale]).
	nfreq := 2 raisedTo: (nfreq log: 2) rounded asInteger.
	df := freqMax / nfreq.
	reals := MathArray new: 2 * nfreq.
	ims := MathArray new: 2 * nfreq.
	random := Random new.
	random seed: seed.
	twopi := 2.0d * Double pi.
	"Zero at zero frequency."
	reals at: 1 put: 0.0d.
	ims at: 1 put: 0.0d.
	1 to: nfreq - 1
		do: 
			[:i | 
			f := i * df.
			amp := splineSD y: (f perform: freqScale).
			amp := densityScale == #log ifTrue: [10.0d raisedTo: amp] ifFalse: [amp].
			amp := (amp / 2) sqrt.
			amp := amp / (twopi * f raisedTo: deriveOrder).
			phase := twopi * random next.
			reals at: i + 1 put: amp * phase cos.
			ims at: i + 1 put: amp * phase sin].
	"Zero at maximum frequency."
	reals at: nfreq + 1 put: 0.0d.
	ims at: nfreq + 1 put: 0.0d.
	1 to: nfreq - 1
		do: 
			[:i | 
			real := reals at: i + 1.
			im := ims at: i + 1.
			ii := 2 * nfreq - i + 1.
			"Assume the time function wiil be real."
			reals at: ii put: real.
			ims at: ii put: 0.0d - im].
	fourier := fourier := FourierTransform new.
	fourier 
		xs: reals
		ys: ims
		delta: df.
	fourier inverse.
	timeSeries := fourier cyclicInverseSeries.
	ts := timeSeries collect: [:element | element f].
	xxs := timeSeries collect: [:element | element aFx].
	spline := GeneralSpline 
				with: x
				order: 5
				xs: ts
				ys: xxs
]

{ #category : #evaluating }
InverseOfSpectralDensity >> differentiateWRTx [
	^spline differentiateWRTx
]

{ #category : #evaluating }
InverseOfSpectralDensity >> value [
	^spline value
]
