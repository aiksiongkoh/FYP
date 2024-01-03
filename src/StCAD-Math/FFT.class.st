"
Based on Numerical Recipes in Fortran.

Instance Variables:
	data	<Object>	description of data


"
Class {
	#name : #FFT,
	#superclass : #Function,
	#instVars : [
		'xs',
		'ys'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #calc }
FFT >> FFTsign: sign times: double [ 
	self doBitReversedOrder.
	self doDanielsonLanczosWithSign: sign sign.
	xs magnifySelf: double.
	ys magnifySelf: double
]

{ #category : #calc }
FFT >> doBitReversedOrder [
	| n j |
	n := xs size.
	j := 1.
	1 to: n
		do: 
			[:i | 
			| m |
			i < j
				ifTrue: 
					[| temp |
					temp := xs at: j.
					xs at: j put: (xs at: i).
					xs at: i put: temp.
					temp := ys at: j.
					ys at: j put: (ys at: i).
					ys at: i put: temp].
			m := n / 2.
			[m >= 2 and: [j > m]]
				whileTrue: 
					[j := j - m.
					m := m / 2].
			j := j + m]
]

{ #category : #calc }
FFT >> doDanielsonLanczosWithSign: sign [ 
	"Ref: Numerical Recipe in Fortran"

	| n mmax |
	n := xs size.
	mmax := 1.
	[n > mmax] whileTrue: 
			[| istep theta wpr wpi wr wi |
			istep := 2 * mmax.
			theta := sign * Double pi / mmax.	"same as 2*pi/istep"
			wpr := -2.0d * (0.5d * theta) sin squared.
			wpi := theta sin.
			wr := 1.0d.
			wi := 0.0d.
			1 to: mmax
				do: 
					[:m | 
					| wtemp |
					m to: n
						by: istep
						do: 
							[:i | 
							| j tempr tempi |
							j := i + mmax.
							tempr := wr * (xs at: j) - (wi * (ys at: j)).
							tempi := wr * (ys at: j) + (wi * (xs at: j)).
							xs at: j put: (xs at: i) - tempr.
							ys at: j put: (ys at: i) - tempi.
							xs at: i put: (xs at: i) + tempr.
							ys at: i put: (ys at: i) + tempi].
					wtemp := wr.
					wr := wr * wpr - (wi * wpi) + wr.
					wi := wi * wpr + (wtemp * wpi) + wi].
			mmax := istep]
]

{ #category : #calc }
FFT >> inverse [
	self FFTsign: -1 times: 1.0d / xs size
]

{ #category : #accessing }
FFT >> size [
	^xs size
]

{ #category : #calc }
FFT >> transform [
	self FFTsign: 1 times: 1
]

{ #category : #accessing }
FFT >> xs [
	^xs
]

{ #category : #accessing }
FFT >> xs: array [ 
	| n |
	n := array size.
	
	[n := n / 2.
	n isInteger] whileTrue.
	n > 1 ifTrue: [Dialog warn: 'Array size must be power of 2.'].
	xs := array
]

{ #category : #accessing }
FFT >> xs: xarray ys: yarray [ 
	| n nn xxs yys |
	xarray isNil 
		ifTrue: 
			[yarray isNil 
				ifTrue: 
					[Dialog warn: 'There is no data'.
					self halt]
				ifFalse: 
					[xs := yarray copy atAllPut: 0.0d.
					ys := yarray]]
		ifFalse: 
			[xs := xarray.
			yarray isNil 
				ifTrue: [ys := xarray copy atAllPut: 0.0d]
				ifFalse: [ys := yarray]].
	xs size ~= ys size 
		ifTrue: 
			[Dialog warn: 'Real and imaginary arrays are not the same size.'.
			self halt].
	n := xs size.
	nn := 2 raisedTo: (n log: 2) rounded asInteger.
	xxs := (MathArray zero: nn).
	yys := (MathArray zero: nn).
	1 to: (n min: nn)
		do: 
			[:i | 
			xxs at: i put: (xs at: i).
			yys at: i put: (ys at: i)].
	xs := xxs.
	ys := yys
]

{ #category : #accessing }
FFT >> ys: array [ 
	| n |
	n := array size.
	
	[n := n / 2.
	n isInteger] whileTrue.
	n > 1 ifTrue: [Dialog warn: 'Array size must be power of 2.'].
	ys := array
]
