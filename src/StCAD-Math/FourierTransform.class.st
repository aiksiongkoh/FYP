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

{ #category : #examples }
FourierTransform class >> example1 [
	"self halt. self example1."

	"0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111"

	"0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

	"0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15"

	| fft |
	fft := self new.
	fft xs: (MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 8.0d 9.0d 10.0d 11.0d 12.0d 13.0d 14.0d 15.0d)).
	fft ys: (MathArray 
				newWithElements: #(0.0d 1.0d 2.0d 3.0d 4.0d 5.0d 6.0d 7.0d 8.0d 9.0d 10.0d 11.0d 12.0d 13.0d 14.0d 15.0d)).
	fft doBitReversedOrder
]

{ #category : #examples }
FourierTransform class >> example2 [
	"self halt. self example2."

	| fft n dt df |
	fft := self new.
	fft 
		xs: (MathArray newWithElements: #(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d)).
	fft 
		ys: (MathArray newWithElements: #(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d)).
	n := fft size.
	dt := 0.1d.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : #examples }
FourierTransform class >> example3 [
	"self halt. self example3."

	| fft n dt df |
	fft := self new.
	fft xs: (MathArray 
				newWithElements: #(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	fft ys: (MathArray 
				newWithElements: #(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	n := fft size.
	dt := 0.1d.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : #examples }
FourierTransform class >> example4 [
	"self halt. self example4."

	"This is a real and even function. The transform is real and even."

	"Even means h(k) = h(N-k) using zero index."

	| fft n dt df |
	fft := self new.
	fft xs: (MathArray 
				newWithElements: #(0.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d)).
	fft ys: (MathArray 
				newWithElements: #(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	n := fft size.
	dt := 0.1d.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : #examples }
FourierTransform class >> example5 [
	"self halt. self example5."

	"This is a real, periodic function. The transform is real."

	| fft n dt df |
	fft := self new.
	fft xs: (MathArray 
				newWithElements: #(1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 1.0d 1.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	fft ys: (MathArray 
				newWithElements: #(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	n := fft size.
	dt := 0.1d.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : #examples }
FourierTransform class >> example6 [
	"self halt. self example6."

	| fft dt |
	fft := self new.
	fft 
		xs: (MathArray newWithElements: #(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d)).
	fft 
		ys: (MathArray newWithElements: #(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	dt := 0.2d.
	fft delta: dt.
	fft transform.
	fft xs: (MathArray 
				newWithElements: #(1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d 1.0d)).
	fft ys: (MathArray 
				newWithElements: #(0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d 0.0d)).
	dt := 0.1d.
	fft delta: dt.
	fft transform
]

{ #category : #'VisualWorks metadata' }
FourierTransform class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

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
