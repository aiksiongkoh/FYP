Class {
	#name : #GeneralMotionDialog,
	#superclass : #ArrayedFunctionDialog,
	#instVars : [
		'rot1',
		'rot2',
		'rot3'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
GeneralMotionDialog class >> menuBar [

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
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Example' #nameKey:
	           #menuExampleID ) )
	     #( 4 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
GeneralMotionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
GeneralMotionDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Title' #min: #( '#{VWQR:Core.Point}'
	           640 480 ) #max: #( '#{VWQR:Core.Point}'
	           640 480 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 288 1024 768 )
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
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 3 0.416666 0 1.0 35 0.416666 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.174779 0 0.75 0 0.227876 )
	              #name: #function4ID #model: #function4 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.227876 0 0.75 0 0.278761 )
	              #name: #function5ID #model: #function5 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.278761 0 0.75 0 0.331858 )
	              #name: #function6ID #model: #function6 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 507 81 )
	              #name: #RadioButton7 #model: #rot1 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'x' #select: 1 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 546 81 )
	              #name: #RadioButton8 #model: #rot1 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'y' #select: 2 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 587 81 )
	              #name: #RadioButton9 #model: #rot1 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'z' #select: 3 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 507 104 )
	              #name: #RadioButton10 #model: #rot2 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'x' #select: 1 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 546 104 )
	              #name: #RadioButton11 #model: #rot2 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'y' #select: 2 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 587 104 )
	              #name: #RadioButton12 #model: #rot2 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'z' #select: 3 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 507 128 )
	              #name: #RadioButton13 #model: #rot3 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'x' #select: 1 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 587 128 )
	              #name: #RadioButton15 #model: #rot3 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'z' #select: 3 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 546 128 )
	              #name: #RadioButton14 #model: #rot3 #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestValueChangeSelector:
	                 #validateRotOrder: )
	              #label: 'y' #select: 2 ) ) ) )
]

