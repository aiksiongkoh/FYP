Class {
	#name : #CADPolylineDialog,
	#superclass : #CADFrameBryantAnglesDialog,
	#instVars : [
		'points',
		'selectedRow',
		'rowIndex'
	],
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
CADPolylineDialog class >> datasetMenu [
	"MenuEditor new openOnClass: self andSelector: #datasetMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'Insert Row' 
				#value: #insertRow ) ) #(1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADPolylineDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CADPolylineDialog class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'Polyline Graphic Dialog                             CADSM'
	        #min: #( '#{VWQR:Core.Point}' 640 480 )
	        #max: #( '#{VWQR:Core.Point}' 640 480 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           353 243 993 723 )
	        #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 182 386 253 411 )
	              #model: #accept #label: 'OK' #style: #default #defaultable:
	              true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 290 386 361 411 )
	              #model: #reset #label: 'Reset' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 399 386 470 411 )
	              #model: #cancel #label: 'Cancel' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 59 51 ) #label: 'X' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 87 47 268 79 )
	              #name: #rGfGxID #model: #rGfGx #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 58 82 ) #label: 'Y' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 87 78 268 110 )
	              #name: #rGfGyID #model: #rGfGy #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 155 10 ) #label: 'Origin' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 345 47 526 79 )
	              #name: #the3fzID #model: #the3fz #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateDouble:
	                 #requestValueChangeSelector:
	                 #validateDouble: )
	              #alignment: #right #style: #default #type: #number )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 376 10 ) #label: 'Rotation about Z'
	              #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 540 51 ) #label: 'deg' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 275 51 ) #label: 'm' #style: #default )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 275 82 ) #label: 'm' #style: #default )
	           #( '#{VWQR:UI.DataSetSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 173 132 597 364 )
	              #name: #pointsID #flags: 13 #model: #points #columns:
	              #( #( '#{VWQR:UI.DataSetColumnSpec}'
	                    #model: #'selectedRow x' #callbacksSpec:
	                    #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                       #requestFocusInSelector:
	                       #validateCellRange: #requestFocusOutSelector:
	                       #validateDouble: #requestValueChangeSelector:
	                       #validateDouble: )
	                    #label: 'x' #labelFont: #default #labelIsImage:
	                    false #width: 203 #editorType: #InputField
	                    #font: #default #alignment: #right #type: #number
	                    #noScroll: false )
	                 #( '#{VWQR:UI.DataSetColumnSpec}'
	                    #model: #'selectedRow y' #callbacksSpec:
	                    #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                       #requestFocusInSelector:
	                       #validateCellRange: #requestFocusOutSelector:
	                       #validateDouble: #requestValueChangeSelector:
	                       #validateDouble: )
	                    #label: 'y' #labelFont: #default #labelIsImage:
	                    false #width: 203 #editorType: #InputField
	                    #font: #default #alignment: #right #type: #number
	                    #noScroll: false ) ) )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Core.Point}'
	                 43 180 ) #label: 'Row' #style: #default )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 85 176 141 208 )
	              #name: #rowIndexID #model: #rowIndex #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #requestFocusOutSelector: #validateRange:
	                 #requestValueChangeSelector:
	                 #validateRange: )
	              #alignment: #right #style: #default #type: #number
	              #formatString: '0' )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 44 133 141 159 )
	              #model: #insertAfter #label: 'Insert After'
	              #style: #default #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 44 222 141 248 )
	              #model: #deleteRow #label: 'Delete' #style: #default
	              #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 44 295 141 321 )
	              #model: #importData #label: 'Import Data' #style:
	              #default #defaultable: true )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:Graphics.Rectangle}'
	                 44 336 141 362 )
	              #model: #exportData #label: 'Export Data' #style:
	              #default #defaultable: true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -50 1 0 1.0 -18 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #centeredWindowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #private }
CADPolylineDialog >> bufferTriggerChanged [
	bufferTrigger value
		ifFalse: 
			[self setPointList.
			rowIndex value: 2]
]

