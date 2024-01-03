Class {
	#name : #GEOKineIKineJ,
	#superclass : #GEOData,
	#instVars : [
		'kineI',
		'kineJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOKineIKineJ >> aAIJ [
	^self aAOI transpose timesFullMatrix: self aAOJ
]

{ #category : #accessing }
GEOKineIKineJ >> aAOI [
	^kineI aAOf
]

{ #category : #accessing }
GEOKineIKineJ >> aAOIT [
	^kineI aAOf transpose
]

{ #category : #accessing }
GEOKineIKineJ >> aAOJ [
	^kineJ aAOf
]

{ #category : #accessing }
GEOKineIKineJ >> aIJ [
	^self aIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> aIJI [
	| rIJI omeOII |
	rIJI := self rIJI.
	omeOII := self omeOII.
	^(self aAOIT timesFullColumn: self aOJO - self aOIO)
		- ((self alpOII cross: rIJI)
				+ (omeOII cross: (omeOII cross: rIJI)) + (2.0d * (omeOII cross: self vIJI)))
]

{ #category : #accessing }
GEOKineIKineJ >> aIJI1 [
	^self aIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> aIJI2 [
	^self aIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> aIJI3 [
	^self aIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> aOIO [
	^kineI aOfO
]

{ #category : #accessing }
GEOKineIKineJ >> aOJO [
	^kineJ aOfO
]

{ #category : #accessing }
GEOKineIKineJ >> alpIJ [
	^self alpIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> alpIJI [
	^(self aAOIT timesFullColumn: self alpOJO - self alpOIO)
		- (self omeOII cross: self omeIJI)
]

{ #category : #accessing }
GEOKineIKineJ >> alpIJI1 [
	^self alpIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> alpIJI2 [
	^self alpIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> alpIJI3 [
	^self alpIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> alpOII [
	^self aAOIT timesFullColumn: self alpOIO
]

{ #category : #accessing }
GEOKineIKineJ >> alpOIO [
	^kineI alpOfO
]

{ #category : #accessing }
GEOKineIKineJ >> alpOJO [
	^kineJ alpOfO
]

{ #category : #accessing }
GEOKineIKineJ >> bryantIJ [
	^self aAIJ bryantAngles
]

{ #category : #accessing }
GEOKineIKineJ >> bryantIJ1 [
	^self bryantIJ at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> bryantIJ2 [
	^self bryantIJ at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> bryantIJ3 [
	^self bryantIJ at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> centripetalAccIJ [
	^self centripetalAccIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> centripetalAccIJI [
	| omeOII |
	omeOII := self omeOII.
	^omeOII cross: (omeOII cross: self rIJI)
]

{ #category : #accessing }
GEOKineIKineJ >> centripetalAccIJI1 [
	^self centripetalAccIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> centripetalAccIJI2 [
	^self centripetalAccIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> centripetalAccIJI3 [
	^self centripetalAccIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> coriollisAccIJ [
	^self coriollisAccIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> coriollisAccIJI [
	^2.0d * (self omeOII cross: self vIJI)
]

{ #category : #accessing }
GEOKineIKineJ >> coriollisAccIJI1 [
	^self coriollisAccIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> coriollisAccIJI2 [
	^self coriollisAccIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> coriollisAccIJI3 [
	^self coriollisAccIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> dataTypes [
	"
	rOJO := rOIO + aAOI*rIJI. 
	vOJO := vOIO + aAOI*vIJI + aAOIdot*rIJI. 
	_	:= vOIO + aAOI*vIJI + aAOI*(omeOII cross: rIJI). 
	aOJO := aOIO + aAOI*aIJI + aAOIdot*vIJI + aAOIdot*vIJI + aAOIddot*rIJI. 
	_	:= aOIO + aAOI*aIJI 
	_		+ aAOI*((alpOII cross: rIJI) + (omeOII cross: (omeOII cross: rIJI)) + 2*(omeOII cross: vIJI)). 
	
	rIJI := aAOIT*(rOJO - rOIO). 
	vIJI := aAOIT*(vOJO - vOIO) - (omeOII cross: rIJI). 
	aIJI := aAOIT*(aOJO - aOIO) 
	_		- ((alpOII cross: rIJI) + (omeOII cross: (omeOII cross: rIJI)) + 2*(omeOII cross: vIJI)). 
	
	omeOJO := omeOIO + aAOI*omeIJI. 
	alpOJO := alpOIO + aAOI*alpIJI + aAOIdot*omeIJI. 
	_	:= alpOIO + aAOI*alpIJI + aAOI*(omeOII cross: omeIJI). 
	
	omeIJI := aAOIT*(omeOJO - omeOIO). 
	alpIJI := aAOIT*(alpOJO - alpOIO) - (omeOII cross: omeIJI). 
	"

	| answer |
	answer := OrderedCollection new.
	answer add: #time.
	answer add: #rIJI1.
	answer add: #rIJI2.
	answer add: #rIJI3.
	answer add: #rIJ.
	answer add: #vIJI1.
	answer add: #vIJI2.
	answer add: #vIJI3.
	answer add: #vIJ.
	answer add: #vIJRadial.
	answer add: #aIJI1.
	answer add: #aIJI2.
	answer add: #aIJI3.
	answer add: #aIJ.
	answer add: #bryantIJ1.
	answer add: #bryantIJ2.
	answer add: #bryantIJ3.
	answer add: #omeIJI1.
	answer add: #omeIJI2.
	answer add: #omeIJI3.
	answer add: #omeIJ.
	answer add: #alpIJI1.
	answer add: #alpIJI2.
	answer add: #alpIJI3.
	answer add: #alpIJ.
	answer add: #transverseVelIJI1.
	answer add: #transverseVelIJI2.
	answer add: #transverseVelIJI3.
	answer add: #transverseVelIJ.
	answer add: #transverseAccIJI1.
	answer add: #transverseAccIJI2.
	answer add: #transverseAccIJI3.
	answer add: #transverseAccIJ.
	answer add: #centripetalAccIJI1.
	answer add: #centripetalAccIJI2.
	answer add: #centripetalAccIJI3.
	answer add: #centripetalAccIJ.
	answer add: #coriollisAccIJI1.
	answer add: #coriollisAccIJI2.
	answer add: #coriollisAccIJI3.
	answer add: #coriollisAccIJ.
	^answer
]

{ #category : #accessing }
GEOKineIKineJ >> eulerAngleszyxIJ [
	^GEOEulerAngleszyx fromA: self aAIJ.
]

{ #category : #'initialize-release' }
GEOKineIKineJ >> initialize [
	"Do nothing."
]

{ #category : #accessing }
GEOKineIKineJ >> kineI: geoKine [ 
	kineI := geoKine
]

{ #category : #accessing }
GEOKineIKineJ >> kineJ: geoKine [ 
	kineJ := geoKine
]

{ #category : #accessing }
GEOKineIKineJ >> omeIJ [
	^self omeIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> omeIJI [
	^self aAOIT timesFullColumn: self omeOJO - self omeOIO
]

{ #category : #accessing }
GEOKineIKineJ >> omeIJI1 [
	^self omeIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> omeIJI2 [
	^self omeIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> omeIJI3 [
	^self omeIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> omeOII [
	^self aAOIT timesFullColumn: self omeOIO
]

{ #category : #accessing }
GEOKineIKineJ >> omeOIO [
	^kineI omeOfO
]

{ #category : #accessing }
GEOKineIKineJ >> omeOJO [
	^kineJ omeOfO
]

{ #category : #accessing }
GEOKineIKineJ >> rIJ [
	^self rIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> rIJI [
	^self aAOIT timesFullColumn: self rOJO - self rOIO
]

{ #category : #accessing }
GEOKineIKineJ >> rIJI1 [
	^self rIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> rIJI2 [
	^self rIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> rIJI3 [
	^self rIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> rOIO [
	^kineI rOfO
]

{ #category : #accessing }
GEOKineIKineJ >> rOJO [
	^kineJ rOfO
]

{ #category : #accessing }
GEOKineIKineJ >> time [
	^kineI time
]

{ #category : #accessing }
GEOKineIKineJ >> timetime [
	^kineI timetime
]

{ #category : #accessing }
GEOKineIKineJ >> transverseAccIJ [
	^self transverseAccIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> transverseAccIJI [
	^self alpOII cross: self rIJI
]

{ #category : #accessing }
GEOKineIKineJ >> transverseAccIJI1 [
	^self transverseAccIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> transverseAccIJI2 [
	^self transverseAccIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> transverseAccIJI3 [
	^self transverseAccIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> transverseVelIJ [
	^self transverseVelIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> transverseVelIJI [
	^self omeOII cross: self rIJI
]

{ #category : #accessing }
GEOKineIKineJ >> transverseVelIJI1 [
	^self transverseVelIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> transverseVelIJI2 [
	^self transverseVelIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> transverseVelIJI3 [
	^self transverseVelIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> vIJ [
	^self vIJI length
]

{ #category : #accessing }
GEOKineIKineJ >> vIJI [
	^(self aAOIT timesFullColumn: self vOJO - self vOIO)
		- (self omeOII cross: self rIJI)
]

{ #category : #accessing }
GEOKineIKineJ >> vIJI1 [
	^self vIJI at: 1
]

{ #category : #accessing }
GEOKineIKineJ >> vIJI2 [
	^self vIJI at: 2
]

{ #category : #accessing }
GEOKineIKineJ >> vIJI3 [
	^self vIJI at: 3
]

{ #category : #accessing }
GEOKineIKineJ >> vIJRadial [
	| ur |
	^self rIJI length > 0
		ifTrue: 
			[ur := self rIJI copy normalizeSelf.
			self vIJI dot: ur]
		ifFalse: [self vIJI length]
]

{ #category : #accessing }
GEOKineIKineJ >> vOIO [
	^kineI vOfO
]

{ #category : #accessing }
GEOKineIKineJ >> vOJO [
	^kineJ vOfO
]
