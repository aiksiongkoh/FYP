"
Make available the machine accuracy, machine precision, machine epsilon for everyone.
"
Class {
	#name : #MachineAccuracy,
	#superclass : #Object,
	#classVars : [
		'Math',
		'Math',
		'Math',
		'Math',
		'Math',
		'Math',
		'Math',
		'Math',
		'Math',
		'Math'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #accessing }
MachineAccuracy class >> DoubleOneMinus4Epsilon [
	^DoubleOneMinus4Epsilon
]

{ #category : #accessing }
MachineAccuracy class >> DoubleOnePlus4Epsilon [
	^DoubleOnePlus4Epsilon
]

{ #category : #accessing }
MachineAccuracy class >> FloatOneMinus4Epsilon [
	^FloatOneMinus4Epsilon
]

{ #category : #accessing }
MachineAccuracy class >> FloatOnePlus4Epsilon [
	^FloatOnePlus4Epsilon
]

{ #category : #accessing }
MachineAccuracy class >> OfDouble [
	^OfDouble
]

{ #category : #accessing }
MachineAccuracy class >> OfDoubleTimesFour [
	^OfDoubleTimesFour
]

{ #category : #accessing }
MachineAccuracy class >> OfFloat [
	^OfFloat
]

{ #category : #accessing }
MachineAccuracy class >> OfFloatTimesFour [
	^OfFloatTimesFour
]

{ #category : #accessing }
MachineAccuracy class >> OfLargestDouble [
	^OfLargestDouble
]

{ #category : #'class initialization' }
MachineAccuracy class >> initialize [
	"To be strictly correct, this should be run everytime the image is started."
	"MachineAccuracy initialize."

	ObjectMemory removeDependent: self.
	ObjectMemory addDependent: self.
	self setVariables
]

{ #category : #'class initialization' }
MachineAccuracy class >> setDoubleVariables [
	"To be strictly correct, this should be run everytime the image is started."
	"StMMachineAccuracy initialize."

	| epsilon unity two max |
	epsilon := Double unity.
	unity := Double unity.
	two := unity + unity.
	max := Double unity.
	
	[OfDouble := epsilon.
	epsilon := epsilon / two.
	unity + epsilon > unity] whileTrue.
	OfDoubleTimesFour := two + two * OfDouble.
	DoubleOnePlus4Epsilon := unity + OfDoubleTimesFour.
	DoubleOneMinus4Epsilon := unity - OfDoubleTimesFour.
	
	[max := [two * max]
				on: RangeError do: [:ex | ex return: nil].
	max == nil ifFalse: [OfLargestDouble := max].
	max == nil] whileFalse
]

{ #category : #'class initialization' }
MachineAccuracy class >> setFloatVariables [
	"To be strictly correct, this should be run everytime the image is started."
	"StMMachineAccuracy initialize."

	| epsilon unity two max |
	epsilon := Float unity.
	unity := Float unity.
	two := unity + unity.
	max := Float unity.
	
	[OfFloat := epsilon.
	epsilon := epsilon / two.
	unity + epsilon > unity] whileTrue.
	OfFloatTimesFour := two + two * OfFloat.
	FloatOnePlus4Epsilon := unity + OfFloatTimesFour.
	FloatOneMinus4Epsilon := unity - OfFloatTimesFour.
	
	[max := [two * max]
				on: RangeError do: [:ex | ex return: nil].
	max == nil ifFalse: [OfLargestFloat := max].
	max == nil] whileFalse
]

{ #category : #'class initialization' }
MachineAccuracy class >> setVariables [
	self setDoubleVariables.
	self setFloatVariables
]

{ #category : #'class initialization' }
MachineAccuracy class >> update: anAspect with: arguments from: anObject [ 
	"Check for return from snapshot to install."

	(anObject == ObjectMemory and: [anAspect == #earlySystemInstallation])
		ifTrue: [self setVariables]
]

{ #category : #'VisualWorks metadata' }
MachineAccuracy class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]
