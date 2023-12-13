Class {
	#name : #CADMassMarkerDirectionDialog,
	#superclass : #CADFrameDirectionDialog,
	#instVars : [
		'mass',
		'aJppx',
		'aJppy',
		'aJppz',
		'density',
		'inputType'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'interface specs' }
CADMassMarkerDirectionDialog class >> massMarkerWindowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #massMarkerWindowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Position Principal Mass Frame in Part                 CADSM'
	        #min: #( '#{VWQR:Core.Point}' 640 480 )
	        #max: #( '#{VWQR:Core.Point}' 640 480 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           390 308 1030 788 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 341 118 )
	              #name: #Label1 #label: 'Jxx' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 341 149 ) #name: #Label2 #label: 'Jyy' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 341 180 ) #name: #Label3 #label: 'Jzz' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 368 76 ) #name: #Label4 #label: 'Principal Moments of Inertia'
	              #style: #default )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 0 224 640 480 )
	              #name: #Subcanvas1 #flags: 0 #minorKey: #windowSpec )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 327 29 ) #name: #Label5 #label: 'Mass' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 11 149 ) #name: #Label6 #label: 'Density' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 569 29 ) #name: #Label7 #label: 'kg' #style: #default )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.LabelSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 7 ) #name: #Label16 #label: 'kg m' #style:
	                    #default )
	                 #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                       34 0 ) #name: #Label17 #label: '2' #style:
	                    #pixelLarge ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    569 111 613 143 )
	                 #name: #Composite1 ) )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.LabelSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 7 ) #name: #Label18 #label: 'kg m' #style:
	                    #default )
	                 #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                       34 0 ) #name: #Label19 #label: '2' #style:
	                    #pixelLarge ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    569 142 613 174 )
	                 #name: #Composite2 ) )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.LabelSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 7 ) #name: #Label20 #label: 'kg m' #style:
	                    #default )
	                 #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                       34 0 ) #name: #Label21 #label: '2' #style:
	                    #pixelLarge ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    569 173 613 205 )
	                 #name: #Composite3 ) )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.LabelSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       0 7 ) #name: #Label22 #label: 'kg m' #style:
	                    #default )
	                 #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                       34 0 ) #name: #Label23 #label: '-3' #style:
	                    #pixelLarge ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    263 142 311 174 )
	                 #name: #Composite4 ) )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 77 35 )
	              #name: #RadioButton1 #model: #inputType #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #valueChangeSelector: #uniformDensitySelected
	                 #requestFocusInSelector: #hasSolidModel
	                 #requestFocusOutSelector: #hasSolidModel
	                 #requestValueChangeSelector:
	                 #hasSolidModel )
	              #tabable: false #label: 'Apply Uniform Density'
	              #select: #uniformDensity )
	           #( '#{VWQR:UI.RadioButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 77 66 )
	              #name: #RadioButton2 #model: #inputType #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #valueChangeSelector: #userSpecifySelected
	                 #requestFocusInSelector: #hasSolidModel
	                 #requestFocusOutSelector: #hasSolidModel
	                 #requestValueChangeSelector:
	                 #hasSolidModel )
	              #tabable: false #label: 'User Specify' #select:
	              #userSpecify )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 73 145 254 177 )
	              #name: #densityID #model: #density #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #valueChangeSelector: #densityChanged
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 378 25 559 57 )
	              #name: #massID #model: #mass #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 378 114 559 146 )
	              #name: #aJppxID #model: #aJppx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 378 145 559 177 )
	              #name: #aJppyID #model: #aJppy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 378 176 559 208 )
	              #name: #aJppzID #model: #aJppz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDoubleZeroAndGreater:
	                 #requestValueChangeSelector:
	                 #validateDoubleZeroAndGreater: )
	              #alignment: #right #style: #default #type: #number ) ) ) )
]

