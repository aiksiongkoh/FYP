Class {
	#name : #Editor,
	#superclass : #ApplicationModel,
	#instVars : [
		'textEditorController',
		'textHolder',
		'adButton',
		'filename'
	],
	#category : #'StCAD-Doc-StDoc'
}

{ #category : #resources }
Editor class >> menuBar [

	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #value: #menuExplain )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'File    ' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'New' #value: #menuFileNew )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Open' #value:
	                    #menuFileOpen )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Save As'
	                    #value: #menuFileSaveAs )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Exit' #value:
	                    #menuFileExit ) )
	              #( 4 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Normal    ' #value:
	           #menuNormal )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Heading' #value: #menuHeading )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Large' #value: #menuLarge )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Small    ' #value:
	           #menuSmall )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Bold' #value: #menuBold )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Italic' #value: #menuItalic )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Underline    '
	           #value: #menuUnderline #labelImage: #( '#{VWQR:UI.ResourceRetriever}'
	              '#{VWQR:Tools.ToolbarIconLibrary}'
	              #exploreOff )
	           #helpText: 'testing' )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Courier' #value: #menuCourier ) )
	     #( 2 1 3 3 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'interface specs' }
Editor class >> noAdReadOnlyWindowSpec [

	"UIPainter new openOnClass: self andSelector: #noAdReadOnlyWindowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: #titleBar #min: #( '#{VWQR:Core.Point}'
	           40 20 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           367 245 1007 725 )
	        #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.TextEditorSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 0 1 )
	              #name: #textHolderID #model: #textHolder #tabable:
	              true #isReadOnly: true #tabRequiresControl:
	              true ) ) ) )
]

