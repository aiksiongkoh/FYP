Class {
	#name : #CADMarkerVelocityDialog,
	#superclass : #CADDialog,
	#instVars : [
		'geoItem',
		'vOfOx',
		'vOfOy',
		'vOfOz',
		'omeOfOx',
		'omeOfOy',
		'omeOfOz'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'instance creation' }
CADMarkerVelocityDialog class >> openOn: geoMarker [ 
	geoMarker part notNil
		ifTrue: [super openOn: geoMarker]
		ifFalse: [Dialog warn: 'Only markers on parts can have velocities.']
]

{ #category : #'instance creation' }
CADMarkerVelocityDialog class >> openOn: geoMarker withSpec: aSymbol [ 
	geoMarker part notNil
		ifTrue: [super openOn: geoMarker withSpec: aSymbol]
		ifFalse: [Dialog warn: 'Only markers on parts can have velocities.']
]

{ #category : #'VisualWorks metadata' }
CADMarkerVelocityDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADMarkerVelocityDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Marker Velocity Dialog' #min: #( '#{VWQR:Core.Point}'
	           627 308 ) #max: #( '#{VWQR:Core.Point}'
	           627 308 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           397 384 1024 692 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 171 206 242 231 )
	              #model: #accept #label: 'OK' #style: #default #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 279 206 350 231 )
	              #model: #reset #label: 'Reset' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 388 206 459 231 )
	              #model: #cancel #label: 'Cancel' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 32 64 ) #label: 'X' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 60 60 241 92 )
	              #model: #vOfOx #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 31 95 ) #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 60 91 241 123 )
	              #model: #vOfOy #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 32 126 ) #label: 'Z' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 60 122 241 154 )
	              #model: #vOfOz #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 88 23 ) #label: 'Absolute Velocity'
	              #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 362 60 543 92 )
	              #model: #omeOfOx #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 362 91 543 123 )
	              #model: #omeOfOy #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 362 122 543 154 )
	              #model: #omeOfOz #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 361 23 ) #label: 'Absolute Angular Velocity'
	              #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 327 64 ) #label: 'X' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 326 95 ) #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 327 126 ) #label: 'Z' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 554 95 ) #label: 'deg/s' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 554 126 ) #label: 'deg/s' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 311 38 ) #label: 'World' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 38 ) #label: 'World' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 554 64 ) #label: 'deg/s' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 254 64 ) #label: 'm/s' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 254 126 ) #label: 'm/s' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 254 95 ) #label: 'm/s' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 68 166 ) #label: 'These velocities are converted to the corresponding part velocities.'
	              #style: #default )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -53 1 0 1.0 -21 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
CADMarkerVelocityDialog >> adaptoromeOfOat: i [ 
	| plugAdap geoMarker geoPartRefFrame omeOPO |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			geoMarker := model value.
			geoPartRefFrame := geoMarker part refFrame.
			omeOPO := geoPartRefFrame omeOfO.
			omeOPO isNil ifTrue: [omeOPO := (FullColumn zero: 3)].
			(omeOPO at: i) radiansToDegrees]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
CADMarkerVelocityDialog >> adaptorvOfOat: i [ 
	| plugAdap vOfO geoMarker geoMarkerRefFrame geoPartRefFrame vOPO omeOPO rPfO |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			geoMarker := model value.
			geoMarkerRefFrame := geoMarker refFrame.
			geoPartRefFrame := geoMarker part refFrame.
			vOPO := geoPartRefFrame vOfO.
			omeOPO := geoPartRefFrame omeOfO.
			vOPO isNil ifTrue: [vOPO := (FullColumn zero: 3)].
			omeOPO isNil ifTrue: [omeOPO := (FullColumn zero: 3)].
			rPfO := geoMarkerRefFrame rOfO - geoPartRefFrame rOfO.
			vOfO := vOPO + (omeOPO cross: rPfO).
			vOfO at: i]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #private }
CADMarkerVelocityDialog >> closeAccept [
	accept value ifTrue: [(self requestForWindowClose and: [self hasInputValid])
			ifTrue: 
				[self updateDomainObjects.
				close value: true.
				builder window checkForEvents]
			ifFalse: [accept value: false]]
]

{ #category : #private }
CADMarkerVelocityDialog >> hasInputValid [
	^true
]

{ #category : #'initialize-release' }
CADMarkerVelocityDialog >> initialize [
	super initialize.
	geoItem := nil asValue.
	vOfOx := self adaptorvOfOat: 1.
	vOfOy := self adaptorvOfOat: 2.
	vOfOz := self adaptorvOfOat: 3.
	omeOfOx := self adaptoromeOfOat: 1.
	omeOfOy := self adaptoromeOfOat: 2.
	omeOfOz := self adaptoromeOfOat: 3
]

{ #category : #accessing }
CADMarkerVelocityDialog >> omeOfOx [
	^omeOfOx
]

{ #category : #accessing }
CADMarkerVelocityDialog >> omeOfOy [
	^omeOfOy
]

{ #category : #accessing }
CADMarkerVelocityDialog >> omeOfOz [
	^omeOfOz
]

{ #category : #accessing }
CADMarkerVelocityDialog >> subject [
	^geoItem
]

{ #category : #private }
CADMarkerVelocityDialog >> updateDomainObjects [
	| vOfO omeOfO geoMarker geoMarkerRefFrame geoPartRefFrame rfPO vOPO |
	vOfO := FullColumn new: 3.
	vOfO at: 1 put: vOfOx value.
	vOfO at: 2 put: vOfOy value.
	vOfO at: 3 put: vOfOz value.
	omeOfO := FullColumn new: 3.
	omeOfO at: 1 put: omeOfOx value degreesToRadians.
	omeOfO at: 2 put: omeOfOy value degreesToRadians.
	omeOfO at: 3 put: omeOfOz value degreesToRadians.
	geoMarker := geoItem value.
	geoMarkerRefFrame := geoMarker refFrame.
	geoPartRefFrame := geoMarker part refFrame.
	rfPO := geoPartRefFrame rOfO - geoMarkerRefFrame rOfO.
	vOPO := vOfO + (omeOfO cross: rfPO).
	geoPartRefFrame vOfO: vOPO.
	geoPartRefFrame omeOfO: omeOfO
]

{ #category : #accessing }
CADMarkerVelocityDialog >> vOfOx [
	^vOfOx
]

{ #category : #accessing }
CADMarkerVelocityDialog >> vOfOy [
	^vOfOy
]

{ #category : #accessing }
CADMarkerVelocityDialog >> vOfOz [
	^vOfOz
]
