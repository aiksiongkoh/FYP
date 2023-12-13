Class {
	#name : #UserFunctionDialog,
	#superclass : #CADDialog,
	#instVars : [
		'cadItem',
		'eqnText',
		'units'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
UserFunctionDialog class >> menuBar [

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
UserFunctionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
UserFunctionDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Title' #min: #( '#{VWQR:Core.Point}'
	           493 323 ) #max: #( '#{VWQR:Core.Point}'
	           493 323 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 1005 707 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.TextEditorSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.03 0 0.166667 0 0.97 0 0.666666 )
	              #name: #eqnTextID #model: #eqnText #style: #system
	              #tabRequiresControl: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.25 0 0.787582 0.5 0.5 )
	              #name: #ActionButton1 #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.501984 0 0.787582 0.5 0.5 )
	              #name: #ActionButton2 #model: #reset #label: 'Reset'
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.75 0 0.787582 0.5 0.5 )
	              #name: #ActionButton3 #model: #cancel #label: 'Cancel'
	              #defaultable: true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.0833333 0.5 0.5 )
	              #name: #userInputLabelID #label: 'User Input Function' )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -41 1 0 1.0 -9 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #private }
UserFunctionDialog >> closeAccept [
	accept value ifTrue: [(self requestForWindowClose and: [self hasInputValid])
			ifTrue: 
				[self updateDomainObjects.
				close value: true.
				builder window checkForEvents]
			ifFalse: [accept value: false]]
]

