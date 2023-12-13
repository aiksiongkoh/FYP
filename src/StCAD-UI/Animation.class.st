Class {
	#name : #Animation,
	#superclass : #ApplicationModel,
	#instVars : [
		'cadInterface',
		'timeSeries',
		'animationData',
		'icurrent',
		'istart',
		'iend',
		'tcurrent',
		'tstart',
		'tend',
		'speed',
		'animationProcess'
	],
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #resources }
Animation class >> directionMenu [
	"MenuEditor new openOnClass: self andSelector: #directionMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Forward' 
				#nameKey: #menuDirectionForwardID 
				#value: #menuDirectionForward 
				#indication: true ) 
			#(#MenuItem 
				#rawLabel: 'Backward' 
				#nameKey: #menuDirectionBackwardID 
				#value: #menuDirectionBackward 
				#indication: true ) ) #(2 ) nil ) decodeAsLiteralArray
]

{ #category : #resources }
Animation class >> frameMenu [
	"MenuEditor new openOnClass: self andSelector: #frameMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Input State' 
				#value: #menuFrameInputState ) 
			#(#MenuItem 
				#rawLabel: 'First' 
				#value: #menuFrameFirst ) 
			#(#MenuItem 
				#rawLabel: 'Last' 
				#value: #menuFrameLast ) ) #(3 ) nil ) decodeAsLiteralArray
]

{ #category : #'instance creation' }
Animation class >> openOn: cadInterface [ 
	| newDialog |
	^(cadInterface geoRootItem notNil and: 
			[cadInterface timeSeries notNil and: [cadInterface timeSeries isEmpty not]]) 
		ifTrue: 
			[newDialog := super new.
			newDialog cadInterface: cadInterface.
			newDialog open]
		ifFalse: 
			[Dialog warn: 'Assembly has no simulation data.'.
			nil]
]

{ #category : #'VisualWorks metadata' }
Animation class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
Animation class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Animation                              Sponsor Logo'
	        #min: #( '#{VWQR:Core.Point}' 438 155 )
	        #max: #( '#{VWQR:Core.Point}' 438 155 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 950 539 )
	        #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.LabelSpec}'
	              #layout: #( '#{VWQR:Core.Point}' 16 58 )
	              #name: #Label1 #label: 'Start' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 82 ) #name: #Label2 #label: 'End' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 251 5 ) #name: #Label3 #label: 'Time' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 16 34 ) #name: #Label4 #label: 'Current' #style:
	              #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 372 5 ) #name: #Label5 #label: 'Speed' #style:
	              #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 77 34 139 59 )
	              #name: #icurrentID #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	                    #white ) )
	              #model: #icurrent #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateRange:
	                 #requestValueChangeSelector:
	                 #validateRange: )
	              #alignment: #right #style: #default #type: #number
	              #formatString: '0' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 77 58 139 83 )
	              #name: #InputField1 #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	                    #white ) )
	              #model: #istart #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateRange:
	                 #requestValueChangeSelector:
	                 #validateRange: )
	              #alignment: #right #style: #default #type: #number
	              #formatString: '0' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 77 82 139 107 )
	              #name: #InputField2 #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	                    #white ) )
	              #model: #iend #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateRange:
	                 #requestValueChangeSelector:
	                 #validateRange: )
	              #alignment: #right #style: #default #type: #number
	              #formatString: '0' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 139 34 288 59 )
	              #name: #InputField3 #model: #tcurrent #alignment:
	              #right #style: #default #isReadOnly: true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 139 58 288 83 )
	              #name: #InputField4 #model: #tstart #alignment:
	              #right #style: #default #isReadOnly: true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 139 82 288 107 )
	              #name: #InputField5 #model: #tend #alignment:
	              #right #style: #default #isReadOnly: true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 359 33 421 58 )
	              #name: #InputField6 #flags: 0 #model: #speed #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateSpeed:
	                 #requestValueChangeSelector:
	                 #validateSpeed: )
	              #alignment: #right #style: #default #type: #number
	              #formatString: '0' )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 77 5 139 30 )
	              #name: #ActionButton1 #model: #frameAction #label:
	              'Frame' #style: #default #isDefault: false #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 297 34 359 59 )
	              #name: #ActionButton2 #model: #play #label: 'Play'
	              #style: #default #isDefault: false #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 297 58 359 83 )
	              #name: #ActionButton3 #model: #stop #label: 'Stop'
	              #style: #default #isDefault: false #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 297 82 359 107 )
	              #name: #ActionButton4 #model: #step #label: 'Step'
	              #style: #default #isDefault: false #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 359 82 421 107 )
	              #name: #ActionButton5 #model: #directionAction
	              #label: 'Direction' #style: #default #isDefault:
	              false #defaultable: true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -38 1 0 1 -6 1 )
	              #name: #adButtonID #flags: 0 #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	                    #black ) )
	              #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #ad }
Animation >> adOpportunity [
	super adOpportunity.
	cadInterface cadApp adOpportunity
]

{ #category : #accessing }
Animation >> cadInterface: interface [ 
	cadInterface := interface.
	timeSeries := cadInterface timeSeries.
	animationData value: cadInterface animationData
]

{ #category : #accessing }
Animation >> calctcurrent [
	| i |
	i := icurrent value.
	^i > 0
		ifTrue: [(timeSeries at: i) printString]
		ifFalse: [animationProcess == nil
				ifTrue: ['Input State']
				ifFalse: ['Animating']]
]

{ #category : #accessing }
Animation >> calctcurrent: string [ 
	"Do nothing."
]

{ #category : #accessing }
Animation >> calctend [
	^(timeSeries at: iend value) printString
]

{ #category : #accessing }
Animation >> calctend: string [ 
	"Do nothing."
]

{ #category : #accessing }
Animation >> calctstart [
	^(timeSeries at: istart value) printString
]

{ #category : #accessing }
Animation >> calctstart: string [ 
	"Do nothing."
]

{ #category : #ad }
Animation >> changeAdTitle [
	self builder window label: 'CADSM Animation' , '          ' , self adTitle
]

{ #category : #'initialize-release' }
Animation >> changeRequest [
	^super changeRequest and: [animationProcess notNil
			ifTrue: 
				[Dialog warn: 'Stop animation before closing.' for: builder window.
				false]
			ifFalse: [true]]
]

{ #category : #change }
Animation >> changedicurrent [
	| i |
	self adOpportunity.
	self updatetcurrent.
	i := icurrent value.
	i > 0 ifTrue: [(cadInterface canUpdateForFrame: i)
			ifTrue: [cadInterface updateForFrame: i]
			ifFalse: [Dialog warn: 'At least one part does not belong to this simulation.']]
]

{ #category : #change }
Animation >> changediend [
	self updatetend
]

{ #category : #change }
Animation >> changedistart [
	self updatetstart
]

{ #category : #actions }
Animation >> directionAction [
	| menu symbol |
	menu := self class directionMenu.
	animationData value isForward
		ifTrue: 
			[(menu atNameKey: #menuDirectionForwardID) beOn.
			(menu atNameKey: #menuDirectionBackwardID) beOff]
		ifFalse: 
			[(menu atNameKey: #menuDirectionForwardID) beOff.
			(menu atNameKey: #menuDirectionBackwardID) beOn].
	symbol := menu startUp.
	symbol isSymbol ifTrue: [self perform: symbol]
]

{ #category : #actions }
Animation >> frameAction [
	| menu symbol |
	menu := self class frameMenu.
	symbol := menu startUp.
	symbol isSymbol ifTrue: [self perform: symbol]
]

{ #category : #accessing }
Animation >> icurrent [
	^icurrent
]

{ #category : #accessing }
Animation >> iend [
	^iend
]

{ #category : #'initialize-release' }
Animation >> initialize [
	super initialize.
	animationData := nil asValue.
	icurrent := self adaptorFor: #icurrent.
	istart := self adaptorFor: #istart.
	iend := self adaptorFor: #iend.
	tcurrent := (AspectAdaptor subject: self)
				forAspect: #calctcurrent.
	tstart := (AspectAdaptor subject: self)
				forAspect: #calctstart.
	tend := (AspectAdaptor subject: self)
				forAspect: #calctend.
	speed := self adaptorFor: #framesPerSecond
]

{ #category : #testing }
Animation >> isUpToDate [
	^cadInterface timeSeries notNil
		ifTrue: 
			[animationData value == cadInterface animationData
				ifFalse: 
					[timeSeries := cadInterface timeSeries.
					animationData value: cadInterface animationData].
			true]
		ifFalse: 
			[Dialog warn: 'Assembly has no simulation data.'.
			self closeAndUnschedule.
			false]
]

{ #category : #accessing }
Animation >> istart [
	^istart
]

{ #category : #actions }
Animation >> menuDirectionBackward [
	animationData value isForward: false
]

{ #category : #actions }
Animation >> menuDirectionForward [
	animationData value isForward: true
]

{ #category : #'menu items' }
Animation >> menuFrameFirst [
	self isUpToDate ifTrue: [icurrent value: 1]
]

{ #category : #'menu items' }
Animation >> menuFrameInputState [
	self isUpToDate
		ifTrue: 
			[icurrent value: 0.
			cadInterface updateFromInputState]
]

{ #category : #'menu items' }
Animation >> menuFrameLast [
	self isUpToDate ifTrue: [icurrent value: animationData value nframe]
]

{ #category : #'initialize-release' }
Animation >> open [
	| x y |
	self allButOpenInterface: #windowSpec.
	x := Screen default bounds extent x - builder window bounds extent x - 20.
	y := 65.
	builder openAt: x @ y.
	self postOpenWith: builder.
	^builder
]

{ #category : #actions }
Animation >> play [
	"Do not use Delay. It causes jerky animation."

	"In Linux86, high fps causes slow user interactions!!!"

	| series data nseries msStartOfAnimation msStartOfFrame |
	(self isUpToDate and: [animationProcess isNil]) 
		ifTrue: 
			[series := OrderedCollection new.
			data := animationData value.
			data istart <= data iend 
				ifTrue: [data istart to: data iend do: [:i | series add: i]]
				ifFalse: 
					[data istart to: data nframe do: [:i | series add: i].
					1 to: data iend do: [:i | series add: i]].
			series := data isForward 
						ifTrue: [series asArray]
						ifFalse: [series asArray reverse].
			(cadInterface cadAnimateSeries: series) 
				ifTrue: 
					[ObjectMemory garbageCollect.
					nseries := series size.
					cadInterface hideHandles.
					msStartOfAnimation := msStartOfFrame := Time millisecondClockValue.
					animationProcess := 
							[[true] whileTrue: 
									[| msElapse msPerFrame iFrameElapse iframe |
									msElapse := Time millisecondClockValue - msStartOfAnimation.
									msPerFrame := 1000 // data framesPerSecond.	"Keep here so that fps can be 
									changes on the fly."
									iFrameElapse := msElapse // msPerFrame.
									iframe := series at: iFrameElapse \\ nseries + 1.
									cadInterface animateFrame: iframe.
									
									["This will limit the actual frame rate to 30 fps. Rapid fps seems to cause problems on Linux."

									Processor yield.
									Time millisecondClockValue - msStartOfFrame < 33] 
											whileTrue.
									msStartOfFrame := Time millisecondClockValue]] 
									forkAt: Processor userBackgroundPriority.
					icurrent value: 0.
					(self builder componentAt: #icurrentID) disable]
				ifFalse: 
					[Dialog 
						warn: 'At least one part does not belong to this simulation.<n>Rerun simulation.' 
								expandMacros]]
]

{ #category : #actions }
Animation >> play1 [
	"Do not use Delay. It causes jerky animation."

	| series data nseries count msStartOfFrame |
	(self isUpToDate and: [animationProcess isNil])
		ifTrue: 
			[series := OrderedCollection new.
			data := animationData value.
			data istart <= data iend
				ifTrue: [data istart to: data iend do: [:i | series add: i]]
				ifFalse: 
					[data istart to: data nframe do: [:i | series add: i].
					1 to: data iend do: [:i | series add: i]].
			series := data isForward
						ifTrue: [series asArray]
						ifFalse: [series asArray reverse].
			(cadInterface cadAnimateSeries: series)
				ifTrue: 
					[ObjectMemory garbageCollect.
					nseries := series size.
					cadInterface hideHandles.
					count := 0.
					msStartOfFrame := Time millisecondClockValue.
					animationProcess := [[true]
								whileTrue: 
									[| iframe msPerFrame msStartOfNextFrame |
									iframe := series at: count \\ nseries + 1.
									cadInterface animateFrame: iframe.
									count := count + 1.
									msPerFrame := 1000 // data framesPerSecond.
									msStartOfNextFrame := msStartOfFrame + msPerFrame.
									
									[Processor yield.
									Time millisecondClockValue < msStartOfNextFrame] whileTrue.
									msStartOfFrame := Time millisecondClockValue]]
								forkAt: Processor userBackgroundPriority.
					icurrent value: 0.
					(self builder componentAt: #icurrentID) disable]
				ifFalse: [Dialog warn: 'At least one part does not belong to this simulation.']]
]

{ #category : #actions }
Animation >> play2 [
	"Do not use Delay. It causes jerky animation."

	| series data nseries msStartOfFrame |
	(self isUpToDate and: [animationProcess isNil])
		ifTrue: 
			[series := OrderedCollection new.
			data := animationData value.
			data istart <= data iend
				ifTrue: [data istart to: data iend do: [:i | series add: i]]
				ifFalse: 
					[data istart to: data nframe do: [:i | series add: i].
					1 to: data iend do: [:i | series add: i]].
			series := data isForward
						ifTrue: [series asArray]
						ifFalse: [series asArray reverse].
			(cadInterface cadAnimateSeries: series)
				ifTrue: 
					[ObjectMemory garbageCollect.
					nseries := series size.
					cadInterface hideHandles.
					msStartOfFrame := Time millisecondClockValue.
					animationProcess := [[true]
								whileTrue: 
									[| msElapse msPerFrame iFrameElapse iframe |
									msElapse := Time millisecondClockValue - msStartOfFrame.
									msPerFrame := 1000 // data framesPerSecond.	"Keep here so that fps can be 
									changes on the fly."
									iFrameElapse := msElapse // msPerFrame.
									iframe := series at: iFrameElapse \\ nseries + 1.
									cadInterface animateFrame: iframe.
									Processor yield]]
								forkAt: Processor userBackgroundPriority.
					icurrent value: 0.
					(self builder componentAt: #icurrentID) disable]
				ifFalse: [Dialog warn: 'At least one part does not belong to this simulation.']]
]

{ #category : #'initialize-release' }
Animation >> postBuildWith: aBuilder [ 
	icurrent onChangeSend: #changedicurrent to: self.
	istart onChangeSend: #changedistart to: self.
	iend onChangeSend: #changediend to: self
]

{ #category : #accessing }
Animation >> speed [
	^speed
]

{ #category : #actions }
Animation >> step [
	| data increment iframe |
	self isUpToDate
		ifTrue: 
			[data := animationData value.
			increment := data isForward
						ifTrue: [1]
						ifFalse: [-1].
			iframe := icurrent value + increment.
			iframe := iframe - 1 \\ data nframe + 1.
			icurrent value: iframe]
]

{ #category : #actions }
Animation >> stop [
	"The garbage can cursor persists when this command is executed during garbage collection."
	"'Cursor normal show' forces a normal cursor."

	| sem |
	animationProcess == nil
		ifFalse: 
			[sem := Semaphore new.
			
			[animationProcess terminate.
			animationProcess := nil.
			sem signal]
				forkAt: animationProcess priority.
			sem wait.
			Cursor normal show.
			(self builder componentAt: #icurrentID) enable.
			icurrent value: animationData value istart.
			cadInterface unhideHandles]
]

{ #category : #accessing }
Animation >> subject [
	^animationData
]

{ #category : #accessing }
Animation >> tcurrent [
	^tcurrent
]

{ #category : #accessing }
Animation >> tend [
	^tend
]

{ #category : #accessing }
Animation >> tstart [
	^tstart
]

{ #category : #change }
Animation >> updatetcurrent [
	^tcurrent value: self calctcurrent
]

{ #category : #change }
Animation >> updatetend [
	^tend value: self calctend
]

{ #category : #change }
Animation >> updatetstart [
	^tstart value: self calctstart
]

{ #category : #validation }
Animation >> validateRange: aController [ 
	| array |
	^self isUpToDate
		ifTrue: 
			[array := Array new: 5.
			array at: 1 put: 1.
			array at: 2 put: #<=.
			array at: 3 put: aController.
			array at: 4 put: #<=.
			array at: 5 put: animationData value nframe.
			self validateIntegerWithArguments: array]
		ifFalse: [false]
]

{ #category : #validation }
Animation >> validateSpeed: aController [ 
	| array |
	array := Array new: 5.
	array at: 1 put: 1.
	array at: 2 put: #<=.
	array at: 3 put: aController.
	array at: 4 put: #<=.
	array at: 5 put: 10000.
	^self validateIntegerWithArguments: array
]
