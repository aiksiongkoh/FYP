Class {
	#name : #FunctionParser,
	#superclass : #SymbolicParser,
	#instVars : [
		'container',
		'geoIJs',
		'units'
	],
	#category : #'StCAD-Geo-CAD'
}

{ #category : #'VisualWorks metadata' }
FunctionParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
FunctionParser >> container [
	^container
]

{ #category : #accessing }
FunctionParser >> container: geoItem [ 
	container := geoItem
]

{ #category : #accessing }
FunctionParser >> displacementFunctions [
	"The methods 'displacement' and 'displacementFunctions' must have the same functions."
	| displacementFunctions |
	displacementFunctions := OrderedCollection new.
	displacementFunctions add: GEOrIJ.
	displacementFunctions add: GEOrIJKi.
	displacementFunctions add: GEOAngleIJz.
	displacementFunctions add: GEOdAngleIJx.
	displacementFunctions add: GEOdAngleIJy.
	^displacementFunctions.
]

{ #category : #accessing }
FunctionParser >> functions [
	| functions |
	functions := super functions.
	functions addAll: self displacementFunctions.
	functions addAll: self velocityFunctions.
	^functions
]

{ #category : #accessing }
FunctionParser >> geoIJs [
	^geoIJs
]

{ #category : #'initialize-release' }
FunctionParser >> geoIJsSet [
	| set |
	set := Set new.
	set addAll: container assembly connectorList.
	^set
]

{ #category : #'initialize-release' }
FunctionParser >> initgeoIJs [
	geoIJs := IdentityDictionary new.
	self geoIJsSet do: [:item | geoIJs at: item name asSymbol put: item].
	geoIJs at: #self put: container
]

{ #category : #accessing }
FunctionParser >> parse: textOrStream as: construct notifying: aRequestor ifFail: aBlock [ 
	self initScanner.
	self
		init: textOrStream
		notifying: aRequestor
		failBlock: aBlock.
	self perform: construct.
	tokenType == #doIt ifFalse: [self expected: 'Nothing more'].
	stack size = 1 ifFalse: [self notify: 'Stack size error, compiler bug!'].
	^stack
]

{ #category : #accessing }
FunctionParser >> parsePOVRay: textOrStream as: construct notifying: aRequestor ifFail: aBlock [ 
	units := Units new.
	self initScanner.
	self
		init: textOrStream
		notifying: aRequestor
		failBlock: aBlock.
	self perform: construct.
	stack size = 1 ifFalse: [self notify: 'Stack size error, compiler bug!'].
	source position: prevEnd.
	^stack
]

{ #category : #accessing }
FunctionParser >> parseUserFunction: userFunction notifying: aRequestor ifFail: aBlock [ 
	| func |
	units := userFunction units.
	self
		parse: userFunction funcText
		as: #expression
		notifying: aRequestor
		ifFail: aBlock.
	func := stack removeLast.
	stack addLast: func * userFunction myUnit.
	^stack
]

{ #category : #accessing }
FunctionParser >> units [
	^units
]

{ #category : #accessing }
FunctionParser >> units: argUnits [ 
	units := argUnits
]

{ #category : #'initialize-release' }
FunctionParser >> variablesSet [
	| set |
	set := Set new.
	set add: container geoTime.
	^set
]

{ #category : #accessing }
FunctionParser >> velocityFunctions [
	"The methods 'velocity' and 'velocityFunctions' must have the same functions."
	| velocityFunctions |
	velocityFunctions := OrderedCollection new.
	velocityFunctions add: GEOvIJ.
	velocityFunctions add: GEOvrIJ.
	velocityFunctions add: GEOvIJKi.
	velocityFunctions add: GEOomeIJ.
	velocityFunctions add: GEOomeIJKi.
	^velocityFunctions.
]
