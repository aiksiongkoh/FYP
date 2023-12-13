Class {
	#name : #ForceTorqueInLineDialog,
	#superclass : #ArrayedFunctionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
ForceTorqueInLineDialog class >> menuBar [

	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #nameKey: #menuExplainID
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'All' #nameKey: #menuExplainAllID
	                    #value: #menuExplainAll ) )
	              #( 1 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Function' #nameKey:
	           #menuFunctionID #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Intrinsic'
	                    #nameKey: #menuFunctionIntrinsicID
	                    #value: #menuFunctionIntrinsic )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Displacement'
	                    #nameKey: #menuFunctionDisplacementID
	                    #value: #menuFunctionDisplacement )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Velocity'
	                    #nameKey: #menuFunctionVelocityID
	                    #value: #menuFunctionVelocity )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'ForceTorque'
	                    #enabled: false #nameKey: #menuFunctionForceTorqueID
	                    #value: #menuFunctionForceTorque
	                    #hidden: true ) )
	              #( 4 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Variable' #nameKey:
	           #menuVariableID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'GeoIJ' #nameKey:
	           #menuGeoIJID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Example' #nameKey:
	           #menuExampleID #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Explain'
	                    #nameKey: #menuExampleExplainID
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Time' #value: #menuExampleExplainTime )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'SpringDamper' #value:
	                             #menuExampleExplainSpringDamper )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Aerodynamic' #value: #menuExampleExplainAerodynamic )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'InverseSquare'
	                             #value: #menuExampleExplainInverseSquare ) )
	                       #( 4 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Time' #nameKey:
	                    #menuExampleTimeID #value: #menuExampleTime )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'SpringDamper'
	                    #nameKey: #menuExampleSpringDamperID
	                    #value: #menuExampleSpringDamper )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Aerodynamic'
	                    #nameKey: #menuExampleAerodynamicID
	                    #value: #menuExampleAerodynamic )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'InverseSquare'
	                    #nameKey: #menuExampleInverseSquareID
	                    #value: #menuExampleInverseSquare ) )
	              #( 5 ) nil ) ) )
	     #( 5 ) nil ) decodeAsLiteralArray
]

{ #category : #accessing }
ForceTorqueInLineDialog class >> radioLabel1 [
	^'tension'
]

{ #category : #accessing }
ForceTorqueInLineDialog class >> radioLabel2 [
	^'twistIJ'
]

{ #category : #'VisualWorks metadata' }
ForceTorqueInLineDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
ForceTorqueInLineDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Title' #min: #( '#{VWQR:Core.Point}'
	           640 305 ) #max: #( '#{VWQR:Core.Point}'
	           640 305 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 384 1024 689 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.TextEditorSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.02 0 0.54417 0 0.98 0 0.840989 )
	              #name: #eqnTextID #model: #eqnText #style: #system
	              #tabRequiresControl: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.25 0 0.929329 0.5 0.5 )
	              #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.929329 0.5 0.5 )
	              #model: #reset #label: 'Reset' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.75 0 0.929329 0.5 0.5 )
	              #model: #cancel #label: 'Cancel' #defaultable:
	              true )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.0388693 )
	              #model: #editFunction #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction1 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel1 #select: #function1 )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 0 0.040625 0 0.159011 )
	              #model: #editFunction #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #editFunction2 #requestFocusInSelector:
	                 #hasInputValid )
	              #label: #radioLabel2 #select: #function2 )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.487632 0.5 0.5 )
	              #name: #userInputLabelID #label: 'User Input Function in SI units' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.024735 0 0.96875 0 0.120141 )
	              #name: #function1ID #model: #function1 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.15625 0 0.144876 0 0.96875 0 0.240283 )
	              #name: #function2ID #model: #function2 #isReadOnly:
	              true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 14 0.25 0 1.0 46 0.25 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
ForceTorqueInLineDialog >> dialogTitle [
	^'In Line Force Torque Functions'
]

