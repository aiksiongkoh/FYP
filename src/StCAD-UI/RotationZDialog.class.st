Class {
	#name : #RotationZDialog,
	#superclass : #UserFunctionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
RotationZDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
RotationZDialog >> dialogTitle [
	^'Rotational Motion Function'
]

{ #category : #accessing }
RotationZDialog >> examples [
	| examples |
	examples := OrderedCollection new.
	examples add: #linear -> '(Cdeg + VELdeg*time)*pi/180.0d'.
	examples 
		add: #quadratic -> '(Cdeg + VELdeg*time + ACCdeg*time^2)*pi/180.0d'.
	examples add: #harmonic 
				-> '(Cdeg + AMPdeg*sin((VELdeg*time - PHASEdeg)*pi/180.0d))*pi/180.0d'.
	examples add: #exponential -> '(Cdeg*exp(time/TIMEC))*pi/180.0d'.
	examples add: #'smooth step' 
				-> '(L1deg + (L2deg - L1deg)*((1/2) + (1/pi)*arctan(SLOPE*(time - T0))))*pi/180.0d'.
	examples add: #'smooth square impulse' 
				-> '((H/pi)*(arctan(SLOPE*(time - T1)) - arctan(SLOPE*(time - T2))))*pi/180.0d'.
	examples add: #'smooth ramp top impulse' 
				-> '(((1/pi)*(arctan(1000*(time - T1)) - arctan(1000*(time - T2))))*(((H2 - H1)/(T2 - T1))*(time - T1) + H1))*pi/180.0d'.
	^examples
]

{ #category : #accessing }
RotationZDialog >> getBlock [
	^
	[:cadModel | 
	| phiIJ |
	phiIJ := cadModel value phiIJ.
	self units: phiIJ units.
	phiIJ funcText]
]

{ #category : #accessing }
RotationZDialog >> getBlock1 [
	^[:cadModel | cadModel value phiIJ cadString]
]

{ #category : #private }
RotationZDialog >> updateDomainObjects [
	cadItem value phiIJ: self userFunction
]

{ #category : #private }
RotationZDialog >> updateDomainObjects1 [
	self halt.
	cadItem value phiIJ: self parserResult
]

{ #category : #private }
RotationZDialog >> userFunction [
	^BasicUserFunction
		with: self eqnTextValue
		myUnit: units angle
		units: units
]

{ #category : #accessing }
RotationZDialog >> userInputLabel [
	^'Enter angle in radians as function of time in seconds'
]
