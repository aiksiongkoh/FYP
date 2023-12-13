"
This class represents a common (Cross Platform) prompter for input.  See the class side protocol for example usage

Instance Variables

message <String> The prompter message
initialAnswer <String> Default input
title <String> Window title
"
Class {
	#name : #CommonPrompter,
	#superclass : #SimpleDialog,
	#instVars : [
		'message',
		'initialAnswer',
		'title'
	],
	#category : #'StCAD-Doc-Portable Common-Dialogs'
}

{ #category : #'interface specs' }
CommonPrompter class >> emptySpec [
"UIPainter new openOnClass: self andSelector: #emptySpec"

	<resource: #canvas>

	^#(#FullSpec #window: 
		#(#WindowSpec 
			#label: ' ' 
			#min: #(#Point 20 20 ) 
			#max: #(#Point 1280 1024 ) 
			#bounds: #(#Rectangle 486 611 754 650 ) 
			#isEventDriven: true ) 
		#component: #(#SpecCollection #collection: #() ) )
]

{ #category : #'interface specs' }
CommonPrompter class >> openPrompter: aString [
	^self openPrompter: aString initialAnswer: ''
]

{ #category : #'interface specs' }
CommonPrompter class >> openPrompter: aString initialAnswer: answer [
	^self openPrompter: aString initialAnswer: answer title: ''
]

{ #category : #'interface specs' }
CommonPrompter class >> openPrompter: aString initialAnswer: answer title: title [
	| inst |
	inst := self new.
	inst message: aString.
	inst initialAnswer: answer.
	inst title: title.
	^inst open
]

{ #category : #'VisualWorks metadata' }
CommonPrompter class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
CommonPrompter class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: '' 
			#min: #(#Point 220 114 ) 
			#max: #(#Point 220 114 ) 
			#bounds: #(#Rectangle 476 377 696 491 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#TextEditorSpec 
					#layout: #(#Rectangle 16 9 146 38 ) 
					#name: #messageArea 
					#flags: 4 
					#model: #message 
					#isReadOnly: true ) ) ) )
]

{ #category : #accessing }
CommonPrompter >> initialAnswer [
	"Returns the string initially displayed in the text input widget"

	^initialAnswer
]

{ #category : #accessing }
CommonPrompter >> initialAnswer: aString [
	"Assign the string initially displayed in the text input widget"

	initialAnswer := aString
]

{ #category : #'initialize-release' }
CommonPrompter >> initialize [
	"Private"

	super initialize.
	self title: ''.
	message := ''  asValue.
	self initialAnswer: ''.
]

{ #category : #accessing }
CommonPrompter >> message [ 
	"The string displayed in the message portion of the dialog"

	^message
]

{ #category : #accessing }
CommonPrompter >> message: aMessage [
	"The string displayed in the message portion of the dialog"

	message value: aMessage
]

{ #category : #actions }
CommonPrompter >> open [
	"open the dialog"
	| spec string textWidth textHeight composedMessage layout |

	string := ValueHolder with: self initialAnswer asString.
	spec := (self class interfaceSpecFor: #windowSpec).
	self allButOpenFrom:spec.

	composedMessage := self message value asComposedText.
	layout := (self builder componentAt: #messageArea) layout.
	textWidth := composedMessage width + 20.
	textWidth > (Screen default bounds width  / 2)
		ifTrue: [ textWidth := (Screen default bounds right  / 2).
			composedMessage compositionWidth: textWidth ].
	textHeight :=composedMessage height.
	layout right < ( layout left + textWidth + 20 )
		ifTrue: [ layout right: layout left + textWidth + 20 ].
	layout bottom: layout top + textHeight.
	(self builder componentAt: #messageArea) layout: layout.

	self setInitialGap.
	self addGap: 15.
	self addGap: textHeight + 10.
	self addTextLine: string.
	self addGap: 10.
	self addOK: [true].
	self addGap: 20.

	self preOpen.
	self builder window label: self title.
	self builder openDialogWithExtent: 
		( ( layout left + layout right ) max: self builder window extent x ) @ 
		self builder window displayBox extent y.

	^self accept value
		ifTrue: [string value]
		ifFalse: [nil].
]

{ #category : #accessing }
CommonPrompter >> title [
	"Returns the string to be displayed in the window title bar"

	^title
]

{ #category : #accessing }
CommonPrompter >> title: aTitle [
	"Assign the string to be displayed in the window title bar"

	title := aTitle
]
