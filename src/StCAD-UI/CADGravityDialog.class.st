Class {
	#name : #CADGravityDialog,
	#superclass : #CADDialog,
	#instVars : [
		'gXYZ',
		'gX',
		'gY',
		'gZ'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #examples }
CADGravityDialog class >> example1 [
	"CADGravityDialog example1."

	| dummy dialogResponse |
	Transcript cr; show: 'CADGravityDialog class example1.'.
	dummy := Array
				with: 0.0d
				with: -9.81d
				with: 0.0d.
	Transcript cr; show: dummy printString.
	dialogResponse := CADGravityDialog openOn: dummy.
	Transcript cr; show: dialogResponse printString.
	Transcript cr; show: dummy printString
]

{ #category : #'VisualWorks metadata' }
CADGravityDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADGravityDialog class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 'Gravity' 
			#min: #(#Point 404 298 ) 
			#max: #(#Point 404 298 ) 
			#bounds: #(#Rectangle 354 282 758 580 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 61 232 132 257 ) 
					#model: #accept 
					#label: 'OK' 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 169 232 240 257 ) 
					#model: #reset 
					#label: 'Reset' 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 278 232 349 257 ) 
					#model: #cancel 
					#label: 'Cancel' 
					#defaultable: true ) 
				#(#LabelSpec 
					#layout: #(#Point 40 50 ) 
					#label: 'gX' ) 
				#(#InputFieldSpec 
					#layout: #(#Rectangle 106 45 286 80 ) 
					#model: #gX 
					#callbacksSpec: 
					#(#UIEventCallbackSubSpec 
						#requestFocusOutSelector: 
						#validateDouble: 
						#requestValueChangeSelector: 
						#validateDouble: ) 
					#type: #number ) 
				#(#LabelSpec 
					#layout: #(#Point 326 50 ) 
					#label: 'm/s*s' ) 
				#(#LabelSpec 
					#layout: #(#Point 40 109 ) 
					#label: 'gY' ) 
				#(#InputFieldSpec 
					#layout: #(#Rectangle 106 104 286 139 ) 
					#model: #gY 
					#callbacksSpec: 
					#(#UIEventCallbackSubSpec 
						#requestFocusOutSelector: 
						#validateDouble: 
						#requestValueChangeSelector: 
						#validateDouble: ) 
					#type: #number ) 
				#(#LabelSpec 
					#layout: #(#Point 326 109 ) 
					#label: 'm/s*s' ) 
				#(#LabelSpec 
					#layout: #(#Point 40 169 ) 
					#label: 'gZ' ) 
				#(#InputFieldSpec 
					#layout: #(#Rectangle 106 164 286 199 ) 
					#model: #gZ 
					#callbacksSpec: 
					#(#UIEventCallbackSubSpec 
						#requestFocusOutSelector: 
						#validateDouble: 
						#requestValueChangeSelector: 
						#validateDouble: ) 
					#type: #number ) 
				#(#LabelSpec 
					#layout: #(#Point 326 169 ) 
					#label: 'm/s*s' ) ) ) )
]

{ #category : #accessing }
CADGravityDialog >> gX [
	^gX
]

{ #category : #accessing }
CADGravityDialog >> gY [
	^gY
]

{ #category : #accessing }
CADGravityDialog >> gZ [
	^gZ
]

{ #category : #'initialize-release' }
CADGravityDialog >> initialize [
	super initialize.
	gXYZ := nil asValue.
	gX := self bufferedAdaptorForIndex: 1.
	gY := self bufferedAdaptorForIndex: 2.
	gZ := self bufferedAdaptorForIndex: 3
]

{ #category : #'initialize-release' }
CADGravityDialog >> subject [
	^gXYZ
]
