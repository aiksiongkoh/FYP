Class {
	#name : #GeometryAsTextParser,
	#superclass : #ExternalLanguageParser,
	#instVars : [
		'level'
	],
	#classVars : [
		'Geo'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'class initialization' }
GeometryAsTextParser class >> initialize [
	"StCAD.Geo.GeometryAsTextParser initialize."
	| block |
	NameToGEOdict := IdentityDictionary new.
	block :=
			[:class |
			class subclasses isEmpty
				ifTrue: 
					[| symbol |
					symbol := class nameString asSymbol.
					(NameToGEOdict at: symbol ifAbsent: nil) isNil
						ifTrue: [NameToGEOdict at: symbol put: class.]
						ifFalse: [self halt.].]
				ifFalse: [class subclasses do: [:subclass | block value: subclass.].].].
	GEORelativeConstraintSet subclasses
		do: [:subclass | block value: subclass.].
	GEOForceTorqueItem subclasses do: [:subclass | block value: subclass.].
	^NameToGEOdict.
]

{ #category : #'VisualWorks metadata' }
GeometryAsTextParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #'error handling' }
GeometryAsTextParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : #scanning }
GeometryAsTextParser >> nextString [
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
GeometryAsTextParser >> notify: aString [ 
	"Notify problem at token starting 'here'"

	^self notify: aString at: mark
]

{ #category : #'public access' }
GeometryAsTextParser >> parse: string as: construct [ 
	self initScanner;
		init: string
		notifying: nil
		failBlock: nil; perform: construct.
	^stack
]

{ #category : #scanning }
GeometryAsTextParser >> scan: inputStream [ 
	"Bind the input stream, fill the character buffers and first token 
	buffer"

	inputStream skipThrough: Character cr.
	super scan: inputStream
]

{ #category : #scanning }
GeometryAsTextParser >> xDigit [
	"form a number"

	tokenType := #number.
	hereChar == nil ifFalse: [source skip: -1].
	token := Number importFrom: source.
	hereChar := source next
]
