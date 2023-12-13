Class {
	#name : #CADCVCVDialog,
	#superclass : #CADDialog,
	#instVars : [
		'cvcv',
		'coeffRestitution'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADCVCVDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADCVCVDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Curve on Curve Dialog' #min: #( '#{VWQR:Core.Point}'
	           422 182 ) #max: #( '#{VWQR:Core.Point}'
	           422 182 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 934 566 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 42 27 )
	              #label: 'coeff. of restitution' #style: #default )
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
	                 197 24 378 55 )
	              #model: #coeffRestitution #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -54 1 0 1.0 -22 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
CADCVCVDialog >> coeffRestitution [
	^coeffRestitution
]

{ #category : #'initialize-release' }
CADCVCVDialog >> initialize [
	super initialize.
	cvcv := nil asValue.
	coeffRestitution := self bufferedAdaptorFor: #coeffRestitution
]

{ #category : #accessing }
CADCVCVDialog >> subject [
	^cvcv
]
