Class {
	#name : #ArrayedFunctionDialog,
	#superclass : #UserFunctionDialog,
	#instVars : [
		'editFunction',
		'function1',
		'function2',
		'function3',
		'function4',
		'function5',
		'function6',
		'markerk'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
ArrayedFunctionDialog class >> menuBar [

	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #nameKey: #menuExplainID
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'All' #nameKey: #menuExplainAllID
	                    #value: #menuExplainAll ) )
	              #( 1 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Function' #nameKey:
	           #menuFunctionID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Variable' #nameKey:
	           #menuVariableID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'GeoIJ' #nameKey:
	           #menuGeoIJID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Example' #nameKey:
	           #menuExampleID ) )
	     #( 5 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
ArrayedFunctionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
ArrayedFunctionDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Title' #min: #( '#{VWQR:Core.Point}'
	           640 480 ) #max: #( '#{VWQR:Core.Point}'
	           640 480 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           351 240 991 720 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.TextEditorSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.0203125 0 0.593886 0 0.979687 0 0.89083 )
	              #name: #eqnTextID #model: #eqnText #style: #system
	              #tabRequiresControl: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.25 0 0.949782 0.5 0.5 )
	              #name: #ActionButton1 #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.949782 0.5 0.5 )
	              #name: #ActionButton2 #model: #reset #label: 'Reset'
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.75 0 0.949782 0.5 0.5 )
	              #name: #ActionButton3 #model: #cancel #label: 'Cancel'
	              #defaultable: true )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.0240175 )
	              #name: #RadioButton1 #model: #editFunction
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction1 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel1 #select: #function1 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.0764192 )
	              #name: #RadioButton2 #model: #editFunction
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction2 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel2 #select: #function2 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.128821 )
	              #name: #RadioButton3 #model: #editFunction
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction3 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel3 #select: #function3 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.181223 )
	              #name: #RadioButton4 #model: #editFunction
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction4 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel4 #select: #function4 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.233624 )
	              #name: #RadioButton5 #model: #editFunction
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction5 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel5 #select: #function5 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.286026 )
	              #name: #RadioButton6 #model: #editFunction
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction6 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel6 #select: #function6 )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.556768 0.5 0.5 )
	              #name: #userInputLabelID #label: 'User Input Function' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 26 157 ) #name: #Label2 #label: 'Ref Frame' )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 94 158 )
	              #name: #RadioButton7 #model: #markerk #label: 'I' #select:
	              #I )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 133 158 )
	              #name: #RadioButton8 #model: #markerk #label: 'J' #select:
	              #J )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 174 158 )
	              #name: #RadioButton9 #model: #markerk #label: 'O' #select:
	              #O )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.0174672 0 0.967187 0 0.069869 )
	              #name: #function1ID #model: #function1 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.069869 0 0.967187 0 0.122271 )
	              #name: #function2ID #model: #function2 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.122271 0 0.967187 0 0.174672 )
	              #name: #function3ID #model: #function3 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.174672 0 0.967187 0 0.227074 )
	              #name: #function4ID #model: #function4 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.227074 0 0.967187 0 0.279476 )
	              #name: #function5ID #model: #function5 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.279476 0 0.967187 0 0.331878 )
	              #name: #function6ID #model: #function6 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 3 0.416666 0 1.0 35 0.416666 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
ArrayedFunctionDialog >> editFunction [
	^editFunction
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> editFunction1 [
	| symbol |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	eqnText value: function1 value
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> editFunction2 [
	| symbol |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	eqnText value: function2 value
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> editFunction3 [
	| symbol |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	eqnText value: function3 value
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> editFunction4 [
	| symbol |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	eqnText value: function4 value
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> editFunction5 [
	| symbol |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	eqnText value: function5 value
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> editFunction6 [
	| symbol |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	eqnText value: function6 value
]

{ #category : #accessing }
ArrayedFunctionDialog >> function1 [
	^function1
]

{ #category : #accessing }
ArrayedFunctionDialog >> function2 [
	^function2
]

{ #category : #accessing }
ArrayedFunctionDialog >> function3 [
	^function3
]

{ #category : #accessing }
ArrayedFunctionDialog >> function4 [
	^function4
]

{ #category : #accessing }
ArrayedFunctionDialog >> function5 [
	^function5
]

{ #category : #accessing }
ArrayedFunctionDialog >> function6 [
	^function6
]

{ #category : #'initialize-release' }
ArrayedFunctionDialog >> getBlock [
	^[:cadModel | '']
]

{ #category : #private }
ArrayedFunctionDialog >> hasInputValid [
	^editFunction value isNil or: [self eqnTextValue isEmpty or: [self parserResult notNil]]
]

{ #category : #accessing }
ArrayedFunctionDialog >> markerk [
	^markerk
]

{ #category : #accessing }
ArrayedFunctionDialog >> menuBar [
	| menu |
	menu := self class menuBar.
	(menu atNameKey: #menuFunctionID)
		submenu: [self menuFunction].
	(menu atNameKey: #menuVariableID)
		submenu: [self menuVariable].
	(menu atNameKey: #menuGeoIJID)
		submenu: [self menuGeoIJ].
	(menu atNameKey: #menuExampleID)
		submenu: [self menuExample].
	^menu
]

{ #category : #accessing }
ArrayedFunctionDialog >> menuExampleExplainTime [
	| labelString |
	labelString := 'Explain Time Examples'.
	self openExplainFile: 'StCADArrayedFunctionDialogMenuExampleExplainTime.sdoc' label: labelString
]

{ #category : #accessing }
ArrayedFunctionDialog >> menuGeoIJ [
	| geoIJkeys sc mb textEditorWrapper textEditorController |
	geoIJkeys := self functionParser geoIJs keys asArray.
	sc := SequenceableCollectionSorter on: geoIJkeys using: [:key1 :key2 | key1 <= key2].
	sc sort.
	mb := MenuBuilder new.
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	geoIJkeys
		do: 
			[:key | 
			| block |
			block := [textEditorController deselect; replaceSelectionWith: key; select].
			mb add: key -> block].
	^mb menu
]
