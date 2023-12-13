Class {
	#name : #GEOEulerAngles,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'aA'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #conditioning }
GEOEulerAngles class >> conditionSeries: series [ 
	"-pi < Euler angles <= pi"

	| pi twopi previousAngle piPlusPrevious ncycle previousRemainder currentAngle piPlusCurrentAngle currentRemainder |
	series isEmpty not
		ifTrue: 
			[pi := Double pi.
			twopi := 2 * pi.
			(series at: 1) isSequenceable
				ifTrue: [1 to: 3
						do: 
							[:j | 
							previousAngle := (series at: 1)
										at: j.
							piPlusPrevious := pi + previousAngle.
							ncycle := piPlusPrevious // twopi.
							previousRemainder := piPlusPrevious \\ twopi.
							2 to: series size
								do: 
									[:i | 
									currentAngle := (series at: i)
												at: j.
									piPlusCurrentAngle := pi + currentAngle.
									currentRemainder := piPlusCurrentAngle \\ twopi.
									(currentRemainder - previousRemainder) abs > pi ifTrue: [currentRemainder < previousRemainder
											ifTrue: [ncycle := ncycle + 1]
											ifFalse: [ncycle := ncycle - 1]].
									currentAngle := ncycle * twopi + currentRemainder - pi.
									(series at: i)
										at: j put: currentAngle.
									previousAngle := currentAngle.
									previousRemainder := currentRemainder]]]
				ifFalse: 
					[previousAngle := series at: 1.
					piPlusPrevious := pi + previousAngle.
					ncycle := piPlusPrevious // twopi.
					previousRemainder := piPlusPrevious \\ twopi.
					2 to: series size
						do: 
							[:i | 
							currentAngle := series at: i.
							piPlusCurrentAngle := pi + currentAngle.
							currentRemainder := piPlusCurrentAngle \\ twopi.
							(currentRemainder - previousRemainder) abs > pi ifTrue: [currentRemainder < previousRemainder
									ifTrue: [ncycle := ncycle + 1]
									ifFalse: [ncycle := ncycle - 1]].
							currentAngle := ncycle * twopi + currentRemainder - pi.
							series at: i put: currentAngle.
							previousAngle := currentAngle.
							previousRemainder := currentRemainder]]]
]

{ #category : #'instance creation' }
GEOEulerAngles class >> new [
	^super new: 3
]

{ #category : #'VisualWorks metadata' }
GEOEulerAngles class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
GEOEulerAngles >> aA [
	aA == nil ifTrue: [self calc].
	^aA
]

{ #category : #calc }
GEOEulerAngles >> rotatex: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := FullMatrix new: 3 by: 3.
	(answer at: 1)
		at: 1 put: 1.0d;
		at: 2 put: 0.0d;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: cthe;
		at: 3 put: 0.0d - sthe.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: sthe;
		at: 3 put: cthe.
	^answer
]

{ #category : #calc }
GEOEulerAngles >> rotatey: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := FullMatrix new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: 0.0d;
		at: 3 put: sthe.
	(answer at: 2)
		at: 1 put: 0.0d;
		at: 2 put: 1.0d;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d - sthe;
		at: 2 put: 0.0d;
		at: 3 put: cthe.
	^answer
]

{ #category : #calc }
GEOEulerAngles >> rotatez: the [ 
	| sthe cthe answer |
	sthe := the sin.
	cthe := the cos.
	answer := FullMatrix new: 3 by: 3.
	(answer at: 1)
		at: 1 put: cthe;
		at: 2 put: 0.0d - sthe;
		at: 3 put: 0.0d.
	(answer at: 2)
		at: 1 put: sthe;
		at: 2 put: cthe;
		at: 3 put: 0.0d.
	(answer at: 3)
		at: 1 put: 0.0d;
		at: 2 put: 0.0d;
		at: 3 put: 1.0d.
	^answer
]