{ #category : #action }
CADPolylineDialog >> deleteRow [
	[points list removeAtIndex: rowIndex value]
		on: Object subscriptOutOfBoundsSignal do: [:ex | Dialog warn: 'Select a valid row to delete.']
]

{ #category : #accessing }
CADPolylineDialog >> dialogTitle [
	^'Position Marker in its GuideFrame                           CADSM'
]

{ #category : #action }
CADPolylineDialog >> exportData [
	| titleString filterArray filenameString newName writeStream block list prompt originalDir newDir |
	(('win32*' match: OSHandle currentPlatformID)
		or: ['unix*linux*' match: OSHandle currentPlatformID])
		ifTrue: 
			[titleString := 'Export polyline data.'.
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
			block := 
					[:row | 
					1 to: 2
						do: 
							[:i | 
							| aij aijString |
							aij := row at: i.
							aij == nil ifTrue: [aij := 0.0d].
							aijString := aij printString.
							aijString last == $d
								ifTrue: [aijString replaceAll: $d with: Character space]
								ifFalse: [aijString replaceAll: $d with: $e].
							writeStream nextPutAll: aijString.
							writeStream tab].
					writeStream cr].
			list := points list.
			list do: block.
			writeStream flush; close]
]

{ #category : #private }
CADPolylineDialog >> hasInputValid [
	| list |
	list := points list.
	list do: [:point | point do: [:element | element isReal ifFalse: [^false]]].
	list first = list last
		ifFalse: 
			[Dialog warn: 'First and last vertex must be equal.'.
			^false].
	^true
]

{ #category : #action }
CADPolylineDialog >> importData [
	| titleString filterArray filenameString newName readStream list row prompt originalDir newDir |
	(('win32*' match: OSHandle currentPlatformID)
		or: ['unix*linux*' match: OSHandle currentPlatformID])
		ifTrue: 
			[titleString := 'Import polyline data.'.
			filterArray := OrderedCollection new.
			filterArray add: (CommonFileFilter filter: '*.txt' description: '*.txt  (Text)').
			filterArray add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := nil.
			filenameString := filenameString isNil
						ifTrue: ['']
						ifFalse: [filenameString].
			newName := CommonFileSelectionDialog
						openTitle: titleString
						filters: filterArray
						filename: filenameString
						mustExist: true]
		ifFalse: 
			[prompt := 'Enter filename to read a Polyline data.  Use wildcards (*.txt) to get list of files.'.
			originalDir := Filename currentDirectory directory.
			newDir := geoItem value interface cadApp fileName asFilename directory.
			newDir beCurrentDirectory.
			newName := [Dialog requestFileName: prompt default: '*.txt']
						ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not])
		ifTrue: [
			[readStream := newName asFilename readStream.
			list := List new.
			[readStream atEnd not]
				whileTrue: 
					[row := FullColumn new: 3.
					readStream skipSeparators.
					row at: 1 put: (Double importFrom: readStream).
					readStream skipSeparators.
					row at: 2 put: (Double importFrom: readStream).
					row at: 3 put: 0.0d.
					list add: row.
					readStream throughAll: (Array with: Character cr)].
			points list: list]
				valueNowOrOnUnwindDo: [readStream close]]
]

{ #category : #'initialize-release' }
CADPolylineDialog >> initialize [
	super initialize.
	points := SelectionInList new.
	points selectionIndexHolder compute: [:v | self selectedRow value: points selection].
	selectedRow := nil asValue.
	rowIndex := points selectionIndexHolder
]

{ #category : #action }
CADPolylineDialog >> insertAfter [
	| list i newRow |
	list := points list.
	i := rowIndex value.
	newRow := i == list size
				ifTrue: [(list at: i)
						* 2.0d - (list at: i - 1)]
				ifFalse: [(list at: i)
						+ (list at: i + 1) / 2.0d].
	list add: newRow beforeIndex: i + 1.
	rowIndex value: i + 1
]

{ #category : #accessing }
CADPolylineDialog >> points [
	^points
]

{ #category : #'initialize-release' }
CADPolylineDialog >> postBuildWith1: aBuilder [ 
	bufferTrigger onChangeSend: #bufferTriggerChanged to: self.
	rowIndex onChangeSend: #rowIndexChanged to: self.
	rowIndex value: 2
]

{ #category : #'initialize-release' }
CADPolylineDialog >> postBuildWith: aBuilder [ 
	bufferTrigger onChangeSend: #bufferTriggerChanged to: self.
	self setPointList.
	rowIndex value: 2
]

{ #category : #accessing }
CADPolylineDialog >> rowIndex [
	^rowIndex
]

{ #category : #accessing }
CADPolylineDialog >> selectedRow [
	^selectedRow
]

{ #category : #accessing }
CADPolylineDialog >> setPointList [
	| geoPolyline list |
	geoPolyline := geoItem value.
	list := geoPolyline listCopyOfPoints.
	points list: list
]

{ #category : #private }
CADPolylineDialog >> updateDomainObjects [
	| geoPolyline list collection |
	super updateDomainObjects.
	geoPolyline := geoItem value.
	list := points list.
	collection := OrderedCollection new: list size.
	list do: [:point | collection addLast: point copy].
	geoPolyline rfpointsf: collection.
	geoPolyline changed.
	geoPolyline interface soleSelection: geoPolyline
]

{ #category : #validation }
CADPolylineDialog >> validateCellRange1: aController [ 
	"The first row should always be (0,0)."

	| cellxy datasetView |
	datasetView := (builder componentAt: #pointsID) widget.
	cellxy := datasetView editCell.
	^cellxy y ~= 1
]

{ #category : #validation }
CADPolylineDialog >> validateCellRange: aController [ 
	^true
]

{ #category : #validation }
CADPolylineDialog >> validateRange: aController [ 
	| array |
	array := Array new: 5.
	array at: 1 put: 1.
	array at: 2 put: #<=.
	array at: 3 put: aController.
	array at: 4 put: #<=.
	array at: 5 put: points list size.
	^self validateIntegerWithArguments: array
]
