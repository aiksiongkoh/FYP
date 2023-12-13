Class {
	#name : #Parser,
	#superclass : #ExternalLanguageParser,
	#category : #'StCAD-Modelica'
}

{ #category : #private }
Parser class >> computeTables [
	"self computeTables."

	super computeTables.
	typeTable at: $/ asInteger put: #xSlash
]

{ #category : #examples }
Parser class >> example1 [

	"self example1."

	| filepath readStream stack |
	filepath := (Filename fromComponents: #( 'Modelica_2_2'
	                'Examples' )) construct: 'VanDerPol.mo'.
	readStream := filepath readStream.

	[ 
	stack := StCAD_Modelica_Parser
		         parse: readStream contents cleanSourceFromSelf
		         as: #stored_definition. "VW_TRANSLATION:StCAD.Modelica.Parser:StCAD_Modelica_Parser"
	stack last inspect ] valueNowOrOnUnwindDo: [ readStream close ]
]

{ #category : #'VisualWorks metadata' }
Parser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Modelica'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #BNF }
Parser >> IDENT [
	^(tokenType == #word and: [token isString]) 
		ifTrue: 
			[self scanToken.
			true]
		ifFalse: [false]
]

{ #category : #BNF }
Parser >> STRING [
	"Taken care by default action."

	^false
]

{ #category : #BNF }
Parser >> UNSIGNED_NUMBER [
	^(tokenType == #number and: [token isReal]) 
		ifTrue: 
			[self scanToken.
			true]
		ifFalse: [false]
]
