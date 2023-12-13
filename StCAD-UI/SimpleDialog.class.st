Class {
	#name : #SimpleDialog,
	#superclass : #SimpleDialog,
	#instVars : [
		'bufferTrigger',
		'adButton'
	],
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'instance creation' }
SimpleDialog class >> openOn: object [ 
	| newDialog |
	newDialog := super new.
	newDialog subject value: object.
	^newDialog openInterface
]

{ #category : #'instance creation' }
SimpleDialog class >> openOn: object withSpec: aSymbol [ 
	| newDialog |
	newDialog := super new.
	newDialog subject value: object.
	^newDialog openInterface: aSymbol
]

{ #category : #'VisualWorks metadata' }
SimpleDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #ad }
SimpleDialog >> adButton [
	^adButton
]

{ #category : #'initialize-release' }
SimpleDialog >> adaptorFor: aspect [ 
	^(AspectAdaptor subjectChannel: self subject)
		forAspect: aspect
]

{ #category : #accessing }
SimpleDialog >> bufferTrigger [
	^bufferTrigger
]

{ #category : #'initialize-release' }
SimpleDialog >> bufferedAdaptorFor: aspect [ 
	| adaptor |
	adaptor := (AspectAdaptor subjectChannel: self subject)
				forAspect: aspect.
	^BufferedValueHolder subject: adaptor triggerChannel: bufferTrigger
]

{ #category : #'initialize-release' }
SimpleDialog >> bufferedAdaptorForIndex: i [ 
	| adaptor |
	adaptor := (IndexedAdaptor subjectChannel: self subject)
				forIndex: i.
	^BufferedValueHolder subject: adaptor triggerChannel: bufferTrigger
]

{ #category : #ad }
SimpleDialog >> changeAdxxxBy32 [
	adButton changeAdxxxBy32
]

{ #category : #'initialize-release' }
SimpleDialog >> closeAccept [
	bufferTrigger value: true.
	super closeAccept
]

{ #category : #'initialize-release' }
SimpleDialog >> initialize [
	super initialize.
	adButton := AdButton new.
	escapeIsCancel := false.
	bufferTrigger := false asValue.
]

{ #category : #binding }
SimpleDialog >> labelFor: aKey [ 
	"Return an instance of a non-abstract subclass of CharacterArray, 
	that will be used as a label for a widget. Check the label registry 
	if no implementation has been provided."

	^[self perform: aKey]
		on: self application messageNotUnderstoodSignal
		do: 
			[:ex | 
			| sel |
			sel := ex parameter selector.
			sel == aKey
				ifTrue: [ex return: (self application labelFor: aKey)]
				ifFalse: [ex pass]]
]

{ #category : #private }
SimpleDialog >> openExplainFile: aFilename label: labelString [
	| filepath newLabelString |
	filepath := (Filename fromComponents: #('resource' 'explain'))
				construct: aFilename.
	newLabelString := labelString , '                ' , AdData adTitle title.
	[self openReadOnlyFile: filepath label: newLabelString.]
		on: OsInaccessibleError
		do: 
			[:ex |
			| dirString |
			dirString := (Filename fromComponents: #('resource' 'explain')) asString.
			Dialog
				warn: ('All Explain files (*.sdoc) should be in the subsubdirectory ''< 1s >''. <n>When unzipping freecad*.zip and patch*.zip make sure that subdirectory information are preserved. <n>Otherwise, create subsubdirectory ''< 1s >'' and move all *.sdoc into it.'
						expandMacrosWith: dirString).].
]

{ #category : #private }
SimpleDialog >> openReadOnlyFile: aFilename label: labelString [
	EditorDialog new filename: aFilename readOnly: true label: labelString.
]

{ #category : #'initialize-release' }
SimpleDialog >> reset [
	bufferTrigger value: false
]

{ #category : #accessing }
SimpleDialog >> subject [
	^self subclassResponsibility
]

{ #category : #validation }
SimpleDialog >> validateDouble: aController [ 
	| array |
	array := #(-1.0d100 #< #double #< 1.0d100) copy.
	array at: 3 put: aController.
	^self validateDoubleWithArguments: array
]

{ #category : #validation }
SimpleDialog >> validateDoubleGreaterThanZero: aController [ 
	| array |
	array := #(0.0d #< #double #< 1.0d100) copy.
	array at: 3 put: aController.
	^self validateDoubleWithArguments: array
]

{ #category : #validation }
SimpleDialog >> validateDoubleWithArguments: array [ 
	| lowerLimit lowerOp aController upperOp upperLimit entry |
	lowerLimit := array at: 1.
	lowerOp := array at: 2.
	aController := array at: 3.
	upperOp := array at: 4.
	upperLimit := array at: 5.
	(aController hasEditValue
		and: 
			[entry := aController editValue.
			entry isKindOf: Number])
		ifTrue: 
			[entry := entry asPrettyDouble.
			aController selectEntireText; deselect; replaceSelectionWith: entry printString; select]
		ifFalse: 
			[aController selectEntireText.
			Dialog warn: 'Enter a number like -5 or -5.5 or -55.555d-55.'.
			^false].
	(lowerLimit perform: lowerOp with: entry)
		& (entry perform: upperOp with: upperLimit)
		ifFalse: 
			[aController selectEntireText.
			Dialog warn: ('Enter a number such that <n><1p> <2s> number <4s> <5p> ' expandMacrosWithArguments: array).
			^false].
	^true
]

{ #category : #validation }
SimpleDialog >> validateDoubleZeroAndGreater: aController [ 
	| array |
	array := #(0.0d #<= #double #< 1.0d100) copy.
	array at: 3 put: aController.
	^self validateDoubleWithArguments: array
]

{ #category : #validation }
SimpleDialog >> validateIntegerWithArguments: array [ 
	| lowerLimit lowerOp aController upperOp upperLimit entry |
	lowerLimit := array at: 1.
	lowerOp := array at: 2.
	aController := array at: 3.
	upperOp := array at: 4.
	upperLimit := array at: 5.
	(aController hasEditValue
		and: 
			[entry := aController editValue.
			entry isInteger])
		ifFalse: 
			[Dialog warn: 'Enter an integer.'.
			^false].
	(lowerLimit perform: lowerOp with: entry)
		& (entry perform: upperOp with: upperLimit)
		ifFalse: 
			[Dialog warn: 'Enter an integer such that ' , lowerLimit printString , ' ' , lowerOp , ' integer ' , upperOp , ' ' , upperLimit printString , '.'.
			^false].
	^true
]

{ #category : #binding }
SimpleDialog >> visualFor: aKey [ 
	"Return an instance of any non-abstract subclass of 
	VisualComponent (in practice usually either ComposedText or 
	Image) for use as a label for a widget."

	^[self perform: aKey]
		on: self application messageNotUnderstoodSignal
		do: 
			[:ex | 
			| sel |
			sel := ex parameter selector.
			sel == aKey
				ifTrue: [ex return: (self application visualFor: aKey)]
				ifFalse: [ex pass]]
]
