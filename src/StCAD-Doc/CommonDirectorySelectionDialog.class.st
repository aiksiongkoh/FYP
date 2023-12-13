"
This class is the superclass for a common file dialog that works across platforms.  The sole subclass should actually be used.  This class handles directory access

Instance Variables

directoryName <String> Name of the current directory
title <String>  Title for the window
volumeName <String> Name of the current volume (Windows Specific)
volumeNames <Collection> All volumes present on this system (Windows Specific)
directoryNames <Collection> Recently visited
subDirectoryName <String> Name of subdirectory visited
directoryMustExist <Boolean> If true, cannot create new directories
openedDialog <Boolean> If true, we are in dialog mode
directoryLabel <String> Name of directory
path <String> Current path
partMoveBy 
rememberedPaths <Collection> Recently visited directories
oldVolume <String> Last volume visited
"
Class {
	#name : #CommonDirectorySelectionDialog,
	#superclass : #SimpleDialog,
	#instVars : [
		'directoryName',
		'title',
		'volumeName',
		'volumeNames',
		'directoryNames',
		'subDirectoryName',
		'directoryMustExist',
		'openedDialog',
		'directoryLabel',
		'path',
		'partMoveBy',
		'rememberedPaths',
		'oldVolume'
	],
	#classVars : [
		'CommonDirectorySelectionDialog',
		'CommonDirectorySelectionDialog'
	],
	#category : #'StCAD-Doc-Portable Common-Dialogs'
}

