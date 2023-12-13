"
This is a cross platform file selection dialog.  See the class side protocol for example usage, including adding of filters

Instance Variables

filters <Collection> Collection of all filters available
filter <CommonFileFilter> The filter being used
fileNames <Collection> All files in the current directory
fileName <String> Selected file name
fileMustExist  <Boolean> For file being entered - if true, it must exist already
promptForOverwrite <Boolean> If true, prompt user before saving to an existing file
"
Class {
	#name : #CommonFileSelectionDialog,
	#superclass : #CommonDirectorySelectionDialog,
	#instVars : [
		'filters',
		'filter',
		'fileNames',
		'fileName',
		'fileMustExist',
		'promptForOverwrite'
	],
	#category : #'StCAD-Doc-Portable Common-Dialogs'
}

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> labels [

	^OrderedCollection withAll: #( #fileLabel
		#fileTypeLabel
		#filenameLabel
		#volumeLabel
		#DirectoryLabel
		#acceptButton
		#cancelButton )
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> openFile [
	| inst |
	inst := self new.
	inst addCommonFilter.
	^inst open
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> openFileWithFilter: filterArray [
	| inst |
	inst := self new.
	inst addFilters: filterArray.
	^inst open
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> openFileWithFilter: filterArray filename: string [ 
	"
	| filterArray string | 
	filterArray := OrderedCollection new. 
	filterArray add: (CommonFileFilter filter: '*.asm' description: '*.asm (assembly)'). 
	filterArray add: (CommonFileFilter filter: '*.*' description: '*.* (all)'). 
	string := 'Assembly1.asm'. 
	CommonFileSelectionDialog openFileWithFilter: filterArray filename: string 
	"

	| inst |
	inst := self new.
	inst addFilters: filterArray.
	inst fileName: string.
	inst fileMustExist: true.
	^inst open
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> openTitle: titleString filters: filterArray filename: filenameString mustExist: mustExist [ 
	"
	| titleString filterArray filenameString | 
	titleString := 'Open an Assembly'. 
	filterArray := OrderedCollection new. 
	filterArray add: (CommonFileFilter filter: '*.asm' description: 
	'*.asm (assembly)'). 
	filterArray add: (CommonFileFilter filter: '*.*' description: '*.* 
	(all)'). 
	filenameString := 'Assembly1.asm'. 
	CommonFileSelectionDialog openTitle: titleString filters: 
	filterArray filename: filenameString mustExist: true 
	"

	| inst |
	inst := self new.
	inst title: titleString.
	inst addFilters: filterArray.
	inst fileName: filenameString.
	inst fileMustExist: true.
	^inst open
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> saveFile [
	| inst |
	inst := self new.
	inst addCommonFilter.
	^inst save
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> saveFileWithFilter: filterArray [
	| inst |
	inst := self new.
	inst addFilters: filterArray.
	^inst save
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> saveFileWithFilter: filterArray filename: string [ 
	"
	| filterArray string | 
	filterArray := OrderedCollection new. 
	filterArray add: (CommonFileFilter filter: '*.asm' description: '*.asm (assembly)'). 
	filterArray add: (CommonFileFilter filter: '*.*' description: '*.* (all)'). 
	string := 'Assembly1.asm'. 
	CommonFileSelectionDialog saveFileWithFilter: filterArray filename: string 
	"

	| inst |
	inst := self new.
	inst addFilters: filterArray.
	inst fileName: string.
	inst promptForOverwrite: true.
	^inst save
]

{ #category : #'interface opening' }
CommonFileSelectionDialog class >> saveTitle: titleString filters: filterArray filename: filenameString promptOverwrite: promptOverwrite [ 
	"
	| titleString filterArray filenameString | 
	titleString := 'Open an Assembly'. 
	filterArray := OrderedCollection new. 
	filterArray add: (CommonFileFilter filter: '*.asm' description: '*.asm (assembly)'). 
	filterArray add: (CommonFileFilter filter: '*.*' description: '*.* (all)'). 
	filenameString := 'Assembly1.asm'. 
	CommonFileSelectionDialog saveTitle: titleString filters: filterArray filename: filenameString promptOverwrite: true 
	"

	| inst |
	inst := self new.
	inst title: titleString.
	inst addFilters: filterArray.
	inst fileName: filenameString.
	inst promptForOverwrite: true.
	^inst save
]

{ #category : #'VisualWorks metadata' }
CommonFileSelectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
CommonFileSelectionDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: '' #min: #( '#{VWQR:Core.Point}' 612 450 )
	        #max: #( '#{VWQR:Core.Point}' 612 450 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           418 338 1030 788 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 69 363 )
	              #name: #filenameLabel #label: 'Filename:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 347 23 ) #name: #fileTypeLabel #label: 'File Type:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 56 ) #name: #DirectoryLabel #label: 'Directory:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 23 ) #name: #volumeLabel #label: 'Drive:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 78 56 ) #name: #directoryLabel )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 136 355 508 384 )
	              #name: #fileName #model: #fileName #tabable: true )
	           #( '#{VWQR:UI.SequenceViewSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 266 83 595 337 )
	              #name: #fileNamesList #flags: 15 #model: #fileNames
	              #useModifierKeys: true #selectionType: #highlight )
	           #( '#{VWQR:UI.SequenceViewSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 16 83 244 337 )
	              #name: #directoryNamesWidget #flags: 15 #model: #directoryNames
	              #useModifierKeys: true #selectionType: #highlight )
	           #( '#{VWQR:UI.ComboBoxSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 415 15 595 44 )
	              #model: #filter #type: #object #comboList: #filters
	              #readSelector: #stringToFilter: #printSelector:
	              #filterToString: )
	           #( '#{VWQR:UI.ComboBoxSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 64 15 244 44 )
	              #name: #volumeNamesWidget #model: #volumeName
	              #comboList: #volumeNames )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 167 402 264 435 )
	              #name: #acceptButton #model: #okPressed #label: 'OK'
	              #isDefault: false #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 343 402 438 435 )
	              #name: #cancelButton #model: #cancel #label: 'Cancel'
	              #defaultable: true ) ) ) )
]

{ #category : #'interface specs' }
CommonFileSelectionDialog class >> windowSpec1 [
	"UIPainter new openOnClass: self andSelector: #windowSpec1"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: '' 
			#min: #(#Point 381 256 ) 
			#max: #(#Point 381 256 ) 
			#bounds: #(#Rectangle 102 122 483 378 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#LabelSpec 
					#layout: #(#Point 5 -2 ) 
					#name: #filenameLabel 
					#label: 'Filename:' ) 
				#(#LabelSpec 
					#layout: #(#Point 7 177 ) 
					#name: #fileTypeLabel 
					#label: 'File Type:' ) 
				#(#LabelSpec 
					#layout: #(#Point 188 46 ) 
					#name: #DirectoryLabel 
					#label: 'Directory:' ) 
				#(#LabelSpec 
					#layout: #(#Point 230 177 ) 
					#name: #volumeLabel 
					#label: 'Drive:' ) 
				#(#LabelSpec 
					#layout: #(#Point 7 46 ) 
					#name: #fileLabel 
					#label: 'File:' ) 
				#(#LabelSpec 
					#layout: #(#Point 249 43 ) 
					#name: #directoryLabel 
					#style: #small ) 
				#(#InputFieldSpec 
					#layout: #(#Rectangle 12 17 372 40 ) 
					#name: #fileName 
					#model: #fileName 
					#tabable: true ) 
				#(#SequenceViewSpec 
					#layout: #(#Rectangle 9 65 179 177 ) 
					#name: #fileNamesList 
					#flags: 15 
					#model: #fileNames 
					#useModifierKeys: true 
					#selectionType: #highlight ) 
				#(#SequenceViewSpec 
					#layout: #(#Rectangle 196 65 372 177 ) 
					#name: #directoryNamesWidget 
					#flags: 15 
					#model: #directoryNames 
					#useModifierKeys: true 
					#selectionType: #highlight ) 
				#(#ComboBoxSpec 
					#layout: #(#Rectangle 9 197 219 221 ) 
					#model: #filter 
					#type: #object 
					#comboList: #filters 
					#readSelector: 
					#stringToFilter: 
					#printSelector: 
					#filterToString: ) 
				#(#ComboBoxSpec 
					#layout: #(#Rectangle 232 196 372 220 ) 
					#name: #volumeNamesWidget 
					#model: #volumeName 
					#comboList: #volumeNames ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 7 228 104 252 ) 
					#name: #acceptButton 
					#model: #okPressed 
					#label: 'OK' 
					#isDefault: true 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 109 228 204 252 ) 
					#name: #cancelButton 
					#model: #cancel 
					#label: 'Cancel' 
					#defaultable: true ) ) ) )
]

{ #category : #'interface specs' }
CommonFileSelectionDialog class >> windowSpec2 [

	"UIPainter new openOnClass: self andSelector: #windowSpec2"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: '' #min: #( '#{VWQR:Core.Point}' 612 493 )
	        #max: #( '#{VWQR:Core.Point}' 612 493 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           412 275 1024 768 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 82 376 )
	              #name: #filenameLabel #label: 'Filename:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 359 23 ) #name: #fileTypeLabel #label: 'File Type:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 67 ) #name: #DirectoryLabel #label: 'Directory:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 23 ) #name: #volumeLabel #label: 'Drive:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 359 67 ) #name: #fileLabel #label: 'File:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 78 72 ) #name: #directoryLabel )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 136 368 508 397 )
	              #name: #fileName #model: #fileName #tabable: true )
	           #( '#{VWQR:UI.SequenceViewSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 266 94 595 348 )
	              #name: #fileNamesList #flags: 15 #model: #fileNames
	              #useModifierKeys: true #selectionType: #highlight )
	           #( '#{VWQR:UI.SequenceViewSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 16 94 244 348 )
	              #name: #directoryNamesWidget #flags: 15 #model: #directoryNames
	              #useModifierKeys: true #selectionType: #highlight )
	           #( '#{VWQR:UI.ComboBoxSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 415 15 595 44 )
	              #model: #filter #type: #object #comboList: #filters
	              #readSelector: #stringToFilter: #printSelector:
	              #filterToString: )
	           #( '#{VWQR:UI.ComboBoxSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 64 15 244 44 )
	              #name: #volumeNamesWidget #model: #volumeName
	              #comboList: #volumeNames )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 220 413 317 437 )
	              #name: #acceptButton #model: #okPressed #label: 'OK'
	              #isDefault: true #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 343 413 438 437 )
	              #name: #cancelButton #model: #cancel #label: 'Cancel'
	              #defaultable: true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 82 433 ) #name: #Label1 #label: 'Label' ) ) ) )
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> addAndSelectFilter: filterArg description: descArg [ 
	self addFilter: filterArg description: descArg.
	self filter: self filters value last
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> addCommonFilter [
	self addFilter: '*.pcl' description: 'Parcels'.
	self addFilter: '*.st' description: 'ST Source'.
	self addFilter: '*.txt' description: 'Text Files'.
	self addFilter: '*.*' description: 'All Files'.
	self filter: '*.*'
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> addFilter: aFilter description: aDescription [
	"Add an entry into the filters dictionary which becomes the filter list for the dialog box.  The 	description is the text to be displayed.  aFilter is the filter string used for matching 
	eg. var addFilter: '*.txt' description: 'Text Files' "

	self filters value add: (aFilter->aDescription).
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> addFilters: anArray [
	"add a set of filters"

	anArray do: [:each |
		self addFilter: each filter description: each description].

	self filter: (anArray at: 1) filter
]

{ #category : #events }
CommonFileSelectionDialog >> changedDirectory [
	"Private - A click in the Directory list widget has occurred and we must update."

	super changedDirectory.
	self fileNames selection: self fileName value
]

{ #category : #events }
CommonFileSelectionDialog >> changedFile [
	"Private - Update the file name input field with the file selected in the file List box."

	(self fileNames selection = 0 | self fileNames selection isNil)
		ifFalse: [ self fileName retractInterestsFor: self.
			self fileName: self fileNames selection.
			self fileName onChangeSend: #enteredPath to: self ]
]

{ #category : #events }
CommonFileSelectionDialog >> enteredPath [
	"Private - Handles input for user specified path."
	
	self builder keyboardProcessor focusIsShifting ifFalse: [ ^self ].
	self processEnteredPath
]

{ #category : #accessing }
CommonFileSelectionDialog >> fileMustExist [
	"Specifies whether the file name specified must exist within the system in order to accept"

	^fileMustExist
]

{ #category : #accessing }
CommonFileSelectionDialog >> fileMustExist: aBoolean [
	"Specifies whether the file name specified must exist within the system in order to accept"

	fileMustExist := aBoolean
]

{ #category : #accessing }
CommonFileSelectionDialog >> fileName [
	"Returns the filename.ext string"

	fileName isNil ifTrue: [ fileName := String new asValue ].
	^fileName
]

{ #category : #accessing }
CommonFileSelectionDialog >> fileName: aName [ 
	"Assign the filename.ext"

	aName ~= self fileName value ifTrue: [self fileName value: (aName isNil
				ifTrue: [String new]
				ifFalse: [aName])]
]

{ #category : #accessing }
CommonFileSelectionDialog >> fileNames [
	"Private - List of filenames within the current subdirectories"

	^fileNames
]

{ #category : #accessing }
CommonFileSelectionDialog >> fileNames: aNameCollection [
	"Private - assign the list of filenames within the current subdirectories"

	fileNames := aNameCollection
]

{ #category : #accessing }
CommonFileSelectionDialog >> filter [
	"Returns the current filter in effect"

	^filter
]

{ #category : #accessing }
CommonFileSelectionDialog >> filter: aFilter [
	"Assign the default filter value for File Dialog. The filter must exist within the list of filters or this 	operation is ignored.  If no filter is provided then all files are displayed."

	filter value:  aFilter.
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> filterToString: anAssociation [
	"Private - convert from a filter to its description"

	anAssociation = '' 
		ifTrue:[^nil]
		ifFalse:[^anAssociation value]
]

{ #category : #accessing }
CommonFileSelectionDialog >> filters [
	"Collection of current active filters"

	^filters
]

{ #category : #private }
CommonFileSelectionDialog >> getTextInputField [

	^#fileName
]

{ #category : #'initialize-release' }
CommonFileSelectionDialog >> initialize [
	"Private - Initialize dialog to have default values."

	super initialize.
	fileName := String new asValue.
	filter := '' asValue.
	filters := List new asValue.
	title := String new.
	fileNames := SelectionInList new.
	fileMustExist := false.
	promptForOverwrite := false.
]

{ #category : #'initialize-release' }
CommonFileSelectionDialog >> initializeNotification [
	"Private - update dependencies"

	super initializeNotification.
 	self filter onChangeSend: #updateCurrentDirectoryContents: to: self.
	self fileName onChangeSend: #enteredPath to: self.
	fileNames selectionIndexHolder onChangeSend: #changedFile to:self.

	(self builder componentAt: #fileNamesList) widget controller setDispatcher:
		(UIDispatcher new doubleClick: [self fileName value = '' ifFalse: [accept value: true]]).
]

{ #category : #api }
CommonFileSelectionDialog >> okPressed [
	"Private - check if path is valid."

	((self pathExists: (self buildPath: self fileName value))
		and: [(self buildPath: self fileName value) asFilename isDirectory not])
		ifTrue: 
			[self promptForOverwrite
				ifTrue: ["valid file exists on the system"
					(Dialog confirm: (self buildPath: self fileName value)
							, ' exists. Overwrite?')
						ifTrue: [self accept value: true]]
				ifFalse: [self accept value: true].
			^self].
	self fileMustExist
		ifTrue: [Dialog warn: '"' , self fileName value , '" does not exist.']
		ifFalse: [(self filenameIsValid: self fileName value)
				ifTrue: [self accept value: true]
				ifFalse: [Dialog warn: '"' , self fileName value , '" is not a valid file path.']]
]

{ #category : #api }
CommonFileSelectionDialog >> open [
	"Open the dialog box for opening files. "

	self title isEmpty ifTrue: [self title: 'Open'].
	^self openDialog: 'Open'
]

{ #category : #api }
CommonFileSelectionDialog >> openDialog: acceptButtonString [
	"Private - Create and display a File Dialog box."
	| spec saveFileName |

	self filters value isEmpty
		ifTrue: [ self filter: String new ]
		ifFalse: [ self filter value isEmpty
			ifTrue:[ self filter: ( self filters value at: 1 ) ]
			ifFalse:[ self filter: ( self filters value 
				detect: [ :filterEntry | self filter value = filterEntry key ] 
				ifNone:[ self filters value at: 1 ] ) ] ].
	saveFileName := self fileName value. 
	self builder source: self.
	spec := self class interfaceSpecFor: #windowSpec.
	self allButOpenFrom:spec.
	openedDialog := true.
	self builder window label: self title.
	self initializeNotification.
	self initVolumeAndDirectory.

	( self builder componentAt: #acceptButton ) labelString: acceptButtonString.
	"self setLabels." "Don't know why this is here. It messes up the font size. ASKoh"
	Filename volumeSeparator isNil
		ifTrue: [ ( self builder componentAt: #volumeNamesWidget ) beInvisible.
				( self builder componentAt: #volumeLabel ) beInvisible ].
	self fileName: saveFileName.
	self fileNames selection: saveFileName.
	openedDialog := true.
	self builder openDialog.
	( self accept value )
		ifFalse: [ ^nil ]
		ifTrue: [ self fileName value = nil
			ifTrue: [ ^nil ]
			ifFalse: [ self saveDialogState.
				^self buildPath: self fileName value ] ]
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> processEnteredPath [
	"Private - Handles input for user specified path."

	| leftovers pathComponents |
	self fileName value isEmpty not
		ifTrue: 
			[leftovers := self updatePath: self fileName value.
			pathComponents := Filename components: self fileName value.
			self fileName retractInterestsFor: self.
			leftovers = 1
				ifTrue: 
					["Filename was given as last element of path"
					self fileName value: pathComponents last.
					(self stringHasWildcard: pathComponents last) not ifTrue: [self okPressed]].
			leftovers = 0 ifTrue: ["Entered a directory"
				self fileName value: String new].
			self fileName onChangeSend: #enteredPath to: self]
]

{ #category : #api }
CommonFileSelectionDialog >> promptForOverwrite [
	"display message box prompting user to overwrite existing file"

	^promptForOverwrite
]

{ #category : #api }
CommonFileSelectionDialog >> promptForOverwrite: aBoolean [
	"display message box prompting user to overwrite existing file"

	promptForOverwrite := aBoolean
]

{ #category : #api }
CommonFileSelectionDialog >> save [
	"Open a dialog for 'Save As' file"

	self title isEmpty ifTrue: [ self title: 'Save As' ].
	^self openDialog: 'Save'
]

{ #category : #'initialize-release' }
CommonFileSelectionDialog >> setDirectoryLabel [
	"Private - Update the label which specifies the current path"
	|labelWidgetWrapper|

	(labelWidgetWrapper := self builder componentAt: #directoryLabel) isNil
		ifFalse: [ labelWidgetWrapper labelString: ( self buildPath: String new ) ]
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> setVolumeAsEmpty [
	"Private - Found a volume that is not valid, eg floppy drive with no floppy.  Set the list of 
	directories and files as empty"

	super setVolumeAsEmpty.
	fileNames list: List new.
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> stringToFilter: aString [
	"Private - Convert from a filter description to the filter"

	filters value do: [ :anElement | aString = anElement value 
		ifTrue: [ ^anElement ] ]
]

{ #category : #events }
CommonFileSelectionDialog >> updateCurrentDirectoryContents: filterString [ 
	"Private - open the current directory and update directoryNames 
	and fileNames instance variables 
	with the contents of the directory"

	| temp list fullList dList fList originalCursor filterPattern entryFullPath |
	filterString isNil
		ifTrue: [self filters value isEmpty
				ifTrue: [filterPattern := '']
				ifFalse: [filterPattern := self filter value key]]
		ifFalse: [filterPattern := filterString].
	originalCursor := Cursor currentCursor.
	Cursor wait showWhile: [(self pathExists: self volumeName value)
			ifTrue: 
				[Object errorSignal
					handle: 
						[:ex | 
						directoryNames list: List new.
						fileNames list: List new.
						originalCursor show.
						^nil]
					do: 
						[temp := (self buildPath: String new) asFilename.
						list := temp directoryContents asSortedCollection.
						fullList := (temp filesMatching: '*') asSortedCollection].
				dList := List new.
				fList := List new.
				list with: fullList
					do: 
						[:directoryEntry :directoryEntryPath | 
						entryFullPath := Filename concreteClass new named: directoryEntryPath.
						entryFullPath isReadable ifTrue: [entryFullPath isDirectory
								ifTrue: [dList add: directoryEntry]
								ifFalse: [filterPattern isEmpty
										ifTrue: [fList add: directoryEntry]
										ifFalse: [(filterPattern match: directoryEntry)
												ifTrue: [fList add: directoryEntry]]]]].
				(self directoryName asString match: self directoryName asFilename head)
					ifFalse: [dList addFirst: '..'].	"if not at top of dir hierarchy"
				directoryNames list: dList.
				fileNames list: fList]]
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> updatePath1: aPathString [ 
	"Private - Handles input for user specified path."

	| leftovers pathComponents |
	pathComponents := Filename components: aPathString.
	leftovers := self parsePath: aPathString accountForFilename: true.
	leftovers > 1
		ifTrue: [Dialog warn: '"' , (self buildPath: aPathString) , '" is not a valid path.']
		ifFalse: 
			[self setDirectoryLabel.
			(leftovers = 1 and: [self stringHasWildcard: pathComponents last])
				ifTrue: [self updateCurrentDirectoryContents: pathComponents last]
				ifFalse: [self updateCurrentDirectoryContents: nil]].
	^leftovers
]

{ #category : #'file utils' }
CommonFileSelectionDialog >> updatePath: aPathString [ 
	"Private - Handles input for user specified path."

	| leftovers pathComponents |
	pathComponents := Filename components: aPathString.
	leftovers := self parsePath: aPathString accountForFilename: true.
	leftovers > 1
		ifTrue: [Dialog warn: '"' , (self buildPath: aPathString) , '" is not a valid path.']
		ifFalse: 
			[self setDirectoryLabel.
			(leftovers = 1 and: [self stringHasWildcard: pathComponents last])
				ifTrue: [self addAndSelectFilter: pathComponents last description: pathComponents last].
			self updateCurrentDirectoryContents: nil].
	^leftovers
]
