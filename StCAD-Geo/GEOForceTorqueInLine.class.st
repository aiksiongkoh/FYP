Class {
	#name : #GEOForceTorqueInLine,
	#superclass : #GEOForceTorqueItem,
	#instVars : [
		'tensionFunc',
		'twistFunc'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOForceTorqueInLine class >> nameString [
	^'InLineForceTorque'
]

{ #category : #'VisualWorks metadata' }
GEOForceTorqueInLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOForceTorqueInLine >> createMbD [

	| eFrmI eFrmJ mbdForceTorqueInLine tension parser stack func twist |
	super createMbD.
	eFrmI := markerI mbdObject.
	eFrmJ := markerJ mbdObject.
	mbdForceTorqueInLine := StCAD_MbD_ForceTorqueInLine
		                        onFrmI: eFrmI
		                        andFrmJ: eFrmJ. "VW_TRANSLATION:StCAD.MbD.ForceTorqueInLine:StCAD_MbD_ForceTorqueInLine"
	mbdForceTorqueInLine name: self fullName.
	tension := tensionFunc notNil
		           ifTrue: [ 
			           func := tensionFunc isUserFunction
				                   ifTrue: [ 
					                   parser := self functionParser.
					                   stack := parser
						                            parseUserFunction: tensionFunc
						                            notifying: nil
						                            ifFail: nil.
					                   stack last ]
				                   ifFalse: [ tensionFunc ].
			           (func / self mbdUnits force) createMbD simplified ]
		           ifFalse: [ nil ].
	mbdForceTorqueInLine tension: tension.
	twist := twistFunc notNil
		         ifTrue: [ 
			         func := twistFunc isUserFunction
				                 ifTrue: [ 
					                 parser := self functionParser.
					                 stack := parser
						                          parseUserFunction: twistFunc
						                          notifying: nil
						                          ifFail: nil.
					                 stack last ]
				                 ifFalse: [ twistFunc ].
			         (func / self mbdUnits torque) createMbD simplified ]
		         ifFalse: [ nil ].
	mbdForceTorqueInLine twist: twist.
	mbdForceTorqueInLine submitToSystem.
	self mbdObject: mbdForceTorqueInLine.
	[ mbdForceTorqueInLine initializeLocally ]
		on: self messageNotUnderstoodSignal
		do: [ :ex | 
			| sel |
			sel := ex parameter selector.
			sel == #isKineIJ
				ifTrue: [ 
					Dialog warn:
						'ForceTorque function cannot use a ''geoIJ'' that also uses marker I of a motion constraint.<n>Just create extra markers and geoIJs.'
							expandMacros.
					SimulationStoppingError raiseSignal ]
				ifFalse: [ ex pass ] ]
]

{ #category : #accessing }
GEOForceTorqueInLine >> cut [
	container cutForceTorque: self.
	super cut
]

{ #category : #testing }
GEOForceTorqueInLine >> isForce [
	^true
]

{ #category : #testing }
GEOForceTorqueInLine >> isTorque [
	^false
]

{ #category : #printing }
GEOForceTorqueInLine >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'tension'
		object: tensionFunc.
	aStream
		storeLevel: level + 1
		title: 'twist'
		object: twistFunc
]

{ #category : #DYN }
GEOForceTorqueInLine >> tension [
	| parser stack |
	^tensionFunc notNil
		ifTrue: [tensionFunc isUserFunction
				ifTrue: 
					[parser := self functionParser.
					stack := parser
								parseUserFunction: tensionFunc
								notifying: nil
								ifFail: nil.
					stack last]
				ifFalse: [tensionFunc]]
		ifFalse: [nil]
]

{ #category : #accessing }
GEOForceTorqueInLine >> tensionFunc [
	^tensionFunc
]

{ #category : #accessing }
GEOForceTorqueInLine >> tensionFunc: userFunc [ 
	tensionFunc := userFunc
]

{ #category : #DYN }
GEOForceTorqueInLine >> twist [
	| parser stack |
	^twistFunc notNil
		ifTrue: [twistFunc isUserFunction
				ifTrue: 
					[parser := self functionParser.
					stack := parser
								parseUserFunction: twistFunc
								notifying: nil
								ifFail: nil.
					stack last]
				ifFalse: [twistFunc]]
		ifFalse: [nil]
]

{ #category : #accessing }
GEOForceTorqueInLine >> twistFunc [
	^twistFunc
]

{ #category : #accessing }
GEOForceTorqueInLine >> twistFunc: userFunc [ 
	twistFunc := userFunc
]

{ #category : #accessing }
GEOForceTorqueInLine >> uncut [
	container addForceTorque: self
]

{ #category : #DYN }
GEOForceTorqueInLine >> validateFormulas [
	self tension.
	self twist
]
