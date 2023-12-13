Class {
	#name : #AdButton,
	#superclass : #ApplicationModel,
	#instVars : [
		'adImage'
	],
	#category : #'StCAD-Doc-StDoc'
}

{ #category : #accessing }
AdButton class >> adxxxBy32 [
	"This is used during canvas editing only. 
	It is not used by the application."
	^AdData adxxxBy32 image.
]

{ #category : #'interface specs' }
AdButton class >> centeredWindowSpec [

	"UIPainter new openOnClass: self andSelector: #centeredWindowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Unlabeled Canvas' #min: #( '#{VWQR:Core.Point}'
	           575 34 ) #max: #( '#{VWQR:Core.Point}'
	           575 34 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           363 384 938 418 ) )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 0 0.5 -4 0 0.5 0 )
	              #name: #adxxxBy32ID #flags: 0 #model: #visitWebSite
	              #helpText: 'Click to Visit Web Site'
	              #label: #adxxxBy32 #hasCharacterOrientedLabel:
	              false ) ) ) )
]

{ #category : #'VisualWorks metadata' }
AdButton class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Doc'
		'superclassNamespace' 'UI'
	)

]

{ #category : #'interface specs' }
AdButton class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Unlabeled Canvas' #min: #( '#{VWQR:Core.Point}'
	           426 32 ) #max: #( '#{VWQR:Core.Point}'
	           426 32 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 938 416 ) )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Core.Point}' -4 -4 )
	              #name: #adxxxBy32ID #flags: 0 #model: #visitWebSite
	              #helpText: 'Click to Visit Web Site'
	              #label: #adxxxBy32 #hasCharacterOrientedLabel:
	              false ) ) ) )
]

{ #category : #accessing }
AdButton >> adImage [
	^adImage
]

{ #category : #accessing }
AdButton >> adImage: image [ 
	adImage := image
]

{ #category : #ad }
AdButton >> adxxxBy32 [
	^adImage image
]

{ #category : #ad }
AdButton >> changeAdxxxBy32 [
	
	[self adImage: AdData adxxxBy32.
	(self builder componentAt: #adxxxBy32ID) label: self adxxxBy32.]
			on: Error
			do: [:ex | ex return.].
]

{ #category : #ad }
AdButton >> changeAdxxxBy32For: companyString [
	self adImage: (AdData adxxxBy32For: companyString).
	(self builder componentAt: #adxxxBy32ID) label: self adxxxBy32.
]

{ #category : #'initialize-release' }
AdButton >> initialize [
	super initialize.
	adImage := AdData adxxxBy32.
]

{ #category : #binding }
AdButton >> labelFor: aKey [ 
	"Return an instance of a non-abstract subclass of CharacterArray, 
	that will be used as a label for a widget. Check the label registry 
	if no implementation has been provided."

	^[self perform: aKey]
		on: self application messageNotUnderstoodSignal
		do: 
			[:ex | 
			| sel |
			sel := ex parameter selector.
			sel == aKey
				ifTrue: [ex return: (self application labelFor: aKey)]
				ifFalse: [ex pass]]
]

{ #category : #ad }
AdButton >> visitWebSite [
	| string app appWindow browsers browser commandLine |
	(adImage isNil or: [adImage http isNil or: [adImage http isEmpty.].])
		ifTrue: [^self.].
	OSHandle currentOS == #win32
		ifTrue: 
			[commandLine := ('* nt *' match: OSHandle currentPlatformID)
						ifTrue: ['cmd /x /c start "" "<1s>"'.]
						ifFalse: ['start "<1s>"'.].
			Win32SystemSupport CreateDetachedProcess: nil
				arguments: (commandLine expandMacrosWith: adImage http).].
	OSHandle currentOS == #unix
		ifTrue: 
			[browsers := Array
						with: '/usr/lib/netscape/netscape-navigator'
						with: '/usr/lib/netscape/netscape-communicator'
						with: '/opt/netscape/netscape'.
			browser := browsers detect: [:b | b asFilename definitelyExists.]
						ifNone: nil.
			browser notNil
				ifTrue: 
					[commandLine := '<1s> -remote openURL\("<2s>"\)' expandMacrosWith: browser
								with: adImage http.
					(UnixProcess cshOne: commandLine) isEmpty not
						ifTrue: 
							[commandLine := '<1s> "<2s>"' expandMacrosWith: browser with: adImage http.
							UnixProcess forkJob: 'csh'
								arguments: (Array with: '-fecb' with: commandLine).].]
				ifFalse: 
					[browsers := Array with: '/usr/bin/mozilla'.
					browser := browsers detect: [:b | b asFilename definitelyExists.]
								ifNone: nil.
					browser notNil
						ifTrue: 
							[commandLine := '<1s> "<2s>"' expandMacrosWith: browser with: adImage http.
							(UnixProcess cshOne: commandLine) isEmpty not
								ifTrue: 
									[commandLine := '<1s> "<2s>"' expandMacrosWith: browser with: adImage http.
									UnixProcess forkJob: 'csh'
										arguments: (Array with: '-fecb' with: commandLine).].].].].
	string := 'If your Web Browser does not automatically open to<n><1s><n>copy and paste the web address into your Web Browser manually.'
				expandMacrosWith: adImage http.
	app := Editor new.
	app textHolder: string asText asValue.
	app allButOpenInterface: #noAdReadOnlyWindowSpec.
	app builder openWithExtent: string asComposedText extent + (50 @ 20).
	appWindow := app builder window.
	appWindow label: 'Starting Web Browser'.
	app postOpenWith: builder.
	
	[(Delay forSeconds: 20) wait.
	app closeRequest.]
			forkAt: Processor userBackgroundPriority.
]

{ #category : #binding }
AdButton >> visualFor: aKey [ 
	"Return an instance of any non-abstract subclass of 
	VisualComponent (in practice usually either ComposedText or 
	Image) for use as a label for a widget."

	^[self perform: aKey]
		on: self application messageNotUnderstoodSignal
		do: 
			[:ex | 
			| sel |
			sel := ex parameter selector.
			sel == aKey
				ifTrue: [ex return: (self application visualFor: aKey)]
				ifFalse: [ex pass]]
]
