Class {
	#name : #STEPParser,
	#superclass : #Object,
	#instVars : [
		'inStream',
		'iMark',
		'aLine',
		'iLine',
		'aKeyword',
		'aDict',
		'cUsedIndex',
		'cAPPLICATION_PROTOCOL_DEFINITION',
		'cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION',
		'cPRODUCT_RELATED_PRODUCT_CATEGORY',
		'cSHAPE_DEFINITION_REPRESENTATION',
		'cSHAPE_REPRESENTATION_RELATIONSHIP',
		'aAssembly',
		'cAnyPart',
		'cAssembly'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'instance creation' }
STEPParser class >> new [
	^super new initialize
]

{ #category : #'instance creation' }
STEPParser class >> parse: aFilename [ 
	| aParser aReadStream |
	aReadStream := aFilename asFilename readStream.
	^
	[aReadStream lineEndAuto.
	aParser := self new.
	aParser inStream: aReadStream.
	aParser parse] 
			ensure: [aReadStream close]
]

{ #category : #'VisualWorks metadata' }
STEPParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
	)

]

{ #category : #parsing }
STEPParser >> DATA [
	| originalClass |
	originalClass := self class.
	self changeClassToThatOf: DATA basicNew.
	
	[self nextKeyword.
	aKeyword ~= 'ENDSEC'] whileTrue: 
				[self perform: aKeyword asSymbol.
				self readCharacter: $;].
	self changeClassToThatOf: originalClass basicNew.
	^true
]

{ #category : #parsing }
STEPParser >> ENDSEC [
	^false
]

{ #category : #parsing }
STEPParser >> HEADER [
	| originalClass |
	originalClass := self class.
	self changeClassToThatOf: HEADER basicNew.
	
	[self nextKeyword.
	aKeyword ~= 'ENDSEC'] whileTrue: 
				[aKeyword = '/*' 
					ifTrue: [self skipComment]
					ifFalse: 
						[self perform: aKeyword asSymbol.
						self readCharacter: $;]].
	self readCharacter: $;.
	self changeClassToThatOf: originalClass basicNew.
	^true
]

{ #category : #parsing }
STEPParser >> ISO1030321 [
	self nextLine.
	('ISO-10303-21*' match: aLine) ifFalse: [self expected: 'ISO-10303-21']
]

{ #category : #accessing }
STEPParser >> aAssembly [

	| cCONTEXT_DEPENDENT cRELATIONSHIP cDEFINITION debug aBlock |
	self fillInstVar.
	aAssembly := StCAD_Geo_GEOAssembly new. "VW_TRANSLATION:StCAD.Geo.GEOAssembly:StCAD_Geo_GEOAssembly"
	aAssembly name: 'STEPAssembly'.
	cCONTEXT_DEPENDENT := OrderedCollection new.
	cRELATIONSHIP := OrderedCollection new.
	cDEFINITION := OrderedCollection new.
	aDict do: [ :aItem | 
		(aItem isMemberOf: CONTEXT_DEPENDENT_SHAPE_REPRESENTATION) ifTrue: [ 
			cCONTEXT_DEPENDENT add: aItem ].
		(aItem isMemberOf: SHAPE_REPRESENTATION_RELATIONSHIP) ifTrue: [ 
			cRELATIONSHIP add: aItem ].
		(aItem isMemberOf: SHAPE_DEFINITION_REPRESENTATION) ifTrue: [ 
			(aItem used_representation isMemberOf:
				 ADVANCED_BREP_SHAPE_REPRESENTATION) ifTrue: [ 
				cDEFINITION add: aItem ] ] ].
	cCONTEXT_DEPENDENT isEmpty not
		ifTrue: [ 
			aBlock := [ :aSHAPE | 
			          aSHAPE _cRELATIONSHIP: cRELATIONSHIP.
			          aAssembly addAnyPart: aSHAPE aPart ].
			debug := false.
			debug
				ifTrue: [ 
					self halt.
					aBlock value: (cCONTEXT_DEPENDENT at: 1).
					aBlock value: (cCONTEXT_DEPENDENT at: 2).
					aBlock value: (cCONTEXT_DEPENDENT at: 3).
					aBlock value: (cCONTEXT_DEPENDENT at: 4).
					aBlock value: (cCONTEXT_DEPENDENT at: 5).
					aBlock value: (cCONTEXT_DEPENDENT at: 6).
					aBlock value: (cCONTEXT_DEPENDENT at: 7).
					aBlock value: (cCONTEXT_DEPENDENT at: 8).
					aBlock value: (cCONTEXT_DEPENDENT at: 9).
					aBlock value: (cCONTEXT_DEPENDENT at: 10) ]
				ifFalse: [ cCONTEXT_DEPENDENT do: aBlock ] ]
		ifFalse: [ 
			cRELATIONSHIP isEmpty not
				ifTrue: [ 
					cRELATIONSHIP doWithIndex: [ :aSHAPE :i | 
						aAssembly addcAnyPart: aSHAPE cPart ] ]
				ifFalse: [ 
					cDEFINITION doWithIndex: [ :aSHAPE :i | 
						aAssembly addcAnyPart: aSHAPE cPart ] ] ].
	^ aAssembly
]

{ #category : #accessing }
STEPParser >> aAssembly1 [

	| aAssembly cRELATIONSHIP cDEFINITION |
	self fillInstVar.
	aAssembly := StCAD_Geo_GEOAssembly new. "VW_TRANSLATION:StCAD.Geo.GEOAssembly:StCAD_Geo_GEOAssembly"
	aAssembly name: 'STEPAssembly'.
	cRELATIONSHIP := OrderedCollection new.
	cDEFINITION := OrderedCollection new.
	aDict do: [ :aItem | 
		(aItem isMemberOf: SHAPE_REPRESENTATION_RELATIONSHIP) ifTrue: [ 
			cRELATIONSHIP add: aItem ].
		(aItem isMemberOf: SHAPE_DEFINITION_REPRESENTATION) ifTrue: [ 
			cDEFINITION add: aItem ] ].
	cRELATIONSHIP isEmpty
		ifTrue: [ 
		cDEFINITION do: [ :aShape | aAssembly addAnyPart: aShape aPart ] ]
		ifFalse: [ 
		cRELATIONSHIP do: [ :aShape | aAssembly addAnyPart: aShape aPart ] ].
	^ aAssembly
]

{ #category : #accessing }
STEPParser >> aAssembly2 [

	| aAssembly cDEFINITION |
	self fillInstVar.
	aAssembly := StCAD_Geo_GEOAssembly new. "VW_TRANSLATION:StCAD.Geo.GEOAssembly:StCAD_Geo_GEOAssembly"
	aAssembly name: 'STEPAssembly'.
	cDEFINITION := OrderedCollection new.
	aDict do: [ :aItem | 
		(aItem isMemberOf:
			 MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION) ifTrue: [ 
			cDEFINITION add: aItem ] ].
	cDEFINITION do: [ :aShape | aAssembly addAnyPart: aShape aPart ].
	^ aAssembly
]

{ #category : #accessing }
STEPParser >> aAssemblySTEP [
	self fillInstVar.
	self collectTopElements.
	self createcAnyPart.
	self checkNamesAreUnique.
	self createAssembly.
	^aAssembly
]

{ #category : #accessing }
STEPParser >> aAssemblySTEP4 [

	| aAssembly |
	cAPPLICATION_PROTOCOL_DEFINITION := OrderedCollection new.
	cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION := OrderedCollection new.
	cPRODUCT_RELATED_PRODUCT_CATEGORY := OrderedCollection new.
	cSHAPE_DEFINITION_REPRESENTATION := OrderedCollection new.
	cSHAPE_REPRESENTATION_RELATIONSHIP := OrderedCollection new.
	self fillInstVar.
	aAssembly := StCAD_Geo_Assembly new. "VW_TRANSLATION:StCAD.Geo.Assembly:StCAD_Geo_Assembly"
	aAssembly name: 'STEPAssembly'.
	aDict do: [ :aItem | 
		(aItem isMemberOf: APPLICATION_PROTOCOL_DEFINITION)
			ifTrue: [ cAPPLICATION_PROTOCOL_DEFINITION add: aItem ]
			ifFalse: [ 
				(aItem isMemberOf: CONTEXT_DEPENDENT_SHAPE_REPRESENTATION)
					ifTrue: [ cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION add: aItem ]
					ifFalse: [ 
						(aItem isMemberOf: PRODUCT_RELATED_PRODUCT_CATEGORY)
							ifTrue: [ cPRODUCT_RELATED_PRODUCT_CATEGORY add: aItem ]
							ifFalse: [ 
								(aItem isMemberOf: SHAPE_DEFINITION_REPRESENTATION)
									ifTrue: [ cSHAPE_DEFINITION_REPRESENTATION add: aItem ]
									ifFalse: [ 
										(aItem isMemberOf: SHAPE_REPRESENTATION_RELATIONSHIP) 
											ifTrue: [ cSHAPE_REPRESENTATION_RELATIONSHIP add: aItem ] ] ] ] ] ].
	self halt.
	^ aAssembly
]

{ #category : #accessing }
STEPParser >> aDict [
	^aDict
]

{ #category : #accessing }
STEPParser >> aDict: anObject [
	aDict := anObject
]

{ #category : #accessing }
STEPParser >> at: i [ 
	cUsedIndex add: i.
	^aDict at: i
]

{ #category : #accessing }
STEPParser >> at: i put: aStepItem [ 
	aStepItem iEntity: i.
	aDict at: i put: aStepItem
]

{ #category : #output }
STEPParser >> bossDict [

	| fileName bos |
	fileName := 'dummy.bos'.
	bos := StCAD_Misc_BinaryObjectStorage onNew:
		       fileName asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
	[ bos nextPut: aDict ] valueNowOrOnUnwindDo: [ bos close ]
]

{ #category : #accessing }
STEPParser >> cTopElement [
	^aDict select: 
			[:aSTEPItem | 
			(aDict detect: 
					[:aaSTEPItem | 
					aaSTEPItem isSequenceable 
						ifTrue: 
							[(aaSTEPItem detect: [:aaaSTEPItem | aaaSTEPItem isSupOf: aSTEPItem]
								ifNone: nil) notNil]
						ifFalse: [aaSTEPItem isSupOf: aSTEPItem]]
				ifNone: nil) isNil]
]

{ #category : #accessing }
STEPParser >> cTopElement1 [
	^aDict select: 
			[:aSTEPItem | 
			(aDict detect: 
					[:aaSTEPItem | 
					aaSTEPItem isSequenceable 
						ifTrue: 
							[(aaSTEPItem detect: [:aaaSTEPItem | aaaSTEPItem isSupOf: aSTEPItem]
								ifNone: nil) notNil]
						ifFalse: [aaSTEPItem isSupOf: aSTEPItem]]
				ifNone: nil) isNil]
]

{ #category : #accessing }
STEPParser >> cTopElement2 [
	| aBlock newCollection |
	aBlock := 
			[:aSTEPItem | 
			(aDict detect: 
					[:aaSTEPItem | 
					aaSTEPItem isSequenceable 
						ifTrue: 
							[(aaSTEPItem detect: [:aaaSTEPItem | aaaSTEPItem isSupOf: aSTEPItem]
								ifNone: nil) notNil]
						ifFalse: [aaSTEPItem isSupOf: aSTEPItem]]
				ifNone: nil) isNil].
	newCollection := aDict species new.
	aDict keysAndValuesDo: 
			[:key :value | 
			key = 1526 ifTrue: [self halt].
			(aBlock value: value) ifTrue: [newCollection at: key put: value]].
	^newCollection
]

{ #category : #accessing }
STEPParser >> cUnusedEntity [
	| answer |
	answer := OrderedCollection new.
	aDict 
		keysAndValuesDo: [:key :value | (cUsedIndex includes: key) ifFalse: [answer add: value]].
	^answer
]

{ #category : #'As yet unclassified' }
STEPParser >> checkNamesAreUnique [
	| cName |
	cName := OrderedCollection new.
	cAnyPart do: 
			[:a | 
			(cName includes: a name) ifTrue: [self checkThis].
			cName add: a name]
]

{ #category : #accessing }
STEPParser >> collectTopElements [
	aDict do: 
			[:aItem | 
			(aItem isMemberOf: APPLICATION_PROTOCOL_DEFINITION) 
				ifTrue: [cAPPLICATION_PROTOCOL_DEFINITION add: aItem]
				ifFalse: 
					[(aItem isMemberOf: CONTEXT_DEPENDENT_SHAPE_REPRESENTATION) 
						ifTrue: [cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION add: aItem]
						ifFalse: 
							[(aItem isMemberOf: PRODUCT_RELATED_PRODUCT_CATEGORY) 
								ifTrue: [cPRODUCT_RELATED_PRODUCT_CATEGORY add: aItem]
								ifFalse: 
									[(aItem isMemberOf: SHAPE_DEFINITION_REPRESENTATION) 
										ifTrue: [cSHAPE_DEFINITION_REPRESENTATION add: aItem]
										ifFalse: 
											[(aItem isMemberOf: SHAPE_REPRESENTATION_RELATIONSHIP) 
												ifTrue: [cSHAPE_REPRESENTATION_RELATIONSHIP add: aItem]]]]]]
]

{ #category : #'As yet unclassified' }
STEPParser >> createAssembly [

	| aPart |
	cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION do: [ :a | 
		a processcAnyPart: cAnyPart ].
	(cAnyPart size = 1 and: [ cAnyPart first isPart ])
		ifTrue: [ 
			aPart := cAnyPart first.
			aAssembly := StCAD_Geo_Assembly new
				             addAnyPart: aPart;
				             yourself "VW_TRANSLATION:StCAD.Geo.Assembly:StCAD_Geo_Assembly" ]
		ifFalse: [ 
		aAssembly := (cAnyPart maxElementWith: [ :a | a depth ]) realCopy ]
]

{ #category : #'As yet unclassified' }
STEPParser >> createAssembly1 [

	| aPart |
	cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION do: [ :a | 
		a processcAnyPart: cAnyPart ].
	(cAnyPart size = 1 and: [ cAnyPart first isPart ])
		ifTrue: [ 
			aPart := cAnyPart first.
			aAssembly := StCAD_Geo_Assembly new
				             addAnyPart: aPart;
				             yourself "VW_TRANSLATION:StCAD.Geo.Assembly:StCAD_Geo_Assembly" ]
		ifFalse: [ 
			cAssembly := cAnyPart select: [ :a | a isAssembly ].
			cAssembly size == 1
				ifTrue: [ aAssembly := cAssembly first ]
				ifFalse: [ self checkThis ] ]
]

{ #category : #accessing }
STEPParser >> createcAnyPart [

	| aSHAPE_REPRESENTATION_RELATIONSHIP |
	cAnyPart := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cSHAPE_DEFINITION_REPRESENTATION do: [ 
		:aSHAPE_DEFINITION_REPRESENTATION | 
		aSHAPE_REPRESENTATION_RELATIONSHIP := cSHAPE_REPRESENTATION_RELATIONSHIP
			                                      detect: [ :a | 
				                                      a aSHAPE_REPRESENTATION
				                                      ==
				                                      aSHAPE_DEFINITION_REPRESENTATION
					                                      aSHAPE_REPRESENTATION ]
			                                      ifNone: nil.
		aSHAPE_REPRESENTATION_RELATIONSHIP
			ifNil: [ cAnyPart add: aSHAPE_DEFINITION_REPRESENTATION aPart ]
			ifNotNil: [ 
				cAnyPart add: (aSHAPE_DEFINITION_REPRESENTATION aPartSTEPWith:
						 aSHAPE_REPRESENTATION_RELATIONSHIP) ] ]
]

{ #category : #'error handling' }
STEPParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: iMark
]

{ #category : #accessing }
STEPParser >> fillInstVar [
	cUsedIndex := Set new: aDict size.
	aDict do: 
			[:aSTEPItem | 
			aSTEPItem isSequenceable 
				ifTrue: [aSTEPItem do: [:aaSTEPItem | aaSTEPItem fillInstVarFrom: self]]
				ifFalse: [aSTEPItem fillInstVarFrom: self]]
]

{ #category : #accessing }
STEPParser >> fillInstVar1 [
	aDict do: 
			[:aSTEPItem | 
			aSTEPItem isSequenceable 
				ifTrue: [aSTEPItem do: [:aaSTEPItem | aaSTEPItem fillInstVarWith: aDict]]
				ifFalse: [aSTEPItem fillInstVarWith: aDict]]
]

{ #category : #accessing }
STEPParser >> fillInstVar2 [
	cUsedIndex := Set new: aDict size.
	aDict do: 
			[:aSTEPItem | 
			aSTEPItem isSequenceable 
				ifTrue: [aSTEPItem do: [:aaSTEPItem | aaSTEPItem fillInstVarFrom: self]]
				ifFalse: [aSTEPItem fillInstVarFrom: self]]
]

{ #category : #accessing }
STEPParser >> inStream [
	^inStream
]

{ #category : #accessing }
STEPParser >> inStream: anObject [
	inStream := anObject
]

{ #category : #'initialize-release' }
STEPParser >> initialize [

	aDict := StCAD_Math_IdentityDictionary new: 1024. "VW_TRANSLATION:StCAD.Math.IdentityDictionary:StCAD_Math_IdentityDictionary"
	cAPPLICATION_PROTOCOL_DEFINITION := OrderedCollection new.
	cCONTEXT_DEPENDENT_SHAPE_REPRESENTATION := OrderedCollection new.
	cPRODUCT_RELATED_PRODUCT_CATEGORY := OrderedCollection new.
	cSHAPE_DEFINITION_REPRESENTATION := OrderedCollection new.
	cSHAPE_REPRESENTATION_RELATIONSHIP := OrderedCollection new
]

{ #category : #parsing }
STEPParser >> mark [
	iMark := inStream position
]

{ #category : #parsing }
STEPParser >> nextKeyword [

	^self subclassResponsibility
]

{ #category : #parsing }
STEPParser >> nextLine [
	| aWriteStream continue |
	self skipToNextToken.
	aWriteStream := (inStream contentsSpecies new: 64) writeStream.
	continue := true.
	
	[inStream atEnd ifTrue: [continue := false].
	continue] whileTrue: 
				[| element |
				element := inStream next.
				(' ;' includes: element) 
					ifTrue: 
						[continue := false.
						inStream skip: -1]
					ifFalse: [aWriteStream nextPut: element]].
	aLine := aWriteStream contents.
	self readCharacter: $;
]

{ #category : #parsing }
STEPParser >> nextSEC [
	self nextLine.
	^aLine = 'END-ISO-10303-21' 
		ifTrue: [false]
		ifFalse: [self perform: aLine asSymbol]
]

{ #category : #'error handling' }
STEPParser >> notify: aString at: position [ 
	"Temporarily reset source in order to get full contents"

	| p contents |
	p := inStream position.
	contents := inStream
				reset;
				contents.
	inStream position: p.
	(SyntaxErrorException new)
		targetClass: nil;
		messageText: aString;
		source: contents;
		position: position;
		raiseSignal
]

{ #category : #parsing }
STEPParser >> parse [
	self ISO1030321.
	
	[self nextLine.
	aLine ~= 'END-ISO-10303-21'] 
			whileTrue: [self perform: aLine asSymbol]
]

{ #category : #parsing }
STEPParser >> readBoolean [
	| aChar answer |
	self skipToNextToken.
	self readCharacter: $..
	aChar := inStream next.
	aChar = $T 
		ifTrue: [answer := true]
		ifFalse: 
			[aChar = $F 
				ifTrue: [answer := false]
				ifFalse: 
					[aChar = $U ifTrue: [answer := nil] ifFalse: [self halt: 'check this.']]].
	self readCharacter: $..
	^answer
]

{ #category : #parsing }
STEPParser >> readCharacter: aChar [ 
	self skipToNextToken.
	inStream next = aChar 
		ifFalse: 
			[| aWriteStream |
			aWriteStream := WriteStream on: (String new: 16).
			aWriteStream nextPut: aChar.
			self expected: aWriteStream contents]
]

{ #category : #parsing }
STEPParser >> readEntityNumber [
	self readCharacter: $#.
	^Number readFrom: inStream
]

{ #category : #parsing }
STEPParser >> readNumber [
	| answer |
	self skipToNextToken.
	answer := Number importFrom: inStream.
	^inStream peek = $. 
		ifTrue: 
			[self readCharacter: $..
			answer asDouble]
		ifFalse: [answer]
]

{ #category : #parsing }
STEPParser >> readOrderedCollection [
	| aStream |
	aStream := OrderedCollection new writeStream.
	self readCharacter: $(.
	
	[self skipToNextToken.
	aStream nextPut: self readEntity.
	inStream skipSeparators.
	inStream peek = $,] 
			whileTrue: [self readCharacter: $,].
	self readCharacter: $).
	^aStream contents
]

{ #category : #parsing }
STEPParser >> readPosNegBoth [
	self skipToNextToken.
	self readCharacter: $..
	^inStream upTo: $.
]

{ #category : #parsing }
STEPParser >> readString [
	self skipToNextToken.
	^inStream peek = $$ 
		ifTrue: [inStream next]
		ifFalse: [String readFrom: inStream]
]

{ #category : #parsing }
STEPParser >> readcEntity [
	| aStream |
	aStream := OrderedCollection new writeStream.
	self readCharacter: $(.
	
	[self skipToNextToken.
	aStream nextPut: self readEntity.
	inStream skipSeparators.
	inStream peek = $,] 
			whileTrue: [self readCharacter: $,].
	self readCharacter: $).
	^aStream contents
]

{ #category : #parsing }
STEPParser >> readcNumber [

	| aStream |
	aStream := StCAD_Math_FullColumn new writeStream. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	self readCharacter: $(.

	[ 
	aStream nextPut: self readNumber.
	inStream peek = $, ] whileTrue: [ self readCharacter: $, ].
	self readCharacter: $).
	^ aStream contents
]

{ #category : #parsing }
STEPParser >> readcString [

	| aStream |
	aStream := StCAD_Math_MathArray new writeStream. "VW_TRANSLATION:StCAD.Math.MathArray:StCAD_Math_MathArray"
	self skipToNextToken.
	inStream peek = $$
		ifTrue: [ inStream next ]
		ifFalse: [ 
			self readCharacter: $(.

			[ 
			aStream nextPut: self readString.
			inStream peek = $, ] whileTrue: [ self readCharacter: $, ].
			self readCharacter: $) ].
	^ aStream contents
]

{ #category : #parsing }
STEPParser >> readccEntity [
	| aStream |
	aStream := OrderedCollection new writeStream.
	self readCharacter: $(.
	
	[self skipToNextToken.
	aStream nextPut: self readcEntity.
	inStream skipSeparators.
	inStream peek = $,] 
			whileTrue: [self readCharacter: $,].
	self readCharacter: $).
	^aStream contents
]

{ #category : #parsing }
STEPParser >> readccNumber [

	| aStream |
	aStream := StCAD_Math_FullColumn new writeStream. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	self readCharacter: $(.

	[ 
	self skipToNextToken.
	aStream nextPut: self readcNumber.
	inStream peek = $, ] whileTrue: [ self readCharacter: $, ].
	self readCharacter: $).
	^ aStream contents
]

{ #category : #parsing }
STEPParser >> skipComment [
	| continue |
	continue := true.
	
	[inStream atEnd ifTrue: [continue := false].
	continue] whileTrue: 
				[| element |
				element := inStream next.
				element = $* 
					ifTrue: 
						[element := inStream next.
						element = $/ ifTrue: [continue := false] ifFalse: [inStream skip: -1]]]
]

{ #category : #parsing }
STEPParser >> skipToNextToken [
	
	[inStream skipSeparators.
	inStream next = $/ 
		ifTrue: 
			[inStream next = $* 
				ifTrue: 
					[self skipComment.
					true]
				ifFalse: 
					[inStream skip: -2.
					false]]
		ifFalse: 
			[inStream skip: -1.
			false]] 
			whileTrue.
	iMark := inStream position
]
