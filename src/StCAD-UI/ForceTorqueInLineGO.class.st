Class {
	#name : #ForceTorqueInLineGO,
	#superclass : #ForceTorqueItemGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
ForceTorqueInLineGO class >> geoClass [
	^GEOForceTorqueInLine
]

{ #category : #'instance creation' }
ForceTorqueInLineGO class >> issueWarning: anInterface [ 
	(Dialog confirm: 'Select a marker and drag to connect to another marker.\Do you wish to cancel the InLineForceTorque Tool?' withCRs)
		ifTrue: [anInterface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
ForceTorqueInLineGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
ForceTorqueInLineGO >> handleLabel [
	^self handleLabel: 'fti'
]

{ #category : #accessing }
ForceTorqueInLineGO >> promptForFunction [
	ForceTorqueInLineDialog openOn: self.
]

{ #category : #accessing }
ForceTorqueInLineGO >> tensionFunc [
	| cadUnits tensionFunc geoTime tensionFunc1 set |
	cadUnits := self cadUnits.
	tensionFunc := self metaObject tensionFunc.
	^tensionFunc isNil
		ifTrue: [BasicUserFunction
				with: ''
				myUnit: cadUnits force
				units: cadUnits]
		ifFalse: [tensionFunc isUserFunction
				ifTrue: [tensionFunc]
				ifFalse: 
					["For backward compatibility"
					geoTime := self geoTime.
					tensionFunc1 := (tensionFunc substitute: geoTime with: geoTime / cadUnits time)
								/ cadUnits force.
					set := Set new.
					set add: geoTime.
					tensionFunc1 := tensionFunc1 expandUntil: set.
					tensionFunc1 := tensionFunc1 simplifyUntil: set.
					BasicUserFunction
						with: tensionFunc1 cadString
						myUnit: cadUnits force
						units: cadUnits]]
]

{ #category : #accessing }
ForceTorqueInLineGO >> twistFunc [
	| cadUnits twistFunc geoTime twistFunc1 set |
	cadUnits := self cadUnits.
	twistFunc := self metaObject twistFunc.
	^twistFunc isNil
		ifTrue: [BasicUserFunction
				with: ''
				myUnit: cadUnits force
				units: cadUnits]
		ifFalse: [twistFunc isUserFunction
				ifTrue: [twistFunc]
				ifFalse: 
					["For backward compatibility"
					geoTime := self geoTime.
					twistFunc1 := (twistFunc substitute: geoTime with: geoTime / cadUnits time)
								/ cadUnits force.
					set := Set new.
					set add: geoTime.
					twistFunc1 := twistFunc1 expandUntil: set.
					twistFunc1 := twistFunc1 simplifyUntil: set.
					BasicUserFunction
						with: twistFunc1 cadString
						myUnit: cadUnits force
						units: cadUnits]]
]
