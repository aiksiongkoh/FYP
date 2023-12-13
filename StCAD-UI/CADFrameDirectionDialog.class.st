Class {
	#name : #CADFrameDirectionDialog,
	#superclass : #CADCartesianFrameDialog2,
	#instVars : [
		'rfzptGx',
		'rfzptGy',
		'rfzptGz',
		'rfxptGx',
		'rfxptGy',
		'rfxptGz'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'VisualWorks metadata' }
CADFrameDirectionDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADFrameDirectionDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'dialogTitle' #min: #( '#{VWQR:Core.Point}'
	           640 256 ) #max: #( '#{VWQR:Core.Point}'
	           640 256 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           390 404 1030 660 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 12 50 )
	              #name: #Label1 #label: 'X' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 11 85 ) #name: #Label2 #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 12 116 ) #name: #Label3 #label: 'Z' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 40 47 221 79 )
	              #name: #rGfGxID #model: #rGfGx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 40 78 221 110 )
	              #name: #rGfGyID #model: #rGfGy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 40 109 221 141 )
	              #name: #rGfGzID #model: #rGfGz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 108 9 ) #name: #Label4 #label: 'Origin' #style:
	              #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 236 47 417 79 )
	              #name: #rfzptGxID #model: #rfzptGx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 236 78 417 110 )
	              #name: #rfzptGyID #model: #rfzptGy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 236 109 417 141 )
	              #name: #rfzptGzID #model: #rfzptGz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 272 9 ) #name: #Label5 #label: 'Direction of z axis'
	              #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 432 47 613 79 )
	              #name: #rfxptGxID #model: #rfxptGx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 432 78 613 110 )
	              #name: #rfxptGyID #model: #rfxptGy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 432 109 613 141 )
	              #name: #rfxptGzID #model: #rfxptGz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.296651 0 0.675889 0.5 0.5 )
	              #name: #ActionButton1 #model: #accept #label: 'OK' #style:
	              #default #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.500797 0 0.675889 0.5 0.5 )
	              #name: #ActionButton2 #model: #reset #label: 'Reset'
	              #style: #default #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.706539 0 0.675889 0.5 0.5 )
	              #name: #ActionButton3 #model: #cancel #label: 'Cancel'
	              #style: #default #defaultable: true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -51 1 0 1.0 -19 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton )
	           #( '#{VWQR:UI.CompositeSpecCollection}'
	              #collection: #( #( '#{VWQR:UI.LabelSpec}'
	                    #layout: #( '#{VWQR:Core.Point}'
	                       6 0 ) #name: #Label7 #label: 'Direction of x axis or'
	                    #style: #default )
	                 #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                       0 17 ) #name: #Label8 #label: 'any vector in x-z plane'
	                    #style: #default ) )
	              #compositeSpec: #( '#{VWQR:UI.CompositeSpec}'
	                 #layout: #( '#{VWQR:Graphics.Rectangle}'
	                    454 2 594 40 )
	                 #name: #Composite1 ) ) ) ) )
]

