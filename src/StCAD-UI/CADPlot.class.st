Class {
	#name : #CADPlot,
	#superclass : #CADApp,
	#instVars : [
		'geoItem',
		'dataSeries',
		'plotView',
		'plotTypes'
	],
	#category : #'StCAD-UI-CADApp'
}

{ #category : #'instance creation' }
CADPlot class >> basicOpenOn: geoItem withSpec: aSymbol [ 
	| newDialog |
	newDialog := super new.
	newDialog geoItem value: geoItem.
	newDialog dataSeries value: geoItem dataSeriesForChart.
	newDialog plotTypes: geoItem plotTypes.
	^newDialog openInterface: aSymbol
]

{ #category : #resources }
CADPlot class >> menuBar [

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
	                    #rawLabel: 'Select' #value: #menuPlotSelect )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Fourier Transform'
	                    #value: #menuPlotFFT )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Export'
	                    #value: #menuPlotExport ) )
	              #( 3 ) nil ) )
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
CADPlot class >> openOn: geoItem withSpec: aSymbol [ 
	| builder |
	builder := self basicOpenOn: geoItem withSpec: aSymbol.
	builder window label: ('Plotting <1s>' expandMacrosWith: geoItem fullName).
	^builder
]

{ #category : #'VisualWorks metadata' }
CADPlot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADPlot class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Plotting                            CADSM'
	        #min: #( '#{VWQR:Core.Point}' 40 20 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           384 288 1024 768 )
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

{ #category : #accessing }
CADPlot >> dataSeries [
	^dataSeries
]

{ #category : #accessing }
CADPlot >> geoItem [
	^geoItem
]

{ #category : #'initialize-release' }
CADPlot >> initialize [
	super initialize.
	geoItem := nil asValue.
	dataSeries := nil asValue
]

{ #category : #'menu items' }
CADPlot >> isEqualScale [
	^plotView isEqualScale
]

{ #category : #accessing }
CADPlot >> menuBar [
	| answer |
	answer := self class menuBar.
	(answer atNameKey: #menuViewEqualScaleID)
		indicationSelector: #isEqualScale.
	^answer
]

{ #category : #'menu items' }
CADPlot >> menuExplainPlot [
	| labelString |
	labelString := 'Explain Plot'.
	self openExplainFile: 'StCADPlotMenuExplainPlot.sdoc' label: labelString
]

{ #category : #'menu items' }
CADPlot >> menuExplainView [
	| labelString |
	labelString := 'Explain View'.
	self openExplainFile: 'StCADPlotMenuExplainView.sdoc' label: labelString
]

{ #category : #'menu items' }
CADPlot >> menuPlotExport [
	| titleString filterArray filenameString newName writeStream messages aij aijString prompt originalDir newDir |
	(('win32*' match: OSHandle currentPlatformID)
		or: ['unix*linux*' match: OSHandle currentPlatformID])
		ifTrue: 
			[titleString := 'Export tabular data.'.
			filterArray := OrderedCollection new.
			filterArray add: (CommonFileFilter filter: '*.txt' description: '*.txt  (text)').
			filterArray add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
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
			messages
				do: 
					[:message | 
					writeStream nextPutAll: message asString.
					writeStream tab].
			writeStream cr.
			dataSeries value
				do: 
					[:data | 
					messages
						do: 
							[:message | 
							aij := data perform: message.
							aij == nil ifTrue: [aij := 0.0d].
							aijString := aij printString.
							aijString last == $d
								ifTrue: [aijString replaceAll: $d with: Character space]
								ifFalse: [aijString replaceAll: $d with: $e].
							writeStream nextPutAll: aijString.
							writeStream tab].
					writeStream cr].
			writeStream flush; close]
]

{ #category : #'menu items' }
CADPlot >> menuPlotFFT [
	| tdelta series xs ys ft appWindow selfWindow m n newSeries rowi istart iend dummy rawSeries |
	(plotTypes isSequenceable and: [plotTypes first x = #time.])
		ifTrue: 
			[rawSeries := dataSeries value.
			tdelta := (((rawSeries at: 2) perform: #time)
						- ((rawSeries at: 1) perform: #time)) abs.
			series := OrderedCollection new.
			istart := 1.
			iend := rawSeries size.
			dummy := Array with: istart with: iend.
			(CADFourierTransformDialog openOn: dummy)
				ifTrue: 
					[istart := dummy at: 1.
					iend := dummy at: 2.
					plotTypes do: 
							[:plotType |
							xs := MathArray new: iend - istart + 1.
							istart to: iend
								do: [:i | xs at: i - istart + 1 put: ((rawSeries at: i) perform: plotType y).].
							ys := nil.
							ft := FourierTransform new.
							ft xs: xs ys: ys delta: tdelta.
							ft transform.
							series add: ft transformSeriesPosFreqOnly.].
					m := series size.
					n := series first size.
					newSeries := FullMatrix new: n by: m.
					1 to: n
						do: 
							[:i |
							rowi := newSeries at: i.
							1 to: m do: [:j | rowi at: j put: ((series at: j) at: i).].].
					appWindow := (CADFourierPlot
								openOn: newSeries
								plotTypes: plotTypes
								withSpec: #windowSpec) window.
					appWindow label: ('Fourier Transform of <1s>'
								expandMacrosWith: geoItem value fullName).
					appWindow application: self.
					appWindow beSlave.
					selfWindow := builder window.
					selfWindow application: self.
					selfWindow beMaster.].].
]

{ #category : #'menu items' }
CADPlot >> menuPlotSelect [
	CADPlotDialog openOn: self withSpec: #windowSpec.
]

{ #category : #'menu items' }
CADPlot >> menuViewEqualScale [
	plotView controller menuEqualScale
]

{ #category : #'menu items' }
CADPlot >> menuViewFitAll [
	plotView controller menuFitAll
]

{ #category : #'menu items' }
CADPlot >> menuViewLogx [
	| menuItem indication scaleType |
	menuItem := (builder menuAt: #menuBar) atNameKey: #menuViewLogxID.
	indication := menuItem indication.
	menuItem indication: indication not.
	scaleType := menuItem indication ifTrue: [#log] ifFalse: [#normal].
	self setXScaleType: scaleType.
	plotView invalidate
]

{ #category : #'menu items' }
CADPlot >> menuViewLogy [
	| menuItem indication scaleType |
	menuItem := (builder menuAt: #menuBar) atNameKey: #menuViewLogyID.
	indication := menuItem indication.
	menuItem indication: indication not.
	scaleType := menuItem indication ifTrue: [#log] ifFalse: [#normal].
	self setYScaleType: scaleType.
	plotView invalidate
]

{ #category : #'menu items' }
CADPlot >> menuViewZoomIn [
	plotView controller menuZoomIn
]

{ #category : #'menu items' }
CADPlot >> menuViewZoomOut [
	plotView controller menuZoomOut
]

{ #category : #'menu items' }
CADPlot >> openExplainFile: aFilename label: labelString [ 
	| filepath newLabelString |
	filepath := (Filename fromComponents: #('resource' 'explain'))
				construct: aFilename.
	newLabelString := labelString , '                ' , AdData adTitle title.
	[self openReadOnlyFile: filepath label: newLabelString]
		on: OsInaccessibleError
		do: 
			[:ex | 
			| dirString |
			dirString := (Filename fromComponents: #('resource' 'explain')) asString.
			Dialog warn: ('All Explain files (*.sdoc) should be in the subsubdirectory ''< 1s >''. <n>When unzipping cadsm*.zip and patch*.zip make sure that subdirectory information are preserved. <n>Otherwise, create subsubdirectory ''< 1s >'' and move all *.sdoc into it.' expandMacrosWith: dirString)]
]

{ #category : #'menu items' }
CADPlot >> openReadOnlyFile: aFilename label: labelString [

	| app appWindow selfWindow |
	app := StCAD_Doc_Editor new. "VW_TRANSLATION:StCAD.Doc.Editor:StCAD_Doc_Editor"
	app openInterface: #readOnlyWindowSpec.
	app loadFile: aFilename.
	appWindow := app builder window.
	appWindow label: labelString.
	builder notNil ifTrue: [ 
		appWindow application: self.
		appWindow beSlave.
		selfWindow := builder window.
		selfWindow application: self.
		selfWindow beMaster ]
]

{ #category : #accessing }
CADPlot >> plotTypes [
	^plotTypes
]

{ #category : #accessing }
CADPlot >> plotTypes: collection [ 
	plotTypes := collection
]

{ #category : #accessing }
CADPlot >> plotView [
	^plotView
]

{ #category : #'initialize-release' }
CADPlot >> postBuildWith: aBuilder [ 
	plotView := (aBuilder componentAt: #plotViewID) widget
]

{ #category : #'menu items' }
CADPlot >> setXScaleType: symbol [ 
	(symbol == #normal or: [symbol == #log]) 
		ifTrue: [plotView grid x newScaleOfType: symbol]
		ifFalse: [Dialog warn: 'Scale type must be #normal or #log.']
]

{ #category : #'menu items' }
CADPlot >> setYScaleType: symbol [ 
	(symbol == #normal or: [symbol == #log])
		ifTrue: 
			[plotView grid y newScaleOfType: symbol.
			plotView grid y scale decrease]
		ifFalse: [Dialog warn: 'Scale type must be #normal or #log.']
]
