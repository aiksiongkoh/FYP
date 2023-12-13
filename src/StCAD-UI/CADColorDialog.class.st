Class {
	#name : #CADColorDialog,
	#superclass : #CADDialog,
	#instVars : [
		'aJunColor',
		'color'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADColorDialog class >> example1 [
	"CADColorDialog example1."

	"DANGER: ColorWhite white returns a shared variable. So changing it can mess the whole color system."

	| dummy dialogResponse |
	self toTranscriptShow: 'CADColorDialog class example1.'.
	dummy := ColorValue white copy.
	self toTranscriptShow: dummy.
	dialogResponse := CADColorDialog openOn: dummy.
	self toTranscriptShow: dialogResponse.
	self toTranscriptShow: dummy
]

{ #category : #resources }
CADColorDialog class >> menuBar [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #nameKey: #menuExplainColorID
	           #value: #menuExplainColor ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'instance creation' }
CADColorDialog class >> openOn: object [ 
	| newDialog |
	newDialog := super new.
	newDialog subject value: object.
	newDialog aJunColor color: object.
	^newDialog openInterface
]

{ #category : #'VisualWorks metadata' }
CADColorDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADColorDialog class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Color Dialog' #min: #( '#{VWQR:Core.Point}'
	           309 212 ) #max: #( '#{VWQR:Core.Point}'
	           309 212 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           518 404 827 616 )
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
	                    11 145 299 170 )
	                 #name: #Composite1 ) )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 -120 0.5 0 0 120 0.5 130 0 )
	              #name: #aJunColorID #flags: 0 #majorKey: '#{VWQR:Jun.JunColorChoiceHSB}'
	              #minorKey: #windowSpec #clientKey: #aJunColor ) ) ) )
]

{ #category : #accessing }
CADColorDialog >> aJunColor [
	^aJunColor
]

{ #category : #accessing }
CADColorDialog >> aJunColor: anObject [
	aJunColor := anObject
]

{ #category : #private }
CADColorDialog >> closeAccept [
	accept value 
		ifTrue: 
			[(self requestForWindowClose and: [self hasInputValid]) 
				ifTrue: 
					[self updateDomainObjects.
					close value: true.
					builder window checkForEvents]
				ifFalse: [accept value: false]]
]

{ #category : #private }
CADColorDialog >> hasInputValid [
	^true
]

{ #category : #'initialize-release' }
CADColorDialog >> initialize [
	super initialize.
	aJunColor := JunColorChoiceHSB new.
	color := nil asValue
]

{ #category : #'menu items' }
CADColorDialog >> menuExplainColor [
	| labelString |
	labelString := 'Explain Color Dialog'.
	self openExplainFile: 'StCADColorDialogMenuExplain.sdoc' label: labelString
]

{ #category : #'initialize-release' }
CADColorDialog >> reset [
	| cadColor |
	cadColor := color value.
	aJunColor color: cadColor
]

{ #category : #accessing }
CADColorDialog >> subject [
	^color
]

{ #category : #private }
CADColorDialog >> updateDomainObjects [
	| cadColor selectedColor |
	cadColor := color value.
	selectedColor := aJunColor color.
	cadColor 
		setRed: selectedColor scaledRed
		setGreen: selectedColor scaledGreen
		setBlue: selectedColor scaledBlue
]
