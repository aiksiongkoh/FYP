Class {
	#name : #CADGearDialog,
	#superclass : #CADDialog,
	#instVars : [
		'aGearJoint',
		'radiusI',
		'radiusJ'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADGearDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADGearDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Gear Joint Dialog' #min: #( '#{VWQR:Core.Point}'
	           422 182 ) #max: #( '#{VWQR:Core.Point}'
	           422 182 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 934 604 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 63 27 )
	              #label: 'Radius of gear I' #style: #default )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 70 122 141 147 )
	              #model: #accept #label: 'OK' #style: #default #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 178 122 249 147 )
	              #model: #reset #label: 'Reset' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 287 122 358 147 )
	              #model: #cancel #label: 'Cancel' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 184 24 365 55 )
	              #model: #radiusI #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -54 1 0 1.0 -22 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 63 71 ) #name: #Label1 #label: 'Radius of gear J'
	              #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 184 68 365 99 )
	              #name: #InputField1 #model: #radiusJ #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number ) ) ) )
]

{ #category : #'initialize-release' }
CADGearDialog >> initialize [
	super initialize.
	aGearJoint := nil asValue.
	radiusI := self bufferedAdaptorFor: #radiusI.
	radiusJ := self bufferedAdaptorFor: #radiusJ
]

{ #category : #accessing }
CADGearDialog >> radiusI [
	^radiusI
]

{ #category : #accessing }
CADGearDialog >> radiusJ [
	^radiusJ
]

{ #category : #accessing }
CADGearDialog >> subject [
	^aGearJoint
]
