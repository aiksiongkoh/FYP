Class {
	#name : #Units,
	#superclass : #Object,
	#instVars : [
		'time',
		'mass',
		'aJ',
		'length',
		'angle',
		'velocity',
		'omega',
		'acceleration',
		'alpha',
		'force',
		'torque'
	],
	#classVars : [
		'Math'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #accessing }
Units >> aJ [
	^aJ
]

{ #category : #accessing }
Units >> acceleration [
	^acceleration
]

{ #category : #accessing }
Units >> alpha [
	^alpha
]

{ #category : #accessing }
Units >> angle [
	^angle
]

{ #category : #calc }
Units >> calc [
	"Calculate derived units."

	aJ := mass * length * length.
	velocity := length / time.
	omega := angle / time.
	acceleration := velocity / time.
	alpha := omega / time.
	force := mass * acceleration.
	torque := force * length
]

{ #category : #accessing }
Units >> force [
	^force
]

{ #category : #'initialize-release' }
Units >> initialize [
	"Default units are second, kilogram, meter, radians."

	self
		time: 1.0d
		mass: 1.0d
		length: 1.0d
		angle: 1.0d
]

{ #category : #accessing }
Units >> length [
	^length
]

{ #category : #accessing }
Units >> mass [
	^mass
]

{ #category : #accessing }
Units >> omega [
	^omega
]

{ #category : #accessing }
Units >> time [
	^time
]

{ #category : #accessing }
Units >> time: unitTime mass: unitMass length: unitLength angle: unitAngle [ 
	time := unitTime.
	mass := unitMass.
	length := unitLength.
	angle := unitAngle.
	self calc
]

{ #category : #accessing }
Units >> torque [
	^torque
]

{ #category : #accessing }
Units >> velocity [
	^velocity
]
