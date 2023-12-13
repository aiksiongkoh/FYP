Class {
	#name : #CADParallelLightingDialog,
	#superclass : #CADLightingDialog,
	#instVars : [
		'zDirX',
		'zDirY',
		'zDirZ'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
CADParallelLightingDialog class >> menuBar [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #nameKey: #menuExplainLightingID
	           #value: #menuExplainLighting ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADParallelLightingDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADParallelLightingDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Parallel Lighting Dialog' #min: #( '#{VWQR:Core.Point}'
	           627 309 ) #max: #( '#{VWQR:Core.Point}'
	           627 309 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           403 404 1030 713 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.SubCanvasSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -54 1 0 1.0 -22 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 103 21 338 156 )
	              #name: #aJunColorChoiceHSBID #flags: 0 #majorKey:
	              '#{VWQR:Jun.JunColorChoiceHSB}'
	              #minorKey: #windowSpec #clientKey: #aJunColorChoiceHSB )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	                    #layout: #( '#{VWQR:Graphics.Rectangle}'
	                       0 0 71 25 )
	                    #model: #accept #label: 'OK' #style: #default
	                    #defaultable: true )
	                 #( '#{VWQR:UI.ActionButtonSpec}'
	                    #layout: #( '#{VWQR:Graphics.Rectangle}'
	                       108 0 179 25 )
	                    #model: #reset #label: 'Reset' #style: #default
	                    #defaultable: true )
	                 #( '#{VWQR:UI.ActionButtonSpec}'
	                    #layout: #( '#{VWQR:Graphics.Rectangle}'
	                       216 0 287 25 )
	                    #model: #cancel #label: 'Cancel' #style: #default
	                    #defaultable: true ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    171 179 458 204 )
	                 #name: #Composite2 ) )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 409 55 590 87 )
	              #model: #zDirX #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 409 86 590 118 )
	              #model: #zDirY #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 409 117 590 149 )
	              #model: #zDirZ #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 443 18 ) #label: 'Direction of Light'
	              #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 374 59 ) #label: 'X' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 373 90 ) #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 374 121 ) #label: 'Z' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 358 33 ) #label: 'World' #style: #default )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.RadioButtonSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 0 ) #name: #RadioButton1 #model: #isOn #label:
	                    'On' #select: true )
	                 #( '#{VWQR:UI.RadioButtonSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 42 ) #name: #RadioButton2 #model: #isOn
	                    #label: 'Off' #select: false ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    36 57 81 120 )
	                 #name: #Composite1 ) ) ) ) )
]

{ #category : #accessing }
CADParallelLightingDialog >> adaptorzDirat: i [ 
	| plugAdap lighting zDir |
	plugAdap := PluggableAdaptor on: aLighting.
	plugAdap 
		getBlock: 
			[:model | 
			lighting := model value.
			zDir := lighting aRefFrame aAOf column: 3.
			zDir at: i]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #private }
CADParallelLightingDialog >> hasInputValid [
	| zDir |
	zDirX myDependents notNil 
		ifTrue: 
			[zDir := FullColumn new: 3.
			zDir at: 1 put: zDirX value.
			zDir at: 2 put: zDirY value.
			zDir at: 3 put: zDirZ value.
			zDir length < 1.0d-6 
				ifTrue: 
					[Dialog warn: 'Direction vector must be greater than 1.0d-6.'.
					^false]].
	^true
]

{ #category : #'initialize-release' }
CADParallelLightingDialog >> initialize [
	super initialize.
	zDirX := self adaptorzDirat: 1.
	zDirY := self adaptorzDirat: 2.
	zDirZ := self adaptorzDirat: 3
]

{ #category : #private }
CADParallelLightingDialog >> updateDomainObjects [
	| aLightingRefFrame zDir xDir newAFf yDir |
	super updateDomainObjects.
	aLightingRefFrame := aLighting value aRefFrame.
	zDir := FullColumn 
				with: zDirX value
				with: zDirY value
				with: zDirZ value.
	zDir normalizeSelf.
	xDir := aLightingRefFrame aAFf column: 1.
	(xDir dot: zDir) abs < 0.9d 
		ifTrue: [newAFf := FullMatrix rotationMatrixFromzDir: zDir xDir: xDir]
		ifFalse: 
			[yDir := aLightingRefFrame aAFf column: 2.
			newAFf := FullMatrix rotationMatrixFromzDir: zDir yDir: yDir].
	aLightingRefFrame aAFf: newAFf
]

{ #category : #accessing }
CADParallelLightingDialog >> zDirX [
	^zDirX
]

{ #category : #accessing }
CADParallelLightingDialog >> zDirY [
	^zDirY
]

{ #category : #accessing }
CADParallelLightingDialog >> zDirZ [
	^zDirZ
]
