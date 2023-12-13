Class {
	#name : #CADPlotDialog,
	#superclass : #CADDialog,
	#instVars : [
		'cadPlot',
		'xList',
		'yList'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #'instance creation' }
CADPlotDialog class >> openOn: aCADPlot withSpec: aSymbol [ 
	| newDialog |
	newDialog := super new.
	newDialog cadPlot value: aCADPlot.
	^newDialog openInterface: aSymbol
]

{ #category : #'VisualWorks metadata' }
CADPlotDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADPlotDialog class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 'Plotting Dialog                        CADSM' 
			#min: #(#Point 640 480 ) 
			#max: #(#Point 640 480 ) 
			#bounds: #(#Rectangle 192 144 832 624 ) 
			#isEventDriven: true ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#SequenceViewSpec 
					#layout: #(#Rectangle 29 53 310 408 ) 
					#name: #xListID 
					#model: #xList 
					#selectionType: #highlight ) 
				#(#SequenceViewSpec 
					#layout: #(#Rectangle 332 53 613 408 ) 
					#name: #yListID 
					#model: #yList 
					#multipleSelections: true 
					#useModifierKeys: true 
					#selectionType: #highlight ) 
				#(#LabelSpec 
					#layout: #(#Point 122 12 ) 
					#label: 'Select X Axis' 
					#style: #default ) 
				#(#LabelSpec 
					#layout: #(#Point 405 12 ) 
					#label: 'Multi Select Y Axis' 
					#style: #default ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 193 431 249 456 ) 
					#model: #accept 
					#label: 'OK' 
					#style: #default 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 290 431 346 456 ) 
					#model: #reset 
					#label: 'Reset' 
					#style: #default 
					#defaultable: true ) 
				#(#ActionButtonSpec 
					#layout: #(#Rectangle 387 431 443 456 ) 
					#model: #cancel 
					#label: 'Cancel' 
					#style: #default 
					#defaultable: true ) ) ) )
]

{ #category : #accessing }
CADPlotDialog >> cadPlot [
	^cadPlot
]

{ #category : #private }
CADPlotDialog >> closeAccept [
	accept value ifTrue: [(self requestForWindowClose and: [self hasInputValid])
			ifTrue: 
				[self updateDomainObjects.
				close value: true.
				builder window checkForEvents]
			ifFalse: [accept value: false]]
]

{ #category : #private }
CADPlotDialog >> hasInputValid [
	xList selection isNil
		ifTrue: 
			[Dialog warn: 'Please select an X axis.'.
			^false].
	yList selections isNil
		ifTrue: 
			[Dialog warn: 'Please select at least one Y axis.'.
			^false].
	^true
]

{ #category : #'initialize-release' }
CADPlotDialog >> initialize [
	super initialize.
	cadPlot := nil asValue.
	xList := SelectionInList new.
	yList := MultiSelectionInList new
]

{ #category : #'initialize-release' }
CADPlotDialog >> postOpenWith: aBuilder [ 
	super postOpenWith: aBuilder.
	xList list: cadPlot value geoItem value dataTypes asList.
	yList list: cadPlot value geoItem value dataTypes.
	self reset
]

{ #category : #'initialize-release' }
CADPlotDialog >> reset [
	| plotTypes xaxis yaxis |
	plotTypes := cadPlot value plotTypes.
	plotTypes isNil
		ifTrue: 
			[xList selection: #time.
			yList selections: (Array with: #time)]
		ifFalse: [plotTypes isEmpty not
				ifTrue: 
					[xaxis := (plotTypes at: 1) x.
					xList selection: xaxis.
					yaxis := plotTypes collect: [:plotType | plotType y].
					yList selections: yaxis]]
]

{ #category : #private }
CADPlotDialog >> updateDomainObjects [
	| xaxis yaxiss descriptors dd plotTypes |
	xaxis := xList selection.
	yaxiss := yList selections.
	plotTypes := yaxiss collect: [:yaxis | Point x: xaxis y: yaxis].
	descriptors := plotTypes
				collect: 
					[:plotType | 
					dd := BG_ChartDataSetDescription new.
					dd name: plotType y.
					dd adaptor: ((PluggableAdaptor new)
							getBlock: [:data | (data perform: plotType x)
									@ (data perform: plotType y)]
							putBlock: [:b :v | ]
							updateBlock: [:b :a :p | false]; yourself).
					dd].
	cadPlot value plotView grid x title: xaxis.
	cadPlot value plotView grid x unit: ''.
	cadPlot value plotView grid y title: ' '.	"Looks better when there is a space."
	cadPlot value plotView grid y unit: ''.
	cadPlot value plotView descriptors: descriptors.
	cadPlot value plotTypes: plotTypes.
	cadPlot value dataSeries changed: #value
]

{ #category : #accessing }
CADPlotDialog >> xList [
	^xList
]

{ #category : #accessing }
CADPlotDialog >> yList [
	^yList
]
