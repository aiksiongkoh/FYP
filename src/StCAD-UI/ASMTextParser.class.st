Class {
	#name : #ASMTextParser,
	#superclass : #ExternalLanguageParser,
	#instVars : [
		'level'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI'
}

{ #category : #'class initialization' }
ASMTextParser class >> initialize [

	"StCAD.UI.ASMTextParser initialize."

	| block |
	NameToGEOdict := IdentityDictionary new.
	block := [ :class | 
	         class subclasses isEmpty
		         ifTrue: [ 
			         | symbol |
			         symbol := class nameString asSymbol.
			         (NameToGEOdict at: symbol ifAbsent: nil) isNil
				         ifTrue: [ NameToGEOdict at: symbol put: class ]
				         ifFalse: [ self halt ] ]
		         ifFalse: [ 
		         class subclasses do: [ :subclass | block value: subclass ] ] ].
	StCAD_Geo_RelativeConstraintSet subclasses do: [ :subclass | 
		block value: subclass ]. "VW_TRANSLATION:StCAD.Geo.RelativeConstraintSet:StCAD_Geo_RelativeConstraintSet"
	StCAD_Geo_ForceTorqueItem subclasses do: [ :subclass | 
		block value: subclass ]. "VW_TRANSLATION:StCAD.Geo.ForceTorqueItem:StCAD_Geo_ForceTorqueItem"
	^ NameToGEOdict
]

{ #category : #'VisualWorks metadata' }
ASMTextParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #geometry3 }
ASMTextParser >> Name [
	^(tokenType == #word and: [token = 'Name'])
		ifTrue: 
			[| geoItem name |
			geoItem := stack last.
			name := self nextString.
			geoItem name: name.
			self scanToken.
			true]
		ifFalse: [false]
]

{ #category : #'error handling' }
ASMTextParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : #scanning }
ASMTextParser >> nextString [
	| newStream tab cr element |
	newStream := (source contentsSpecies new: 64) writeStream.
	hereChar isSeparator
		ifTrue: [source skipSeparators]
		ifFalse: [newStream nextPut: hereChar].
	tab := Character tab.
	cr := Character cr.
	[source atEnd]
		whileFalse: 
			[element := source next.
			element = tab
				ifTrue: 
					[hereChar := element.
					^newStream contents]
				ifFalse: [element = cr
						ifTrue: 
							[hereChar := element.
							^newStream contents]].
			newStream nextPut: element].
	^newStream contents
]

{ #category : #'error handling' }
ASMTextParser >> notify: aString [ 
	"Notify problem at token starting 'here'"

	^self notify: aString at: mark
]

{ #category : #'public access' }
ASMTextParser >> parse: string as: construct [ 
	self initScanner;
		init: string
		notifying: nil
		failBlock: nil; perform: construct.
	^stack
]

{ #category : #scanning }
ASMTextParser >> scan: inputStream [ 
	"Bind the input stream, fill the character buffers and first token 
	buffer"

	inputStream skipThrough: Character cr.
	super scan: inputStream
]

{ #category : #scanning }
ASMTextParser >> xDigit [
	"form a number"

	tokenType := #number.
	hereChar == nil ifFalse: [source skip: -1].
	token := Number importFrom: source.
	hereChar := source next
]
