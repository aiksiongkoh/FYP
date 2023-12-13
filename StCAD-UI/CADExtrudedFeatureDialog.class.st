Class {
	#name : #CADExtrudedFeatureDialog,
	#superclass : #CADDialog,
	#instVars : [
		'feature',
		'zStart',
		'zEnd'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADExtrudedFeatureDialog class >> example1 [
	"CADExtrudedFeatureDialog example1."

	| dummy dialogResponse |
	Transcript cr; show: 'CADExtrudedFeatureDialog class example1.'.
	dummy := GEOExtrudedFeature new.
	dummy zStart: 1.1111d.
	dummy zEnd: 5.5555555555d.
	Transcript cr; show: dummy printString.
	dialogResponse := CADExtrudedFeatureDialog openOn: dummy.
	Transcript cr; show: dialogResponse printString.
	Transcript cr; show: dummy printString
]

{ #category : #'VisualWorks metadata' }
CADExtrudedFeatureDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADExtrudedFeatureDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Extruded Feature' #min: #( '#{VWQR:Core.Point}'
	           318 240 ) #max: #( '#{VWQR:Core.Point}'
	           318 240 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 830 624 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 30 40 )
	              #label: 'zStart' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 39 107 ) #label: 'zEnd' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 109 35 289 70 )
	              #model: #zStart #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 109 102 289 137 )
	              #model: #zEnd #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 17 163 88 188 )
	              #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 125 163 196 188 )
	              #model: #reset #label: 'Reset' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 234 163 305 188 )
	              #model: #cancel #label: 'Cancel' #defaultable:
	              true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.9 0.5 0.5 )
	              #isOpaque: true #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	                    #yellow ) )
	              #label: 'CADSM' ) ) ) )
]

{ #category : #'initialize-release' }
CADExtrudedFeatureDialog >> initialize [
	super initialize.
	feature := nil asValue.
	zStart := self bufferedAdaptorFor: #zStart.
	zEnd := self bufferedAdaptorFor: #zEnd
]

{ #category : #accessing }
CADExtrudedFeatureDialog >> subject [
	^feature
]

{ #category : #accessing }
CADExtrudedFeatureDialog >> zEnd [
	^zEnd
]

{ #category : #accessing }
CADExtrudedFeatureDialog >> zStart [
	^zStart
]
