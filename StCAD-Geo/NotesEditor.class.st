Class {
	#name : #NotesEditor,
	#superclass : #Editor,
	#instVars : [
		'geoItem'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #resources }
NotesEditor class >> menuBar [

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
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Save Notes'
	                    #value: #menuFileSaveNotes )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Exit' #value:
	                    #menuFileExit ) )
	              #( 5 ) nil ) )
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

{ #category : #'interface opening' }
NotesEditor class >> openOn: geoItem [ 
	^(self new geoItem: geoItem) open
]

{ #category : #resources }
NotesEditor class >> textMenu [

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
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Save Notes' #value:
	           #menuSaveNotes )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Cancel' #value: #cancel ) )
	     #( 2 1 3 3 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
NotesEditor class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Doc'
	)

]

{ #category : #accessing }
NotesEditor >> geoItem: object [ 
	| notes |
	geoItem := object.
	notes := geoItem notes.
	notes notNil ifTrue: [self textHolder value: notes]
]

{ #category : #'menu items' }
NotesEditor >> menuFileSaveNotes [
	geoItem interface notNil
		ifTrue: [(textEditorController textHasChanged and: [Dialog confirm: 'Override previous Notes?' expandMacros])
				ifTrue: 
					[textEditorController accept.
					geoItem notes: self textHolder value.
					builder window label: ('<1s> Notes        <2s>' expandMacrosWith: geoItem name with: AdData adTitle title).
					geoItem interface cadApp isDirty: true]]
		ifFalse: [Dialog warn: 'The original owner of these notes no longer exists in the system. <n>You can still copy the contents and paste elsewhere.' expandMacros]
]

{ #category : #'menu items' }
NotesEditor >> menuSaveNotes [
	self menuFileSaveNotes
]
