Class {
	#name : #CADXYZDialog,
	#superclass : #CADDialog,
	#instVars : [
		'xyz',
		'x',
		'y',
		'z'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADXYZDialog class >> example1 [
	"CADXYZDialog example1."

	| dummy dialogResponse |
	Transcript cr; show: 'CADXYZDialog class example1.'.
	dummy := Array
				with: 0.0d
				with: -9.81d
				with: 0.0d.
	Transcript cr; show: dummy printString.
	dialogResponse := CADXYZDialog openOn: dummy.
	Transcript cr; show: dialogResponse printString.
	Transcript cr; show: dummy printString
]

{ #category : #'VisualWorks metadata' }
CADXYZDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADXYZDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Shift xyz' #min: #( '#{VWQR:Core.Point}'
	           404 298 ) #max: #( '#{VWQR:Core.Point}'
	           404 298 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 916 682 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 61 232 132 257 )
	              #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 169 232 240 257 )
	              #model: #reset #label: 'Reset' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 278 232 349 257 )
	              #model: #cancel #label: 'Cancel' #defaultable:
	              true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 59 50 ) #label: 'x' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 106 45 286 80 )
	              #model: #x #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 326 50 ) #label: 'm' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 59 109 ) #label: 'y' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 106 104 286 139 )
	              #model: #y #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 326 109 ) #label: 'm' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 59 169 ) #label: 'z' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 106 164 286 199 )
	              #model: #z #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 326 169 ) #label: 'm' ) ) ) )
]

{ #category : #'initialize-release' }
CADXYZDialog >> initialize [
	super initialize.
	xyz := nil asValue.
	x := self bufferedAdaptorForIndex: 1.
	y := self bufferedAdaptorForIndex: 2.
	z := self bufferedAdaptorForIndex: 3
]

{ #category : #'initialize-release' }
CADXYZDialog >> subject [
	^xyz
]

{ #category : #accessing }
CADXYZDialog >> x [
	^x
]

{ #category : #accessing }
CADXYZDialog >> y [
	^y
]

{ #category : #accessing }
CADXYZDialog >> z [
	^z
]
