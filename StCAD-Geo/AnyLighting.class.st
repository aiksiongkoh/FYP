Class {
	#name : #AnyLighting,
	#superclass : #SpatialItem,
	#instVars : [
		'isOn'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #defaults }
AnyLighting class >> defaultAlpha [
	^1.0
]

{ #category : #defaults }
AnyLighting class >> defaultColor [
	^ColorValue white
]

{ #category : #'VisualWorks metadata' }
AnyLighting class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #'initialize-release' }
AnyLighting >> initialize [
	super initialize.
	self privateCalcBoundingBox.
	isOn := true
]

{ #category : #accessing }
AnyLighting >> isOn [
	^isOn
]

{ #category : #accessing }
AnyLighting >> isOn: aBoolean [ 
	isOn := aBoolean = true
]

{ #category : #accessing }
AnyLighting >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeLighting: self]
]

{ #category : #displaying }
AnyLighting >> renderOn: aRenderingContext [ 
	"Do nothing."
]

{ #category : #lighting }
AnyLighting >> shineOn: aRenderingContext [ 
	isOn ifTrue: [self lightingOn: aRenderingContext]
]
