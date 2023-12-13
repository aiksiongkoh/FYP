Class {
	#name : #EditorDialog,
	#superclass : #SimpleDialog,
	#instVars : [
		'editor'
	],
	#category : #'StCAD-Doc-StDoc'
}

{ #category : #resources }
EditorDialog class >> menuBar [

	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #value: #menuExplain )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'File        '
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'New' #value: #menuFileNew )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Open' #value:
	                    #menuFileOpen )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Save As'
	                    #value: #menuFileSaveAs )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Exit' #value:
	                    #menuFileExit ) )
	              #( 4 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Normal        '
	           #value: #menuNormal )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Heading' #value: #menuHeading )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Large' #value: #menuLarge )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Small        '
	           #value: #menuSmall )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Bold' #value: #menuBold )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Italic' #value: #menuItalic )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Underline        '
	           #value: #menuUnderline #labelImage: #( '#{VWQR:UI.ResourceRetriever}'
	              '#{VWQR:Tools.ToolbarIconLibrary}'
	              #exploreOff )
	           #helpText: 'testing' )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Courier' #value: #menuCourier ) )
	     #( 2 1 3 3 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'interface opening' }
EditorDialog class >> openOn: text readOnly: readOnly label: labelString [ 
	^super new
		text: text
		readOnly: readOnly
		label: labelString
]

{ #category : #'interface specs' }
EditorDialog class >> readOnlyWindowSpec [

	"UIPainter new openOnClass: self andSelector: #readOnlyWindowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'new file' #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 288 1024 768 ) )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.SubCanvasSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 0 1 )
	              #name: #editorID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.Editor}'
	              #minorKey: #readOnlyWindowSpec #clientKey: #editor ) ) ) )
]

{ #category : #'VisualWorks metadata' }
EditorDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Doc'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
EditorDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'new file' #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 288 1024 768 )
	        #flags: 4 #menu: #menuBar )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.SubCanvasSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 0 1 )
	              #name: #editorID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.Editor}'
	              #minorKey: #windowSpec #clientKey: #editor ) ) ) )
]

{ #category : #private }
EditorDialog >> doesNotUnderstand: aMessage [ 
	^editor perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #accessing }
EditorDialog >> editor [
	^editor
]

{ #category : #'interface opening' }
EditorDialog >> filename: aFilename readOnly: readOnly label: labelString [ 
	| spec |
	spec := readOnly
				ifTrue: [#readOnlyWindowSpec]
				ifFalse: [#windowSpec].
	spec := self class interfaceSpecFor: spec.
	self allButOpenFrom: spec.
	self loadFile: aFilename.
	self builder window label: labelString.
	self builder openDialog
]

{ #category : #'initialize-release' }
EditorDialog >> initialize [
	super initialize.
	editor := Editor new
]

{ #category : #'interface opening' }
EditorDialog >> text: text readOnly: readOnly label: labelString [ 
	| spec |
	self textHolder: text asText asValue.
	spec := readOnly
				ifTrue: [#readOnlyWindowSpec]
				ifFalse: [#windowSpec].
	spec := self class interfaceSpecFor: spec.
	self allButOpenFrom: spec.
	self builder window label: labelString.
	self builder openDialog
]
