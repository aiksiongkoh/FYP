Class {
	#name : #CADAngleDialog,
	#superclass : #CADDialog,
	#instVars : [
		'aAngleJoint',
		'theIzJz'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADAngleDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADAngleDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Angle Joint Dialog' #min: #( '#{VWQR:Core.Point}'
	           422 182 ) #max: #( '#{VWQR:Core.Point}'
	           422 182 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 934 566 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 34 27 )
	              #label: 'angle from Iz to Jz' #style: #default )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 70 79 141 104 )
	              #model: #accept #label: 'OK' #style: #default #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 178 79 249 104 )
	              #model: #reset #label: 'Reset' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 287 79 358 104 )
	              #model: #cancel #label: 'Cancel' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 158 24 339 55 )
	              #model: #theIzJz #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -54 1 0 1.0 -22 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 353 29 ) #name: #Label1 #label: 'deg' ) ) ) )
]

{ #category : #accessing }
CADAngleDialog >> adaptorDegrees [
	| plugAdap |
	plugAdap := PluggableAdaptor on: self subject.
	plugAdap 
		getBlock: [:model | model value theIzJz radiansToDegrees]
		putBlock: [:model :value | model value theIzJz: value degreesToRadians]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
CADAngleDialog >> angle [
	^theIzJz
]

{ #category : #'initialize-release' }
CADAngleDialog >> initialize [
	super initialize.
	aAngleJoint := nil asValue.
	theIzJz := self adaptorDegrees
]

{ #category : #accessing }
CADAngleDialog >> subject [
	^aAngleJoint
]

{ #category : #accessing }
CADAngleDialog >> theIzJz [
	^theIzJz
]
