Class {
	#name : #ForceTorqueGeneralGO,
	#superclass : #ForceTorqueItemGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
ForceTorqueGeneralGO class >> geoClass [
	^GEOForceTorqueGeneral
]

{ #category : #'instance creation' }
ForceTorqueGeneralGO class >> issueWarning: anInterface [ 
	(Dialog confirm: 'Select a marker and drag to connect to another marker.\Do you wish to cancel the GeneralForceTorque Tool?' withCRs)
		ifTrue: [anInterface setDefaultTool]
]

{ #category : #'VisualWorks metadata' }
ForceTorqueGeneralGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
ForceTorqueGeneralGO >> aFIeKe [
	| cadUnits aFIeKe geoTime newFIeKei set |
	cadUnits := self cadUnits.
	aFIeKe := self metaObject aFIeKe.
	^aFIeKe collect: [:aFIeKei | aFIeKei isNil
			ifTrue: [BasicUserFunction
					with: ''
					myUnit: cadUnits force
					units: cadUnits]
			ifFalse: [aFIeKei isUserFunction
					ifTrue: [aFIeKei]
					ifFalse: 
						["For backward compatibility"
						geoTime := self geoTime.
						newFIeKei := (aFIeKei substitute: geoTime with: geoTime / cadUnits time)
									/ cadUnits force.
						set := Set new.
						set add: geoTime.
						newFIeKei := newFIeKei expandUntil: set.
						newFIeKei := newFIeKei simplifyUntil: set.
						BasicUserFunction
							with: newFIeKei cadString
							myUnit: cadUnits force
							units: cadUnits]]]
]

{ #category : #accessing }
ForceTorqueGeneralGO >> aTIeKe [
	| cadUnits aTIeKe geoTime newTIeKei set |
	cadUnits := self cadUnits.
	aTIeKe := self metaObject aTIeKe.
	^aTIeKe collect: [:aTIeKei | aTIeKei isNil
			ifTrue: [BasicUserFunction
					with: ''
					myUnit: cadUnits torque
					units: cadUnits]
			ifFalse: [aTIeKei isUserFunction
					ifTrue: [aTIeKei]
					ifFalse: 
						["For backward compatibility"
						geoTime := self geoTime.
						newTIeKei := (aTIeKei substitute: geoTime with: geoTime / cadUnits time)
									/ cadUnits torque.
						set := Set new.
						set add: geoTime.
						newTIeKei := newTIeKei expandUntil: set.
						newTIeKei := newTIeKei simplifyUntil: set.
						BasicUserFunction
							with: newTIeKei cadString
							myUnit: cadUnits torque
							units: cadUnits]]]
]

{ #category : #handles }
ForceTorqueGeneralGO >> handleLabel [
	^self handleLabel: 'ftg'
]

{ #category : #accessing }
ForceTorqueGeneralGO >> promptForFunction [
	ForceTorqueGeneralDialog openOn: self.
]
