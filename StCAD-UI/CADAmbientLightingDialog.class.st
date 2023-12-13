Class {
	#name : #CADAmbientLightingDialog,
	#superclass : #CADLightingDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
CADAmbientLightingDialog class >> menuBar [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #nameKey: #menuExplainLightingID
	           #value: #menuExplainLighting ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADAmbientLightingDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADAmbientLightingDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Color Dialog' #min: #( '#{VWQR:Core.Point}'
	           369 212 ) #max: #( '#{VWQR:Core.Point}'
	           369 212 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           518 404 887 616 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.CompositeSpecCollection}'
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
	                       217 0 288 25 )
	                    #model: #cancel #label: 'Cancel' #style: #default
	                    #defaultable: true ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    41 145 329 170 )
	                 #name: #Composite1 ) )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 -122 0.6 0 0 118 0.6 130 0 )
	              #name: #aJunColorChoiceHSBID #flags: 0 #majorKey:
	              '#{VWQR:Jun.JunColorChoiceHSB}'
	              #minorKey: #windowSpec #clientKey: #aJunColorChoiceHSB )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.RadioButtonSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 0 ) #name: #RadioButton1 #model: #isOn #label:
	                    'On' #select: true )
	                 #( '#{VWQR:UI.RadioButtonSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 39 ) #name: #RadioButton2 #model: #isOn
	                    #label: 'Off' #select: false ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    29 35 74 95 )
	                 #name: #Composite2 ) ) ) ) )
]
