Class {
	#name : #CADTextCollector,
	#superclass : #CADApp,
	#instVars : [
		'textCollectorView'
	],
	#category : #'StCAD-UI-CADApp'
}

{ #category : #'interface opening' }
CADTextCollector class >> openOn: aTextCollector [ 
	"CADTextCollector openOn: Transcript."

	^(self new textCollector: aTextCollector) open
]

{ #category : #'VisualWorks metadata' }
CADTextCollector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADTextCollector class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'CADSM Transcript' #min: #( '#{VWQR:Core.Point}'
	           40 20 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 1004 596 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ArbitraryComponentSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 -33 1 )
	              #name: #textCollectorViewID #flags: 9 #component:
	              #textCollectorView )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -32 1 0 1.0 0 1.0 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #ad }
CADTextCollector >> changeAdTitle [
	self builder window label: 'CADSM Transcript' , '          ' , self adTitle
]

{ #category : #'initialize-release' }
CADTextCollector >> open [
	| x y |
	self allButOpenInterface: #windowSpec.
	x := Screen default bounds extent x - builder window bounds extent x - 20.
	y := 65.
	builder openAt: x @ y.
	self postOpenWith: builder.
	^builder
]

{ #category : #'initialize-release' }
CADTextCollector >> postBuildWith: aBuilder [ 
	textCollectorView controller: TextEditorController new.	"	textCollectorView controller initializeMenuForCode."
	textCollectorView controller keyboardProcessor: builder keyboardProcessor
]

{ #category : #'initialize-release' }
CADTextCollector >> postOpenWith1: aBuilder [ 
	| x y |
	x := Screen default bounds extent x - builder window bounds extent x - 20.
	y := 65.
	builder window moveTo: x @ y
]

{ #category : #'initialize-release' }
CADTextCollector >> textCollector: aTextCollector [ 
	textCollectorView := TextCollectorView new model: aTextCollector
]

{ #category : #accessing }
CADTextCollector >> textCollectorView [
	^textCollectorView
]