{ #category : #accessing }
GeneralMotionDialog >> dialogTitle [
	^'Full Motion Functions'
]

{ #category : #accessing }
GeneralMotionDialog >> getBlock1 [
	^
	[:cadModel | 
	| rIJIi |
	rIJIi := cadModel value rIJI at: 1.
	self units: rIJIi units.
	rIJIi funcText]
]

{ #category : #accessing }
GeneralMotionDialog >> getBlock2 [
	^
	[:cadModel | 
	| rIJIi |
	rIJIi := cadModel value rIJI at: 2.
	self units: rIJIi units.
	rIJIi funcText]
]

{ #category : #accessing }
GeneralMotionDialog >> getBlock3 [
	^
	[:cadModel | 
	| rIJIi |
	rIJIi := cadModel value rIJI at: 3.
	self units: rIJIi units.
	rIJIi funcText]
]

{ #category : #accessing }
GeneralMotionDialog >> getBlock4 [
	^
	[:cadModel | 
	| angleIJJi |
	angleIJJi := cadModel value angleIJJ at: 1.
	self units: angleIJJi units.
	angleIJJi funcText]
]

{ #category : #accessing }
GeneralMotionDialog >> getBlock5 [
	^
	[:cadModel | 
	| angleIJJi |
	angleIJJi := cadModel value angleIJJ at: 2.
	self units: angleIJJi units.
	angleIJJi funcText]
]

{ #category : #accessing }
GeneralMotionDialog >> getBlock6 [
	^
	[:cadModel | 
	| angleIJJi |
	angleIJJi := cadModel value angleIJJ at: 3.
	self units: angleIJJi units.
	angleIJJi funcText]
]

{ #category : #accessing }
GeneralMotionDialog >> getRot1 [
	^[:cadModel | cadModel value rotOrder at: 1]
]

{ #category : #accessing }
GeneralMotionDialog >> getRot2 [
	^[:cadModel | cadModel value rotOrder at: 2]
]

{ #category : #accessing }
GeneralMotionDialog >> getRot3 [
	^[:cadModel | cadModel value rotOrder at: 3]
]

{ #category : #'initialize-release' }
GeneralMotionDialog >> initialize [
	| block |
	super initialize.
	editFunction := nil asValue.
	block := 
			[:getSymbol | 
			| plugAdap |
			plugAdap := PluggableAdaptor on: cadItem.
			plugAdap 
				getBlock: (self perform: getSymbol)
				putBlock: [:model :value | ]
				updateBlock: [:model :aspect :parameter | false].
			BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger].
	function1 := block value: #getBlock1.
	function2 := block value: #getBlock2.
	function3 := block value: #getBlock3.
	function4 := block value: #getBlock4.
	function5 := block value: #getBlock5.
	function6 := block value: #getBlock6.
	rot1 := block value: #getRot1.
	rot2 := block value: #getRot2.
	rot3 := block value: #getRot3
]

{ #category : #accessing }
GeneralMotionDialog >> menuBar [
	| menu |
	menu := self class menuBar.
	(menu atNameKey: #menuFunctionID) submenu: [self menuFunction].
	(menu atNameKey: #menuVariableID) submenu: [self menuVariable].
	(menu atNameKey: #menuExampleID) submenu: [self menuExample].
	^menu
]

{ #category : #accessing }
GeneralMotionDialog >> menuExplainAll [
	| labelString |
	labelString := 'Explain General Motion Dialog'.
	self openExplainFile: 'StCADGeneralMotionDialogMenuExplainAll.sdoc'
		label: labelString
]

{ #category : #accessing }
GeneralMotionDialog >> radioLabel1 [
	^'rIJI1'
]

{ #category : #accessing }
GeneralMotionDialog >> radioLabel2 [
	^'rIJI2'
]

{ #category : #accessing }
GeneralMotionDialog >> radioLabel3 [
	^'rIJI3'
]

{ #category : #accessing }
GeneralMotionDialog >> radioLabel4 [
	^'rotIJJ1'
]

{ #category : #accessing }
GeneralMotionDialog >> radioLabel5 [
	^'rotIJJ2'
]

{ #category : #accessing }
GeneralMotionDialog >> radioLabel6 [
	^'rotIJJ3'
]

{ #category : #accessing }
GeneralMotionDialog >> rot1 [
	^rot1
]

{ #category : #accessing }
GeneralMotionDialog >> rot2 [
	^rot2
]

{ #category : #accessing }
GeneralMotionDialog >> rot3 [
	^rot3
]

{ #category : #private }
GeneralMotionDialog >> updateDomainObjects [
	| symbol block text |
	(symbol := editFunction value) notNil 
		ifTrue: [(self perform: symbol) value: self eqnTextValue].
	block := 
			[:func :unitSymbol | 
			((text := func value) notNil and: [text isEmpty not]) 
				ifTrue: 
					[BasicUserFunction 
						with: text
						myUnit: (units perform: unitSymbol)
						units: units]
				ifFalse: [nil]].
	cadItem value rIJI: (FullColumn 
				with: (block value: function1 value: #length)
				with: (block value: function2 value: #length)
				with: (block value: function3 value: #length)).
	cadItem value angleIJJ: (FullColumn 
				with: (block value: function4 value: #angle)
				with: (block value: function5 value: #angle)
				with: (block value: function6 value: #angle)).
	cadItem value rotOrder: (Array 
				with: rot1 value
				with: rot2 value
				with: rot3 value)
]

{ #category : #accessing }
GeneralMotionDialog >> userFunction [
	| myUnit |
	myUnit := editFunction value last < $4 
				ifTrue: [units length]
				ifFalse: [units angle].
	^BasicUserFunction 
		with: self eqnTextValue
		myUnit: myUnit
		units: units
]

{ #category : #accessing }
GeneralMotionDialog >> userInputLabel [
	^'Enter displacement in meters and angles in raidans.'
]

{ #category : #validation }
GeneralMotionDialog >> validateRotOrder: aController [ 
	"Prevent rot1 and rot2 to be about the same axis. Same with rot2 and rot3."

	| block rot1value rot2value rot3value |
	block := 
			[:rot | 
			aController model == rot 
				ifTrue: 
					["Get the would be new value."

					aController view getReferenceValue]
				ifFalse: [rot value]].
	rot1value := block value: rot1.
	rot2value := block value: rot2.
	rot3value := block value: rot3.
	^(rot1value = rot2value or: [rot2value = rot3value]) not
]
