"
This class is a more sophisticated common 'Warning' dialog.  See the class side protocol for example usage

Instance Variables:

	title	<String>	 Window title
	button	<Number>	Controls the number of buttons to use
	message	<String>	 Prompter message
	iconStyle	<Symbol>	Name of icon to use
	buttonStyle	<Symbol>	Image (if any) to use on button(s)
"
Class {
	#name : #CommonMessageDialog,
	#superclass : #SimpleDialog,
	#instVars : [
		'title',
		'button',
		'message',
		'iconStyle',
		'buttonStyle'
	],
	#classInstVars : [
		'buttonLabelList',
		'iconStyleList'
	],
	#category : #'StCAD-Doc-Portable Common-Dialogs'
}

{ #category : #'accessing ' }
CommonMessageDialog class >> buttonLabelList [
	"Private - Initialize a dictionary that associates a user supplied symbol with the label value"

	buttonLabelList isNil
		ifTrue:[
			buttonLabelList := Dictionary new.
			buttonLabelList at: #ok put: #('OK');
				at: #okCancel put: #('OK' 'Cancel');
				at: #yesNo put: #('Yes' 'No');
				at: #retryCancel put: #('Retry' 'Cancel');
				at: #yesNoCancel put: #('Yes' 'No' 'Cancel');
				at: #abortRetryIgnore put: #('Abort' 'Retry' 'Ignore')].
		^buttonLabelList
]

{ #category : #'accessing ' }
CommonMessageDialog class >> buttonValueList [
	"Private - list of possible return values for button action"

	^#(#(true) #(true false) #(true false nil)).
]

{ #category : #'accessing ' }
CommonMessageDialog class >> criticalImage [
	"UIMaskEditor new openOnClass: self andSelector: #criticalImage"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 2 bitsPerPixel: 2 palette: (MappedPalette withColors: ((Array new: 3) at: 1 put: ColorValue red; at: 2 put: (ColorValue scaledRed: 4112 scaledGreen: 4112 scaledBlue: 4112); at: 3 put: ColorValue white; yourself)) usingBits: (ByteArray fromPackedString: '****@@*******(@@@B*****(@@@@@*****@@@@@@**** @@@@@@***(@@@@@@@***@@@@@@@@** @B@@@H@@**@@*@@B(@A* @J*@@*(@A*@@J*@J*@@F(@@J*B* @@V@@@J**(@@@X@@@J**@@@A @@@J* @@@E@@@@**@@@@T@@@J**@@@AP@@B***@@@E @@*(J*@@AV@@J*@J*@@EX@B* @J*@@V(@B(@@J @EZ @B@@@H@@U* @@@@@@@EZ* @@@@@@AU** @@@@@@UZ** @@@@@EV*** @@@@AU****$@@@AUZ****%P@EUV*****)UUUV*******%UZ*** @a'))
]

{ #category : #'accessing ' }
CommonMessageDialog class >> criticalMask [
	"UIMaskEditor new openOnClass: self andSelector: #criticalMask"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: CoveragePalette monoMaskPalette usingBits: #[0 15 192 0 0 127 248 0 1 255 254 0 3 255 255 0 7 255 255 128 15 255 255 192 31 255 255 224 63 255 255 240 63 255 255 248 127 255 255 252 127 255 255 252 127 255 255 254 255 255 255 254 255 255 255 254 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 127 255 255 255 127 255 255 255 127 255 255 254 63 255 255 254 63 255 255 254 31 255 255 252 15 255 255 252 7 255 255 248 3 255 255 240 1 255 255 224 0 255 255 192 0 127 255 128 0 31 254 0 0 3 240 0])
]

{ #category : #'accessing ' }
CommonMessageDialog class >> escapeIsCancelList [
	"Private - A list of button styles which equates the escape key with cancel"

	^#(#yesNoCancel #okCancel #retryCancel)
]

{ #category : #'accessing ' }
CommonMessageDialog class >> iconStyleList [
	"Private - Initialize a dictionary that associates a icon symbol to the method which returns the image"

	iconStyleList isNil
		ifTrue:[
			iconStyleList := Dictionary new.
			iconStyleList at: #information put: #informationIcon;
				at: #critical put: #criticalIcon;
				at: #warning put: #warningIcon;
				at: #question put: #questionIcon].
		^iconStyleList
]

{ #category : #'accessing ' }
CommonMessageDialog class >> informationImage [
	"UIMaskEditor new openOnClass: self andSelector: #informationImage"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 2 bitsPerPixel: 2 palette: (MappedPalette withColors: ((Array new: 4) at: 1 put: ColorValue black; at: 2 put: (ColorValue scaledRed: 4112 scaledGreen: 4112 scaledBlue: 4112); at: 3 put: ColorValue white; at: 4 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 4112); yourself)) usingBits: (ByteArray fromPackedString: '****UV*******)V*%Z*****)Z***V*****Z*/:*"****&*+?:*"***)**/?**"***Z**/:**"**&*******"**Z**??***J*&**+?>***F*Z***?:**(Z)***+?***!Z&***/>***E*Z***?:**(V*Z**+?***EZ)**+??:*(U*)**/??**EZ*(******!U**(*****(UZ**(*****EV***(J***AU****)@*(AUZ****)T*EUV******R(UV*******"!Z********"E********* V*********!Z*********%**********&************************* @a'))
]

{ #category : #'accessing ' }
CommonMessageDialog class >> informationMask [
	"UIMaskEditor new openOnClass: self andSelector: #informationMask"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: CoveragePalette monoMaskPalette usingBits: #[0 15 128 0 0 127 240 0 1 255 252 0 3 255 254 0 7 255 255 0 15 255 255 128 31 255 255 192 63 255 255 224 63 255 255 224 127 255 255 248 127 255 255 248 127 255 255 252 127 255 255 252 127 255 255 252 63 255 255 252 63 255 255 252 31 255 255 248 15 255 255 248 7 255 255 240 3 255 255 224 1 255 255 192 0 255 255 128 0 127 255 0 0 31 252 0 0 7 224 0 0 3 224 0 0 1 224 0 0 0 224 0 0 0 96 0 0 0 32 0 0 0 0 0 0 0 0 0])
]

{ #category : #'class initialization' }
CommonMessageDialog class >> initialize [
	"CommonMessageDialog initialize"
	self buttonLabelList.
	self buttonValueList.
	self iconStyleList
]

{ #category : #'instance creation' }
CommonMessageDialog class >> open: iconSymbol message: aMessageString title: aTitleString [
	| inst |
	inst := self new.
	inst message: aMessageString.
	inst iconStyle: iconSymbol.
	^inst open
]

{ #category : #'instance creation' }
CommonMessageDialog class >> openCritical: aMessage [
	^self 
		open: #critical
		message: aMessage
		title: 'Critical Warning !'
]

{ #category : #'instance creation' }
CommonMessageDialog class >> openInformation: aMessage [
	^self 
		open: #information
		message: aMessage
		title: 'Information'
]

{ #category : #'instance creation' }
CommonMessageDialog class >> openQuestion: aMessage [
	^self 
		open: #question
		message: aMessage
		title: 'Question'
]

{ #category : #'instance creation' }
CommonMessageDialog class >> openWarning: aMessage [
	^self 
		open: #warning
		message: aMessage
		title: 'Warning !'
]

{ #category : #'accessing ' }
CommonMessageDialog class >> questionImage [
	"UIMaskEditor new openOnClass: self andSelector: #questionImage"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 2 bitsPerPixel: 2 palette: (MappedPalette withColors: ((Array new: 4) at: 1 put: ColorValue black; at: 2 put: (ColorValue scaledRed: 4112 scaledGreen: 4112 scaledBlue: 4112); at: 3 put: ColorValue white; at: 4 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 4112); yourself)) usingBits: (ByteArray fromPackedString: '****UV*******)V*%Z*****)Z***V*****Z****"****&*+?:*"***)**:/:*"***Z*/*/:*"**&**?:?**"**Z*+?+>**J*&**+:?***F*Z***/:**(Z)****>***!Z&***/****E*Z***>***(V*Z*******EZ)***/***(U*)**+?***EZ*(**/>**!U**(**/**(UZ**(*****EV***(J***AU****)@*(AUZ****)T*EUV******R(UV*******"!Z********"E********* V*********!Z*********%**********&************************* @a'))
]

{ #category : #'accessing ' }
CommonMessageDialog class >> questionMask [
	"UIMaskEditor new openOnClass: self andSelector: #questionMask"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: CoveragePalette monoMaskPalette usingBits: #[0 15 128 0 0 127 240 0 1 255 252 0 3 255 254 0 7 255 255 0 15 255 255 128 31 255 255 192 63 255 255 224 63 255 255 224 127 255 255 248 127 255 255 248 127 255 255 252 127 255 255 252 127 255 255 252 63 255 255 252 63 255 255 252 31 255 255 248 15 255 255 248 7 255 255 240 3 255 255 224 1 255 255 192 0 255 255 128 0 127 255 0 0 31 252 0 0 7 224 0 0 3 224 0 0 1 224 0 0 0 224 0 0 0 96 0 0 0 32 0 0 0 0 0 0 0 0 0])
]

{ #category : #'VisualWorks metadata' }
CommonMessageDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'accessing ' }
CommonMessageDialog class >> warningImage [
	"UIMaskEditor new openOnClass: self andSelector: #warningImage"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 2 bitsPerPixel: 2 palette: (MappedPalette withColors: ((Array new: 4) at: 1 put: ColorValue black; at: 2 put: ColorValue yellow; at: 3 put: ColorValue white; at: 4 put: (ColorValue scaledRed: 4112 scaledGreen: 4112 scaledBlue: 4112); yourself)) usingBits: (ByteArray fromPackedString: '**** J********(UJ********EUJ*******(UT********EUT*******(UUR*******EUUR******(UUUJ******EUUUJ*****(UPET******ET@ET*****(UP@UR*****EU@AUR****(UT@EUJ****EUP@UUJ***(UU@AUT****EUU@UUT***(UUTAUUR***EUUPEUUR**(UUU@UUUJ**EUUUEUUUJ*(UUUTUUUT**EUUUUUUUT*(UUUUAUUUR*EUUUPAUUUS(UUUU@EUUUN!UUUUAUUUT>EUUUUUUUUS:EUUUUUUUT?*@@@@@@@@O>*?????????**????????: @a'))
]

{ #category : #'accessing ' }
CommonMessageDialog class >> warningMask [
	"UIMaskEditor new openOnClass: self andSelector: #warningMask"

	<resource: #image>
	^CachedImage on: (Image extent: 32@32 depth: 1 bitsPerPixel: 1 palette: CoveragePalette monoMaskPalette usingBits: #[0 7 0 0 0 15 128 0 0 31 192 0 0 31 192 0 0 63 224 0 0 63 224 0 0 127 240 0 0 127 240 0 0 255 248 0 0 255 248 0 1 255 252 0 1 255 252 0 3 255 254 0 3 255 254 0 7 255 255 0 7 255 255 0 15 255 255 128 15 255 255 128 31 255 255 192 31 255 255 192 63 255 255 224 63 255 255 224 127 255 255 240 127 255 255 240 255 255 255 252 255 255 255 252 255 255 255 254 255 255 255 254 127 255 255 254 63 255 255 254 31 255 255 252 15 255 255 248])
]

{ #category : #'interface specs' }
CommonMessageDialog class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: '' 
			#min: #(#Point 211 112 ) 
			#max: #(#Point 211 112 ) 
			#bounds: #(#Rectangle 407 328 618 440 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#LabelSpec 
					#layout: #(#Point 38 7 ) 
					#name: #iconLabel 
					#hasCharacterOrientedLabel: false ) 
				#(#TextEditorSpec 
					#layout: #(#Rectangle 56 15 189 38 ) 
					#name: #messageArea 
					#flags: 4 
					#model: #message 
					#isReadOnly: true ) ) ) )
]

{ #category : #accessing }
CommonMessageDialog >> button [
	"return default button value"

	^button
]

{ #category : #accessing }
CommonMessageDialog >> button: aButton [
	"Assign the default button to have focus.  Valid values are true, false and nil"

	button := aButton
]

{ #category : #accessing }
CommonMessageDialog >> buttonStyle [
	"valid styles symbols are #ok, #okCancel, #yesNo, #yesNoCancel, #retryCancel, #abortRetryIgnore"

	^buttonStyle
]

{ #category : #accessing }
CommonMessageDialog >> buttonStyle: aButtonStyle [
	"valid styles symbols are #ok, #okCancel, #yesNo, #yesNoCancel, #retryCancel, #abortRetryIgnore"

	(self class escapeIsCancelList includes: aButtonStyle)
		ifTrue: [self escapeIsCancel: true]
		ifFalse: [self escapeIsCancel: false].
	buttonStyle := aButtonStyle
]

{ #category : #accessing }
CommonMessageDialog >> criticalIcon [
	"Private"

	^OpaqueImage
		figure: self class criticalImage
		shape: self class criticalMask
]

{ #category : #accessing }
CommonMessageDialog >> iconStyle [
	"Returns one of the following symbols: #information, #warning, #question, #critical"

	^iconStyle
]

{ #category : #accessing }
CommonMessageDialog >> iconStyle: styleSymbol [
	"valid symbols are #information, #warning, #question, #critical"

	iconStyle := styleSymbol.
]

{ #category : #accessing }
CommonMessageDialog >> informationIcon [
	"Private"

	^OpaqueImage
		figure: self class informationImage
		shape: self class informationMask
]

{ #category : #'initialize-release' }
CommonMessageDialog >> initialize [
	"Private"

	super initialize.
	self title: ''.
	message := '' asValue.
	self button: 1.
	self escapeIsCancel: false.
	self iconStyle: #none
]

{ #category : #accessing }
CommonMessageDialog >> message [
	"The string to be displayed within the message box"

	^message
]

{ #category : #accessing }
CommonMessageDialog >> message: aString [
	"The string to be displayed within the message box"

	message value: aString asString.
]

{ #category : #actions }
CommonMessageDialog >> open [
	"open method for MessageDialog, has new text placement"
	| result spec valueList labelList layout textHeight textWidth 
	windowWidth composedMessage defaultButton |

	self buttonStyle isNil
		ifTrue: [ labelList := self class buttonLabelList at: #ok ]
		ifFalse: [ labelList := self class buttonLabelList at: self buttonStyle ].
	valueList := self class buttonValueList at: labelList size.
	( self button > valueList size ) ifTrue: [ self button: 1 ].
	defaultButton := valueList at: self button.
	result := ValueHolder new.
	spec := self class interfaceSpecFor: #windowSpec.
	self allButOpenFrom:spec.
	composedMessage := self message value asComposedText.
	layout := ( self builder componentAt: #messageArea ) layout.
	textWidth := composedMessage width + 20.
	textWidth > ( Screen default bounds width  / 2 )
		ifTrue: [ textWidth := ( Screen default bounds right  / 2).
			composedMessage compositionWidth: textWidth ].
	textHeight :=composedMessage height + composedMessage lineGrid.
	self setInitialGap.
	self addGap: layout top + textHeight.
	self addLabels: labelList
		values: valueList
		default: defaultButton
		storeInto: result
		takeKeyboard: true
		equalize: true.
	self addGap: 10.
	windowWidth := textWidth + 20.
	self iconStyle = #none
		ifFalse: [ ( self builder componentAt: #iconLabel )
			label: ( self perform: (self class iconStyleList at: self iconStyle ) ).
			windowWidth := windowWidth + ( self builder componentAt: #iconLabel ) bounds right + 20.

					( windowWidth < self builder window displayBox extent x ) 
						ifTrue: [ windowWidth := self builder window displayBox extent x.
							layout left: ( self builder componentAt: #iconLabel ) bounds right + 20 ]
						ifFalse:[ layout left: ( ( self builder componentAt: #iconLabel ) bounds right + 15 ) ] ]
		ifTrue:[ ( windowWidth < self builder window displayBox extent x ) 
					ifTrue: [ windowWidth := self builder window displayBox extent x ].
				layout left: 15 ].

	layout right: layout left + textWidth.
	layout bottom: layout top + textHeight.
	( self builder componentAt: #messageArea ) layout: layout.
	self builder window label: self title.
	self builder openDialogWithExtent: windowWidth @ 
		self builder window displayBox extent y.
	
	cancel value
		ifTrue:[ ^( valueList at: ( labelList indexOf: 'Cancel' ) ) ]
		ifFalse:[ ^result value ]
]

{ #category : #accessing }
CommonMessageDialog >> questionIcon [
	"Private"

	^OpaqueImage
		figure: self class questionImage
		shape: self class questionMask
]

{ #category : #accessing }
CommonMessageDialog >> title [
	"Returns the text to be displayed on the dialog windows title bar"

	^title
]

{ #category : #accessing }
CommonMessageDialog >> title: aString [
	"Assigns the text string to be displayed on the dialog windows title bar"

	title := aString
]

{ #category : #accessing }
CommonMessageDialog >> warningIcon [
	"Private"

	^OpaqueImage
		figure: self class warningImage
		shape: self class warningMask
]