{ #category : #private }
UserFunctionDialog >> doesNotUnderstand: aMessage [ 
	^cadItem value perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #accessing }
UserFunctionDialog >> eqnText [
	^eqnText
]

{ #category : #accessing }
UserFunctionDialog >> eqnTextValue [
	| textEditorWrapper textEditorController |
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	textEditorController accept.
	^eqnText value
]

{ #category : #accessing }
UserFunctionDialog >> examples [
	^self menuExampleTime
]

{ #category : #private }
UserFunctionDialog >> hasInputValid [
	^self parserResult notNil
]

{ #category : #'initialize-release' }
UserFunctionDialog >> initialize [
	| plugAdap |
	super initialize.
	cadItem := nil asValue.
	plugAdap := PluggableAdaptor on: cadItem.
	plugAdap
		getBlock: self getBlock
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	eqnText := BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
UserFunctionDialog >> menuBar [
	| menu |
	menu := self class menuBar.
	(menu atNameKey: #menuFunctionID)
		submenu: [self menuFunction].
	(menu atNameKey: #menuVariableID)
		submenu: [self menuVariable].
	(menu atNameKey: #menuExampleID)
		submenu: [self menuExample].
	^menu
]

{ #category : #accessing }
UserFunctionDialog >> menuExample [
	| mb examples textEditorWrapper textEditorController |
	mb := MenuBuilder new.
	mb 
		add: 'Explain' -> 
					[| labelString |
					labelString := 'Explain Time Examples'.
					self 
						openExplainFile: 'StCADArrayedFunctionDialogMenuExampleExplainTime.sdoc'
						label: labelString].
	examples := self examples asArray.
	textEditorWrapper := self builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	examples do: 
			[:item | 
			| block |
			block := 
					[textEditorController
						deselect;
						replaceSelectionWith: item value;
						select].
			mb add: item key -> block].
	^mb menu
]

{ #category : #accessing }
UserFunctionDialog >> menuExample1 [
	| examples mb textEditorWrapper textEditorController |
	examples := self examples asArray.
	mb := MenuBuilder new.
	textEditorWrapper := self builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	examples do: 
			[:item | 
			| block |
			block := 
					[textEditorController
						deselect;
						replaceSelectionWith: item value;
						select].
			mb add: item key -> block].
	^mb menu
]

{ #category : #accessing }
UserFunctionDialog >> menuExample: symbol [ 
	| examples mb textEditorWrapper textEditorController |
	examples := self perform: symbol.
	mb := MenuBuilder new.
	textEditorWrapper := self builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	examples
		do: 
			[:item | 
			| block |
			block := [textEditorController deselect; replaceSelectionWith: item value; select].
			mb add: item key -> block].
	^mb menu
]

{ #category : #accessing }
UserFunctionDialog >> menuExampleTime [
	| examples |
	examples := OrderedCollection new.
	examples add: #linear -> 'C + VEL*time'.
	examples add: #quadratic -> 'C + VEL*time + ACC*time^2'.
	examples add: #harmonic -> 'C + AMP*sin(VEL*time - PHASE)'.
	examples add: #exponential -> 'C*exp(time/TIMEC)'.
	examples add: #'smooth step' 
				-> 'L1 + (L2 - L1)*((1/2) + (1/pi)*arctan(SLOPE*(time - T0)))'.
	examples add: #'smooth square impulse ' 
				-> '(H/pi)*(arctan(SLOPE*(time - T1)) - arctan(SLOPE*(time - T2)))'.
	examples add: #'smooth ramp top impulse ' 
				-> '((1/pi)*(arctan(1000*(time - T1)) - arctan(1000*(time - T2))))*(((H2 - H1)/(T2 - T1))*(time - T1) + H1)'.
	^examples
]

{ #category : #accessing }
UserFunctionDialog >> menuExplainAll [
	| labelString |
	labelString := 'Explain User Function Dialog'.
	self openExplainFile: 'StCADUserFunctionDialogMenuExplainAll.sdoc' label: labelString
]

{ #category : #accessing }
UserFunctionDialog >> menuFunction [
	| functions sc mb textEditorWrapper textEditorController |
	functions := self functionParser functions asArray.
	sc := SequenceableCollectionSorter on: functions using: [:item1 :item2 | item1 functionTemplate <= item2 functionTemplate].
	sc sort.
	mb := MenuBuilder new.
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	functions
		do: 
			[:item | 
			| functionTemplate block |
			functionTemplate := item functionTemplate.
			block := [textEditorController deselect; replaceSelectionWith: functionTemplate; select].
			mb add: functionTemplate -> block].
	^mb menu
]

{ #category : #accessing }
UserFunctionDialog >> menuFunction: symbol [ 
	| functions mb textEditorWrapper textEditorController |
	functions := self functionParser perform: symbol.
	mb := MenuBuilder new.
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	functions
		do: 
			[:item | 
			| functionTemplate block |
			functionTemplate := item functionTemplate.
			block := [textEditorController deselect; replaceSelectionWith: functionTemplate; select].
			mb add: functionTemplate -> block].
	^mb menu
]

{ #category : #accessing }
UserFunctionDialog >> menuVariable [
	| variables sc mb textEditorWrapper textEditorController |
	variables := self functionParser variables asArray.
	sc := SequenceableCollectionSorter on: variables using: [:item1 :item2 | item1 name <= item2 name].
	sc sort.
	mb := MenuBuilder new.
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	variables
		do: 
			[:item | 
			| name block |
			name := item name.
			block := [textEditorController deselect; replaceSelectionWith: name; select].
			mb add: name -> block].
	^mb menu
]

{ #category : #private }
UserFunctionDialog >> parserResult [
	| parser textEditorWrapper textEditorController compilationError stack |
	parser := self functionParser.
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	compilationError := textEditorController class compilationErrorSignal.
	^
	[stack := parser
				parseUserFunction: self userFunction
				notifying: textEditorController
				ifFail: 
					[textEditorWrapper takeKeyboardFocus.
					compilationError raiseSignal].
	stack last]
		on: compilationError do: [:ex | ex return: nil]
]

{ #category : #private }
UserFunctionDialog >> parserResult1 [
	| parser textEditorWrapper textEditorController compilationError stack |
	parser := self functionParser.
	textEditorWrapper := builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	compilationError := textEditorController class compilationErrorSignal.
	^
	[stack := parser
				parse: eqnText value
				as: #expression
				notifying: textEditorController
				ifFail: 
					[textEditorWrapper takeKeyboardFocus.
					compilationError raiseSignal].
	stack last]
		on: compilationError do: [:ex | ex return: nil]
]

{ #category : #'interface opening' }
UserFunctionDialog >> postBuildWith: aBuilder [ 
	aBuilder window label: self dialogTitle.
	(aBuilder componentAt: #userInputLabelID)
		labelString: self userInputLabel
]

{ #category : #accessing }
UserFunctionDialog >> subject [
	^cadItem
]

{ #category : #accessing }
UserFunctionDialog >> units [
	^units
]

{ #category : #accessing }
UserFunctionDialog >> units: argUnits [ 
	units := argUnits
]

{ #category : #private }
UserFunctionDialog >> updateDomainObjects [
	bufferTrigger value: true
]
