Class {
	#name : #MbDSymbolicFunction,
	#superclass : #CADFunction,
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'message handling' }
MbDSymbolicFunction >> argsPerform: selector withArguments: anArray [ 
	^x perform: selector withArguments: anArray
]

{ #category : #evaluating }
MbDSymbolicFunction >> differentiateWRT: variable [ 
	^self == variable
		ifTrue: [Constant with: 1]
		ifFalse: [Constant with: 0]
]

{ #category : #accessing }
MbDSymbolicFunction >> fillJointForces: orderedCollection [ 
	x isJointForce ifTrue: [(orderedCollection includes: self)
			ifFalse: [orderedCollection add: self]]
]

{ #category : #accessing }
MbDSymbolicFunction >> fillJointTorques: orderedCollection [ 
	x isJointTorque ifTrue: [(orderedCollection includes: self)
			ifFalse: [orderedCollection add: self]]
]

{ #category : #accessing }
MbDSymbolicFunction >> fillKineIJs: orderedCollection [ 
	x isKineIJ ifTrue: [(orderedCollection includes: self)
			ifFalse: [orderedCollection add: self]]
]

{ #category : #accessing }
MbDSymbolicFunction >> fillKinedotIJs: orderedCollection [ 
	x isKinedotIJ ifTrue: [(orderedCollection includes: self)
			ifFalse: [orderedCollection add: self]]
]

{ #category : #evaluating }
MbDSymbolicFunction >> value [
	^x value
]
