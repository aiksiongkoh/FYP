"
FFT does not account for step size, delta. Fourier Transform does.
Given f(t), the Fourier Tranform F(f)
F(f) := delta*FFT(f(t)).
f(t) := FFT(F(f))/(N*delta)

Instance Variables:
	delta	<Object>	description of delta


"
Class {
	#name : #FourierTransform,
	#superclass : #FFT,
	#instVars : [
		'delta'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #accessing }
FourierTransform >> cyclicInverseSeries [
	| n dt answer |
	n := xs size.
	dt := 1.0d / (n * delta).
	answer := super cyclicSeries.
	1 to: n + 1 do: [:i | (answer at: i) f: (i - 1) * dt].
	^answer
]

{ #category : #accessing }
FourierTransform >> delta: del [ 
	delta := del abs asDouble
]

{ #category : #calc }
FourierTransform >> inverse [
	self FFTsign: -1 times: delta
]

{ #category : #accessing }
FourierTransform >> inverseSeries [
	| n dt answer |
	n := xs size.
	dt := 1.0d / (n * delta).
	answer := super series.
	1 to: n do: [:i | (answer at: i) f: (i - 1) * dt].
	^answer
]

{ #category : #calc }
FourierTransform >> transform [
	self FFTsign: 1 times: delta
]

{ #category : #accessing }
FourierTransform >> transformSeries [
	| n nOver2 fmin answer |
	n := xs size.
	nOver2 := n / 2.
	fmin := 1.0d / (n * delta).
	answer := super series.
	1 to: n
		do: 
			[:i | 
			i <= nOver2 
				ifTrue: [(answer at: i) f: (i - 1) * fmin]
				ifFalse: [(answer at: i) f: (i - 1 - n) * fmin]].
	^answer
]

{ #category : #accessing }
FourierTransform >> xs: xarray ys: yarray delta: del [ 
	super xs: xarray ys: yarray.
	delta := del abs asDouble
]
