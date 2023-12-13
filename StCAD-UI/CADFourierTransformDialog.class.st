Class {
	#name : #CADFourierTransformDialog,
	#superclass : #CADDialog,
	#instVars : [
		'istart',
		'iend',
		'limitOfStart',
		'limitOfEnd',
		'istartend'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADFourierTransformDialog class >> example1 [
	"CADFourierTransformDialog example1."

	| dummy dialogResponse |
	Transcript
		cr;
		show: 'CADFourierTransformDialog class example1.'.
	dummy := Array with: 1 with: 100.
	Transcript
		cr;
		show: dummy printString.
	dialogResponse := CADFourierTransformDialog openOn: dummy.
	Transcript
		cr;
		show: dialogResponse printString.
	Transcript
		cr;
		show: dummy printString
]

{ #category : #'instance creation' }
CADFourierTransformDialog class >> openOn: object [ 
	| newDialog |
	newDialog := super new.
	newDialog subject value: object.
	newDialog limitOfStart: (object at: 1).
	newDialog limitOfEnd: (object at: 2).
	^newDialog openInterface
]

{ #category : #'VisualWorks metadata' }
CADFourierTransformDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADFourierTransformDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #properties: #( '#{VWQR:UI.PropertyListDictionary}'
	           #sizeType #specifiedSize #positionType #positionSystemDefault
	           #openType #advanced )
	        #label: 'Fourier Transform' #min: #( '#{VWQR:Core.Point}'
	           349 202 ) #max: #( '#{VWQR:Core.Point}'
	           349 202 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           512 384 861 586 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 32 146 103 171 )
	              #model: #accept #label: 'OK' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 136 146 207 171 )
	              #model: #reset #label: 'Reset' #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 241 146 312 171 )
	              #model: #cancel #label: 'Cancel' #defaultable:
	              true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 46 30 ) #label: 'istart' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 112 23 292 58 )
	              #model: #istart #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateRange:
	                 #requestValueChangeSelector:
	                 #validateRange: )
	              #type: #number #formatString: '0' )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 46 89 ) #label: 'iend' )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 112 82 292 117 )
	              #model: #iend #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateRange:
	                 #requestValueChangeSelector:
	                 #validateRange: )
	              #type: #number #formatString: '0' ) ) ) )
]

{ #category : #accessing }
CADFourierTransformDialog >> iend [
	^iend
]

{ #category : #'initialize-release' }
CADFourierTransformDialog >> initialize [
	super initialize.
	istartend := nil asValue.
	istart := self bufferedAdaptorForIndex: 1.
	iend := self bufferedAdaptorForIndex: 2
]

{ #category : #accessing }
CADFourierTransformDialog >> istart [
	^istart
]

{ #category : #accessing }
CADFourierTransformDialog >> limitOfEnd: integer [ 
	limitOfEnd := integer
]

{ #category : #accessing }
CADFourierTransformDialog >> limitOfStart: integer [ 
	limitOfStart := integer
]

{ #category : #'initialize-release' }
CADFourierTransformDialog >> subject [
	^istartend
]

{ #category : #validation }
CADFourierTransformDialog >> validateRange: aController [ 
	| array |
	array := Array new: 5.
	array at: 1 put: limitOfStart.
	array at: 2 put: #<=.
	array at: 3 put: aController.
	array at: 4 put: #<=.
	array at: 5 put: limitOfEnd.
	^self validateIntegerWithArguments: array
]
