Class {
	#name : #CADFourierPlot,
	#superclass : #CADPlot,
	#instVars : [
		'yType'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI-CADApp'
}

{ #category : #accessing }
CADFourierPlot class >> initYLabels [
	YLabels := (Dictionary new)
				at: #magnitude put: 'magFT';
				at: #phaseDegrees put: 'phaseFT';
				at: #aFx put: 'reFT';
				at: #aFy put: 'imFT';
				yourself
]

{ #category : #'class initialization' }
CADFourierPlot class >> initialize [
	self initYLabels
]

{ #category : #resources }
CADFourierPlot class >> menuBar [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #value: #menuExplain #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Plot' #value: #menuExplainPlot )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'View' #value:
	                    #menuExplainView ) )
	              #( 2 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plot' #value: #menuPlot
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Spectral Density' #value: #menuPlotSpectralDensity )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Magnitude'
	                    #value: #menuPlotMagnitude )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Phase' #value:
	                    #menuPlotPhase )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Real Part'
	                    #value: #menuPlotRealPart )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Imaginary Part'
	                    #value: #menuPlotImaginaryPart )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Export'
	                    #value: #menuPlotExport ) )
	              #( 5 1 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'View' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Fit All' #value: #menuViewFitAll )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Zoom In'
	                    #value: #menuViewZoomIn )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Zoom Out'
	                    #value: #menuViewZoomOut )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Log x' #nameKey:
	                    #menuViewLogxID #value: #menuViewLogx
	                    #indication: false )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Log y' #nameKey:
	                    #menuViewLogyID #value: #menuViewLogy
	                    #indication: false )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Equal Scale'
	                    #nameKey: #menuViewEqualScaleID
	                    #value: #menuViewEqualScale #indication:
	                    false ) )
	              #( 3 3 ) nil ) ) )
	     #( 3 ) nil ) decodeAsLiteralArray
]

{ #category : #'instance creation' }
CADFourierPlot class >> openOn: series plotTypes: plotTypes withSpec: aSymbol [ 
	| newPlot |
	newPlot := super new.
	newPlot geoItem value: nil.
	newPlot dataSeries value: series.
	newPlot plotTypes: plotTypes.
	newPlot allButOpenInterface: aSymbol.
	newPlot menuPlotSpectralDensity.
	^newPlot finallyOpen
]

{ #category : #'instance creation' }
CADFourierPlot class >> openOn: series withSpec: aSymbol [ 
	| newPlot |
	self halt.
	newPlot := super new.
	newPlot geoItem value: nil.
	newPlot dataSeries value: series.
	newPlot plotTypes: (Array with: (Point x: #f y: #magnitude)).
	^newPlot openInterface: aSymbol
]

{ #category : #'VisualWorks metadata' }
CADFourierPlot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADFourierPlot class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Plotting                            CADSM'
	        #min: #( '#{VWQR:Core.Point}' 40 20 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           390 308 1030 788 )
	        #flags: 12 #menu: #menuBar #colors: #( '#{VWQR:UI.LookPreferences}'
	           #setForegroundColor: #( '#{VWQR:Graphics.ColorValue}'
	              #black ) #setBackgroundColor: #( '#{VWQR:Graphics.ColorValue}'
	              #white ) )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ChartViewSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 1 0 1 )
	              #name: #plotViewID #model: #dataSeries #chartType:
	              #StCAD_XYChartView #dataSeries: #( '#{VWQR:UI.ChartDataSpec}'
	                 #series: #( #( '#{VWQR:UI.ChartDataSetSpec}'
	                       #aspect: #timetime #name: 'New-1' #look:
	                       #( '#{VWQR:UI.ChartElementLookSpec}'
	                          #lineWidth: 2 ) ) ) )
	              #options: #( '#{VWQR:UI.LineChartOptionsSpec}'
	                 #showMarker: false #showLine: true )
	              #xDataAxis: #( '#{VWQR:UI.ChartingValueAxisSpec}'
	                 #title: ' ' #unit: '' #labelsMarkAt: #majorMarks
	                 #labelFormat: #float )
	              #yAxis: #( '#{VWQR:UI.ChartingValueAxisSpec}'
	                 #scale: #( '#{VWQR:UI.ChartingScaleSpec}'
	                    #invert: true )
	                 #title: ' ' #unit: '' #labelFormat: #float )
	              #legendPosition: 2 ) ) ) )
]

{ #category : #'menu items' }
CADFourierPlot >> menuExplainPlot [
	| labelString |
	labelString := 'Explain Plot'.
	self openExplainFile: 'StCADFourierPlotMenuExplainPlot.sdoc'
		label: labelString
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotExport [
	| titleString filterArray filenameString newName writeStream messages prompt originalDir newDir block |
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Export tabular data.'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.txt' description: '*.txt  (text)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := nil.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename tail].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to write tabular data.  Use wildcards (*.txt) to get list of relevant data files.'.
				originalDir := Filename currentDirectory directory.
				newDir := geoItem value interface cadApp fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: '*.txt'] 
							ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: 
			[writeStream := newName asFilename writeStream.
			messages := OrderedCollection new.
			messages add: (plotTypes at: 1) x.
			plotTypes do: [:plotType | messages add: plotType y].
			messages do: 
					[:message | 
					writeStream nextPutAll: message asString.
					writeStream tab].
			writeStream cr.
			messages := OrderedCollection new.
			messages add: #f.
			plotTypes do: [:plotType | messages add: yType].
			messages do: 
					[:message | 
					writeStream nextPutAll: message asString.
					writeStream tab].
			writeStream cr.
			block := 
					[:aij | 
					| aijString |
					aijString := (aij == nil ifTrue: [0.0d] ifFalse: [aij]) printString.
					aijString last == $d 
						ifTrue: [aijString replaceAll: $d with: Character space]
						ifFalse: [aijString replaceAll: $d with: $e].
					writeStream nextPutAll: aijString.
					writeStream tab].
			dataSeries value do: 
					[:data | 
					block value: ((data at: 1) perform: #f).
					1 to: plotTypes size do: [:i | block value: ((data at: i) perform: yType)].
					writeStream cr].
			writeStream
				flush;
				close]
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotImaginaryPart [
	self plotSymbol: #aFy string: 'imFT'
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotMagnitude [
	self plotSymbol: #magnitude string: 'magFT'
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotPhase [
	self plotSymbol: #phaseDegrees string: 'argFT(degrees)'
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotPhase1 [
	self setXScaleType: #log.
	self setYScaleType: #normal.
	self plotSymbol: #phase string: 'argFT/rad'
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotRealPart [
	self plotSymbol: #aFx string: 'reFT'
]

{ #category : #'menu items' }
CADFourierPlot >> menuPlotSpectralDensity [
	self plotSymbol: #oneSidedSpectralDensity
		string: 'OneSidedSpectralDensity_FT'
]

{ #category : #'menu items' }
CADFourierPlot >> plotSymbol: symbol string: string [ 
	| descriptors dd |
	yType := symbol.
	descriptors := Array new: plotTypes size.
	1 to: descriptors size
		do: 
			[:i | 
			dd := BG_ChartDataSetDescription new.
			dd name: (plotTypes at: i) y.
			dd adaptor: ((PluggableAdaptor new)
						getBlock: [:data | ((data at: i) perform: #f) @ ((data at: i) perform: symbol)]
							putBlock: [:b :v | ]
							updateBlock: [:b :a :p | false];
						yourself).
			descriptors at: i put: dd].
	plotView grid x title: 'frequency'.
	plotView grid x unit: 'Hz'.
	plotView grid y title: string.
	plotView grid y unit: ''.
	plotView descriptors: descriptors.
	dataSeries changed: #value
]

{ #category : #accessing }
CADFourierPlot >> yType [
	^yType
]
