Class {
	#name : #CADRectangleDialog,
	#superclass : #CADFrameBryantAnglesDialog,
	#instVars : [
		'xLength',
		'yLength'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADRectangleDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADRectangleDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Rectangle Graphic Dialog                             CADSM'
	        #min: #( '#{VWQR:Core.Point}' 627 293 )
	        #max: #( '#{VWQR:Core.Point}' 627 293 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           397 384 1024 677 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 182 188 253 213 )
	              #model: #accept #label: 'OK' #style: #default #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 290 188 361 213 )
	              #model: #reset #label: 'Reset' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 399 188 470 213 )
	              #model: #cancel #label: 'Cancel' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 55 51 ) #label: 'X' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 83 47 264 79 )
	              #name: #rGfGxID #model: #rGfGx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 54 82 ) #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 83 78 264 110 )
	              #name: #rGfGyID #model: #rGfGy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 151 10 ) #label: 'Origin' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 262 131 443 163 )
	              #name: #the3fzID #model: #the3fz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 134 135 ) #label: 'Rotation about Z'
	              #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 457 135 ) #label: 'deg' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 346 51 ) #label: 'X' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 374 47 555 79 )
	              #name: #xLengthID #model: #xLength #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 346 82 ) #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 374 78 555 110 )
	              #name: #yLengthID #model: #yLength #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 442 10 ) #label: 'Length' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 271 51 ) #label: 'm' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 271 82 ) #label: 'm' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 564 51 ) #label: 'm' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 564 82 ) #label: 'm' #style: #default )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -56 1 0 1.0 -24 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
CADRectangleDialog >> dialogTitle [
	^'Position Marker in its GuideFrame                           CADSM'
]

{ #category : #'initialize-release' }
CADRectangleDialog >> initialize [
	super initialize.
	xLength := self bufferedAdaptorFor: #xLength.
	yLength := self bufferedAdaptorFor: #yLength
]

{ #category : #private }
CADRectangleDialog >> updateDomainObjects [
	| geoRectangle |
	super updateDomainObjects.
	geoRectangle := geoItem value.
	geoRectangle xLength: xLength value.
	geoRectangle yLength: yLength value.
	geoRectangle changed
]

{ #category : #accessing }
CADRectangleDialog >> xLength [
	^xLength
]

{ #category : #accessing }
CADRectangleDialog >> yLength [
	^yLength
]
