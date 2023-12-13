Class {
	#name : #TranslationZDialog,
	#superclass : #UserFunctionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
TranslationZDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
TranslationZDialog >> dialogTitle [
	^'Translational Motion Function'
]

{ #category : #accessing }
TranslationZDialog >> getBlock [
	^
	[:cadModel | 
	| zIJ |
	zIJ := cadModel value zIJ.
	self units: zIJ units.
	zIJ funcText]
]

{ #category : #private }
TranslationZDialog >> updateDomainObjects [
	cadItem value zIJ: self userFunction
]

{ #category : #private }
TranslationZDialog >> userFunction [
	^BasicUserFunction
		with: self eqnTextValue
		myUnit: units length
		units: units
]

{ #category : #accessing }
TranslationZDialog >> userInputLabel [
	^'Enter translation in meters as function of time in seconds'
]
