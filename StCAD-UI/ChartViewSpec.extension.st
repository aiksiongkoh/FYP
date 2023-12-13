Extension { #name : #ChartViewSpec }

{ #category : #'*StCAD-UI-StCAD-UI' }
ChartViewSpec classSide >> chartTypeMenu [

	"MenuEditor new openOnClass: self andSelector: #chartTypeMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Bar' #value: #BG_BarChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Pareto' #value: #BG_ParatoChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Picture' #value: #BG_PictureChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'StackedBar' #value:
	           #BG_StackedBarChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Band' #value: #BG_BandChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Layer' #value: #BG_LayerChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Line' #value: #BG_LineChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'StackedLine'
	           #value: #BG_StackedLineChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Step' #value: #BG_StepChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'XY' #value: #BG_XYChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'XYzoom' #value: #StCAD_XYChartView )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Pie' #value: #BG_PieChartView ) )
	     #( 6 5 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'*StCAD-UI-StCAD-UI' }
ChartViewSpec classSide >> initialize [

	"Initialize the class."

	"Create a dictionary, use chart types as keys and put arrays describing 
	properties of charts as values. Each array has the following 
	structure: 
	1st element describes the type of data axis appropriate for the given 
	chart type. Choice are xitem meaning that x axis is item axis so it 
	can only be automatically labeled. The only exception is XY chart which 
	has the x axis as full blown data axis. 

	2nd element of the array describes the y axis. Restricted axis are 
	used for Pareto and band charts. 

	3th element describes if the chart uses fill patterns or line widths 
	as options.

	4th element says what kind of options dialog should be used.

	Also: Install ChartViewSpec into the UIPalette activeSpecsList"

	"self initalize"

	ChartTypes := IdentityDictionary new.
	ChartTypes
		at: #BG_BarChartView
		put: #( #xitem #ynormal #regions #bar ).
	ChartTypes
		at: #BG_ParatoChartView
		put: #( #xitem #yrestricted #regions #bar ).
	ChartTypes
		at: #BG_PictureChartView
		put: #( #xitem #ynormal #regions #bar ).
	ChartTypes
		at: #BG_StackedBarChartView
		put: #( #xitem #ynormal #regions #bar ).
	ChartTypes
		at: #BG_BandChartView
		put: #( #xitem #yrestricted #regions #bar ).
	ChartTypes
		at: #BG_LayerChartView
		put: #( #xitem #ynormal #regions #bar ).
	ChartTypes
		at: #BG_LineChartView
		put: #( #xitem #ynormal #lines #line ).
	ChartTypes
		at: #BG_StackedLineChartView
		put: #( #xitem #ynormal #lines #line ).
	ChartTypes
		at: #BG_StepChartView
		put: #( #xitem #ynormal #lines #line ).
	ChartTypes at: #BG_XYChartView put: #( #xdata #ynormal #lines #line ).
	ChartTypes
		at: #StCAD_XYChartView
		put: #( #xdata #ynormal #lines #line ).
	ChartTypes
		at: #BG_PieChartView
		put: #( #xitem #yrestricted #regions #pie ).

	'#{VWQR:UIPalette}' ifDefinedDo: [ :uip | 
		(uip activeSpecsList includes: #ChartViewSpec) ifFalse: [ 
			uip activeSpecsList add: #ChartViewSpec ] ]
]