{ #category : #accessing }
CommonDirectorySelectionDialog class >> constructPath: aString1 with: aString2 [
	| newString |
	( aString1 isNil or: [ aString1 isEmpty ] )
		ifTrue: [ ^ aString2 ]
		ifFalse: [ 	( ( newString := aString1 ) last = Filename volumeSeparator )
			ifTrue: [ newString := newString , self separator ].
			aString2 notNil
				ifTrue: [ 
					Object errorSignal
						handle: [:ex | ^newString last = Filename separator
								ifTrue: [ newString , aString2 ]
								ifFalse: [ newString, self separator, aString2 ] ]
						do: [^newString asFilename constructString: aString2]]
				ifFalse: [ ^newString ] ]
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> currentDirectory [
	"Return the directory that the user last accessed from the directory or file selection dialogs. 
	This currently gets updated only when the user presses OK"

	CurrentDirectory isNil ifTrue: [ CurrentDirectory := self getDefaultDirectoryName ].
	^CurrentDirectory
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> currentDirectory: aDirectory [
	"Assign the directory that the user last accessed from the directory or file 
	selection dialogs.  This currently gets updated only when the user presses OK"

	CurrentDirectory := aDirectory
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> currentVolume [
	"Return the volume that the user last accessed from the directory or file selection dialogs.  
	This currently gets updated only when the user presses OK"

	( CurrentVolume isNil or: [ CurrentVolume isEmpty ] ) ifTrue: 
		[ CurrentVolume := self getDefaultVolumeName ].
	^CurrentVolume
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> currentVolume: aVolume [
	"Assign the volume that the user last accessed from the directory or file selection dialogs.  
	This currently gets updated only when the user presses OK"

	CurrentVolume := aVolume
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> getDefaultDirectoryName [

	"Get the initial volume to the volume specified in the default directory."
	|temp dirName|

	dirName := ''.
	temp := Filename components: Filename defaultDirectory asString.
	temp removeFirst.
	temp do: [:anElement | dirName := dirName, self separator, anElement].
	^dirName, self separator
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> getDefaultVolumeName [
	"Get the initial volume to the volume specified in the default directory."
	| volumeString |

	volumeString := ( Filename components: Filename defaultDirectory asString ) first.
	volumeString last ~= Filename separator 
		ifTrue: [ volumeString := volumeString , self separator ].
	^self getSystemVolumeNames 
		detect: [ :volume | volume match: volumeString ] 
		ifNone: [ ^self getSystemVolumeNames first ]
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> getSystemVolumeNames [
	"Get the list of volumes available within the entire system.  This list of volumes is the default"

	^Filename volumes
]

{ #category : #'class initialization' }
CommonDirectorySelectionDialog class >> initialize [
	"CommonDirectorySelectionDialog initialize"

	self currentVolume: nil.
	self currentDirectory: nil.
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> labels [
	"Private - IDs for label and button widgets.  Used to pass font information to these static
	text widgets"

	^OrderedCollection withAll: #( 
		#pathLabel
		#volumeLabel
		#directoryLabel
		#okButton
		#cancelButton )
]

{ #category : #'interface opening' }
CommonDirectorySelectionDialog class >> openTitle: titleString directoryName: directoryNameString [ 
	"
	| titleString directoryNameString | 
	titleString := 'Open an Assembly'. 
	directoryNameString := 'c:\vw5i4nc\koh\v07\a\resource'. 
	CommonDirectorySelectionDialog openTitle: titleString 
	directoryName: directoryNameString 
	"

	| inst |
	inst := self new.
	inst title: titleString.
	inst directoryName: directoryNameString.
	inst directoryMustExist: true.
	^inst open
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> pathExists: aString [
	"Check if a path string exists.  Return a boolean"
	| result pathString components |

	( aString isNil or: [ aString isEmpty ] ) ifTrue: [ ^false ].
	self separator notNil 
		ifTrue: [ ( aString occurrencesOf: Filename volumeSeparator ) > 1
			ifTrue: [ ^false ] ].
	components := Filename components: aString. 
	 ( components first = '.' or: [ components first = '..' ] ) 
		ifTrue: [ 
			components first = '.' 
				ifTrue: [ pathString := self constructPath: self currentVolume 
					with: self currentDirectory ].
			components first = '..' 
				ifTrue: [ pathString := self constructPath: self currentVolume 
					with: self currentDirectory asFilename head ].
		components size > 1
			ifTrue: [ 2 to: components size do: [ :anElement | 
				anElement = '.' ifFalse: [
					anElement = '..' 
						ifTrue: [ pathString := pathString asFilename head ]
						ifFalse: [ pathString := self constructPath: pathString with: ( components at: anElement ) ] ] ] ] ]
		ifFalse: [ pathString := aString ].

	Object errorSignal
		handle: [:ex | result := false. ex return]
		do: [result := pathString asFilename definitelyExists].

	^result
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> separator [

	^String with: Filename separator
]

{ #category : #accessing }
CommonDirectorySelectionDialog class >> updateCurrentPath [
	"Check if the CurrentVolume and CurrentDirectory is as valid path.  If not reset"

	( self currentVolume isEmpty )
		ifTrue: [ ( self pathExists: self currentDirectory )
			ifFalse: [ self currentVolume: self getDefaultVolumeName.
				self currentDirectory: self getDefaultDirectoryName ] ]
		ifFalse: [ ( self pathExists: ( self constructPath: self currentVolume with: self currentDirectory ) )
			ifFalse: [ self currentVolume: self getDefaultVolumeName.
				self currentDirectory: self getDefaultDirectoryName ] ]
]

{ #category : #'VisualWorks metadata' }
CommonDirectorySelectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
CommonDirectorySelectionDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Directory' #min: #( '#{VWQR:Core.Point}'
	           502 352 ) #max: #( '#{VWQR:Core.Point}'
	           502 352 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 1014 736 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.InputFieldSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 21 259 480 286 )
	              #name: #path #model: #path )
	           #( '#{VWQR:UI.SequenceViewSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 21 93 480 227 )
	              #name: #directoryNamesWidget #model: #directoryNames
	              #useModifierKeys: true #selectionType: #highlight )
	           #( '#{VWQR:UI.ComboBoxSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 21 34 480 61 )
	              #name: #volumeNamesWidget #model: #volumeName
	              #comboList: #volumeNames )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 118 309 207 338 )
	              #name: #okButton #model: #okPressed #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 289 309 378 338 )
	              #name: #cancelButton #model: #cancel #label: 'Cancel'
	              #defaultable: true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 21 235 ) #name: #pathLabel #label: 'Path:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 21 69 ) #name: #directoryLabel #label: 'Directory:' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 21 10 ) #name: #volumeLabel #label: 'Drive:' ) ) ) )
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> buildPath: aPathElement [
	"Private - Answer a path string 'volume:directory\aPathElement'.
	This element may be a file name or a subdirectory."
	| volumeString |

	( ( volumeString := self volumeName value ) last ~= Filename separator )
		ifTrue: [ volumeString := volumeString , self separator ].
	( aPathElement = '..' )
		ifTrue: [ ^self constructPath: volumeString
			with: self directoryName asFilename head ]
		ifFalse: [ ^self constructPath: ( self constructPath: volumeString with: self directoryName )
			with: aPathElement ]
]

{ #category : #events }
CommonDirectorySelectionDialog >> changedDirectory [
	"Private - The selection in the Directory list widget has occurred.  Update
	the input field with the revised path. "

	( self directoryNames selectionIndex = 0 )
	ifFalse: [ ( self directoryNames selection = '..' )
		ifTrue: [ self directoryName: '..' ]
		ifFalse: [ self directoryName: ( self constructPath: self directoryName 
			with: self directoryNames selection ) ] ]
]

{ #category : #events }
CommonDirectorySelectionDialog >> changedVolume [
	"Private - The volume has so update the current directory as root."

	| newDir |
	self rememberedPaths at: oldVolume put: self directoryName.
	newDir := self rememberedPaths at: self volumeName value ifAbsent: [nil].
	self oldVolume: self volumeName value.
	( self pathExists: self volumeName value )
		ifTrue: [ newDir notNil
				ifTrue: [self directoryName: newDir]
				ifFalse: [self directoryName: self separator ]]
		ifFalse: [ "Drive is not valid eg empty floppy so set list as empty"
			directoryName := self separator.
			self setVolumeAsEmpty.
			self setDirectoryLabel ]
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> constructPath: aString1 with: aString2 [
	"Private - Answer a string which combine the path elements into a valid path string."

	^self class constructPath: aString1 with: aString2
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> directoryMustExist [
	"Answer a boolean value whether the dialog can specify a path to a non existent directory."

	^directoryMustExist
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> directoryMustExist: aBoolean [
	"Assign aBoolean value whether the dialog can specify a path to a non existent directory."

	directoryMustExist := aBoolean
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> directoryName [
	"Answer the directory which the dialog currently is referencing."

	^directoryName
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> directoryName: aDirectory [ 
	"Assign the directory path the dialog box will point to. The 
	argument should be 
	of the format \path where \ is the current OS file separator. 
	Do not pass the volume."

	| wildcardPattern textInputString val |
	openedDialog
		ifTrue: 
			[Object errorSignal handle: [:ex | ex proceed]
				do: [val := aDirectory isEmpty not].
			val
				ifTrue: 
					[textInputString := (self perform: self getTextInputField) value.
					((self stringHasWildcard: textInputString)
						and: [(Filename components: textInputString) size = 1])
						ifTrue: [wildcardPattern := textInputString]
						ifFalse: [wildcardPattern := String new].
					self updatePath: (self constructPath: aDirectory with: wildcardPattern)]]
		ifFalse: [directoryName := aDirectory]
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> directoryNames [
	"Private - List of current subdirectories within current hierarchy"

	^directoryNames
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> directoryNames: aNamesList [
	"Private - Assign a list of current subdirectories within current hierarchy"

	directoryNames := aNamesList
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> directoryPathIsValid: pathString [
	"Private - check if directory is valid path"
	| components index |

	index := self getVolumeFromPath: pathString.
	( index + 1 <= pathString size )
		ifTrue: [
			components := Filename components: 
				( pathString copyFrom: index + 1 to: pathString size ).
			components do: [ :dir |	
				 dir ~= self separator
					ifTrue: [ ( self filenameIsValid: dir ) ifFalse: [ ^false ] ] ] ].
	^true
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> enteredPath [
	"Private - Handles input for user specified path."

	self builder keyboardProcessor focusIsShifting ifFalse: [ ^self ].
	self processEnteredPath
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> filenameIsValid: pathString [
	"Private - Check to make sure the directory does not have illegal chars."

	( ( self stringHasWildcard: pathString ) or: 
	[ pathString includes: Filename volumeSeparator ] )
		ifFalse: [ pathString detect: [ :c | Filename defaultClass isBadCharacter: c ] 
			ifNone: [ ^true ] ].
	^false
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> getTextInputField [
	"Private"

	^#path
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> getVolumeFromPath: pathString [
	"Private -  take path components to see if the volume exists.  This method is to handle
	network path names which Filename components: does not recognize"

	( self volumeExists: ( Filename components: pathString ) first ) notNil
		ifTrue: [ ^( Filename components: pathString ) first size ]
		ifFalse: [ self volumeNames value do: [ :volume | | interval |
			interval :=  pathString findString: volume startingAt: 1 ignoreCase: true useWildcards: false.
			interval first = 1 ifTrue: [ ^interval last ] ] ].
	^0
]

{ #category : #'initialize-release' }
CommonDirectorySelectionDialog >> initVolumeAndDirectory [
	"private - initialize and check the volume and directory values from client."
	| tempArray |

	self class updateCurrentPath.
	self path notNil
		ifTrue: [ ( self pathExists: self path value )
			ifTrue: [ ^self updatePath: self path value ] ].
	tempArray := self setInitialState: self volumeName value directoryName: self directoryName.
	self volumeName retractInterestsFor: self.
	self volumeName value: ( tempArray at: 1 ).
	directoryName := tempArray at: 2.
	self oldVolume: self volumeName value.
	self rememberedPaths at: self oldVolume put: directoryName.
	self volumeName onChangeSend: #changedVolume to: self.
	( ( ( Filename components: directoryName ) first = '.' or: 
	[ ( Filename components: directoryName ) first = '..' ] )
		ifTrue: [ ( self parsePath: directoryName
			accountForFilename: false ) ~= 0 ]
		ifFalse: [ ( self parsePath: ( self buildPath: String new )
			accountForFilename: false ) ~= 0 ] )
			ifTrue: [ self volumeName value: self class currentVolume.
				directoryName := self class currentDirectory ].
	self updatePath: self directoryName
]

{ #category : #'initialize-release' }
CommonDirectorySelectionDialog >> initialize [
	super initialize.
	directoryNames := SelectionInList new.
	volumeName := '' asValue.
	volumeNames := Filename volumes asList asValue.
	path := '' asValue.
	directoryName := ''.
	directoryMustExist := true.
	openedDialog := false.
	rememberedPaths := Dictionary new
]

{ #category : #'initialize-release' }
CommonDirectorySelectionDialog >> initializeNotification [
	"Private - update dependencies"

	self volumeName onChangeSend: #changedVolume to: self.
	self path onChangeSend: #enteredPath to: self.
	(self builder componentAt: #directoryNamesWidget) widget controller setDispatcher:
		(UIDispatcher new doubleClick: [self changedDirectory]).
	self builder keyboardProcessor
			keyboardHook:  [:ev :ctrl | self keyboardEvent: ev].
	self title isNil ifFalse: [ self builder window label: self title ].
]

{ #category : #events }
CommonDirectorySelectionDialog >> keyboardEvent: ev [
	"Private - If the event is an escape then do a cancel"

	ev keyValue = Character esc
		ifTrue: [ self accept value: false.
				self closeRequest.
				^nil ].
	ev keyValue = Character cr
		ifTrue: [
			( self builder componentAt: #cancelButton ) widget controller =
				self builder keyboardProcessor currentConsumer
				ifTrue: [ 
					self accept value: false.
					self closeRequest.
					^nil ].

			( ( self builder componentAt: #directoryNamesWidget ) widget controller =
				self builder keyboardProcessor currentConsumer and: 
				[ self directoryNames selectionIndex ~= 0 ] )
				ifTrue: [ self changedDirectory.
					^nil ]
				ifFalse: [
					self builder keyboardProcessor forceGlobalAccept.
					( self builder componentAt: self getTextInputField ) 
						widget controller accept.
					self processEnteredPath.
					^nil ] ].
	^ev
]

{ #category : #actions }
CommonDirectorySelectionDialog >> okPressed [
	"Private - Method handler for the open or save button."

	(self directoryMustExist)
	ifTrue: [ ( self pathExists: self path value )
		ifTrue: [ self accept value: true ]
		ifFalse: [ Dialog warn: '"' , self path value, '" does not exist.' ] ]
	ifFalse: [ 
		( self directoryPathIsValid: self path value ) 
			ifTrue: [ ^self accept value: true ].
		Dialog warn: '"' , self path value , '" is not a valid file path.' ]
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> oldVolume [

	^oldVolume
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> oldVolume: aValue [

	oldVolume := aValue
]

{ #category : #actions }
CommonDirectorySelectionDialog >> open [
	"Open a Directory dialog box which allows the selection of a directory path.  
	If OK is pressed, then a string indiciating a full path is answered.  
	Cancel answers nil."
	| spec |

	self builder source: self.
	spec := self class interfaceSpecFor: #windowSpec.
	self allButOpenFrom:spec.
	self initializeNotification.
	self initVolumeAndDirectory.
	Filename volumeSeparator isNil
		ifTrue: [ ( self builder componentAt: #volumeNamesWidget ) beInvisible.
			( self builder componentAt: #volumeLabel ) beInvisible ].
	openedDialog := true.
	"self setLabels." "Don't know why this is here. It messes up the font size. ASKoh"
	"kludgy fix, must move part after open or list box defaults to wrong look policy"
	self postOpenBlock: [  :dialog :uiBuilder | 
		partMoveBy notNil ifTrue: [ ( self builder componentAt: #compPart ) moveBy: partMoveBy ] ].
	self builder openDialog.
	(self accept value)
		ifFalse: [ ^nil ]
		ifTrue: [ self saveDialogState.
			^(self constructPath: self path value 
				with: self separator ) ]
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> parsePath: pathString accountForFilename: filenameExists [
	"Private - Parse a directory path, including relative path, and paths with the volume specified"
	| volume  index directory pathComponents |

	index := self getVolumeFromPath: pathString.
	index = 0 
		ifTrue: [ volume := self volumeName value.
			pathComponents := Filename components: pathString.
			directory := self directoryName.

			( pathComponents first = '.' ) | ( pathComponents first = '..' ) 
				ifTrue: [ ( directory isEmpty or: [ ( Filename components: directory ) first = '.' ] )
						ifTrue: [ directory := self class currentDirectory.
							volume := self class currentVolume ].
					( Filename components: directory ) first = '..' 
						ifTrue: [ directory := self class currentDirectory asFilename head.
							volume := self class currentVolume ] ] ]
		ifFalse: [ volume := pathString copyFrom: 1 to: index.
			directory := self separator.
			pathComponents := OrderedCollection new.
			pathString size > index
				ifTrue: [  pathComponents := Filename components: 
						( pathString copyFrom: index + 1 to: pathString size ) ] ].
	pathComponents size > 0 ifTrue: [
		1 to: pathComponents size do: [ :currentIndex | | pathElement saveDirectory |
			pathElement := pathComponents at: currentIndex.
			pathElement = self separator
				ifTrue: [ directory := self separator ]
				ifFalse: [ pathElement = '..' 
					ifTrue:[ directory := directory asFilename head.
						directory last ~= Filename separator ifTrue: [ directory := directory , self separator ] ]
					ifFalse: [ pathElement = '.'
						ifFalse: [ saveDirectory := directory.
							directory := self constructPath: 
								( self constructPath: directory with: pathElement ) with: self separator.
							( ( (self pathExists: (self constructPath: volume with: directory ) )  and: 
							[ (self constructPath: volume with: directory ) asFilename isDirectory ] ) and:
							[ ( self stringHasWildcard: pathElement ) not ] )
								ifFalse: [ filenameExists 
									ifTrue: [
										directory := self constructPath: saveDirectory with: self separator.
										( self pathExists: volume , self separator ) 
											ifFalse: [ self setVolumeAsEmpty.
												directory := self separator ].
										self volumeName retractInterestsFor: self.
										self volumeName value: volume.
										self volumeName onChangeSend: #changedVolume to: self.
										directoryName := directory.
										^pathComponents size - ( currentIndex - 1 ) ]
									ifFalse: [ ^pathComponents size - ( currentIndex - 1 ) ] ] ] ] ] ] ].
	( self pathExists: volume )
		ifFalse: [ self setVolumeAsEmpty.
			directory := self separator ].
	self volumeName retractInterestsFor: self.
	self volumeName value: volume.
	self volumeName onChangeSend: #changedVolume to: self.
	directoryName := directory.
	^0
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> path [
	"Client supplied fully specified path"

	^path
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> path: aString [
	"Client supplied fully specified path"

	self path value: aString
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> pathExists: aString [
"Private - check if path is valid, handle exceptions, and return a boolean"

	^self class pathExists: aString
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> processEnteredPath [
	"Private - Handles input for user specified path."
	| leftovers pathComponents |

	self path value isEmpty not 
		ifTrue: [  leftovers := self updatePath: self path value.
			self path retractInterestsFor: self.
			leftovers = 1	
				ifTrue: [ 
					pathComponents := Filename components: self path value.
					( self stringHasWildcard: pathComponents last )
						ifFalse: [ self okPressed ] ]."entering input = clicking OK button"
			leftovers = 0 "if valid string, clear input field"
				ifTrue: [ self okPressed ].
			( leftovers > 1 and: [ self directoryMustExist = false ] )
				ifTrue: [ self okPressed ].
			self path onChangeSend: #enteredPath to: self ]
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> rememberedPaths [

	^rememberedPaths
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> rememberedPaths: aValue [

	rememberedPaths := aValue
]

{ #category : #actions }
CommonDirectorySelectionDialog >> saveDialogState [
	"Private - save the state so it can be restored next time the dialog is opened."

	self class currentDirectory: self directoryName.
	self class currentVolume: self volumeName value
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> separator [
	"OS specific separator as a String"

	^self class separator
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> setDirectoryLabel [
	"Private - Update the label which specifies the current path"
	| newPath |

	self builder notNil
		ifTrue: [ 	
			newPath :=  self buildPath: String new.
			newPath ~= self path value
				ifTrue: [ self path: newPath ] ]
]

{ #category : #'initialize-release' }
CommonDirectorySelectionDialog >> setInitialState: volume directoryName: directory [
"Private - setup initial volume and directory depending upon user info provided.
 This method guarantees that both the volume and directory will have a value,
 although it does not check for validity."
	| tempVolume tempDirectory components |

	tempVolume := nil.
	tempDirectory := nil.
	directory isEmpty
		ifTrue: [  volume isEmpty "vol but no dir, so root"
			ifFalse: [ tempVolume := volume.
				tempDirectory := self separator ] ] 
		ifFalse: [ components := Filename components: directory. 
			 ( ( components first = '.' or: [ components first = '..' ] ) or: [ volume isEmpty ] )
				ifTrue: [ tempVolume := self class currentVolume.
					components first = '.' ifTrue: [ tempDirectory := self class currentDirectory ].
					components first = '..' ifTrue: [ tempDirectory := self class currentDirectory asFilename head ].
					tempDirectory notNil
						ifTrue: [ components size > 1
							ifTrue: [ 2 to: components size do: [ :anElement | 
							tempDirectory := self constructPath: tempDirectory 
								with: ( components at: anElement ) ] ] ]
						ifFalse: [ tempDirectory := directory ] ]
				ifFalse: [ tempVolume := volume.
					tempDirectory := directory ] ].
	( self pathExists: ( self constructPath: tempVolume with: tempDirectory ) )
		ifFalse: [ tempVolume := self class currentVolume.
			tempDirectory := self class currentDirectory ].
	^Array with: tempVolume with: tempDirectory
]

{ #category : #'initialize-release' }
CommonDirectorySelectionDialog >> setLabels [
	"Open the dialog"

	| fontDesc charAttr textAttr label |
	self halt.
	label := ComposedText new.
	fontDesc := (TextAttributes defaultNoCopy characterAttributes defaultQueryFor: nil) copy.
	fontDesc pixelSize: (fontDesc pixelSize min: 16).
	charAttr := CharacterAttributes newWithDefaultAttributes.
	charAttr setDefaultQuery: fontDesc.
	textAttr := TextAttributes characterAttributes: charAttr.
	self class labels
		do: 
			[:component | 
			label := (self builder componentAt: component) widget label text string asComposedText.
			label textStyle: textAttr.
			label compositionWidth: label width.
			(self builder componentAt: component)
				label: label]
]

{ #category : #'initialize-release' }
CommonDirectorySelectionDialog >> setVolumeAsEmpty [
	"Private - Found a volume that is not valid, eg floppy drive with no floppy.  Set the list of 
	directories as empty"

	directoryNames list: List new.
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> stringHasWildcard: aString [ 
	"Private - check if string has * or # chars"

	^(aString includes: $*)
		or: [aString includes: $#]
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> title [
	"Return the string that is to be displayed on the dialog's title bar"

	^title
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> title: aTitle [
	"Assign the string that is to be displayed on the dialog's title bar"

	title := aTitle
]

{ #category : #events }
CommonDirectorySelectionDialog >> updateCurrentDirectoryContents: filterString [
"Private  - This method handles the interaction with the filing system when the user navigates through the directory structure. directoryNames, which hold the subdirectories within a particular directory, is updated with new values."

	| temp fullList list dList originalCursor entryFullPath |

	originalCursor := Cursor currentCursor.
	Cursor wait showWhile: [
	( self pathExists: self volumeName value )
	ifFalse: [ self setVolumeAsEmpty ]
	ifTrue:
		[ Filename errorReporter errorSignal
			handle: [:ex |
				directoryNames list: List new.
				originalCursor show.
				^nil ]
			do: [temp := ( self buildPath: String new ) asFilename.
					list := temp directoryContents asSortedCollection.
					fullList := ( temp filesMatching: '*' ) asSortedCollection].

		dList := List new.
		list with: fullList do: [ :directoryEntry :directoryEntryPath |
				entryFullPath := Filename concreteClass new named: directoryEntryPath.
			entryFullPath  isReadable
				ifTrue:[ entryFullPath isDirectory
					ifTrue: [ filterString isNil
						ifTrue:[ dList add: directoryEntry]
						ifFalse: [ ( filterString match: directoryEntry )
							ifTrue:[ dList add: directoryEntry ] ] ] ] ].

		( self directoryName asString match: self directoryName asFilename head ) 
			ifFalse: [ dList addFirst: '..' ]. "if not at top of dir hierarchy"
		directoryNames list: dList ] ]
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> updatePath: aPathString [
	"Private - Handles input for user specified path."
	| leftovers pathComponents|
  
	pathComponents := Filename components: aPathString . 
	leftovers := self parsePath: aPathString accountForFilename: self directoryMustExist not.
	( leftovers = 1 and: [ self stringHasWildcard: pathComponents last ] )
		ifTrue: [ self updateCurrentDirectoryContents: pathComponents last ]
		ifFalse: [ self updateCurrentDirectoryContents: nil.
			leftovers = 0 ifTrue: [ self path: ( self buildPath: String new ) ] ].
	^leftovers
]

{ #category : #'file utils' }
CommonDirectorySelectionDialog >> volumeExists: aVolumeName [
"Private - check if aVolumeName exists within volumeNames"
	| volumeString |

	( volumeString := aVolumeName ) last ~= Filename separator
		ifTrue: [ volumeString := volumeString , self separator ].
	( self stringHasWildcard: volumeString ) ifTrue: [ ^nil ].
	
	^self volumeNames value detect: [ :volume |  
		volumeString match: volume ] ifNone: [ 
		( volumeString includes: self separator )		
			ifTrue: [ ( self pathExists: volumeString )
				ifTrue: [ ^volumeString ]
				ifFalse: [ ^nil ] ] ].
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> volumeName [
	"The current volume value"

	^volumeName
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> volumeName: aVolume [
	"Set volume for inital display of dialog.  The argument must be a member of the current
	 collection of volumes; otherwise the default volume is used."

	openedDialog 
		ifTrue: [
			aVolume ~= self volumeName value ifTrue: [ 
				( self volumeExists: aVolume )
					ifTrue: [ self volumeName value: aVolume ]
					ifFalse: [ self volumeName value isNil 
						ifTrue: [ self volumeName value: self class currentVolume ]
						ifFalse: [ ( self volumeExists: self volumeName value ) notNil
							ifTrue: [ self volumeName value: self volumeName value ]
							ifFalse: [ self volumeName value: self class currentVolume ] ] ] ] ]
		ifFalse: [ self volumeName value: aVolume ]
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> volumeNames [
	"Private - current list of volume names which appear in the volumes combo box"

	^volumeNames
]

{ #category : #accessing }
CommonDirectorySelectionDialog >> volumeNames: aVolumeNameCollection [
	"Private - Assign the collection of volumes which can be selected in File Dialog."

	volumeNames := aVolumeNameCollection asValue
]

{ #category : #private }
CommonDirectorySelectionDialog >> widget: aWidget [
	"Private - Set the widget for the receiver."

	^self loadFromWidget: aWidget
]
