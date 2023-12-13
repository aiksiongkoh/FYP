Class {
	#name : #CADLightingDialog,
	#superclass : #CADDialog,
	#instVars : [
		'aLighting',
		'isOn',
		'aJunColorChoiceHSB'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'instance creation' }
CADLightingDialog class >> openOn: aLighting [ 
	| newDialog |
	newDialog := super new.
	newDialog subject value: aLighting.
	newDialog isOn value: aLighting isOn.
	newDialog aJunColorChoiceHSB color: aLighting color.
	^newDialog openInterface
]

{ #category : #'VisualWorks metadata' }
CADLightingDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADLightingDialog >> aJunColorChoiceHSB [
	^aJunColorChoiceHSB
]

{ #category : #private }
CADLightingDialog >> closeAccept [
	accept value 
		ifTrue: 
			[(self requestForWindowClose and: [self hasInputValid]) 
				ifTrue: 
					[self updateDomainObjects.
					close value: true.
					builder window checkForEvents]
				ifFalse: [accept value: false]]
]

{ #category : #private }
CADLightingDialog >> hasInputValid [
	^true
]

{ #category : #'initialize-release' }
CADLightingDialog >> initialize [
	super initialize.
	aLighting := nil asValue.
	isOn := nil asValue.
	aJunColorChoiceHSB := JunColorChoiceHSB new
]

{ #category : #accessing }
CADLightingDialog >> isOn [
	^isOn
]

{ #category : #'menu items' }
CADLightingDialog >> menuExplainLighting [
	| labelString |
	labelString := 'Explain Lighting Dialog'.
	self openExplainFile: 'StCADLightingDialogMenuExplain.sdoc'
		label: labelString
]

{ #category : #'initialize-release' }
CADLightingDialog >> reset [
	| aLightingColor |
	super reset.
	isOn value: aLighting value isOn.
	aLightingColor := aLighting value color.
	aJunColorChoiceHSB color: aLightingColor
]

{ #category : #'initialize-release' }
CADLightingDialog >> subject [
	^aLighting
]

{ #category : #private }
CADLightingDialog >> updateDomainObjects [
	| selectedColor |
	aLighting value isOn: isOn value.
	selectedColor := aJunColorChoiceHSB color.
	aLighting value color: selectedColor
]