{ #category : #accessing }
ForceTorqueInLineDialog >> getBlock1 [
	^
	[:cadModel | 
	| tensionFunc |
	tensionFunc := cadModel value tensionFunc.
	self units: tensionFunc units.
	tensionFunc funcText]
]

{ #category : #accessing }
ForceTorqueInLineDialog >> getBlock2 [
	^
	[:cadModel | 
	| twistFunc |
	twistFunc := cadModel value twistFunc.
	self units: twistFunc units.
	twistFunc funcText]
]

{ #category : #'initialize-release' }
ForceTorqueInLineDialog >> initialize [
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
	markerk := self bufferedAdaptorFor: #markerK
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuBar [
	| menu |
	menu := self class menuBar.
	(menu atNameKey: #menuFunctionIntrinsicID)
		submenu: [self menuFunction: #intrinsicFunctions].
	(menu atNameKey: #menuFunctionDisplacementID)
		submenu: [self menuFunction: #displacementFunctions].
	(menu atNameKey: #menuFunctionVelocityID)
		submenu: [self menuFunction: #velocityFunctions].
	(menu atNameKey: #menuVariableID)
		submenu: [self menuVariable].
	(menu atNameKey: #menuGeoIJID)
		submenu: [self menuGeoIJ].
	(menu atNameKey: #menuExampleTimeID)
		submenu: [self menuExample: #menuExampleTime].
	(menu atNameKey: #menuExampleSpringDamperID)
		submenu: [self menuExample: #menuExampleSpringDamper].
	^menu
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExampleAerodynamic [
	| textEditorWrapper textEditorController |
	textEditorWrapper := self builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	textEditorController deselect; replaceSelectionWith: 'CD*vrIJ(self)^2'; select
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExampleExplainAerodynamic [
	| labelString |
	labelString := 'Explain Aerodynamic Example'.
	self openExplainFile: 'StCADForceTorqueInLineDialogMenuExampleExplainAerodynamic.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExampleExplainInverseSquare [
	| labelString |
	labelString := 'Explain Inverse Square Law Example'.
	self openExplainFile: 'StCADForceTorqueInLineDialogMenuExampleExplainInverseSquare.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExampleExplainSpringDamper [
	| labelString |
	labelString := 'Explain SpringDamper Example'.
	self openExplainFile: 'StCADForceTorqueInLineDialogMenuExampleExplainSpringDamper.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExampleInverseSquare [
	| textEditorWrapper textEditorController |
	textEditorWrapper := self builder componentAt: #eqnTextID.
	textEditorController := textEditorWrapper widget controller.
	textEditorController deselect; replaceSelectionWith: '3.0d/rIJ(self)^2'; select
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExampleSpringDamper [
	| examples |
	examples := OrderedCollection new.
	examples add: #linear -> 'F0 + K*(rIJ(self) - L0) + C*vrIJ(self)'.
	examples add: #hardening -> 'K*(rIJ(self) - L0) + E*(rIJ(self) - L0)^3 + C*vrIJ(self)'.
	examples add: #softening -> 'FMAX*arctan((K/FMAX)*(rIJ(self) - L0)) + C*vrIJ(self)'.
	examples add: #'van der Pol' -> '1.0d*(rIJ(self) - L0) - EPSILON*(1.0d - (rIJ(self) - L0)^2)*vrIJ(self)'.
	examples add: #'linear twist' -> 'T0 + KT*angleIJz(self) + CT*omeIJKi(self, I, 3)'.
	^examples
]

{ #category : #accessing }
ForceTorqueInLineDialog >> menuExplainAll [
	| labelString |
	labelString := 'Explain In-Line ForceTorque Dialog'.
	self openExplainFile: 'StCADForceTorqueInLineDialogMenuExplainAll.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueInLineDialog >> radioLabel1 [
	^self class radioLabel1
]

{ #category : #accessing }
ForceTorqueInLineDialog >> radioLabel2 [
	^self class radioLabel2
]

{ #category : #private }
ForceTorqueInLineDialog >> updateDomainObjects [
	| symbol block text |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	block := [:func :unitSymbol | ((text := func value) notNil and: [text isEmpty not])
				ifTrue: [BasicUserFunction
						with: text
						myUnit: (units perform: unitSymbol)
						units: units]
				ifFalse: [nil]].
	cadItem value tensionFunc: (block value: function1 value: #force).
	cadItem value twistFunc: (block value: function2 value: #torque)
]

{ #category : #accessing }
ForceTorqueInLineDialog >> userFunction [
	| myUnit |
	myUnit := editFunction value last < $2
				ifTrue: [units force]
				ifFalse: [units torque].
	^BasicUserFunction
		with: self eqnTextValue
		myUnit: myUnit
		units: units
]

{ #category : #accessing }
ForceTorqueInLineDialog >> userInputLabel [
	^'Enter force and torque functions in SI units.'
]