{ #category : #'VisualWorks metadata' }
CADMassMarkerDirectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> aJppx [
	^aJppx
]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> aJppy [
	^aJppy
]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> aJppz [
	^aJppz
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> adaptorInputType [
	| plugAdap geoMassMarker geoPart |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			geoMassMarker := model value.
			geoPart := geoMassMarker part.
			geoPart isCMtheCentriod
				ifTrue: 
					[self uniformDensitySelectedSwitches.
					#uniformDensity]
				ifFalse: 
					[self userSpecifySelectedSwitches.
					#userSpecify]]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> density [
	^density
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> densityChanged [
	| geoMassMarker geoPart den |
	geoMassMarker := geoItem value.
	geoPart := geoMassMarker part.
	den := density value.
	mass value: den * geoPart volume.
	aJppx value: den * (geoPart vJpp at: 1).
	aJppy value: den * (geoPart vJpp at: 2).
	aJppz value: den * (geoPart vJpp at: 3).
	rGfGx value: (geoPart rPcP at: 1).
	rGfGy value: (geoPart rPcP at: 2).
	rGfGz value: (geoPart rPcP at: 3).
	rfzptGx value: (geoPart aAPpv at: 1 and: 3).
	rfzptGy value: (geoPart aAPpv at: 2 and: 3).
	rfzptGz value: (geoPart aAPpv at: 3 and: 3).
	rfxptGx value: (geoPart aAPpv at: 1 and: 1).
	rfxptGy value: (geoPart aAPpv at: 2 and: 1).
	rfxptGz value: (geoPart aAPpv at: 3 and: 1)
]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> dialogTitle [
	^'Position Principal Mass Frame in Part                 CADSM'
]

{ #category : #testing }
CADMassMarkerDirectionDialog >> hasSolidModel [
	| aMassMarker answer |
	aMassMarker := geoItem value.
	answer := aMassMarker hasCentroid.
	answer 
		ifFalse: 
			[Dialog warn: #'The part does not have a solid' << #'StCAD.UI' expandMacros].
	^answer
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> initialize [
	super initialize.
	mass := self bufferedAdaptorFor: #mass.
	aJppx := self bufferedAdaptorFor: #aJppx.
	aJppy := self bufferedAdaptorFor: #aJppy.
	aJppz := self bufferedAdaptorFor: #aJppz.
	density := self bufferedAdaptorFor: #density.
	inputType := self adaptorInputType
]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> inputType [
	^inputType
]

{ #category : #accessing }
CADMassMarkerDirectionDialog >> mass [
	^mass
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> uniformDensitySelected [
	inputType value: #uniformDensity.
	self densityChanged.
	self uniformDensitySelectedSwitches
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> uniformDensitySelectedSwitches [
	(self builder componentAt: #densityID) enable.
	(self builder componentAt: #massID) disable.
	(self builder componentAt: #aJppxID) disable.
	(self builder componentAt: #aJppyID) disable.
	(self builder componentAt: #aJppzID) disable.
	(self builder componentAt: #rGfGxID) disable.
	(self builder componentAt: #rGfGyID) disable.
	(self builder componentAt: #rGfGzID) disable.
	(self builder componentAt: #rfzptGxID) disable.
	(self builder componentAt: #rfzptGyID) disable.
	(self builder componentAt: #rfzptGzID) disable.
	(self builder componentAt: #rfxptGxID) disable.
	(self builder componentAt: #rfxptGyID) disable.
	(self builder componentAt: #rfxptGzID) disable
]

{ #category : #private }
CADMassMarkerDirectionDialog >> updateDomainObjects [
	| geoMassMarker |
	super updateDomainObjects.
	geoMassMarker := geoItem value.
	geoMassMarker mass: mass value.
	geoMassMarker aJppx: aJppx value.
	geoMassMarker aJppy: aJppy value.
	geoMassMarker aJppz: aJppz value.
	geoMassMarker density: density value.
	geoMassMarker changed
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> userSpecifySelected [
	inputType value: #userSpecify.
	self userSpecifySelectedSwitches
]

{ #category : #'initialize-release' }
CADMassMarkerDirectionDialog >> userSpecifySelectedSwitches [
	(self builder componentAt: #densityID) disable.
	(self builder componentAt: #massID) enable.
	(self builder componentAt: #aJppxID) enable.
	(self builder componentAt: #aJppyID) enable.
	(self builder componentAt: #aJppzID) enable.
	(self builder componentAt: #rGfGxID) enable.
	(self builder componentAt: #rGfGyID) enable.
	(self builder componentAt: #rGfGzID) enable.
	(self builder componentAt: #rfzptGxID) enable.
	(self builder componentAt: #rfzptGyID) enable.
	(self builder componentAt: #rfzptGzID) enable.
	(self builder componentAt: #rfxptGxID) enable.
	(self builder componentAt: #rfxptGyID) enable.
	(self builder componentAt: #rfxptGzID) enable
]
