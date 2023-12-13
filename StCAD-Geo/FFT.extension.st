Extension { #name : #FFT }

{ #category : #'*StCAD-Geo-accessing' }
FFT >> cyclicSeries [
	| n answer data |
	n := xs size.
	answer := MathArray new: n + 1.
	1 to: n
		do: 
			[:i |
			data := GEOFourierTransformData new.
			data aFx: (xs at: i).
			data aFy: (ys at: i).
			answer at: i put: data.].
	data := GEOFourierTransformData new.
	data aFx: (xs at: 1).
	data aFy: (ys at: 1).
	answer at: n + 1 put: data.
	^answer.
]

{ #category : #'*StCAD-Geo-accessing' }
FFT >> series [
	| n answer |
	n := xs size.
	answer := MathArray new: n.
	1 to: n
		do: 
			[:i |
			| data |
			data := GEOFourierTransformData new.
			data aFx: (xs at: i).
			data aFy: (ys at: i).
			answer at: i put: data.].
	^answer.
]
