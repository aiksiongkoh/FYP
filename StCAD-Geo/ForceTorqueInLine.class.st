Class {
	#name : #ForceTorqueInLine,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'tensionFunc',
		'twistFunc'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Force'
}

{ #category : #accessing }
ForceTorqueInLine class >> nameString [
	^'InLineForceTorque'
]

{ #category : #'VisualWorks metadata' }
ForceTorqueInLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
ForceTorqueInLine >> createMbD [

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
ForceTorqueInLine >> cut [
	aSup cutForceTorque: self.
	super cut
]

{ #category : #testing }
ForceTorqueInLine >> isForce [
	^true
]

{ #category : #testing }
ForceTorqueInLine >> isTorque [
	^false
]

{ #category : #printing }
ForceTorqueInLine >> storeOn: aStream level: level [ 
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
ForceTorqueInLine >> tension [
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
ForceTorqueInLine >> tensionFunc [
	^tensionFunc
]

{ #category : #accessing }
ForceTorqueInLine >> tensionFunc: userFunc [ 
	tensionFunc := userFunc
]

{ #category : #DYN }
ForceTorqueInLine >> twist [
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
ForceTorqueInLine >> twistFunc [
	^twistFunc
]

{ #category : #accessing }
ForceTorqueInLine >> twistFunc: userFunc [ 
	twistFunc := userFunc
]

{ #category : #accessing }
ForceTorqueInLine >> uncut [
	aSup addForceTorque: self
]

{ #category : #DYN }
ForceTorqueInLine >> validateFormulas [
	self tension.
	self twist
]
