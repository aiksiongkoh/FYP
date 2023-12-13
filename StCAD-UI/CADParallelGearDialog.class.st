Class {
	#name : #CADParallelGearDialog,
	#superclass : #CADDialog,
	#instVars : [
		'aParallelGearJoint',
		'ratio'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADParallelGearDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADParallelGearDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Parallel Gear Joint Dialog'
	        #min: #( '#{VWQR:Core.Point}' 422 182 )
	        #max: #( '#{VWQR:Core.Point}' 422 182 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 934 566 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 63 27 )
	              #label: 'Gear ratio of I to J' #style: #default )
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
	                 184 24 365 55 )
	              #model: #ratio #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -54 1 0 1.0 -22 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #'initialize-release' }
CADParallelGearDialog >> initialize [
	super initialize.
	aParallelGearJoint := nil asValue.
	ratio := self bufferedAdaptorFor: #ratio
]

{ #category : #accessing }
CADParallelGearDialog >> ratio [
	^ratio
]

{ #category : #accessing }
CADParallelGearDialog >> subject [
	^aParallelGearJoint
]
