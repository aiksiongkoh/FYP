"
AnyPart 

Instance Variables:
	aMbD can used to store a MbD object. It is stores in eventHandlers.
	aFEM can used to store a FEM object. It is stores in eventHandlers.
	aCFD can used to store a CFD object. It is stores in eventHandlers.


"
Class {
	#name : #AnyPart,
	#superclass : #SpatialItem,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #events }
AnyPart class >> constructEventsTriggered [
	^(super constructEventsTriggered)
		add: #getMbD;
		add: #getFEM;
		add: #getCFD;
		yourself
]

{ #category : #'VisualWorks metadata' }
AnyPart class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
AnyPart >> aCFD [
	^self triggerEvent: #getCFD
]

{ #category : #accessing }
AnyPart >> aCFD: aCFD [ 
	self removeActionsForEvent: #getCFD.
	aCFD ifNotNil: 
			[self 
				when: #getCFD
				ask: aCFD
				perform: #yourself]
]

{ #category : #accessing }
AnyPart >> aFEM [
	^self triggerEvent: #getFEM
]

{ #category : #accessing }
AnyPart >> aFEM: aFEM [ 
	self removeActionsForEvent: #getFEM.
	aFEM ifNotNil: 
			[self 
				when: #getFEM
				ask: aFEM
				perform: #yourself]
]

{ #category : #accessing }
AnyPart >> aMbD [
	^self triggerEvent: #getMbD
]

{ #category : #accessing }
AnyPart >> aMbD: aMbD [ 
	self removeActionsForEvent: #getMbD.
	aMbD ifNotNil: 
			[self 
				when: #getMbD
				ask: aMbD
				perform: #yourself]
]

{ #category : #displaying }
AnyPart >> canUpdateForFrame: integer [ 
	^[(self dataSeries at: integer) notNil] 
		on: Object subscriptOutOfBoundsSignal
		do: [:ex | ex return: false]
]

{ #category : #displaying }
AnyPart >> updateForFrame: integer [ 
	| data |
	data := self dataSeries at: integer.
	aRefFrame quietlyrOfO: data rOfO aAOf: data aAOf.
	aRefFrame quietlyvOfO: data vOfO omeOfO: data omeOfO
]
