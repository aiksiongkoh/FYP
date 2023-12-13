"
This class is a common (cross platform) list picker.  See the class side protocol for example usage

Instance Variables

title <String> Title for the window
message <String> Prompter message
multipleSelect <Boolean> If true, allow multi-select
list <Collection> The list of objects to choose from
initialSelection <Number> Index of initial selection
printSelector <Symbol> Unused
"
Class {
	#name : #CommonListChooser,
	#superclass : #SimpleDialog,
	#instVars : [
		'title',
		'message',
		'multipleSelect',
		'list',
		'initialSelection',
		'printSelector'
	],
	#category : #'StCAD-Doc-Portable Common-Dialogs'
}

{ #category : #'interface opening' }
CommonListChooser class >> openMultiWith: aList [
	^self openWith: aList multiSelect: true
]

{ #category : #'interface opening' }
CommonListChooser class >> openWith: aList [
	^self openWith: aList multiSelect: false
]

{ #category : #'interface opening' }
CommonListChooser class >> openWith: aList multiSelect: aBoolean [
	| inst | 
	inst := self new.
	inst list: aList.
	inst multipleSelect: aBoolean.
	^inst open
]

{ #category : #'VisualWorks metadata' }
CommonListChooser class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
CommonListChooser class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: '' 
			#min: #(#Point 251 123 ) 
			#bounds: #(#Rectangle 515 451 766 574 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#TextEditorSpec 
					#layout: #(#Rectangle 12 23 234 58 ) 
					#name: #messageArea 
					#flags: 4 
					#model: #message 
					#isReadOnly: true ) 
				#(#SequenceViewSpec 
					#layout: #(#Rectangle 9 43 239 57 ) 
					#name: #listWidget 
					#flags: 15 
					#model: #list 
					#multipleSelections: false 
					#useModifierKeys: true 
					#selectionType: #highlight ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 20 76 108 104 ) 
					#name: #okButton 
					#model: #accept 
					#label: 'OK' 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 139 76 227 104 ) 
					#name: #cancelButton 
					#model: #cancel 
					#label: 'Cancel' 
					#defaultable: true ) ) ) )
]

{ #category : #'interface specs' }
CommonListChooser class >> windowSpecMultipleSelect [
	"UIPainter new openOnClass: self andSelector: #windowSpecMultipleSelect"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: '' 
			#min: #(#Point 251 123 ) 
			#bounds: #(#Rectangle 515 451 766 574 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#TextEditorSpec 
					#layout: #(#Rectangle 12 23 234 58 ) 
					#name: #messageArea 
					#flags: 4 
					#model: #message 
					#isReadOnly: true ) 
				#(#SequenceViewSpec 
					#layout: #(#Rectangle 9 43 239 57 ) 
					#name: #listWidget 
					#flags: 15 
					#model: #list 
					#multipleSelections: true 
					#useModifierKeys: true 
					#selectionType: #highlight ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 20 76 108 104 ) 
					#name: #okButton 
					#model: #accept 
					#label: 'OK' 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 139 76 227 104 ) 
					#name: #cancelButton 
					#model: #cancel 
					#label: 'Cancel' 
					#defaultable: true ) ) ) )
]

{ #category : #private }
CommonListChooser >> adjustLayout [
	"Private -  adjust the layout of the message label to span multiple lines and list widget
	to calculated list box height depending on the number of elements." 	
	| composedMessage layout textWidth textHeight listHeight wrapper listWidth index pad |

	composedMessage := self message value asComposedText.
	wrapper := self builder componentAt: #messageArea.
	layout := wrapper layout.
	textWidth := composedMessage width.
	textWidth > layout width
		ifTrue: [ textWidth := layout width.
			composedMessage compositionWidth: textWidth - 20 ].
	textHeight := composedMessage height.
	layout right: layout left + textWidth.
	layout bottom: layout top + textHeight.
	wrapper layout: layout.
	wrapper := self builder componentAt: #listWidget.
	layout := wrapper layout.
	self list list size <= 10
		ifTrue: [ wrapper decorator noVerticalScrollBar ].
	listWidth := wrapper layout right - wrapper layout left.
	index := 0.
	pad := layout bottom - layout top.
	self list list detect: [ :entry | 
		index := index + 1.
		( wrapper widget displayStringAt: index ) asComposedText width > listWidth ]
		ifNone: [ wrapper decorator noHorizontalScrollBar.
			pad := 0 ].

	listHeight := ( wrapper widget displayStringAt: index ) asComposedText height * 
		( self list list size min: 10 ) .
	layout bottom: layout top + listHeight + pad.
	wrapper layout: layout.
	( self builder componentAt: #okButton ) moveBy: 0@( textHeight + listHeight ).
	( self builder componentAt: #cancelButton ) moveBy: 0@( textHeight + listHeight )
]

{ #category : #accessing }
CommonListChooser >> initialSelection [
	"Accessor for the initial selection"

	^initialSelection
]

{ #category : #accessing }
CommonListChooser >> initialSelection: aListItem [
	"Assign the initial selection"

	initialSelection := aListItem
]

{ #category : #'initialize-release' }
CommonListChooser >> initialize [
	"Private"

	super initialize.
	list := SelectionInList new.
	self title: ''.
	self multipleSelect: false.
	message := '' asValue.
	self printSelector: nil.
]

{ #category : #accessing }
CommonListChooser >> list [
	"Accessor for the list of items"

	^list
]

{ #category : #accessing }
CommonListChooser >> list: aList [
	"Assignment for the list of item to be displayed"

	list := aList
]

{ #category : #accessing }
CommonListChooser >> message [
	"Returns the message to be displayed on the list dialog"

	^message
]

{ #category : #accessing }
CommonListChooser >> message: aMessage [
	"Assigns the message string to be displayed on the list dialog"

	message value: aMessage
]

{ #category : #accessing }
CommonListChooser >> multipleSelect [
	"A boolean whether multiple selections are allowed"

	^multipleSelect
]

{ #category : #accessing }
CommonListChooser >> multipleSelect: aBoolean [
	"Assign whether multiple selections are allowed"

	multipleSelect := aBoolean
]

{ #category : #actions }
CommonListChooser >> open [
	"Open the dialog"
	| spec |

	self builder source: self.
	spec := self class interfaceSpecFor: #windowSpec.
	self multipleSelect
		ifTrue: [ 
			self list:( MultiSelectionInList with: self list ).
			spec := self class interfaceSpecFor: #windowSpecMultipleSelect ]
		ifFalse: [ 
			self list: ( SelectionInList with: self list ).
			spec := self class interfaceSpecFor: #windowSpec ].
	self allButOpenFrom:spec.
	( self builder componentAt: #listWidget ) widget displayStringSelector: self printSelector.
	self adjustLayout.
 	self builder window label: self title.
	( self builder componentAt: #listWidget ) widget 
		controller setDispatcher: (UIDispatcher new doubleClick: 
		[ ( self list selection  = 0 ) ifFalse: [ accept value: true ] ] ).
	( self list list includes: self initialSelection )
		ifTrue: [ self list selection: self initialSelection ].
	"kludgy fix, must move list box after open or it defaults to wrong look policy"
	self postOpenBlock: [  :dialog :uiBuilder | | layout | 
		layout := ( uiBuilder componentAt: #messageArea ) layout.
		(uiBuilder componentAt: #listWidget) moveBy: 0@( layout bottom - layout top) ].
	self builder openDialogWithExtent: self builder window width @ 
		( ( self builder componentAt: #okButton) layout bottom + 15 ).
	( self accept value )
		ifFalse: [ ^nil ]
		ifTrue: [ self multipleSelect
			ifTrue: [ ^self list selections ]
			ifFalse:[ ^self list selection ] ]
]

{ #category : #accessing }
CommonListChooser >> printSelector [
	"Returns the symbol of the selector used to obtain the display string for the SequenceView.
	If nil, then the SequenceView default will be used"

	^printSelector
]

{ #category : #accessing }
CommonListChooser >> printSelector: aSymbol [
	"Assign the symbol of the selector used to obtain the display string for the SequenceView.
	If nil, then the SequenceView default will be used"

	printSelector := aSymbol
]

{ #category : #accessing }
CommonListChooser >> title [
	"Returns the string to be displayed in the dialog window's title bar."

	^title
]

{ #category : #accessing }
CommonListChooser >> title: aString [
	"Returns the string to be displayed in the dialog window's title bar."

	title := aString
]