{ #category : #'interface opening' }
Editor class >> openOn: text readOnly: readOnly label: labelString [ 
	^super new
		text: text
		readOnly: readOnly
		label: labelString
]

{ #category : #'interface specs' }
Editor class >> readOnlyWindowSpec [

	"UIPainter new openOnClass: self andSelector: #readOnlyWindowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: #titleBar #min: #( '#{VWQR:Core.Point}'
	           40 20 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           370 222 1010 702 )
	        #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.TextEditorSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 -36 1 )
	              #name: #textHolderID #model: #textHolder #tabable:
	              true #isReadOnly: true #tabRequiresControl:
	              true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -33 1 0 1.0 -1 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #resources }
Editor class >> textMenu [

	"MenuEditor new openOnClass: self andSelector: #textMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Find_with_dots #defaultString: 'Find...' )
	           #value: #find )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Replace_with_dots #defaultString:
	              'Replace...' )
	           #value: #replace )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Undo #defaultString: 'Undo' )
	           #value: #undo )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Copy #defaultString: 'Copy' )
	           #value: #copySelection )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Cut #defaultString: 'Cut' )
	           #value: #cut )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Paste #defaultString: 'Paste' )
	           #value: #paste )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: #( '#{VWQR:Kernel.UserMessage}'
	              #key: #Paste #defaultString: 'Save As' )
	           #value: #menuSaveAs )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Cancel' #value: #cancel ) )
	     #( 2 1 3 2 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
Editor class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Doc'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
Editor class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: #titleBar #min: #( '#{VWQR:Core.Point}'
	           40 20 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 288 1024 768 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.TextEditorSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 -36 1 )
	              #name: #textHolderID #model: #textHolder #tabable:
	              true #menu: #textMenu #isReadOnly: false #tabRequiresControl:
	              true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -33 1 0 1.0 -1 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #ad }
Editor >> adButton [
	^adButton
]

{ #category : #ad }
Editor >> changeAdxxxBy32 [
	adButton changeAdxxxBy32
]

{ #category : #'initialize-release' }
Editor >> changeRequest [
	^textEditorController textHasChanged
		ifTrue: [Dialog confirm: 'Discard changes?' for: builder window]
		ifFalse: [true]
]

{ #category : #accessing }
Editor >> filename: string [ 
	filename := string
]

{ #category : #binding }
Editor >> labelFor: aKey [ 
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

{ #category : #'menu items' }
Editor >> loadFile: aFilename [

	| bos sdoc |
	self filename: aFilename asString.
	bos := StCAD_Misc_BinaryObjectStorage onOldNoScan:
		       aFilename asFilename readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
	[ sdoc := bos contents at: 1 ] valueNowOrOnUnwindDo: [ bos close ].
	(sdoc notNil and: [ sdoc isMemberOf: Text ])
		ifTrue: [ 
			self textHolder value: sdoc.
			builder window label: filename ]
		ifFalse: [ 
		Dialog warn: 'Error reading a Smalltalk document from file.' ]
]

{ #category : #accessing }
Editor >> menuBar [
	| menu |
	menu := self class menuBar.
	^menu
]

{ #category : #'menu items' }
Editor >> menuBold [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#bold)
		removeEmphasis: #()
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuCourier [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#CODE)
		removeEmphasis: #()
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuExplain [
	| labelString text stop block start |
	labelString := 'Explain Editor          ' , AdData adTitle title.
	text := #'CAD: Copyright (C) 2001-2004, Aik-Siong Koh, All Rights Reserved.

Text Editor Basics:
Word wrap is always on.
To select entire string, click before the first or after the last character.
To select line without carrage return, click before the beginning or after the end of line.
To select line with carrage return, drag before the beginning of line to beginning of next line.
To select a word, double on the word.
To undo last change, ctrl-z or RightClick/Undo.
To copy, make selection, ctrl-c or RightClick/Copy.
To cut, make selection, ctrl-x or RightClick/Cut.
To paste, position cursor or make selection, ctrl-v or RightClick/Paste to paste last copy or cut at cursor or over selection. Press shift also to select any of last four copies or cuts to paste.
To search a string, ctrl-shift-L or RightClick/Find..., the last copy or cut string is in the dialog. Search is always case sensitive.
To search again, ctrl-L.
To search selection again, make selection then ctrl-L.
To replace a string, ctrl-shift-r or RightClick/Replace..., the last copy or cut string is in the dialog. Search is always case sensitive.
To replace again, ctrl-r.
To replace a selection repeatedly, select the string to be replaced, type in new string, ctrl-r to change the next occurence.
To bracket string with matching parentheses, select string to be bracketed, press ESC then ( to produce matching parentheses at both ends.
To select string within matching parentheses, click just inside the open or close parentheses.
To remove matching parentheses, select the string inside the parentheses, press ESC then ( to remove matching parentheses at both ends.
The same procedures apply for matching '' or " or { or [ or <.
'.
	text := text asText.
	stop := 1.
	block :=
			[:string :emphasis |
			start := text findString: string startingAt: stop.
			stop := start + string size - 1.
			text emphasizeFrom: start to: stop with: emphasis.].
	block value: 'Text Editor Basics:' value: #(#bold #large).
	self class openOn: text readOnly: true label: labelString.
]

{ #category : #'menu items' }
Editor >> menuFileExit [
	self closeRequest
]

{ #category : #'menu items' }
Editor >> menuFileNew [
	self changeRequest ifFalse: [^self].
	self textHolder value: Text new.
	self filename: ''.
	builder window label: filename
]

{ #category : #'menu items' }
Editor >> menuFileOpen [
	| titleString filterArray filenameString newName prompt originalDir newDir |
	self changeRequest ifFalse: [^self].
	(('win32*' match: OSHandle currentPlatformID)
		or: ['unix*linux*' match: OSHandle currentPlatformID])
		ifTrue: 
			[titleString := 'Open StDocument'.
			filterArray := OrderedCollection new.
			filterArray add: (CommonFileFilter filter: '*.sdoc' description: '*.sdoc  (StDocument)').
			filterArray add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := ''.
			newName := CommonFileSelectionDialog
						openTitle: titleString
						filters: filterArray
						filename: filenameString
						mustExist: true]
		ifFalse: 
			[prompt := 'Enter filename to read StDocument.'.
			newName := ''.
			newName := (newName isNil or: [newName isEmpty])
						ifTrue: [Dialog requestFileName: prompt default: '*.sdoc']
						ifFalse: 
							[originalDir := Filename currentDirectory directory.
							newDir := newName asFilename directory.
							newDir beCurrentDirectory.
							[Dialog requestFileName: prompt default: '*.sdoc']
								ensure: [originalDir beCurrentDirectory]]].
	(newName notNil and: [newName isEmpty not])
		ifTrue: [self loadFile: newName]
]

{ #category : #'menu items' }
Editor >> menuFileOpen1 [
	| prompt newName |
	self changeRequest ifFalse: [^self].
	prompt := 'Enter filename to read a Smalltalk document.  Use wildcards (*.sdoc) to get list of relevant files.'.
	newName := Dialog requestFileName: prompt default: '*.sdoc'.
	newName isEmpty not ifTrue: [self loadFile: newName]
]

{ #category : #'menu items' }
Editor >> menuFileSaveAs [

	| titleString filterArray filenameTail newName bos prompt initName originalDir newDir |
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Save StDocument'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter
					 filter: '*.sdoc'
					 description: '*.sdoc (StDocument)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.* (All)').
			filenameTail := (filename notNil and: [ filename isEmpty not ])
				                ifTrue: [ filename asFilename tail ]
				                ifFalse: [ '' ].
			newName := CommonFileSelectionDialog
				           saveTitle: titleString
				           filters: filterArray
				           filename: filenameTail
				           promptOverwrite: true ]
		ifFalse: [ 
			prompt := 'Enter filename to save StDocument.' expandMacros.
			newName := (filename notNil and: [ filename isEmpty not ])
				           ifTrue: [ 
					           initName := filename asFilename tail.
					           originalDir := Filename currentDirectory directory.
					           newDir := filename asFilename directory.
					           newDir beCurrentDirectory.
					           [ Dialog requestFileName: prompt default: initName ] 
						           ensure: [ originalDir beCurrentDirectory ] ]
				           ifFalse: [ 
				           Dialog requestFileName: prompt default: '*.sdoc' ] ].
	(newName notNil and: [ 
		 newName isEmpty not and: [ 
			 newName ~= filename or: [ textEditorController textHasChanged ] ] ]) 
		ifTrue: [ 
			bos := StCAD_Misc_BinaryObjectStorage onNew:
				       newName asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"

			[ 
			textEditorController accept.
			bos nextPut: self textHolder value.
			self filename: newName.
			builder window label: filename ] valueNowOrOnUnwindDo: [ bos close ] ]
]

{ #category : #'menu items' }
Editor >> menuHeading [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#bold #large)
		removeEmphasis: #()
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuItalic [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#italic)
		removeEmphasis: #()
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuLarge [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#large)
		removeEmphasis: #(#small)
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuNormal [
	textEditorController deselect.
	textEditorController
		addEmphasis: #()
		removeEmphasis: #(#underline #bold #serif #italic #large #small #H1 #CODE)
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuNormal1 [
	textEditorController deselect.
	textEditorController
		addEmphasis: #()
		removeEmphasis: #(#underline #bold #serif #italic #large #H1)
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuSaveAs [
	self menuFileSaveAs
]

{ #category : #'menu items' }
Editor >> menuSmall [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#small)
		removeEmphasis: #(#large)
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'menu items' }
Editor >> menuUnderline [
	textEditorController deselect.
	textEditorController
		addEmphasis: #(#underline)
		removeEmphasis: #()
		allowDuplicates: false.
	textEditorController select
]

{ #category : #'initialize-release' }
Editor >> postBuildWith: aBuilder [ 
	textEditorController := (aBuilder componentAt: #textHolderID) widget controller.
	(textEditorController isKindOf: TextEditorController)
		ifTrue: [textEditorController autoAccept: false]
]

{ #category : #'interface opening' }
Editor >> text: text readOnly: readOnly label: labelString [ 
	| selfWindow |
	self textHolder: text asText asValue.
	self openInterface: (readOnly
			ifTrue: [#readOnlyWindowSpec]
			ifFalse: [#windowSpec]).
	selfWindow := builder window.
	selfWindow label: labelString asString.
	^builder
]

{ #category : #accessing }
Editor >> textHolder [
	"This method was generated by UIDefiner. Any edits made here 
	may be lost whenever methods are automatically defined. The 
	initialization provided below may have been preempted by an 
	initialize method."

	^textHolder isNil
		ifTrue: [textHolder := Text new asValue]
		ifFalse: [textHolder]
]

{ #category : #accessing }
Editor >> textHolder: aValueHolder [ 
	textHolder := aValueHolder
]

{ #category : #accessing }
Editor >> titleBar [
	^'new file'
]

{ #category : #binding }
Editor >> visualFor: aKey [ 
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