{ #category : #accessing }
CADFrameDirectionDialog >> adaptorrfxptGat: i [ 
	| plugAdap rfx1O rfx1G |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			rfx1O := refFrame value aAOf column: 1.
			rfx1G := guideFrame value aAOf transpose timesFullColumn: rfx1O.
			rfx1G at: i]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
CADFrameDirectionDialog >> adaptorrfzptGat: i [ 
	| plugAdap rfz1O rfz1G |
	plugAdap := PluggableAdaptor on: geoItem.
	plugAdap
		getBlock: 
			[:model | 
			rfz1O := refFrame value aAOf column: 3.
			rfz1G := guideFrame value aAOf transpose timesFullColumn: rfz1O.
			rfz1G at: i]
		putBlock: [:model :value | ]
		updateBlock: [:model :aspect :parameter | false].
	^BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger
]

{ #category : #accessing }
CADFrameDirectionDialog >> dialogTitle [
	^'Cartesian Frame Dialog'
]

{ #category : #private }
CADFrameDirectionDialog >> hasInputValid [
	| rfzptG rfxptG rfzpt rfxpt |
	rfzptGx myDependents notNil
		ifTrue: 
			[rfzptG := FullColumn new: 3.
			rfxptG := FullColumn new: 3.
			rfzptG at: 1 put: rfzptGx value.
			rfzptG at: 2 put: rfzptGy value.
			rfzptG at: 3 put: rfzptGz value.
			rfxptG at: 1 put: rfxptGx value.
			rfxptG at: 2 put: rfxptGy value.
			rfxptG at: 3 put: rfxptGz value.
			rfzpt := rfzptG length.
			rfzpt < 1.0d-6
				ifTrue: 
					[Dialog warn: 'Point on the z axis almost coincides with the origin.'.
					^false].
			rfxpt := rfxptG length.
			rfxpt < 1.0d-6
				ifTrue: 
					[Dialog warn: 'Point on the x-z plane almost coincides with the origin.'.
					^false].
			((rfzptG cross: rfxptG) length / (rfzpt * rfxpt)) modifiedArcSin < 0.1d
				ifTrue: 
					[Dialog warn: 'Vector on the x-z plane is almost parallel with z axis.'.
					^false]].
	^true
]

{ #category : #'initialize-release' }
CADFrameDirectionDialog >> initialize [
	super initialize.
	rfzptGx := self adaptorrfzptGat: 1.
	rfzptGy := self adaptorrfzptGat: 2.
	rfzptGz := self adaptorrfzptGat: 3.
	rfxptGx := self adaptorrfxptGat: 1.
	rfxptGy := self adaptorrfxptGat: 2.
	rfxptGz := self adaptorrfxptGat: 3
]

{ #category : #accessing }
CADFrameDirectionDialog >> rfxptGx [
	^rfxptGx
]

{ #category : #accessing }
CADFrameDirectionDialog >> rfxptGy [
	^rfxptGy
]

{ #category : #accessing }
CADFrameDirectionDialog >> rfxptGz [
	^rfxptGz
]

{ #category : #accessing }
CADFrameDirectionDialog >> rfzptGx [
	^rfzptGx
]

{ #category : #accessing }
CADFrameDirectionDialog >> rfzptGy [
	^rfzptGy
]

{ #category : #accessing }
CADFrameDirectionDialog >> rfzptGz [
	^rfzptGz
]

{ #category : #private }
CADFrameDirectionDialog >> updateDomainObjects [
	| rGfG rfzptG rfxptG refFrameValue guideFrameValue |
	rGfG := FullColumn new: 3.
	rGfG at: 1 put: rGfGx value.
	rGfG at: 2 put: rGfGy value.
	rGfG at: 3 put: rGfGz value.
	rfzptG := FullColumn new: 3.
	rfxptG := FullColumn new: 3.
	rfzptG at: 1 put: rfzptGx value.
	rfzptG at: 2 put: rfzptGy value.
	rfzptG at: 3 put: rfzptGz value.
	rfxptG at: 1 put: rfxptGx value.
	rfxptG at: 2 put: rfxptGy value.
	rfxptG at: 3 put: rfxptGz value.
	refFrameValue := refFrame value.
	guideFrameValue := guideFrame value.
	refFrameValue storeMemento: refFrameValue positionMemento for: refFrameValue.
	refFrameValue
		refFrame: refFrameValue refFrame
		rFfF: (refFrameValue rFpFfromrOpO: (guideFrameValue rOpOfromrfpf: rGfG))
		zPoint: (refFrameValue rFpFfromrOpO: (guideFrameValue rOpOfromrfpf: rGfG + rfzptG))
		xPoint: (refFrameValue rFpFfromrOpO: (guideFrameValue rOpOfromrfpf: rGfG + rfxptG))
]
