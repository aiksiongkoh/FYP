Class {
	#name : #CADRotateMarkerDialog,
	#superclass : #CADDialog,
	#instVars : [
		'array',
		'axis',
		'theta'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADRotateMarkerDialog class >> example1 [
	"CADRotateMarkerDialog example1."

	| dummy dialogResponse |
	Transcript cr; show: 'CADRotateMarkerDialog class example1.'.
	dummy := Array with: 3 with: 90.0d.
	Transcript cr; show: dummy printString.
	dialogResponse := CADRotateMarkerDialog openOn: dummy.
	Transcript cr; show: dialogResponse printString.
	Transcript cr; show: dummy printString
]

{ #category : #'VisualWorks metadata' }
CADRotateMarkerDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADRotateMarkerDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Rotate Marker' #min: #( '#{VWQR:Core.Point}'
	           427 260 ) #max: #( '#{VWQR:Core.Point}'
	           427 260 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 939 644 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 68 44 )
	              #model: #axis #tabable: false #label: 'x' #select:
	              #x )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 199 44 )
	              #model: #axis #tabable: false #label: 'y' #select:
	              #y )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 329 44 )
	              #model: #axis #tabable: false #label: 'z' #select:
	              #z )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 40 104 ) #label: 'Angle' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 113 99 293 134 )
	              #model: #theta #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 315 104 ) #label: 'degrees' )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 69 166 140 191 )
	              #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 177 166 248 191 )
	              #model: #reset #label: 'Reset' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 286 166 357 191 )
	              #model: #cancel #label: 'Cancel' #defaultable:
	              true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -50 1 0 1 -18 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
CADRotateMarkerDialog >> axis [
	^axis
]

{ #category : #'initialize-release' }
CADRotateMarkerDialog >> initialize [
	| plugAdap |
	super initialize.
	array := nil asValue.
	theta := self bufferedAdaptorForIndex: 2.
	plugAdap := PluggableAdaptor on: array.
	plugAdap
		getBlock: 
			[:model | 
			| iaxis |
			iaxis := model value at: 1.
			iaxis == 1
				ifTrue: [#x]
				ifFalse: [iaxis == 2
						ifTrue: [#y]
						ifFalse: [iaxis == 3
								ifTrue: [#z]
								ifFalse: [self error]]]]
		putBlock: 
			[:model :value | 
			| iaxis |
			iaxis := value == #x
						ifTrue: [1]
						ifFalse: [value == #y
								ifTrue: [2]
								ifFalse: [value == #z
										ifTrue: [3]
										ifFalse: [self error]]].
			model value at: 1 put: iaxis]
		updateBlock: [:model :aspect :parameter | false].
	axis := BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
CADRotateMarkerDialog >> subject [
	^array
]

{ #category : #accessing }
CADRotateMarkerDialog >> theta [
	^theta
]
