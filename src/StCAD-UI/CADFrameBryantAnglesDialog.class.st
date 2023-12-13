Class {
	#name : #CADFrameBryantAnglesDialog,
	#superclass : #CADCartesianFrameDialog2,
	#instVars : [
		'the1fx',
		'the2fy',
		'the3fz'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADFrameBryantAnglesDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADFrameBryantAnglesDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Cartesian Frame Dialog' #min: #( '#{VWQR:Core.Point}'
	           640 256 ) #max: #( '#{VWQR:Core.Point}'
	           640 256 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 384 1024 640 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 118 9 )
	              #name: #Label4 #label: 'Origin' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 22 51 ) #name: #Label1 #label: 'X' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 21 82 ) #name: #Label2 #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 22 113 ) #name: #Label3 #label: 'Z' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 50 47 231 79 )
	              #name: #rGfGxID #model: #rGfGx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 50 78 231 110 )
	              #name: #rGfGyID #model: #rGfGy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 50 109 231 141 )
	              #name: #rGfGzID #model: #rGfGz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 415 9 ) #name: #Label5 #label: 'Rotation Sequence'
	              #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 332 51 ) #name: #Label7 #label: 'about x' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 332 82 ) #name: #Label8 #label: 'about y' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 332 113 ) #name: #Label9 #label: 'about z' #style:
	              #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 394 47 575 79 )
	              #name: #the1fxID #model: #the1fx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 394 78 575 110 )
	              #name: #the2fyID #model: #the2fy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 394 109 575 141 )
	              #name: #the3fzID #model: #the3fz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 589 51 ) #name: #Label10 #label: 'deg' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 589 82 ) #name: #Label11 #label: 'deg' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 589 113 ) #name: #Label12 #label: 'deg' #style:
	              #default )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.325 0 0.675781 0.5 0.5 )
	              #name: #ActionButton1 #model: #accept #label: 'OK' #style:
	              #default #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 0 0.675781 0.5 0.5 )
	              #name: #ActionButton2 #model: #reset #label: 'Reset'
	              #style: #default #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.675 0 0.675781 0.5 0.5 )
	              #name: #ActionButton3 #model: #cancel #label: 'Cancel'
	              #style: #default #defaultable: true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -50 1 0 1.0 -18 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #accessing }
CADFrameBryantAnglesDialog >> adaptorBryantAnglesAt: i [ 
	| plugAdap aAGf |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			aAGf := guideFrame value aAOf transpose timesFullMatrix: refFrame value aAOf.
			(aAGf bryantAngles at: i) radiansToDegrees]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #private }
CADFrameBryantAnglesDialog >> hasInputValid [
	^true
]

{ #category : #'initialize-release' }
CADFrameBryantAnglesDialog >> initialize [
	super initialize.
	the1fx := self adaptorBryantAnglesAt: 1.
	the2fy := self adaptorBryantAnglesAt: 2.
	the3fz := self adaptorBryantAnglesAt: 3
]

{ #category : #accessing }
CADFrameBryantAnglesDialog >> the1fx [
	^the1fx
]

{ #category : #accessing }
CADFrameBryantAnglesDialog >> the2fy [
	^the2fy
]

{ #category : #accessing }
CADFrameBryantAnglesDialog >> the3fz [
	^the3fz
]

{ #category : #private }
CADFrameBryantAnglesDialog >> updateDomainObjects [
	| rGfG refFrameValue guideFrameValue eulerAnglesxyz aAGf aAOf aAFf |
	rGfG := FullColumn new: 3.
	rGfG at: 1 put: rGfGx value.
	rGfG at: 2 put: rGfGy value.
	rGfG at: 3 put: rGfGz value.
	eulerAnglesxyz := GEOEulerAnglesxyz new.
	eulerAnglesxyz at: 1 put: the1fx value degreesToRadians.
	eulerAnglesxyz at: 2 put: the2fy value degreesToRadians.
	eulerAnglesxyz at: 3 put: the3fz value degreesToRadians.
	refFrameValue := refFrame value.
	guideFrameValue := guideFrame value.
	refFrameValue storeMemento: refFrameValue positionMemento for: refFrameValue.
	aAGf := eulerAnglesxyz aA.
	aAOf := guideFrameValue aAOf timesFullMatrix: aAGf.
	aAFf := refFrameValue aAOF transpose timesFullMatrix: aAOf.
	refFrameValue
		refFrame: refFrameValue refFrame
		rFfF: (refFrameValue rFpFfromrOpO: (guideFrameValue rOpOfromrfpf: rGfG))
		aAFf: aAFf
]
