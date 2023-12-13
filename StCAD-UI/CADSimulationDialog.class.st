Class {
	#name : #CADSimulationDialog,
	#superclass : #CADDialog,
	#instVars : [
		'systemSolver',
		'errorTolPosKine',
		'errorTolAccKine',
		'iterMaxPosKine',
		'iterMaxAccKine',
		'tstart',
		'hmin',
		'hmax',
		'tend',
		'hout',
		'corAbsTol',
		'corRelTol',
		'intAbsTol',
		'intRelTol',
		'iterMaxDyn',
		'orderMax'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADSimulationDialog class >> example1 [
	"CADSimulationDialog example1."

	| dummy dialogResponse |
	Transcript cr; show: 'CADSimulationDialog class example1.'.
	dummy := MbDSystemSolver2 new.
	dummy tstart: 0.0d.
	dummy tend: 1.0d.
	dummy hout: 0.1d.
	dummy hmin: 1.0d-9.
	dummy hmax: 1.0d.
	dummy errorTol: 1.0d-6.
	Transcript cr.
	Transcript show: '   tstart := ' , dummy tstart printString.
	Transcript show: '   tend := ' , dummy tend printString.
	Transcript show: '   hout := ' , dummy hout printString.
	Transcript show: '   hmin := ' , dummy hmin printString.
	Transcript show: '   hmax := ' , dummy hmax printString.
	Transcript show: '   errorTol := ' , dummy errorTol printString.
	dialogResponse := CADSimulationDialog openOn: dummy.
	Transcript cr; show: dialogResponse printString.
	Transcript cr.
	Transcript show: '   tstart := ' , dummy tstart printString.
	Transcript show: '   tend := ' , dummy tend printString.
	Transcript show: '   hout := ' , dummy hout printString.
	Transcript show: '   hmin := ' , dummy hmin printString.
	Transcript show: '   hmax := ' , dummy hmax printString.
	Transcript show: '   errorTol := ' , dummy errorTol printString
]

{ #category : #examples }
CADSimulationDialog class >> example2 [
	"CADSimulationDialog example2."

	| dummy dialogResponse |
	Transcript cr; show: 'CADSimulationDialog class example1.'.
	dummy := GEOSimulationData new.
	dummy tstart: 0.0d.
	dummy tend: 1.0d.
	dummy hout: 0.1d.
	dummy hmin: 1.0d-9.
	dummy hmax: 1.0d.
	dummy errorTol: 1.0d-6.
	Transcript cr.
	Transcript show: '   tstart := ' , dummy tstart printString.
	Transcript show: '   tend := ' , dummy tend printString.
	Transcript show: '   hout := ' , dummy hout printString.
	Transcript show: '   hmin := ' , dummy hmin printString.
	Transcript show: '   hmax := ' , dummy hmax printString.
	Transcript show: '   errorTol := ' , dummy errorTol printString.
	dialogResponse := CADSimulationDialog openOn: dummy.
	Transcript cr; show: dialogResponse printString.
	Transcript cr.
	Transcript show: '   tstart := ' , dummy tstart printString.
	Transcript show: '   tend := ' , dummy tend printString.
	Transcript show: '   hout := ' , dummy hout printString.
	Transcript show: '   hmin := ' , dummy hmin printString.
	Transcript show: '   hmax := ' , dummy hmax printString.
	Transcript show: '   errorTol := ' , dummy errorTol printString
]

{ #category : #'VisualWorks metadata' }
CADSimulationDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADSimulationDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Simulation                    CADSM'
	        #min: #( '#{VWQR:Core.Point}' 486 480 )
	        #max: #( '#{VWQR:Core.Point}' 486 480 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           518 308 1004 788 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 104 436 175 461 )
	              #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 212 436 283 461 )
	              #model: #reset #label: 'Reset' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 321 436 392 461 )
	              #model: #cancel #label: 'Cancel' #defaultable:
	              true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 89 60 ) #label: 'Start' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 198 54 378 89 )
	              #model: #tstart #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 404 60 ) #label: 's' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 89 104 ) #label: 'End' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 198 99 378 134 )
	              #model: #tend #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 404 104 ) #label: 's' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 89 193 ) #label: 'Output' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 198 187 378 222 )
	              #model: #hout #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 46 18 ) #label: 'Time' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 46 149 ) #label: 'Time Step' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 46 330 ) #label: 'Error Tolerance' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 89 238 ) #label: 'Minimum' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 198 232 378 267 )
	              #model: #hmin #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 89 283 ) #label: 'Maximum' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 198 277 378 312 )
	              #model: #hmax #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 404 193 ) #label: 's' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 404 238 ) #label: 's' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 404 283 ) #label: 's' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 198 369 378 404 )
	              #model: #intRelTol #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 89 375 ) #label: 'Global' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 198 18 ) #isOpaque: true #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	                    #yellow ) )
	              #label: 'CADSM: 3D CAD with Motion Simulation' ) ) ) )
]

{ #category : #accessing }
CADSimulationDialog >> hmax [
	^hmax
]

{ #category : #accessing }
CADSimulationDialog >> hmin [
	^hmin
]

{ #category : #accessing }
CADSimulationDialog >> hout [
	^hout
]

{ #category : #'initialize-release' }
CADSimulationDialog >> initialize [
	super initialize.
	systemSolver := nil asValue.
	tstart := self bufferedAdaptorFor: #tstart.
	tend := self bufferedAdaptorFor: #tend.
	hout := self bufferedAdaptorFor: #hout.
	hmin := self bufferedAdaptorFor: #hmin.
	hmax := self bufferedAdaptorFor: #hmax.
	intRelTol := self bufferedAdaptorFor: #errorTol
]

{ #category : #accessing }
CADSimulationDialog >> intRelTol [
	^intRelTol
]

{ #category : #accessing }
CADSimulationDialog >> subject [
	^systemSolver
]

{ #category : #accessing }
CADSimulationDialog >> tend [
	^tend
]

{ #category : #accessing }
CADSimulationDialog >> tstart [
	^tstart
]
