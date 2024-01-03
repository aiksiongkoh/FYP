Class {
	#name : #GEOForceTorqueGeneral,
	#superclass : #GEOForceTorqueItem,
	#instVars : [
		'markerK',
		'aFIeKe',
		'aTIeKe'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOForceTorqueGeneral >> aFIeKe [
	^aFIeKe
]

{ #category : #accessing }
GEOForceTorqueGeneral >> aFIeKe: col [ 
	aFIeKe := col
]

{ #category : #DYN }
GEOForceTorqueGeneral >> aFIeKeFunc [
	| aFIeKeFunc aFIeKei aFIeKeiFunc parser stack func |
	aFIeKeFunc := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			aFIeKei := aFIeKe at: i.
			aFIeKei notNil
				ifTrue: 
					[aFIeKeiFunc := aFIeKei isUserFunction
								ifTrue: 
									[parser := self functionParser.
									stack := parser
												parseUserFunction: aFIeKei
												notifying: nil
												ifFail: nil.
									func := stack last.
									func]
								ifFalse: [aFIeKei].
					aFIeKeFunc at: i put: aFIeKeiFunc]].
	^aFIeKeFunc
]

{ #category : #accessing }
GEOForceTorqueGeneral >> aMarkerK [
	^markerK
]

{ #category : #accessing }
GEOForceTorqueGeneral >> aMarkerK: markerk [ 
	markerK := markerk
]

{ #category : #accessing }
GEOForceTorqueGeneral >> aTIeKe [
	^aTIeKe
]

{ #category : #accessing }
GEOForceTorqueGeneral >> aTIeKe: col [ 
	aTIeKe := col
]

{ #category : #DYN }
GEOForceTorqueGeneral >> aTIeKeFunc [
	| aTIeKeFunc aTIeKei aTIeKeiFunc parser stack func |
	aTIeKeFunc := FullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			aTIeKei := aTIeKe at: i.
			aTIeKei notNil
				ifTrue: 
					[aTIeKeiFunc := aTIeKei isUserFunction
								ifTrue: 
									[parser := self functionParser.
									stack := parser
												parseUserFunction: aTIeKei
												notifying: nil
												ifFail: nil.
									func := stack last.
									func]
								ifFalse: [aTIeKei].
					aTIeKeFunc at: i put: aTIeKeiFunc]].
	^aTIeKeFunc
]

{ #category : #DYN }
GEOForceTorqueGeneral >> createMbD [

	| eFrmI eFrmJ mbdForce efrmK aFIeKeFunc aFIeKei aFIeKeiFunc parser stack func aTIeKeFunc aTIeKei aTIeKeiFunc |
	super createMbD.
	eFrmI := markerI mbdObject.
	eFrmJ := markerJ mbdObject.
	mbdForce := markerK == #O
		            ifTrue: [ 
			            StCAD_MbD_ForceTorqueGeneral
				            onFrmI: eFrmI
				            andFrmJ: eFrmJ "VW_TRANSLATION:StCAD.MbD.ForceTorqueGeneral:StCAD_MbD_ForceTorqueGeneral" ]
		            ifFalse: [ 
			            efrmK := markerK == #J
				                     ifTrue: [ eFrmJ ]
				                     ifFalse: [ eFrmI ].
			            StCAD_MbD_ForceTorqueGeneral
				            onFrmI: eFrmI
				            andFrmJ: eFrmJ
				            wrtFrmK: efrmK ].
	mbdForce name: self fullName.
	aFIeKeFunc := FullColumn new: 3.
	1 to: 3 do: [ :i | 
		aFIeKei := aFIeKe at: i.
		aFIeKei notNil ifTrue: [ 
			aFIeKeiFunc := aFIeKei isUserFunction
				               ifTrue: [ 
					               parser := self functionParser.
					               stack := parser
						                        parseUserFunction: aFIeKei
						                        notifying: nil
						                        ifFail: nil.
					               func := stack last.
					               func ]
				               ifFalse: [ aFIeKei ].
			aFIeKeiFunc := (aFIeKeiFunc / self mbdUnits force) createMbD
				               simplified.
			aFIeKeFunc at: i put: aFIeKeiFunc ] ].
	mbdForce forceFunctions: aFIeKeFunc.
	aTIeKeFunc := FullColumn new: 3.
	1 to: 3 do: [ :i | 
		aTIeKei := aTIeKe at: i.
		aTIeKei notNil ifTrue: [ 
			aTIeKeiFunc := aTIeKei isUserFunction
				               ifTrue: [ 
					               parser := self functionParser.
					               stack := parser
						                        parseUserFunction: aTIeKei
						                        notifying: nil
						                        ifFail: nil.
					               func := stack last.
					               func ]
				               ifFalse: [ aTIeKei ].
			aTIeKeiFunc := (aTIeKeiFunc / self mbdUnits torque) createMbD
				               simplified.
			aTIeKeFunc at: i put: aTIeKeiFunc ] ].
	mbdForce torqueFunctions: aTIeKeFunc.
	mbdForce submitToSystem.
	self mbdObject: mbdForce.
	[ mbdForce initializeLocally ]
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
GEOForceTorqueGeneral >> cut [
	container cutForceTorque: self.
	super cut
]

{ #category : #'initialize-release' }
GEOForceTorqueGeneral >> initialize [
	markerK := #I.
	aFIeKe := FullColumn new: 3.
	aTIeKe := FullColumn new: 3
]

{ #category : #testing }
GEOForceTorqueGeneral >> isForce [
	^true
]

{ #category : #testing }
GEOForceTorqueGeneral >> isTorque [
	^true
]

{ #category : #accessing }
GEOForceTorqueGeneral >> markerK [
	^markerK
]

{ #category : #accessing }
GEOForceTorqueGeneral >> markerK: markerk [ 
	markerK := markerk
]

{ #category : #printing }
GEOForceTorqueGeneral >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'FxOnI'
		object: (aFIeKe at: 1).
	aStream
		storeLevel: level + 1
		title: 'FyOnI'
		object: (aFIeKe at: 2).
	aStream
		storeLevel: level + 1
		title: 'FzOnI'
		object: (aFIeKe at: 3).
	aStream
		storeLevel: level + 1
		title: 'TxOnI'
		object: (aTIeKe at: 1).
	aStream
		storeLevel: level + 1
		title: 'TyOnI'
		object: (aTIeKe at: 2).
	aStream
		storeLevel: level + 1
		title: 'TzOnI'
		object: (aTIeKe at: 3).
	aStream
		storeLevel: level + 1
		title: 'MarkerK'
		object: (markerK notNil
				ifTrue: [markerK]
				ifFalse: [#I])
]

{ #category : #accessing }
GEOForceTorqueGeneral >> uncut [
	container addForceTorque: self
]

{ #category : #DYN }
GEOForceTorqueGeneral >> validateFormulas [
	self aFIeKeFunc.
	self aTIeKeFunc
]
