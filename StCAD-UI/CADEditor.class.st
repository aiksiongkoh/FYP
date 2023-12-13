Class {
	#name : #CADEditor,
	#superclass : #CADApp,
	#instVars : [
		'textCollector',
		'interface',
		'fileName',
		'isDirty',
		'cadView',
		'handle',
		'rDcursorPx',
		'selection',
		'treeView'
	],
	#category : #'StCAD-UI-CADApp'
}

{ #category : #resources }
CADEditor class >> menuTreeView [

	"MenuEditor new openOnClass: self andSelector: #menuTreeView"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Rename' #value: #inplaceEdit ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADEditor class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADEditor >> adTitle [
	^AdData adTitle title
]

{ #category : #accessing }
CADEditor >> animationWindow [
	^self dependents detect: 
			[:dependent |
			(dependent isKindOf: ApplicationWindow)
				and: [dependent model isMemberOf: CADAnimation.].]
		ifNone: nil.
]

{ #category : #'menubar items' }
CADEditor >> animationWindowRaise [
	| selfWindow animationWindow animationBuilder |
	animationWindow := self animationWindow.
	animationWindow isNil
		ifTrue: 
			[animationBuilder := CADAnimation openOn: interface.
			animationBuilder notNil
				ifTrue: 
					[selfWindow := builder window.
					animationWindow := animationBuilder window.
					selfWindow application: self.
					animationWindow application: self.
					selfWindow beMaster.
					animationWindow beSlave.].]
		ifFalse: 
			[animationWindow
				expand;
				raise.].
]

{ #category : #accessing }
CADEditor >> cadView [
	^cadView
]

{ #category : #ad }
CADEditor >> changeAdTitle [
	self builder window label: 'CADSM     ' , fileName asString , '          ' , self adTitle
]

{ #category : #'initialize-release' }
CADEditor >> changeRequest [
	| appWindow |
	appWindow := self dependents detect: 
					[:dependent |
					(dependent isMemberOf: ApplicationWindow)
						and: [dependent model isMemberOf: CADAnimation.].]
				ifNone: nil.
	^((appWindow isNil
		ifTrue: [true.]
		ifFalse: [appWindow model changeRequest.]) and: [interface updateRequest.])
		and: 
			[isDirty
				ifTrue: 
					[Dialog confirm: 'Do you wish to discard the changes?' for: builder window.]
				ifFalse: [true.].].
]

{ #category : #aspects }
CADEditor >> clearHandleValue [
	self handle value: String new
]

{ #category : #'menubar items' }
CADEditor >> createMenuFor: col actionBlock: block [ 
	| array |
	array := col asArray.
	(SequenceableCollectionSorter on: array using: [:geoItem1 :geoItem2 | geoItem1 fullName <= geoItem2 fullName]) sort.
	^Menu
		labelArray: (array collect: [:geoItem | geoItem fullName])
		lines: Array new
		values: (array collect: block)
]

{ #category : #'menubar items' }
CADEditor >> createMenuOfPlotsFor: col [ 
	| block |
	block := [:geoItem | MessageSend
				receiver: self
				selector: #openPlotOn:withSpec:
				arguments: (Array with: geoItem with: #windowSpec)].
	^self createMenuFor: col actionBlock: block
]

{ #category : #debug }
CADEditor >> debug1 [
	"Delete all but specified joint."

	| jointList motionList |
	jointList := interface jointList.
	jointList do: 
			[:a | 
			('Align (90)' match: a name) 
				ifFalse: 
					[interface soleSelection: a.
					interface cut]].
	motionList := interface motionList.
	motionList do: 
			[:a | 
			interface soleSelection: a.
			interface cut]
]

{ #category : #debug }
CADEditor >> debug2 [
	"Delete joints not connected to a specified part."

	| jointList |
	jointList := interface jointList.
	jointList do: 
			[:joint | 
			(('H-3063<1>' match: joint aMarkerI anyPart name) 
				or: ['H-3063<1>' match: joint aMarkerJ anyPart name]) 
					ifFalse: 
						[interface soleSelection: joint.
						interface cut]]
]

{ #category : #debug }
CADEditor >> debug3 [
	"Delete parts not connected to a set of constraints."

	| partList jointList |
	partList := interface partList.
	jointList := interface jointList.
	partList do: 
			[:aPart | 
			(jointList detect: 
					[:joint | 
					aPart == joint aMarkerI anyPart or: [aPart == joint aMarkerJ anyPart]]
				ifNone: nil) ifNil: 
						[interface soleSelection: aPart.
						interface cut]]
]

{ #category : #debug }
CADEditor >> debug4 [
	"Delete markers not connected to a set of constraints."

	| partList jointList markerList cMarker |
	partList := interface partList.
	partList add: interface geoRootItem.
	jointList := interface jointList.
	markerList := Set new.
	jointList do: 
			[:joint | 
			markerList add: joint aMarkerI.
			markerList add: joint aMarkerJ].
	partList do: 
			[:aPart | 
			cMarker := aPart cMarker copy.
			cMarker do: 
					[:aMarker | 
					(markerList includes: aMarker) 
						ifFalse: 
							[interface soleSelection: aMarker.
							interface cut]]]
]

{ #category : #debug }
CADEditor >> debugShowMasses [
	| partList min max mass minPart maxPart |
	partList := interface partList.
	min := 1.0d300.
	max := 0.0d.
	partList do: 
			[:aPart | 
			mass := aPart mass.
			min < mass 
				ifFalse: 
					[min := mass.
					minPart := aPart].
			max < mass 
				ifTrue: 
					[max := mass.
					maxPart := aPart].
			self toTranscriptShow: ('<1s> mass := <2p>' expandMacrosWith: aPart name
						with: aPart mass)].
	self 
		toTranscriptShow: ('<1s> min mass := <2p>' expandMacrosWith: minPart name
				with: min).
	self 
		toTranscriptShow: ('<1s> max mass := <2p>' expandMacrosWith: maxPart name
				with: max).
	self toTranscriptShow: ('max/min := <1p>' expandMacrosWith: max / min)
]

{ #category : #'menubar items' }
CADEditor >> dialogTitle: title directory: directory prompt: prompt directoryB: directoryB [ 
	"Returns nil or a directory name string."

	^interface geoRootItem isNil
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil]
		ifFalse: [(('win32*' match: OSHandle currentPlatformID)
				or: ['unix*linux*' match: OSHandle currentPlatformID])
				ifTrue: [CommonDirectorySelectionDialog openTitle: title directoryName: directory]
				ifFalse: [Dialog requestDirectoryName: prompt default: directoryB]]
]

{ #category : #'menubar items' }
CADEditor >> dialogType: string Title: title fileExt: fileExt description: description prompt: prompt [ 
	| dotExt wildcard filterArray filenameString initName originalDir newDir |
	dotExt := '.' , fileExt.
	wildcard := '*' , dotExt.
	^interface geoRootItem isNil
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			nil]
		ifFalse: [(('win32*' match: OSHandle currentPlatformID)
				or: ['unix*linux*' match: OSHandle currentPlatformID])
				ifTrue: 
					[filterArray := OrderedCollection new.
					filterArray add: (CommonFileFilter filter: wildcard description: wildcard , ' (' , description , ')').
					filterArray add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
					filenameString := self fileName.
					filenameString := filenameString isNil
								ifTrue: ['']
								ifFalse: [filenameString asFilename moniker , dotExt].
					string = 'open'
						ifTrue: [CommonFileSelectionDialog
								openTitle: title
								filters: filterArray
								filename: filenameString
								mustExist: true]
						ifFalse: [CommonFileSelectionDialog
								saveTitle: title
								filters: filterArray
								filename: filenameString
								promptOverwrite: true]]
				ifFalse: 
					[initName := (fileName notNil and: [fileName isEmpty not])
								ifTrue: [fileName asFilename moniker]
								ifFalse: ['*'].
					initName := initName , dotExt.
					originalDir := Filename currentDirectory directory.
					newDir := fileName asFilename directory.
					newDir beCurrentDirectory.
					[Dialog requestFileName: prompt expandMacros default: initName]
						ensure: [originalDir beCurrentDirectory]]]
]

{ #category : #aspects }
CADEditor >> doubleClick: aTreeController [ 
	"Let the tree toggle the state of expandation of the selected node."

	aTreeController toggleExpand
]

{ #category : #accessing }
CADEditor >> drawingRect [
	^interface drawingRect
]

{ #category : #aspects }
CADEditor >> exitTreeView: controller [ 

	Transcript cr.
	Transcript show: 'exiting tree view.'
]

{ #category : #accessing }
CADEditor >> fileName [
	^fileName
]

{ #category : #accessing }
CADEditor >> fileName: string [ 
	fileName := string.
	self builder window label: 'CADSM     ' , fileName asString , '          ' , self adTitle
]

{ #category : #aspects }
CADEditor >> handle [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."

	^handle isNil
		ifTrue:
			[handle := String new asValue]
		ifFalse:
			[handle]
]

{ #category : #aspects }
CADEditor >> handleValue: aHandle [ 
	self handle value: aHandle description
]

{ #category : #'initialize-release' }
CADEditor >> initialize [
	super initialize.
	textCollector := TextCollector new.
	interface := self interfaceClass new.
	interface cadApp: self.
	cadView := interface displayPane.
	cadView model: self.
	isDirty := false.
	treeView := SelectionInTree new
]

{ #category : #'menubar items' }
CADEditor >> inputFileDialog [
	| filenameString prompt originalDir titleString filterArray newName newDir |
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Open an Assembly'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.asm*' description: '*.asm*  (Assembly)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename tail].
				newName := CommonFileSelectionDialog 
							openTitle: titleString
							filters: filterArray
							filename: filenameString
							mustExist: true]
			ifFalse: 
				[prompt := 'Enter filename to read a Assembly.  Use wildcards (*.asm) to get list of relevant Assembly files.'.
				newName := self fileName.
				newName := newName isNil 
							ifTrue: [Dialog requestFileName: prompt default: '*.asm*']
							ifFalse: 
								[originalDir := Filename currentDirectory directory.
								newDir := newName asFilename directory.
								newDir beCurrentDirectory.
								[Dialog requestFileName: prompt default: '*.asm*'] 
									ensure: [originalDir beCurrentDirectory]]].
	^newName
]

{ #category : #'menubar items' }
CADEditor >> inputFileDialog: objectString filter: filterString [ 
	| titleString filterArray filenameString newName prompt originalDir newDir |
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := #'Open <1s> File' << #'StCAD.UI' 
							expandMacrosWith: objectString.
				filterArray := OrderedCollection new.
				filterArray add: (CommonFileFilter filter: filterString
							description: (#'<2s>  (<1s>)' << #'StCAD.UI' expandMacrosWith: objectString
									with: filterString)).
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename tail].
				newName := CommonFileSelectionDialog 
							openTitle: titleString
							filters: filterArray
							filename: filenameString
							mustExist: true]
			ifFalse: 
				[prompt := #'Enter filename to read a <1s>.  Use wildcards (<2s>) to get list of relevant <1s> files.' 
							<< #'StCAD.UI' expandMacrosWith: objectString with: filterString.
				newName := self fileName.
				newName := newName isNil 
							ifTrue: [Dialog requestFileName: prompt default: filterString]
							ifFalse: 
								[originalDir := Filename currentDirectory directory.
								newDir := newName asFilename directory.
								newDir beCurrentDirectory.
								[Dialog requestFileName: prompt default: filterString] 
									ensure: [originalDir beCurrentDirectory]]].
	^newName
]

{ #category : #accessing }
CADEditor >> interface [
	^interface
]

{ #category : #accessing }
CADEditor >> isDirty: boolean [ 
	isDirty := boolean
]

{ #category : #accessing }
CADEditor >> longTitle [
	^'freeCAD: 3D CAD with Motion Simulation  by  askoh.com'
]

{ #category : #'menubar items' }
CADEditor >> menuAllowZRotation [
	interface createAllowZRotation
]

{ #category : #'menubar items' }
CADEditor >> menuBar [
	| menu |
	menu := self class menuBar.
	^menu
]

{ #category : #'menubar items' }
CADEditor >> menuDrawCircle [
	interface drawCircle
]

{ #category : #'menubar items' }
CADEditor >> menuDrawEllipse [
	interface drawEllipse
]

{ #category : #menuExplain }
CADEditor >> menuDrawExplain [
	| labelString |
	labelString := 'Explain Draw Menu Items'.
	self openExplainFile: 'StCADEditorMenuDrawExplain.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuDrawLine [
	interface drawLine
]

{ #category : #'menubar items' }
CADEditor >> menuDrawPolyline [
	interface drawPolyline
]

{ #category : #'menubar items' }
CADEditor >> menuDrawRectangle [
	interface drawRectangle
]

{ #category : #menuExplain }
CADEditor >> menuDynamicExplainForceTorque [
	| labelString |
	labelString := 'Explain Force and Torque'.
	self openExplainFile: 'StCADEditorMenuDynamicExplainForceTorque.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuDynamicExplainGravity [
	| labelString |
	labelString := 'Explain Gravity'.
	self openExplainFile: 'StCADEditorMenuDynamicExplainGravity.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuDynamicExplainMass [
	| labelString |
	labelString := 'Explain Mass'.
	self openExplainFile: 'StCADEditorMenuDynamicExplainMass.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuDynamicForceTorqueGeneral [
	interface createDynamicForceTorqueGeneral
]

{ #category : #'menubar items' }
CADEditor >> menuDynamicForceTorqueInLine [
	interface createDynamicsForceTorqueInLine
]

{ #category : #'menubar items' }
CADEditor >> menuDynamicGravity [
	interface insertGravity
]

{ #category : #'menubar items' }
CADEditor >> menuEditAssemblySize [
	| magnification |
	magnification := Dialog prompt: 'Magnify Assembly by'
				defaultExpression: 1.0d printString.
	magnification isNil ifTrue: [^self].
	(magnification isReal and: [magnification positive]) 
		ifTrue: 
			[magnification ~= 1 
				ifTrue: 
					[(interface geoRootItem)
						magnifySelf: magnification asDouble;
						changed.
					interface projectWorld.
					self menuViewRegen]]
		ifFalse: [Dialog warn: 'Magnification must be a positive number.']
]

{ #category : #'menubar items' }
CADEditor >> menuEditCut [
	interface cut
]

{ #category : #menuExplain }
CADEditor >> menuEditExplain [
	| labelString |
	labelString := 'Explain Edit Menu Items'.
	self openExplainFile: 'StCADEditorMenuEditExplain.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuEditMarkerSize [
	interface editMarkerSize
]

{ #category : #'menubar items' }
CADEditor >> menuEditNotes [
	self menuOpenNotesReadOnly: false
]

{ #category : #'menubar items' }
CADEditor >> menuEditPartSize [
	| geoPart |
	geoPart := interface soleSelection.
	(geoPart isNil or: [geoPart isPart not]) 
		ifTrue: 
			[Dialog warn: 'Select a part to change size.'.
			^nil].
	geoPart cadObject aSizeDialog
]

{ #category : #'menubar items' }
CADEditor >> menuEditUndo [
	interface undo
]

{ #category : #menuExplain }
CADEditor >> menuExplainQuickStart [
	| labelString |
	labelString := 'Where are the Quick Start tutorials?'.
	self openExplainFile: 'StCADEditorMenuExplainQuickStart.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuExplainQuickTest [
	| labelString |
	labelString := 'Explain Quick Test'.
	self openExplainFile: 'StCADEditorMenuExplainQuickTest.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuExplainTreeView [
	| labelString |
	labelString := 'Explain Tree View'.
	self openExplainFile: 'StCADEditorMenuExplainTreeView.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuExplainUsage [
	| labelString |
	labelString := 'How to use CADSM?'.
	self openExplainFile: 'StCADEditorMenuExplainUsage.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuFileExit [
	self closeRequest
]

{ #category : #menuExplain }
CADEditor >> menuFileExplain [
	| labelString |
	labelString := 'Explain File Menu Items'.
	self openExplainFile: 'StCADEditorMenuFileExplain.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuFileNewAssembly [
	self changeRequest ifFalse: [^self].
	interface newAssemblyRoot
]

{ #category : #'menubar items' }
CADEditor >> menuFileNewPart [
	self changeRequest ifFalse: [^self].
	interface newPartRoot
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenAssembly [

	| titleString filterArray filenameString newName readStream bos geoAssembly stack prompt originalDir newDir |
	self changeRequest ifFalse: [ ^ self ].
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Open an Assembly'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter
					 filter: '*.asm*'
					 description: '*.asm*  (Assembly)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := self fileName.
			filenameString := filenameString isNil
				                  ifTrue: [ '' ]
				                  ifFalse: [ filenameString asFilename tail ].
			newName := CommonFileSelectionDialog
				           openTitle: titleString
				           filters: filterArray
				           filename: filenameString
				           mustExist: true ]
		ifFalse: [ 
			prompt := 'Enter filename to read a Assembly.  Use wildcards (*.asm) to get list of relevant Assembly files.'.
			newName := self fileName.
			newName := newName isNil
				           ifTrue: [ 
				           Dialog requestFileName: prompt default: '*.asm*' ]
				           ifFalse: [ 
					           originalDir := Filename currentDirectory directory.
					           newDir := newName asFilename directory.
					           newDir beCurrentDirectory.
					           [ Dialog requestFileName: prompt default: '*.asm*' ] 
						           ensure: [ originalDir beCurrentDirectory ] ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.

		[ 
		readStream := newName asFilename readStream.

		[ 
		bos := StCAD_Misc_BinaryObjectStorage onOldNoScan: readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
		geoAssembly := bos contents at: 1 ] valueNowOrOnUnwindDo: [ 
			readStream close ] ]
			on: Error
			do: [ :ex | ex return ].
		geoAssembly isNil ifTrue: [ 
			readStream := newName asFilename readStream.

			[ 
			stack := GeometryAsTextParser
				         parse: readStream contents cleanSourceFromSelf
				         as: #asmt.
			geoAssembly := stack last ] valueNowOrOnUnwindDo: [ 
				readStream close ] ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				interface deleteGEORootItem.
				interface geoRootItem: geoAssembly.
				interface createUpdateSelectGOfor: geoAssembly.
				interface fitAssemblyInPane.
				cadView invalidate.
				self isDirty: false ]
			ifFalse: [ Dialog warn: 'Error reading an assembly from file.' ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenAssembly1 [

	| titleString filterArray filenameString newName bos geoAssembly |
	self changeRequest ifFalse: [ ^ self ].
	titleString := 'Open an Assembly'.
	filterArray := OrderedCollection new.
	filterArray add:
		(CommonFileFilter filter: '*.asm' description: '*.asm  (Assembly)').
	filterArray add:
		(CommonFileFilter filter: '*.*' description: '*.*  (All)').
	filenameString := self fileName.
	filenameString := filenameString isNil
		                  ifTrue: [ '' ]
		                  ifFalse: [ filenameString asFilename tail ].
	newName := CommonFileSelectionDialog
		           openTitle: titleString
		           filters: filterArray
		           filename: filenameString
		           mustExist: true.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		bos := StCAD_Misc_BinaryObjectStorage onOldNoScan:
			       newName asFilename readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
		[ geoAssembly := bos contents at: 1 ] valueNowOrOnUnwindDo: [ 
			bos close ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				interface deleteGEORootItem.
				interface geoRootItem: geoAssembly.
				interface createUpdateSelectGOfor: geoAssembly.
				interface repairDamage.
				interface fitAssemblyInPane.
				self isDirty: false ]
			ifFalse: [ Dialog warn: 'Error reading an assembly from file.' ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenDXFNew [

	| newName geoAssembly |
	self changeRequest ifFalse: [ ^ self ].
	newName := self inputFileDialog: 'DXF' filter: '*.dxf'.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		[ 
		geoAssembly := (StCAD_UI_DXF_DXFParser parse: newName) aAssembly "VW_TRANSLATION:StCAD.UI.DXF.DXFParser:StCAD_UI_DXF_DXFParser" ]
			on: Error
			do: [ :ex | ex pass ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				interface deleteGEORootItem.
				interface geoRootItem: geoAssembly.
				interface createUpdateSelectGOfor: geoAssembly.
				interface fitAssemblyInPane.
				"					interface display isOpenGL: false."
				cadView invalidate.
				self isDirty: true ]
			ifFalse: [ 
				Dialog warn:
					(#'Error reading DXF file. <n>If possible, please send the DXF file to askoh@cadsm.com for debugging.'
					 << #'StCAD.UI') expandMacros ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenDXFUpdate [

	| newName geoAssembly |
	self changeRequest ifFalse: [ ^ self ].
	newName := self inputFileDialog: 'DXF' filter: '*.dxf'.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		[ 
		geoAssembly := (StCAD_UI_DXF_DXFParser parse: newName) aAssembly "VW_TRANSLATION:StCAD.UI.DXF.DXFParser:StCAD_UI_DXF_DXFParser" ]
			on: Error
			do: [ :ex | ex pass ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				| geoRootItem |
				geoRootItem := interface geoRootItem.
				geoRootItem
					ifNil: [ 
						interface geoRootItem: geoAssembly.
						interface createUpdateSelectGOfor: geoAssembly ]
					ifNotNil: [ 
						interface noSelections.
						geoRootItem cadObject release.
						geoRootItem preSave.
						geoAssembly anyParts copy do: [ :anyPart | 
							| oldPart |
							oldPart := geoRootItem anyParts
								           detect: [ :aPart | anyPart name = aPart name ]
								           ifNone: [ nil ].
							oldPart
								ifNil: [ geoRootItem addAnyPart: anyPart ]
								ifNotNil: [ oldPart aDXFBLOCK: anyPart aDXFBLOCK ] ].
						interface createUpdateSelectGOfor: geoRootItem ].
				interface fitAssemblyInPane.
				"					interface display isOpenGL: false."
				cadView invalidate.
				self isDirty: true ]
			ifFalse: [ 
				Dialog warn:
					(#'Error reading DXF file. <n>If possible, please send the DXF file to askoh@cadsm.com for debugging.'
					 << #'StCAD.UI') expandMacros ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenMOSESppo [

	| geoRootItem titleString newName prompt mosesFrame readStream parser filterArray filenameString originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil ifTrue: [ 
		Dialog warn: 'The root item is nil.'.
		^ nil ].
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Open a MOSES output file'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter filter: '*.ppo' description: '*.ppo  (Assembly)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := self fileName.
			filenameString := filenameString isNil
				                  ifTrue: [ '' ]
				                  ifFalse: [ 
				                  filenameString asFilename moniker , '.ppo' ].
			newName := CommonFileSelectionDialog
				           openTitle: titleString
				           filters: filterArray
				           filename: filenameString
				           mustExist: true ]
		ifFalse: [ 
			prompt := 'Enter filename to read MOSES output.  Use wildcards (*.ppo) to get list of relevant Assembly files.'.
			newName := self fileName.
			newName := newName isNil
				           ifTrue: [ 
				           Dialog requestFileName: prompt default: '*.ppo' ]
				           ifFalse: [ 
					           originalDir := Filename currentDirectory directory.
					           newDir := newName asFilename directory.
					           newDir beCurrentDirectory.
					           [ Dialog requestFileName: prompt default: '*.ppo' ] 
						           ensure: [ originalDir beCurrentDirectory ] ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		mosesFrame := [ geoRootItem mosesFrame ]
			              on: Object notFoundSignal
			              do: [ :ex | ex return: nil ].
		mosesFrame isNil
			ifTrue: [ 
				Dialog warn:
					'The assembly (ground) needs a MOSESFrame. <n>No further processing.'
						expandMacros ]
			ifFalse: [ 
				readStream := newName asFilename readStream.

				[ 
				parser := StCAD_UI_MOSES_Parser new. "VW_TRANSLATION:StCAD.UI.MOSES.Parser:StCAD_UI_MOSES_Parser"
				parser geoRootItem: geoRootItem.
				parser parse: readStream contents as: #ppo ] 
					valueNowOrOnUnwindDo: [ readStream close ] ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenPart [
	self changeRequest ifFalse: [^self].
	interface fromFilePartRoot
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenSTEPNew [

	| newName geoAssembly |
	self changeRequest ifFalse: [ ^ self ].
	newName := self inputFileDialog: 'STEP' filter: '*.ST*P'.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		[ 
		geoAssembly := (StCAD_UI_STEP_STEPParser parse: newName) aAssembly "VW_TRANSLATION:StCAD.UI.STEP.STEPParser:StCAD_UI_STEP_STEPParser" ]
			on: Error
			do: [ :ex | ex pass ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				interface deleteGEORootItem.
				interface geoRootItem: geoAssembly.
				interface createUpdateSelectGOfor: geoAssembly.
				interface fitAssemblyInPane.
				cadView invalidate.
				self isDirty: true ]
			ifFalse: [ 
				Dialog warn:
					(#'Error reading STEP file. <n>If possible, please send the STEP file to askoh@cadsm.com for debugging.'
					 << #'StCAD.UI') expandMacros ] ].
	self menuViewRegen
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenSTEPUpdate [

	| newName geoAssembly |
	self changeRequest ifFalse: [ ^ self ].
	newName := self inputFileDialog: 'STEP' filter: '*.st*p'.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		[ 
		geoAssembly := (StCAD_UI_STEP_STEPParser parse: newName) aAssembly "VW_TRANSLATION:StCAD.UI.STEP.STEPParser:StCAD_UI_STEP_STEPParser" ]
			on: Error
			do: [ :ex | ex pass ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				| geoRootItem |
				geoRootItem := interface geoRootItem.
				geoRootItem
					ifNil: [ 
						interface geoRootItem: geoAssembly.
						interface createUpdateSelectGOfor: geoAssembly ]
					ifNotNil: [ 
						interface noSelections.
						geoRootItem cadObject release.
						geoRootItem preSave.
						geoAssembly anyParts copy do: [ :anyPart | 
							| oldPart |
							oldPart := geoRootItem anyParts
								           detect: [ :aPart | anyPart name = aPart name ]
								           ifNone: [ nil ].
							oldPart
								ifNil: [ geoRootItem addAnyPart: anyPart ]
								ifNotNil: [ oldPart aNMT: anyPart aNMT ] ].
						interface createUpdateSelectGOfor: geoRootItem ].
				interface fitAssemblyInPane.
				interface removeDisplayList.
				cadView invalidate.
				self isDirty: true ]
			ifFalse: [ 
				Dialog warn:
					(#'Error reading STEP file. <n>If possible, please send the STEP file to askoh@cadsm.com for debugging.'
					 << #'StCAD.UI') expandMacros ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileOpenSebertdat [

	| geoRootItem newName readStream parser filename |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil ifTrue: [ 
		interface newAssemblyRoot.
		geoRootItem := interface geoRootItem ].
	newName := self
		           openTitle: 'Open a Sebert DAT file'
		           fileExt: 'dat'
		           description: 'Sebert'
		           prompt:
		           'Enter filename to read Sebert template file. <n>Use wildcards (*.dat) to get list of relevant Sebert template files.'.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		filename := newName asFilename.
		readStream := filename readStream.

		[ 
		parser := StCAD_UI_Sebert_Parser new. "VW_TRANSLATION:StCAD.UI.Sebert.Parser:StCAD_UI_Sebert_Parser"
		parser geoRootItem: geoRootItem.
		parser parse: readStream contents as: #dat ] valueNowOrOnUnwindDo: [ 
			readStream close ].
		readStream := (filename directory construct:
			               filename moniker , '.fkt') asFilename readStream.
		[ parser parse: readStream contents as: #fkt ] 
			valueNowOrOnUnwindDo: [ readStream close ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsAssembly [

	| geoRootItem titleString filterArray filenameString newName bos prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil ifTrue: [ 
		Dialog warn: 'The root item is nil.'.
		^ nil ].
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Save an Assembly'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter filter: '*.asm' description: '*.asm  (Assembly)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := self fileName.
			filenameString := filenameString isNil
				                  ifTrue: [ '' ]
				                  ifFalse: [ 
				                  filenameString asFilename moniker , '.asm' ].
			newName := CommonFileSelectionDialog
				           saveTitle: titleString
				           filters: filterArray
				           filename: filenameString
				           promptOverwrite: true ]
		ifFalse: [ 
			prompt := 'Enter filename to save Assembly.<n>Use wildcards (*.asm) to get list of relevant Assembly files.'
				          expandMacros.
			initName := (fileName notNil and: [ fileName isEmpty not ])
				            ifTrue: [ fileName asFilename moniker ]
				            ifFalse: [ '*' ].
			initName := initName , '.asm'.
			originalDir := Filename currentDirectory directory.
			newDir := fileName asFilename directory.
			newDir beCurrentDirectory.
			newName := [ Dialog requestFileName: prompt default: initName ] 
				           ensure: [ originalDir beCurrentDirectory ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		bos := StCAD_Misc_BinaryObjectStorage onNew:
			       fileName asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"

		[ 
		interface noSelections.
		geoRootItem cadObject release.
		geoRootItem preSave.
		geoRootItem container: nil.
		geoRootItem refFrame refFrame removeDependentFrame:
			geoRootItem refFrame.
		geoRootItem refFrame refFrame: nil.
		bos nextPut: geoRootItem.
		self isDirty: false ] valueNowOrOnUnwindDo: [ bos close ].
		interface geoRootItem: geoRootItem.
		interface createUpdateSelectGOfor: geoRootItem ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsAssembly1 [

	| geoRootItem titleString filterArray filenameString newName bos prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil ifTrue: [ 
		Dialog warn: 'The root item is nil.'.
		^ nil ].
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Save an Assembly'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter filter: '*.asm' description: '*.asm  (Assembly)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := self fileName.
			filenameString := filenameString isNil
				                  ifTrue: [ '' ]
				                  ifFalse: [ 
				                  filenameString asFilename moniker , '.asm' ].
			newName := CommonFileSelectionDialog
				           saveTitle: titleString
				           filters: filterArray
				           filename: filenameString
				           promptOverwrite: true ]
		ifFalse: [ 
			prompt := 'Enter filename to save Assembly.<n>Use wildcards (*.asm) to get list of relevant Assembly files.'
				          expandMacros.
			initName := (fileName notNil and: [ fileName isEmpty not ])
				            ifTrue: [ fileName asFilename moniker ]
				            ifFalse: [ '*' ].
			initName := initName , '.asm'.
			originalDir := Filename currentDirectory directory.
			newDir := fileName asFilename directory.
			newDir beCurrentDirectory.
			newName := [ Dialog requestFileName: prompt default: initName ] 
				           ensure: [ originalDir beCurrentDirectory ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		self fileName: newName.
		bos := StCAD_Misc_BinaryObjectStorage onNew:
			       fileName asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"

		[ 
		interface noSelections.
		geoRootItem cadObject release.
		geoRootItem preSave.
		geoRootItem container: nil.
		geoRootItem refFrame refFrame removeDependentFrame:
			geoRootItem refFrame.
		geoRootItem refFrame refFrame: nil.
		bos nextPut: geoRootItem.
		self isDirty: false ] valueNowOrOnUnwindDo: [ bos close ].
		interface geoRootItem: geoRootItem.
		interface createUpdateSelectGOfor: geoRootItem ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsPart [

	"geoPart cadObject release is not good because CADMarkers can 
	still be held on by CADJoints."

	"Use geoRootItem cadObject release to clear all cad objects."

	| geoRootItem geoPart titleString filterArray filenameString newName bos assembly prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoPart := interface soleSelection.
	(geoPart isNil or: [ geoPart isPart not ]) ifTrue: [ 
		Dialog warn: 'Select a part to be saved to file.'.
		^ nil ].
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Save a Part'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter filter: '*.prt' description: '*.prt  (Part)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := '<1s>.prt' expandMacrosWith: geoPart name.
			filenameString := filenameString isNil
				                  ifTrue: [ '' ]
				                  ifFalse: [ filenameString asFilename tail ].
			newName := CommonFileSelectionDialog
				           saveTitle: titleString
				           filters: filterArray
				           filename: filenameString
				           promptOverwrite: true ]
		ifFalse: [ 
			prompt := 'Enter filename to save Part.<n>Use wildcards (*.prt) to get list of relevant Part files.'
				          expandMacros.
			initName := '<1s>.prt' expandMacrosWith: geoPart name.
			originalDir := Filename currentDirectory directory.
			newDir := fileName asFilename directory.
			newDir beCurrentDirectory.
			newName := [ Dialog requestFileName: prompt default: initName ] 
				           ensure: [ originalDir beCurrentDirectory ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		bos := StCAD_Misc_BinaryObjectStorage onNew:
			       newName asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"

		[ 
		interface noSelections.
		geoRootItem cadObject release.
		geoRootItem preSave.
		assembly := geoPart container.
		geoPart container: nil.
		geoPart refFrame refFrame removeDependentFrame: geoPart refFrame.
		geoPart refFrame refFrame: nil.
		bos nextPut: geoPart ] valueNowOrOnUnwindDo: [ bos close ].
		assembly addAnyPart: geoPart.
		interface createUpdateSelectGOfor: geoRootItem ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsPart1 [

	| geoPart prompt initName originalDir newDir newName bos assembly |
	geoPart := interface soleSelection.
	(geoPart isNil or: [ geoPart isPart not ]) ifTrue: [ 
		Dialog warn: 'Select a part to be saved to file.'.
		^ nil ].
	prompt := 'Enter filename to save Part.<n>Use wildcards (*.prt) to get list of relevant Part files.'
		          expandMacros.
	initName := '<1s>.prt' expandMacrosWith: geoPart name.
	originalDir := Filename currentDirectory directory.
	newDir := fileName asFilename directory.
	newDir beCurrentDirectory.
	newName := [ Dialog requestFileName: prompt default: initName ] 
		           ensure: [ originalDir beCurrentDirectory ].
	newName = '' ifTrue: [ ^ nil ]. "	 
	self fileName: newName."
	bos := StCAD_Misc_BinaryObjectStorage onNew:
		       fileName asFilename writeStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"

	[ 
	interface noSelections.
	assembly := geoPart container.
	geoPart cadObject release.
	geoPart preSave.
	geoPart container: nil.
	geoPart refFrame refFrame removeDependentFrame: geoPart refFrame.
	geoPart refFrame refFrame: nil.
	bos nextPut: geoPart ] valueNowOrOnUnwindDo: [ bos close ].
	assembly addAnyPart: geoPart.
	interface createUpdateSelectGOfor: geoPart
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextAssembly [
	| geoRootItem titleString filterArray filenameString newName writeStream prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil 
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Save an Assembly as Text'.
				filterArray := OrderedCollection new.
				filterArray add: (CommonFileFilter filter: '*.asmt'
							description: '*.asmt  (Assembly Text)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename moniker , '.asmt'].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to save Assembly as text.<n>Use wildcards (*.asmt) to get list of relevant Assembly files.' 
							expandMacros.
				initName := (fileName notNil and: [fileName isEmpty not]) 
							ifTrue: [fileName asFilename moniker]
							ifFalse: ['*'].
				initName := initName , '.asmt'.
				originalDir := Filename currentDirectory directory.
				newDir := fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: initName] 
							ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: 
			[self fileName: newName.
			writeStream := newName asFilename writeStream.
			
			[writeStream 
				storeLevel: 0
				title: self longTitle
				object: geoRootItem.
			geoRootItem storeTimeSeriesOn: writeStream] 
					valueNowOrOnUnwindDo: [writeStream close]]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextLMUPath [
	| geoRootItem titleString directoryNameString newName prompt initName northEastDownFrame geoKineIJ dataSeries eulerAngleszyxIJSeries series writeStream deck deckPDMSFrame up |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID)
		or: ['unix*linux*' match: OSHandle currentPlatformID])
		ifTrue: 
			[titleString := 'Save Review Animation Path as Text'.
			directoryNameString := ''.
			newName := CommonDirectorySelectionDialog openTitle: titleString directoryName: directoryNameString]
		ifFalse: 
			[prompt := 'Enter directoryName to save Review Animation Path as text.<n>Use wildcards (*) to get list of directories.' expandMacros.
			initName := '*'.
			newName := Dialog requestDirectoryName: prompt default: initName].
	(newName notNil and: [newName isEmpty not])
		ifTrue: 
			[northEastDownFrame := [geoRootItem pdmsFrame]
						on: Object notFoundSignal do: [:ex | ex return: nil].
			northEastDownFrame isNil
				ifTrue: [Dialog warn: 'The assembly (ground) needs a PDMSFrame. <n>No path files are generated.' expandMacros]
				ifFalse: 
					[deck := interface partList detect: [:part | part name = #DECK].
					deckPDMSFrame := [deck pdmsFrame]
								on: Object notFoundSignal do: [:ex | ex return: nil].
					deckPDMSFrame notNil
						ifTrue: 
							[geoKineIJ := GEOKineIJ markerI: northEastDownFrame markerJ: deckPDMSFrame.
							geoKineIJ name: 'LMUA2'.
							dataSeries := geoKineIJ dataSeriesForChart.
							eulerAngleszyxIJSeries := dataSeries collect: [:kineIkineJ | kineIkineJ eulerAngleszyxIJ].
							GEOEulerAngles conditionSeries: eulerAngleszyxIJSeries.
							series := Array new: dataSeries size.
							1 to: series size
								do: 
									[:i | 
									| row data rIJI |
									row := OrderedCollection new: 7.
									data := dataSeries at: i.
									row add: data time.
									rIJI := data rIJI.
									row add: 0.0d.	"East"
									row add: 0.0d.	"North"
									up := -1000.0d * (rIJI at: 3).
									up := up > 450.0d
												ifTrue: [0.0d]
												ifFalse: [up - 450.0d].
									row add: up.	"Up"
									row add: 0.0d.	"Bearing"
									row add: 0.0d.	"Elevation"
									row add: 0.0d.	"Roll"
									series at: i put: row].
							writeStream := (newName , geoKineIJ name , '.path') asFilename writeStream.
							
							[writeStream nextPutAll: '#rr animation path'; cr.
							writeStream nextPutAll: 'name'; space; nextPutAll: geoKineIJ name; cr.
							writeStream nextPutAll: 'points'; space; print: series size; cr.
							writeStream nextPutAll: 'units metric'; cr.
							writeStream nextPutAll: 'mode direction'; cr.
							writeStream nextPutAll: 'begin'; cr.
							series
								do: 
									[:row | 
									writeStream nextPutAll: (PrintConverter print: (row at: 1)
											formattedBy: '####.###'); space.
									2 to: 4 do: [:j | writeStream nextPutAll: (PrintConverter print: (row at: j)
												formattedBy: '##########.###'); space].
									writeStream nextPutAll: 'spline'; space.
									5 to: 7 do: [:j | writeStream nextPutAll: (PrintConverter print: (row at: j)
												formattedBy: '#######.######'); space].
									writeStream nextPutAll: 'spline'; space.
									writeStream nextPutAll: (PrintConverter print: 1000.0 formattedBy: '##########.###'); cr].
							writeStream nextPutAll: 'end'; cr]
								valueNowOrOnUnwindDo: [writeStream close]]]]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPDMSReview [
	| geoRootItem titleString directoryNameString newName prompt initName writeStream northEastDownFrame partList geoKineIJ series dataSeries eulerAngleszyxIJSeries eulerAngleszyxIJi partPDMSFrame |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID)
		or: ['unix*linux*' match: OSHandle currentPlatformID])
		ifTrue: 
			[titleString := 'Save Review Animation Path as Text'.
			directoryNameString := ''.
			newName := CommonDirectorySelectionDialog openTitle: titleString directoryName: directoryNameString]
		ifFalse: 
			[prompt := 'Enter directoryName to save Review Animation Path as text.<n>Use wildcards (*) to get list of directories.' expandMacros.
			initName := '*'.
			newName := Dialog requestDirectoryName: prompt default: initName].
	(newName notNil and: [newName isEmpty not])
		ifTrue: 
			[northEastDownFrame := [geoRootItem pdmsFrame]
						on: Object notFoundSignal do: [:ex | ex return: nil].
			northEastDownFrame isNil
				ifTrue: [Dialog warn: 'The assembly (ground) needs a PDMSFrame. <n>No path files are generated.' expandMacros]
				ifFalse: 
					[partList := interface partList.
					partList
						do: 
							[:part | 
							partPDMSFrame := [part pdmsFrame]
										on: Object notFoundSignal do: [:ex | ex return: nil].
							partPDMSFrame notNil
								ifTrue: 
									[geoKineIJ := GEOKineIJ markerI: northEastDownFrame markerJ: partPDMSFrame.
									geoKineIJ name: part name.
									dataSeries := geoKineIJ dataSeriesForChart.
									eulerAngleszyxIJSeries := dataSeries collect: [:kineIkineJ | kineIkineJ eulerAngleszyxIJ].
									GEOEulerAngles conditionSeries: eulerAngleszyxIJSeries.
									series := Array new: dataSeries size.
									1 to: series size
										do: 
											[:i | 
											| row data rIJI |
											row := OrderedCollection new: 7.
											data := dataSeries at: i.
											row add: data time.
											rIJI := data rIJI.
											row add: 1000.0d * (rIJI at: 2).	"East"
											row add: 1000.0d * (rIJI at: 1).	"North"
											row add: -1000.0d * (rIJI at: 3).	"Up"
											eulerAngleszyxIJi := eulerAngleszyxIJSeries at: i.
											row add: (eulerAngleszyxIJi at: 1) radiansToDegrees.	"Bearing"
											row add: (eulerAngleszyxIJi at: 2) radiansToDegrees.	"Elevation"
											row add: (eulerAngleszyxIJi at: 3) radiansToDegrees.	"Roll"
											series at: i put: row].
									writeStream := (newName , geoKineIJ name , '.path') asFilename writeStream.
									
									[writeStream nextPutAll: '#rr animation path'; cr.
									writeStream nextPutAll: 'name'; space; nextPutAll: geoKineIJ name; cr.
									writeStream nextPutAll: 'points'; space; print: series size; cr.
									writeStream nextPutAll: 'units metric'; cr.
									writeStream nextPutAll: 'mode direction'; cr.
									writeStream nextPutAll: 'begin'; cr.
									series
										do: 
											[:row | 
											writeStream nextPutAll: (PrintConverter print: (row at: 1)
													formattedBy: '####.###'); space.
											2 to: 4 do: [:j | writeStream nextPutAll: (PrintConverter print: (row at: j)
														formattedBy: '##########.###'); space].
											writeStream nextPutAll: 'spline'; space.
											5 to: 7 do: [:j | writeStream nextPutAll: (PrintConverter print: (row at: j)
														formattedBy: '#######.######'); space].
											writeStream nextPutAll: 'spline'; space.
											writeStream nextPutAll: (PrintConverter print: 1000.0 formattedBy: '##########.###'); cr].
									writeStream nextPutAll: 'end'; cr]
										valueNowOrOnUnwindDo: [writeStream close]]]]]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPOVRay [
	| geoRootItem titleString filterArray filenameString newName prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil 
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Save an Assembly as POVRay'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.pov' description: '*.pov  (POVRay)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename moniker , '.pov'].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to save Assembly as text.<n>Use wildcards (*.pov) to get list of relevant Assembly files.' 
							expandMacros.
				initName := (fileName notNil and: [fileName isEmpty not]) 
							ifTrue: [fileName asFilename moniker]
							ifFalse: ['*'].
				initName := initName , '.pov'.
				originalDir := Filename currentDirectory directory.
				newDir := fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: initName] 
							ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: 
			[self outputPOViniOn: newName.
			self outputPOVcamOn: newName.
			self outputPOVpovOn: newName.
			self outputPOVTimeSeriesOn: newName]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPOVRay1 [

	| newName geoRootItem povrayFrame readStream parser dirName |
	newName := self
		           openTitle: 'Open a POV-Ray template file'
		           fileExt: 'povt'
		           description: 'POV-Ray'
		           prompt:
		           'Enter filename to read POV-Ray template file. <n>Use wildcards (*.povt) to get list of relevant POV-Ray template files.'.
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		geoRootItem := interface geoRootItem.
		povrayFrame := [ geoRootItem povrayFrame ]
			               on: Object notFoundSignal
			               do: [ :ex | ex return: nil ].
		povrayFrame isNil
			ifTrue: [ 
				Dialog warn:
					'The assembly (ground) needs a POV-Ray Frame. <n>No further processing.'
						expandMacros ]
			ifFalse: [ 
				readStream := newName asFilename readStream.

				[ 
				parser := StCAD_UI_POVRay_Parser new. "VW_TRANSLATION:StCAD.UI.POVRay.Parser:StCAD_UI_POVRay_Parser"
				parser geoRootItem: geoRootItem.
				parser parse: readStream contents as: #povt ] 
					valueNowOrOnUnwindDo: [ readStream close ].
				dirName := self
					           dialogTitle: 'Select directory to save POV-Ray files'
					           directory: ''
					           prompt:
					           'Enter directoryName to save POV-Ray files.<n>Use wildcards (*) to get list of directories.'
					           directoryB: '*'.
				(dirName notNil and: [ dirName isEmpty not ]) ifTrue: [ 
					parser
						outputPOVseriesName: newName asFilename moniker
						in: dirName ] ] ]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPOVRay2 [
	| geoRootItem titleString filterArray filenameString newName writeStream prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil 
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Save an Assembly as POVRay'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.pov' description: '*.pov  (POVRay)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename moniker , '.pov'].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to save Assembly as text.<n>Use wildcards (*.pov) to get list of relevant Assembly files.' 
							expandMacros.
				initName := (fileName notNil and: [fileName isEmpty not]) 
							ifTrue: [fileName asFilename moniker]
							ifFalse: ['*'].
				initName := initName , '.pov'.
				originalDir := Filename currentDirectory directory.
				newDir := fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: initName] 
							ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: 
			[writeStream := newName asFilename writeStream.
			
			[writeStream storePOVLevel: 0
				title: '//freeCAD: 3D CAD with Motion Simulation  by  askoh.com

#include "colors.inc" 
#include "glass.inc"
#include "finish.inc"
#include "textures.inc" 

camera {
  direction < 0, 0, -1>    //-1 = right hand rule. 1 = left hand rule.
  up    < 0, 1, 0>            //Do not change.
  right   < 4/3, 0, 0>         //Must equal Width/Height ratio of the image.
  location < 10, 10, 10>  //Camera location.
  sky   <0,1,0>              //The sky vector will always be up in the image.
  look_at  <0, 0, 0>         //Focus of camera view.
  angle 15                     //Zoom
}

light_source {
  < 10, 10, 10>
  color red 1.0  green 1.0  blue 1.0
}

'.
			geoRootItem storePOVOn: writeStream level: 1] 
					valueNowOrOnUnwindDo: [writeStream close].
			writeStream := (newName asFilename moniker , '.inc') asFilename 
						writeStream.
			
			[writeStream storePOVLevel: 0
				title: '//freeCAD: 3D CAD with Motion Simulation  by  askoh.com'.
			geoRootItem storePOVTimeSeriesOn: writeStream] 
					valueNowOrOnUnwindDo: [writeStream close]]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPOVRay3 [
	| geoRootItem titleString filterArray filenameString newName writeStream prompt initName originalDir newDir fullRect viewAngleDeg cameraDist centerOfView cameraVertical cameraLocation |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil 
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Save an Assembly as POVRay'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.pov' description: '*.pov  (POVRay)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename moniker , '.pov'].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to save Assembly as text.<n>Use wildcards (*.pov) to get list of relevant Assembly files.' 
							expandMacros.
				initName := (fileName notNil and: [fileName isEmpty not]) 
							ifTrue: [fileName asFilename moniker]
							ifFalse: ['*'].
				initName := initName , '.pov'.
				originalDir := Filename currentDirectory directory.
				newDir := fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: initName] 
							ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: 
			[writeStream := newName asFilename writeStream.
			
			[writeStream storePOVLevel: 1
				title: '//freeCAD: 3D CAD with Motion Simulation  by  askoh.com

#include "colors.inc" 
#include "glass.inc"
#include "finish.inc"
#include "textures.inc" 

camera {
  direction < 0, 0, -1>    //-1 = right hand rule. 1 = left hand rule.
  up    < 0, 1, 0>            //Do not change.
  right   < 4/3, 0, 0>         //Must equal Width/Height ratio of the image.'.
			fullRect := interface fullProjectedRectangle.
			viewAngleDeg := 20.
			cameraDist := fullRect extent r / 2 
						/ (viewAngleDeg degreesToRadians / 2) tan.
			cameraDist := 1.2 * cameraDist.
			centerOfView := interface a3DCenter.
			cameraVertical := interface projectionVertical.
			cameraLocation := centerOfView - (cameraDist * interface projectionAxis).
			cameraLocation := cameraLocation collect: [:coord | coord printForExport].
			cameraVertical := cameraVertical collect: [:coord | coord printForExport].
			centerOfView := centerOfView collect: [:coord | coord printForExport].
			writeStream storePOVLevel: 1
				title: ('  location %<<1s>,<2s>,<3s>>  //Camera location.' 
						expandMacrosWithArguments: cameraLocation).
			writeStream storePOVLevel: 1
				title: ('  sky %<<1s>,<2s>,<3s>>  //The sky vector will always be up in the image.' 
						expandMacrosWithArguments: cameraVertical).
			writeStream storePOVLevel: 1
				title: ('  look_at %<<1s>,<2s>,<3s>>  //Focus of camera view.' 
						expandMacrosWithArguments: centerOfView).
			writeStream storePOVLevel: 1
				title: ('  angle <1s>  //Zoom' expandMacrosWith: viewAngleDeg).
			writeStream storePOVLevel: 1
				title: ('}

light_source {
  %<<1s>,<2s>,<3s>>
  color red 1.0  green 1.0  blue 1.0
}
' 
						expandMacrosWithArguments: cameraLocation).
			geoRootItem storePOVOn: writeStream level: 1] 
					valueNowOrOnUnwindDo: [writeStream close].
			writeStream := (newName asFilename moniker , '.inc') asFilename 
						writeStream.
			
			[writeStream storePOVLevel: 0
				title: '//freeCAD: 3D CAD with Motion Simulation  by  askoh.com'.
			geoRootItem storePOVTimeSeriesOn: writeStream] 
					valueNowOrOnUnwindDo: [writeStream close]]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPOVRayCurrent [
	| newName |
	newName := self openFileDialogPOVRay.
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: 
			[self outputPOViniCurrentOn: newName.
			self outputPOVcamOn: newName.
			self outputPOVpovOn: newName.
			self outputPOVdatCurrentOn: newName]
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextPOVRaySeries [
	| newName |
	(interface geoRootItem notNil and: [interface timeSeries notNil]) 
		ifTrue: 
			[newName := self openFileDialogPOVRay.
			(newName notNil and: [newName isEmpty not]) 
				ifTrue: 
					[self outputPOViniOn: newName.
					self outputPOVcamOn: newName.
					self outputPOVpovOn: newName.
					self outputPOVTimeSeriesOn: newName]]
		ifFalse: [Dialog warn: 'Assembly has no simulation data.']
]

{ #category : #'menubar items' }
CADEditor >> menuFileSaveAsTextRobotAxes [
	| geoRootItem titleString filterArray filenameString newName prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil 
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Save Robot Axes as Text'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.rob' description: '*.rob  (Robot Axes)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename moniker , '.rob'].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to save Assembly as text.<n>Use wildcards (*.rob) to get list of relevant Assembly files.' 
							expandMacros.
				initName := (fileName notNil and: [fileName isEmpty not]) 
							ifTrue: [fileName asFilename moniker]
							ifFalse: ['*'].
				initName := initName , '.rob'.
				originalDir := Filename currentDirectory directory.
				newDir := fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: initName] 
							ensure: [originalDir beCurrentDirectory]].
	(newName notNil and: [newName isEmpty not]) 
		ifTrue: [self outputRobotAxesOn: newName]
]

{ #category : #'menubar items' }
CADEditor >> menuInsertAssembly [

	| titleString filterArray filenameString newName readStream bos geoAssembly stack prompt originalDir newDir geoRootItem |
	(('win32*' match: OSHandle currentPlatformID) or: [ 
		 'unix*linux*' match: OSHandle currentPlatformID ])
		ifTrue: [ 
			titleString := 'Open an Assembly'.
			filterArray := OrderedCollection new.
			filterArray add:
				(CommonFileFilter
					 filter: '*.asm*'
					 description: '*.asm*  (Assembly)').
			filterArray add:
				(CommonFileFilter filter: '*.*' description: '*.*  (All)').
			filenameString := self fileName.
			filenameString := filenameString isNil
				                  ifTrue: [ '' ]
				                  ifFalse: [ filenameString asFilename tail ].
			newName := CommonFileSelectionDialog
				           openTitle: titleString
				           filters: filterArray
				           filename: filenameString
				           mustExist: true ]
		ifFalse: [ 
			prompt := 'Enter filename to read a Assembly.  Use wildcards (*.asm) to get list of relevant Assembly files.'.
			newName := self fileName.
			newName := newName isNil
				           ifTrue: [ 
				           Dialog requestFileName: prompt default: '*.asm*' ]
				           ifFalse: [ 
					           originalDir := Filename currentDirectory directory.
					           newDir := newName asFilename directory.
					           newDir beCurrentDirectory.
					           [ Dialog requestFileName: prompt default: '*.asm*' ] 
						           ensure: [ originalDir beCurrentDirectory ] ] ].
	(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
		[ 
		readStream := newName asFilename readStream.

		[ 
		bos := StCAD_Misc_BinaryObjectStorage onOldNoScan: readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
		geoAssembly := bos contents at: 1 ] valueNowOrOnUnwindDo: [ 
			readStream close ] ]
			on: Error
			do: [ :ex | ex return ].
		geoAssembly isNil ifTrue: [ 
			readStream := newName asFilename readStream.

			[ 
			stack := GeometryAsTextParser
				         parse: readStream contents cleanSourceFromSelf
				         as: #asmt.
			geoAssembly := stack last ] valueNowOrOnUnwindDo: [ 
				readStream close ] ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				geoRootItem := interface geoRootItem.
				geoRootItem insertAssembly: geoAssembly.
				interface createUpdateSelectGOfor: geoRootItem.
				interface fitAssemblyInPane.
				cadView invalidate.
				self isDirty: false ]
			ifFalse: [ Dialog warn: 'Error reading an assembly from file.' ] ]
]

{ #category : #menuExplain }
CADEditor >> menuInsertExplain [
	| labelString |
	labelString := 'Explain Insert Menu Items'.
	self openExplainFile: 'StCADEditorMenuInsertExplain.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuInsertFeatureExtrusion [
	interface createExtrusion
]

{ #category : #'menubar items' }
CADEditor >> menuInsertFrameOfClass: frameClass [ 
	"Create a marker on a selected plane."

	| selectedGEOs plane name geoMarker |
	selectedGEOs := interface selectedGEOs.
	(selectedGEOs isEmpty not
		and: 
			[plane := selectedGEOs soleSelection.
			plane isPlanar])
		ifTrue: 
			[name := interface promptUserForMarkerNameIn: plane anyPart.
			name isEmpty not
				ifTrue: 
					[geoMarker := frameClass new.
					geoMarker name: name.
					plane addMarker: geoMarker.
					interface createUpdateSelectGOfor: geoMarker.
					plane isFace not ifTrue: [plane release]]]
		ifFalse: [Dialog warn: 'Select a face or a plane. Then insert a new marker.']
]

{ #category : #'menubar items' }
CADEditor >> menuInsertMOSESFrame [

	self menuInsertFrameOfClass: StCAD_UI_MOSES_Frame "VW_TRANSLATION:StCAD.UI.MOSES.Frame:StCAD_UI_MOSES_Frame"
]

{ #category : #'menubar items' }
CADEditor >> menuInsertMarker [
	interface insertMarker
]

{ #category : #'menubar items' }
CADEditor >> menuInsertPDMSFrame [

	self menuInsertFrameOfClass: StCAD_UI_PDMS_Frame "VW_TRANSLATION:StCAD.UI.PDMS.Frame:StCAD_UI_PDMS_Frame"
]

{ #category : #'menubar items' }
CADEditor >> menuInsertPOVRayFrame [

	self menuInsertFrameOfClass: StCAD_UI_POVRay_Frame "VW_TRANSLATION:StCAD.UI.POVRay.Frame:StCAD_UI_POVRay_Frame"
]

{ #category : #'menubar items' }
CADEditor >> menuInsertPartDXF [

	| plane aAssembly name newName aDXFAssembly |
	interface := self interface.
	interface hasValidActiveSketch ifTrue: [ 
		Dialog warn:
			'Complete the part with an active sketch. Then insert a new part.'.
		^ interface ].
	(interface selectedGEOs isEmpty not and: [ 
		 plane := interface selectedGEOs soleSelection.
		 plane isPlanar and: [ plane container isAssembly ] ])
		ifTrue: [ 
			aAssembly := plane assembly.
			name := interface promptUserForPartNameIn: aAssembly.
			name isEmpty not ifTrue: [ 
				newName := self inputFileDialog: 'DXF' filter: '*.dxf'.
				(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
					[ 
					aDXFAssembly := (StCAD_UI_DXF_DXFParser parse: newName) aAssembly "VW_TRANSLATION:StCAD.UI.DXF.DXFParser:StCAD_UI_DXF_DXFParser" ]
						on: Error
						do: [ :ex | ex pass ].
					(aDXFAssembly notNil and: [ aDXFAssembly isAssembly ])
						ifTrue: [ 
							| aPart aDXFBLOCK aMassMarker |
							aPart := GEOPart new.
							aPart name: name.
							aPart refFrame
								rFfF: plane refFrame rFfF
								aAFf: plane refFrame aAFf.
							plane release.
							aDXFBLOCK := StCAD_UI_DXF_DXFBLOCK new. "VW_TRANSLATION:StCAD.UI.DXF.DXFBLOCK:StCAD_UI_DXF_DXFBLOCK"
							aDXFAssembly anyParts copy do: [ :anyPart | 
								| aaDXFBLOCK aaRefFrame |
								aaDXFBLOCK := anyPart aDXFBLOCK.
								aaRefFrame := aaDXFBLOCK aRefFrame.
								aaRefFrame rFfF: aaRefFrame rOfO aAFf: aaRefFrame aAOf.
								aDXFBLOCK addGraphic: aaDXFBLOCK ].
							aDXFBLOCK calcBoundingBox.
							aPart aDXFBLOCK: aDXFBLOCK.
							aMassMarker := GEOMassMarker new.
							aMassMarker name: 'MassMarker'.
							aMassMarker refFrame
								rFfF: aDXFBLOCK aBoundingBox center
								aAFf: (FullMatrix identity: 3).
							aPart aMassMarker: aMassMarker.
							aAssembly addAnyPart: aPart.
							interface createUpdateSelectGOfor: aPart.
							self isDirty: true ]
						ifFalse: [ 
							Dialog warn:
								(#'Error reading DXF file. <n>If possible, please send the DXF file to askoh@cadsm.com for debugging.'
								 << #'StCAD.UI') expandMacros ] ] ] ]
		ifFalse: [ 
			Dialog warn:
				'Select an assembly. Select a plane. Then insert a new part' ]
]

{ #category : #'menubar items' }
CADEditor >> menuInsertPartFile [
	interface insertPartFile
]

{ #category : #'menubar items' }
CADEditor >> menuInsertPartNew [
	interface insertPart
]

{ #category : #'menubar items' }
CADEditor >> menuInsertPartSTEP [

	| plane aAssembly name newName aSTEPAssembly |
	interface := self interface.
	interface hasValidActiveSketch ifTrue: [ 
		Dialog warn:
			'Complete the part with an active sketch. Then insert a new part.'.
		^ interface ].
	(interface selectedGEOs isEmpty not and: [ 
		 plane := interface selectedGEOs soleSelection.
		 plane isPlanar and: [ plane container isAssembly ] ])
		ifTrue: [ 
			aAssembly := plane assembly.
			name := interface promptUserForPartNameIn: aAssembly.
			name isEmpty not ifTrue: [ 
				newName := self inputFileDialog: 'STEP' filter: '*.st*p'.
				(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
					[ 
					aSTEPAssembly := (StCAD_UI_STEP_STEPParser parse: newName)
						                 aAssembly "VW_TRANSLATION:StCAD.UI.STEP.STEPParser:StCAD_UI_STEP_STEPParser" ]
						on: Error
						do: [ :ex | ex pass ].
					(aSTEPAssembly notNil and: [ aSTEPAssembly isAssembly ])
						ifTrue: [ 
							| aPart |
							aPart := aSTEPAssembly anyParts soleItem.
							aAssembly addAnyPart: aPart.
							interface createUpdateSelectGOfor: aPart.
							self isDirty: true ]
						ifFalse: [ 
							Dialog warn:
								(#'Error reading STEP file. <n>If possible, please send the STEP file to askoh@cadsm.com for debugging.'
								 << #'StCAD.UI') expandMacros ] ] ] ]
		ifFalse: [ 
			Dialog warn:
				'Select an assembly. Select a plane. Then insert a new part' ]
]

{ #category : #'menubar items' }
CADEditor >> menuInsertSketch [
	interface insertSketch
]

{ #category : #'menubar items' }
CADEditor >> menuInspect [
	self inspect
]

{ #category : #'menubar items' }
CADEditor >> menuJointAngle [
	interface createJointAngle
]

{ #category : #'menubar items' }
CADEditor >> menuJointConstantVelocityZ [
	interface createJointConstantVelocityZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointCurveOnCurve [
	interface createJointCurveOnCurve
]

{ #category : #'menubar items' }
CADEditor >> menuJointCylSph [
	interface createJointCylSph
]

{ #category : #'menubar items' }
CADEditor >> menuJointCylindricalZ [
	interface createJointCylindricalZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointFixed [
	interface createJointFixed
]

{ #category : #'menubar items' }
CADEditor >> menuJointGear [
	interface createJointGear
]

{ #category : #'menubar items' }
CADEditor >> menuJointLineInPlaneXY [
	interface createJointLineInPlaneXY
]

{ #category : #'menubar items' }
CADEditor >> menuJointNoRotation [
	interface createJointNoRotation
]

{ #category : #'menubar items' }
CADEditor >> menuJointParallelGear [
	interface createJointParallelGear
]

{ #category : #'menubar items' }
CADEditor >> menuJointParallelZ [
	interface createJointParallelZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointPerpendicularZ [
	interface createJointPerpendicularZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointPlanarXY [
	interface createJointPlanarXY
]

{ #category : #'menubar items' }
CADEditor >> menuJointPointInLineZ [
	interface createJointPointInLineZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointPointInPlaneXY [
	interface createJointPointInPlaneXY
]

{ #category : #'menubar items' }
CADEditor >> menuJointRackXAndPinionZ [
	interface createJointRackXAndPinionZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointRevCyl [
	interface createJointRevCyl
]

{ #category : #'menubar items' }
CADEditor >> menuJointRevoluteZ [
	interface createJointRevoluteZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointScrewZ [
	interface createJointScrewZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointSphSph [
	interface createJointSphSph
]

{ #category : #'menubar items' }
CADEditor >> menuJointSpherical [
	interface createJointSpherical
]

{ #category : #'menubar items' }
CADEditor >> menuJointTranslationalZ [
	interface createJointTranslationalZ
]

{ #category : #'menubar items' }
CADEditor >> menuJointUniversalZ [
	interface createJointUniversalZ
]

{ #category : #menuExplain }
CADEditor >> menuKinematicExplainJoint [
	| labelString |
	labelString := 'Explain Joints'.
	self openExplainFile: 'StCADEditorMenuKinematicExplainJoint.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuKinematicExplainKineIJ [
	| labelString |
	labelString := 'Explain Kinematic IJ'.
	self openExplainFile: 'StCADEditorMenuKinematicExplainKinematicIJ.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuKinematicExplainMotion [
	| labelString |
	labelString := 'Explain Prescribe Motion'.
	self openExplainFile: 'StCADEditorMenuKinematicExplainMotion.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuKinematicExplainRedundantConstraint [
	| labelString |
	labelString := 'Explain Redundant Constraint'.
	self openExplainFile: 'StCADEditorMenuKinematicExplainRedundantConstraint.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuKinematicICZeroAllVelocities [
	interface zeroAllVelocities
]

{ #category : #'menubar items' }
CADEditor >> menuKinematicIJCreate [
	interface createKinematicIJ
]

{ #category : #'menubar items' }
CADEditor >> menuKinematicIJSelectList [
	| col sc |
	col := OrderedCollection new.
	interface kineIJList do: [:kineIJ | col add: kineIJ fullName -> kineIJ].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:a1 :a2 | a1 key <= a2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key])
		lines: Array new
		values: (col collect: [:a | [interface soleSelection: a value]])
]

{ #category : #'menubar items' }
CADEditor >> menuKinematicKineIJCreate [
	interface createKinematicIJ
]

{ #category : #'menubar items' }
CADEditor >> menuKinematicKineIJRobotAxis [
	interface selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADRobotAxisGO
				name: 'RobotAxis').
]

{ #category : #'menubar items' }
CADEditor >> menuMotionGeneral [
	interface createMotionGeneral
]

{ #category : #'menubar items' }
CADEditor >> menuMotionGravity [
	interface insertGravity
]

{ #category : #'menubar items' }
CADEditor >> menuMotionJointSelectList [
	| col sc |
	col := OrderedCollection new.
	interface jointList do: [:joint | col add: joint fullName -> joint].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:a1 :a2 | a1 key <= a2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key])
		lines: Array new
		values: (col collect: [:a | [interface soleSelection: a value]])
]

{ #category : #'menubar items' }
CADEditor >> menuMotionMassList [
	| block |
	block :=
			[:geoItem |
			MessageSend
				receiver: CADMassMarkerDirectionDialog
				selector: #openOn:withSpec:
				arguments: (Array with: geoItem with: #massMarkerWindowSpec).].
	^self createMenuFor: interface massMarkerList actionBlock: block.
]

{ #category : #'menubar items' }
CADEditor >> menuMotionMassList1 [
	| col sc |
	col := OrderedCollection new.
	interface partList do: [:part | col add: part name -> part.].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col
				using: [:a1 :a2 | a1 key <= a2 key.].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key.])
		lines: Array new
		values: (col collect: 
					[:a |
					MessageSend
						receiver: CADMassMarkerDirectionDialog
						selector: #openOn:withSpec:
						arguments: (Array with: a value massMarker with: #massMarkerWindowSpec).]).
]

{ #category : #'menubar items' }
CADEditor >> menuMotionMotionSelectList [
	| col sc |
	col := OrderedCollection new.
	interface motionList do: [:motion | col add: motion fullName -> motion].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:a1 :a2 | a1 key <= a2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key])
		lines: Array new
		values: (col collect: [:a | [interface soleSelection: a value]])
]

{ #category : #'menubar items' }
CADEditor >> menuMotionRotationalZ [
	interface createMotionRotationalZ
]

{ #category : #'menubar items' }
CADEditor >> menuMotionTranslationalZ [
	interface createMotionTranslationalZ
]

{ #category : #'menubar items' }
CADEditor >> menuOpenNotesReadOnly: readOnly [ 
	| geoRootItem app appWindow selfWindow |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	app := NotesEditor new.
	app geoItem: geoRootItem.
	app openInterface: (readOnly
			ifTrue: [#readOnlyWindowSpec]
			ifFalse: [#windowSpec]).
	appWindow := app builder window.
	appWindow label: ('<1s> Notes        <2s>' expandMacrosWith: geoRootItem name with: AdData adTitle title).
	builder notNil
		ifTrue: 
			[appWindow application: self.
			appWindow beSlave.
			selfWindow := builder window.
			selfWindow application: self.
			selfWindow beMaster]
]

{ #category : #'menubar items' }
CADEditor >> menuPlotJointList [
	^self createMenuOfPlotsFor: interface jointList
]

{ #category : #'menubar items' }
CADEditor >> menuPlotKineIJList [
	^self createMenuOfPlotsFor: interface kineIJList
]

{ #category : #'menubar items' }
CADEditor >> menuPlotMarkerList [
	^self createMenuOfPlotsFor: interface markerList
]

{ #category : #'menubar items' }
CADEditor >> menuPlotMotionList [
	^self createMenuOfPlotsFor: interface motionList
]

{ #category : #'menubar items' }
CADEditor >> menuPlotPartList [
	^self createMenuOfPlotsFor: interface massMarkerList
]

{ #category : #'menubar items' }
CADEditor >> menuSelectAssemblyList [
	| col sc |
	col := OrderedCollection new.
	interface assemblyList do: [:assembly | col add: assembly fullName -> assembly].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:a1 :a2 | a1 key <= a2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key])
		lines: Array new
		values: (col collect: [:a | [interface soleSelection: a value]])
]

{ #category : #menuExplain }
CADEditor >> menuSelectExplain [
	| labelString |
	labelString := 'Explain Select Menu Items'.
	self openExplainFile: 'StCADEditorMenuSelectExplain.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuSelectMarkerList [
	| col sc |
	col := OrderedCollection new.
	interface markerList do: [:marker | col add: marker fullName -> marker].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:a1 :a2 | a1 key <= a2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key])
		lines: Array new
		values: (col collect: [:a | [interface soleSelection: a value]])
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPartList [
	| col sc |
	col := OrderedCollection new.
	interface partList do: [:part | col add: part fullName -> part].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:a1 :a2 | a1 key <= a2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:a | a key])
		lines: Array new
		values: (col collect: [:a | MessageSend
					receiver: interface
					selector: #soleSelection:
					argument: a value])
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatex180 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 180.0d degreesToRadians
				with: 0.0d
				with: 0.0d) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatex270 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 270.0d degreesToRadians
				with: 0.0d
				with: 0.0d) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatex90 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 90.0d degreesToRadians
				with: 0.0d
				with: 0.0d) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatey180 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 0.0d
				with: 180.0d degreesToRadians
				with: 0.0d) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatey270 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 0.0d
				with: 270.0d degreesToRadians
				with: 0.0d) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatey90 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 0.0d
				with: 90.0d degreesToRadians
				with: 0.0d) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatez180 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 0.0d
				with: 0.0d
				with: 180.0d degreesToRadians) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatez270 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 0.0d
				with: 0.0d
				with: 270.0d degreesToRadians) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneRotatez90 [
	| aA |
	aA := (GEOEulerAnglesxyz
				with: 0.0d
				with: 0.0d
				with: 90.0d degreesToRadians) aA.
	interface selectPlane: aA
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneXrightYup [
	interface selectXrightYupPlane
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneXrightZdown [
	interface selectXrightZdownPlane
]

{ #category : #'menubar items' }
CADEditor >> menuSelectPlaneYupZleft [
	interface selectYupZleftPlane
]

{ #category : #'menubar items' }
CADEditor >> menuSelectSketchList [
	| col sc |
	col := OrderedCollection new.
	interface sketchList do: [:sketch | col add: sketch fullName -> sketch].
	col := col asArray.
	sc := SequenceableCollectionSorter on: col using: [:association1 :association2 | association1 key <= association2 key].
	sc sort.
	^Menu
		labelArray: (col collect: [:association | association key])
		lines: Array new
		values: (col collect: [:association | [interface selectActiveSketch: association value]])
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationAnimation [
	self animationWindowRaise
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationDynamic [
	interface startDynamic
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainAnimation [
	| labelString |
	labelString := 'Explain Animation'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainAnimation.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainDynamic [
	| labelString |
	labelString := 'Explain Dynamic Simulation'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainDynamic.sdoc'
		label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainIC [
	| labelString |
	labelString := 'Explain Initial Conditions'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainIC.sdoc'
		label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainPlot [
	| labelString |
	labelString := 'Explain Plot'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainPlot.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainQuasiStatic [
	| labelString |
	labelString := 'Explain Quasi Static Simulation'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainQuasiStatic.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainStop [
	| labelString |
	labelString := 'Explain Stop Simulation'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainStop.sdoc' label: labelString
]

{ #category : #menuExplain }
CADEditor >> menuSimulationExplainTransient [
	| labelString |
	labelString := 'Explain Transient Simulation'.
	self openExplainFile: 'StCADEditorMenuSimulationExplainTransient.sdoc'
		label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationKinematic [
	interface startKinematic
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationPreviousAssembledState [
	interface updateFromInitiallyAssembledState
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationPreviousInputState [
	interface updateFromInputState
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationQuasiStatic [
	interface startQuasiStatic
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationRestoreInitialConditions [
	interface updateFromInputState
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationStop [
	interface stopSimulation
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationTransient [
	interface startTransient
]

{ #category : #'menubar items' }
CADEditor >> menuSimulationZeroAllVelocities [
	interface zeroAllVelocities
]

{ #category : #'menubar items' }
CADEditor >> menuTorqueGeneral [
	interface createTorqueGeneral
]

{ #category : #'menubar items' }
CADEditor >> menuTorqueSpringDamper [
	interface createTorqueSpringDamper
]

{ #category : #'menubar items' }
CADEditor >> menuTreeView [
	| menu |
	menu := self class menuTreeView.
	^menu
]

{ #category : #menuExplain }
CADEditor >> menuViewExplain [
	| labelString |
	labelString := 'Explain View Menu Items'.
	self openExplainFile: 'StCADEditorMenuViewExplain.sdoc' label: labelString
]

{ #category : #'menubar items' }
CADEditor >> menuViewNotes [
	self menuOpenNotesReadOnly: true
]

{ #category : #'menubar items' }
CADEditor >> menuViewRegen [
	interface removeDisplayList.
	cadView invalidate
]

{ #category : #'menubar items' }
CADEditor >> menuViewSolid [
	interface display isOpenGL: true.
	cadView invalidate
]

{ #category : #'menubar items' }
CADEditor >> menuViewTiltRotatePart [
	interface tiltRotatePart
]

{ #category : #'menubar items' }
CADEditor >> menuViewTiltRotateWorld [

	self adOpportunity.
	interface tiltRotateWorld.
	self menuViewRegen
]

{ #category : #'menubar items' }
CADEditor >> menuViewTranscript [
	self textCollectorWindowRaise
]

{ #category : #'menubar items' }
CADEditor >> menuViewWireframe [
	interface display isOpenGL: false.
	cadView invalidate
]

{ #category : #'menubar items' }
CADEditor >> menuViewXrightYup [
	self adOpportunity.
	interface viewXrightYup
]

{ #category : #'menubar items' }
CADEditor >> menuViewXrightZdown [
	self adOpportunity.
	interface viewXrightZdown
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupQuadmpm [
	self adOpportunity.
	interface viewYupQuadmpm
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupQuadmpp [
	self adOpportunity.
	interface viewYupQuadmpp
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupQuadppm [
	self adOpportunity.
	interface viewYupQuadppm
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupQuadppp [
	self adOpportunity.
	interface viewYupQuadppp
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupXleft [
	self adOpportunity.
	interface viewYupXleft
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupXright [
	self adOpportunity.
	interface viewYupXright
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupZleft [
	self adOpportunity.
	interface viewYupZleft
]

{ #category : #'menubar items' }
CADEditor >> menuViewYupZright [
	self adOpportunity.
	interface viewYupZright
]

{ #category : #'menubar items' }
CADEditor >> menuViewZoomIn [
	self adOpportunity.
	interface zoomIn
]

{ #category : #'menubar items' }
CADEditor >> menuViewZoomOut [
	self adOpportunity.
	interface zoomOut
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupQuadmmp [
	self adOpportunity.
	interface viewZupQuadmmp
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupQuadmpp [
	self adOpportunity.
	interface viewZupQuadmpp
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupQuadpmp [
	self adOpportunity.
	interface viewZupQuadpmp
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupQuadppp [
	self adOpportunity.
	interface viewZupQuadppp
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupXleft [
	self adOpportunity.
	interface viewZupXleft
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupXright [
	self adOpportunity.
	interface viewZupXright
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupYleft [
	self adOpportunity.
	interface viewZupYleft
]

{ #category : #'menubar items' }
CADEditor >> menuViewZupYright [
	self adOpportunity.
	interface viewZupYright
]

{ #category : #'menubar items' }
CADEditor >> openExplainFile: aFilename label: labelString [ 
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
			Dialog warn: ('All Explain files (*.sdoc) should be in the subsubdirectory ''< 1s >''. <n>When unzipping freecad*.zip or cadsm*.zip and patch*.zip make sure that subdirectory information are preserved. <n>Otherwise, create subsubdirectory ''< 1s >'' and move all *.sdoc into it.' expandMacrosWith: dirString)]
]

{ #category : #'menubar items' }
CADEditor >> openFileDialogPOVRay [
	| geoRootItem titleString filterArray filenameString newName prompt initName originalDir newDir |
	geoRootItem := interface geoRootItem.
	geoRootItem isNil 
		ifTrue: 
			[Dialog warn: 'The root item is nil.'.
			^nil].
	(('win32*' match: OSHandle currentPlatformID) 
		or: ['unix*linux*' match: OSHandle currentPlatformID]) 
			ifTrue: 
				[titleString := 'Save an Assembly as POVRay'.
				filterArray := OrderedCollection new.
				filterArray 
					add: (CommonFileFilter filter: '*.pov' description: '*.pov  (POVRay)').
				filterArray 
					add: (CommonFileFilter filter: '*.*' description: '*.*  (All)').
				filenameString := self fileName.
				filenameString := filenameString isNil 
							ifTrue: ['']
							ifFalse: [filenameString asFilename moniker , '.pov'].
				newName := CommonFileSelectionDialog 
							saveTitle: titleString
							filters: filterArray
							filename: filenameString
							promptOverwrite: true]
			ifFalse: 
				[prompt := 'Enter filename to save Assembly as text.<n>Use wildcards (*.pov) to get list of relevant Assembly files.' 
							expandMacros.
				initName := (fileName notNil and: [fileName isEmpty not]) 
							ifTrue: [fileName asFilename moniker]
							ifFalse: ['*'].
				initName := initName , '.pov'.
				originalDir := Filename currentDirectory directory.
				newDir := fileName asFilename directory.
				newDir beCurrentDirectory.
				newName := [Dialog requestFileName: prompt default: initName] 
							ensure: [originalDir beCurrentDirectory]].
	^newName
]

{ #category : #'menubar items' }
CADEditor >> openPlotOn: geoItem withSpec: symbol [ 
	| appWindow selfWindow |
	appWindow := (CADPlot openOn: geoItem withSpec: symbol) window.
	appWindow application: self.
	appWindow beSlave.
	selfWindow := builder window.
	selfWindow application: self.
	selfWindow beMaster
]

{ #category : #'menubar items' }
CADEditor >> openReadOnlyFile: aFilename label: labelString [

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

{ #category : #'initialize-release' }
CADEditor >> openStartUpDialog [
	| changeFilename changeFileStream changeContents string openDialog stop interval start |
	changeFilename := ObjectMemory imageFilePrefixWithoutPath 
				, Filename changeExtension.
	SourceFileManager default changesFileName: changeFilename.
	changeFileStream := changeFilename asFilename readWriteStream.
	[changeContents := changeFileStream contents] 
		ensure: [changeFileStream close].
	string := self pclString.
	openDialog := false.
	stop := 1.
	5 timesRepeat: 
			[interval := changeContents 
						findString: string
						startingAt: stop
						ignoreCase: true
						useWildcards: true.
			start := interval first.
			start = 0 
				ifTrue: [openDialog := true]
				ifFalse: [stop := start + interval size - 1]].
	openDialog 
		ifTrue: 
			[Dialog 
				warn: 'Click Explain at Top Left for <n>Quick Test and Quick Start' 
						expandMacros]
]

{ #category : #'menubar items' }
CADEditor >> openTitle: title fileExt: fileExt description: description prompt: prompt [ 
	^self
		dialogType: 'open'
		Title: title
		fileExt: fileExt
		description: description
		prompt: prompt
]

{ #category : #'menubar items' }
CADEditor >> outputPOVTimeSeriesOn: newName [ 
	| writeStream |
	writeStream := (newName asFilename longMoniker , '_dat.inc') asFilename 
				writeStream.
	
	[writeStream storePOVLevel: 0 title: '// ' , self longTitle.
	writeStream cr.
	writeStream storePOVLevel: 0
		title: ('// Time Series from <1s>.' 
				expandMacrosWith: fileName asFilename tail).
	writeStream cr.
	interface geoRootItem storePOVTimeSeriesOn: writeStream] 
			valueNowOrOnUnwindDo: [writeStream close]
]

{ #category : #'menubar items' }
CADEditor >> outputPOVcamOn: newName [ 
	| writeStream fullRect viewAngleDeg cameraDist centerOfView cameraVertical cameraLocation |
	writeStream := (newName asFilename longMoniker , '_cam.inc') asFilename 
				writeStream.
	
	[writeStream storePOVLevel: 1 title: self stringPOVcam.
	fullRect := interface fullProjectedRectangle.
	viewAngleDeg := 20.
	cameraDist := fullRect extent r / 2 
				/ (viewAngleDeg degreesToRadians / 2) tan.
	cameraDist := 1.2 * cameraDist.
	centerOfView := interface a3DCenter.
	cameraVertical := interface projectionVertical.
	cameraLocation := centerOfView - (cameraDist * interface projectionAxis).
	cameraLocation := cameraLocation 
				collect: [:coord | coord asFloat printString].
	cameraVertical := cameraVertical 
				collect: [:coord | coord asFloat printString].
	centerOfView := centerOfView collect: [:coord | coord asFloat printString].
	writeStream storePOVLevel: 1
		title: ('  location %<<1s>, <2s>, <3s>>  //Camera location.' 
				expandMacrosWithArguments: cameraLocation).
	writeStream storePOVLevel: 1
		title: ('  sky %<<1s>, <2s>, <3s>>  //The sky vector will always be up in the image.' 
				expandMacrosWithArguments: cameraVertical).
	writeStream storePOVLevel: 1
		title: ('  look_at %<<1s>, <2s>, <3s>>  //Focus of camera view.' 
				expandMacrosWithArguments: centerOfView).
	writeStream storePOVLevel: 1
		title: ('  angle <1s>  //Zoom' expandMacrosWith: viewAngleDeg).
	writeStream storePOVLevel: 1
		title: ('}

light_source {
  %<<1s>, <2s>, <3s>>
  color red 1.0  green 1.0  blue 1.0
}
' 
				expandMacrosWithArguments: cameraLocation)] 
			valueNowOrOnUnwindDo: [writeStream close]
]

{ #category : #'menubar items' }
CADEditor >> outputPOVdatCurrentOn: newName [ 
	| writeStream |
	writeStream := (newName asFilename longMoniker , '_dat.inc') asFilename 
				writeStream.
	
	[writeStream storePOVLevel: 0 title: '// ' , self longTitle.
	writeStream cr.
	writeStream storePOVLevel: 0
		title: ('// Time Series from <1s>.' 
				expandMacrosWith: fileName asFilename tail).
	writeStream cr.
	interface geoRootItem storePOVdatCurrentOn: writeStream] 
			valueNowOrOnUnwindDo: [writeStream close]
]

{ #category : #'menubar items' }
CADEditor >> outputPOViniCurrentOn: newName [ 
	| writeStream |
	writeStream := (newName asFilename longMoniker , '.ini') asFilename 
				writeStream.
	
	[writeStream storePOVLevel: 1 title: '; ' , self longTitle.
	writeStream storePOVLevel: 1
		title: '
Antialias=Off
Antialias_Threshold=0.2
Antialias_Depth=3
Jitter=off

Height=240
Width=320
Start_Row=0.0
End_Row=1.0
Start_Column=0.0
End_Column=1.0
'.
	writeStream storePOVLevel: 1
		title: ('Input_File_Name=<1s>.pov' 
				expandMacrosWith: newName asFilename moniker).
	writeStream cr.
	writeStream storePOVLevel: 1 title: 'Initial_Frame=0'.
	writeStream storePOVLevel: 1 title: 'Final_Frame=0'.
	writeStream cr.
	writeStream storePOVLevel: 1 title: 'Initial_Clock=0'.
	writeStream storePOVLevel: 1 title: 'Final_Clock=0'.
	writeStream storePOVLevel: 1
		title: '
Cyclic_Animation=off
Pause_when_Done=off  
'] 
			ensure: [writeStream close]
]

{ #category : #'menubar items' }
CADEditor >> outputPOViniOn: newName [ 
	| writeStream |
	writeStream := (newName asFilename longMoniker , '.ini') asFilename 
				writeStream.
	
	[writeStream storePOVLevel: 1 title: '; ' , self longTitle.
	writeStream storePOVLevel: 1
		title: '
Antialias=Off
Antialias_Threshold=0.2
Antialias_Depth=3
Jitter=off

Height=240
Width=320
Start_Row=0.0
End_Row=1.0
Start_Column=0.0
End_Column=1.0
'.
	writeStream storePOVLevel: 1
		title: ('Input_File_Name=<1s>.pov' 
				expandMacrosWith: newName asFilename moniker).
	writeStream cr.
	writeStream storePOVLevel: 1 title: 'Initial_Frame=0'.
	writeStream storePOVLevel: 1
		title: ('Final_Frame=<1p>' 
				expandMacrosWith: interface geoRootItem dataSeries size - 1).
	writeStream cr.
	writeStream storePOVLevel: 1 title: 'Initial_Clock=0'.
	writeStream storePOVLevel: 1
		title: ('Final_Clock=<1p>' 
				expandMacrosWith: interface geoRootItem dataSeries size - 1).
	writeStream storePOVLevel: 1
		title: '
Cyclic_Animation=off
Pause_when_Done=off  
'] 
			ensure: [writeStream close]
]

{ #category : #'menubar items' }
CADEditor >> outputPOVpovOn: newName [ 
	| writeStream |
	writeStream := (newName asFilename longMoniker , '.pov') asFilename 
				writeStream.
	
	[writeStream storePOVLevel: 1
		title: '// ' , self longTitle 
				, '

#include "colors.inc" 
#include "glass.inc"
#include "finish.inc"
#include "textures.inc"

#macro MARKER (RotX, RotY, RotZ, X, Y, Z, length)
	union{
		cylinder{<0, 0, 0>, <1, 0, 0>, 0.05
			pigment{rgb <1, 0, 0>}
		}
		cylinder{<0, 0, 0>, <0, 1, 0>, 0.05
			pigment{rgb <0, 1, 0>}
		}
		cylinder{<0, 0, 0>, <0, 0, 1>, 0.05
			pigment{rgb <0, 0, 1>}
		}
	scale <length, length, length>
	rotate <RotX, RotY, RotZ>
	translate <X, Y, Z>
	}
#end

#macro VECTOR (X, Y, Z, VX, VY, VZ, magnification)
	union{
		cylinder{<0, 0, 0>, <0, 0, 0.7>, 0.025}
		cone{<0, 0, 0.7>, 0.05, <0, 0, 1>, 0}
		pigment{rgb <1, 0, 0>}
		#declare V=<VX, VY, VZ>;   
		#declare Vabs=vlength(V);   
		scale magnification * Vabs
		rotate <0, degrees(acos(VZ/Vabs)), degrees(atan2(VY,VX))>
		translate <X, Y, Z>
	}
#end

#macro AXIAL (X, Y, Z, VX, VY, VZ, magnification)
	union{
		cylinder{<0, 0, 0>, <0, 0, 0.6>, 0.025}
		cone{<0, 0, 0.6>, 0.05, <0, 0, 0.75>, 0.025}
		cone{<0, 0, 0.75>, 0.05, <0, 0, 1>, 0}
		pigment{rgb <1, 0, 0>}
		#declare V=<VX, VY, VZ>;   
		#declare Vabs=vlength(V);   
		scale magnification * Vabs
		rotate <0, degrees(acos(VZ/Vabs)), degrees(atan2(VY,VX))>
		translate <X, Y, Z>
	}
#end
'.
	writeStream storePOVLevel: 1
		title: ('#include "<1s>" // Camera and lighting infomation.' 
				expandMacrosWith: newName asFilename moniker , '_cam.inc').
	writeStream storePOVLevel: 1
		title: ('#include "<1s>" // Arrays of motion data.' 
				expandMacrosWith: newName asFilename moniker , '_dat.inc').
	writeStream cr.
	interface geoRootItem storePOVOn: writeStream level: 1] 
			valueNowOrOnUnwindDo: [writeStream close]
]

{ #category : #'menubar items' }
CADEditor >> outputRobotAxesOn: aFilename [ 
	| writeStream |
	writeStream := aFilename asFilename writeStream.
	[interface geoRootItem storeRobotAxesOn: writeStream] 
		ensure: [writeStream close]
]

{ #category : #'initialize-release' }
CADEditor >> postBuildWith: aBuilder [ 
	builder window application: self.
	self interface when: #select
		do: [self selectionValue: interface selections asArray].
	self interface when: #deselect
		do: [self selectionValue: interface selections asArray].
	self interface 
		when: #mousePointChanged
		ask: self
		perform: #rDcursorPxValue:.
	self interface 
		when: #handleInvoked
		ask: self
		perform: #handleValue:.
	self interface 
		when: #noHandleInvoked
		ask: self
		perform: #clearHandleValue.
	self treeView list root: GEOTreeNode new displayIt: true.
	(self widgetAt: #treeViewID) 
		when: #selectionChanged
		ask: self
		perform: #updateCadViewFromTreeView.
	self interface 
		when: #select
		ask: self
		perform: #updateTreeViewFromCadView
]

{ #category : #'initialize-release' }
CADEditor >> postOpenWith1: aBuilder [ 
	"Use a brand new readStream for the change file to get the entire 
	contents."

	| changeFileStream string changeContents |
	interface projectWorldFrame.
	interface centerPaneAtDrawingPoint: 0 @ 0.
	changeFileStream := SourceFileManager default targetFile name asFilename readStream.
	string := '*Parcel loadParcelFrom: ''freecad*.pcl''!*'.
	[(changeFileStream size < (4 * string size) and: [(changeContents := changeFileStream contents) size < string size or: [string match: changeContents]])
		ifTrue: [Dialog warn: 'Click Explain at Top Left for <n>Quick Test and Quick Start' expandMacros]]
		ensure: [changeFileStream close]
]

{ #category : #'initialize-release' }
CADEditor >> postOpenWith: aBuilder [

	"Open the start up dialog for the first five launches only."

	interface centerPaneAtDrawingPoint: 0 @ 0.
	JunColorChoiceHSB installColorBarsAndPlates.
	'#{VWQR:RuntimePackager.RuntimeManager}' ifDefinedDo: [ :rtmgr | 
		rtmgr isRuntime ifTrue: [ self openStartUpDialog ] ]
]

{ #category : #aspects }
CADEditor >> rDcursorPx [
	"This method was generated by UIDefiner. Any edits made here 
	may be lost whenever methods are automatically defined. The 
	initialization provided below may have been preempted by an 
	initialize method."

	^rDcursorPx isNil
		ifTrue: [rDcursorPx := String new asValue]
		ifFalse: [rDcursorPx]
]

{ #category : #aspects }
CADEditor >> rDcursorPxValue: aPoint [ 
	self rDcursorPx value: aPoint printString
]

{ #category : #'interface closing' }
CADEditor >> requestForWindowClose [
	| answer |
	(answer := super requestForWindowClose) 
		ifTrue: 
			[JunColorChoiceModel subclasses do: [:class | class clearBarsAndPlates]].
	^answer
]

{ #category : #'menubar items' }
CADEditor >> saveTitle: title fileExt: fileExt description: description prompt: prompt [ 
	^self
		dialogType: 'save'
		Title: title
		fileExt: fileExt
		description: description
		prompt: prompt
]

{ #category : #aspects }
CADEditor >> selection [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."

	^selection isNil
		ifTrue:
			[selection := String new asValue]
		ifFalse:
			[selection]
]

{ #category : #aspects }
CADEditor >> selectionValue: cadGO [ 
	self selection value: cadGO printString
]

{ #category : #accessing }
CADEditor >> textCollector [
	^textCollector
]

{ #category : #accessing }
CADEditor >> textCollectorWindow [
	^self dependents detect: [:dependent | (dependent isKindOf: ApplicationWindow)
			and: [dependent model isMemberOf: CADTextCollector]]
		ifNone: nil
]

{ #category : #'menubar items' }
CADEditor >> textCollectorWindowRaise [
	| selfWindow textCollectorWindow |
	textCollectorWindow := self textCollectorWindow.
	textCollectorWindow isNil
		ifTrue: 
			[selfWindow := builder window.
			textCollectorWindow := (CADTextCollector openOn: textCollector) window.
			selfWindow application: self.
			textCollectorWindow application: self.
			selfWindow beMaster.
			textCollectorWindow beSlave]
		ifFalse: 
			[textCollectorWindow model adOpportunity.
			textCollectorWindow expand; raise]
]

{ #category : #accessing }
CADEditor >> title [
	^'freeCAD          Sponsor Message'
]

{ #category : #aspects }
CADEditor >> treeView [
	^treeView
]

{ #category : #'initialize-release' }
CADEditor >> updateCadViewFromTreeView [
	| geoSelection |
	self interface removeActionsWithReceiver: self forEvent: #select.
	(self treeView selection notNil and: 
			[(geoSelection := self treeView selection geoItem) notNil 
				and: [geoSelection class canUnderstand: #cadObject]]) 
		ifTrue: 
			[geoSelection isSketch 
				ifTrue: [self interface selectActiveSketch: geoSelection]
				ifFalse: 
					[geoSelection cadObject notNil 
						ifTrue: [self interface soleSelection: geoSelection]
						ifFalse: [self interface noSelections]]]
		ifFalse: [self interface noSelections].
	self interface 
		when: #select
		ask: self
		perform: #updateTreeViewFromCadView.
	self updateTreeViewMenu
]

{ #category : #aspects }
CADEditor >> updateTreeModel1: controller [ 
	| newRoot treeModel originalRoot |
	newRoot := interface geoRootItem isNil
				ifTrue: [GEOTreeNode new]
				ifFalse: [interface geoRootItem asTreeNode].
	treeModel := self treeView list.
	originalRoot := treeModel at: 1.
	originalRoot copyFrom: newRoot.
	treeModel refreshRoot.
	treeModel expand: 1
]

{ #category : #aspects }
CADEditor >> updateTreeModel2: controller [ 
	| newRoot treeModel |
	newRoot := interface geoRootItem isNil 
				ifTrue: [GEOTreeNode new]
				ifFalse: [interface geoRootItem asTreeNode].
	treeModel := self treeView list.
	treeModel root: newRoot displayIt: true.
	treeModel refreshRoot.
	treeModel expand: 1
]

{ #category : #aspects }
CADEditor >> updateTreeModel3: controller [ 
	| newRoot treeModel originalRoot |
	newRoot := interface geoRootItem isNil 
				ifTrue: [GEOTreeNode new]
				ifFalse: [interface geoRootItem asTreeNode].
	treeModel := self treeView list.
	originalRoot := treeModel at: 1.
	originalRoot geoItem == newRoot geoItem 
		ifTrue: 
			[originalRoot copyFrom: newRoot.
			treeModel refreshRoot]
		ifFalse: [treeModel root: newRoot displayIt: true].
	treeModel expand: 1.
	treeModel refreshNodeAt: 1
]

{ #category : #aspects }
CADEditor >> updateTreeModel: controller [ 
	| newRoot treeModel originalRoot |
	newRoot := interface geoRootItem isNil
				ifTrue: [GEOTreeNode new]
				ifFalse: [interface geoRootItem asTreeNode].
	treeModel := self treeView list.
	originalRoot := treeModel at: 1.
	originalRoot copyFrom: newRoot.
	treeModel refreshRoot.
	treeModel expand: 1
]

{ #category : #'initialize-release' }
CADEditor >> updateTreeViewFromCadView [
	| geoSelection index |
	self 
		updateTreeModel: (self builder componentAt: #treeViewID) widget controller.
	geoSelection := self interface soleSelection.
	index := self treeView list 
				findFirst: [:elem | elem value geoItem == geoSelection]
				startingAt: 1.
	(self widgetAt: #treeViewID) removeActionsWithReceiver: self
		forEvent: #selectionChanged.
	self treeView selectionIndex: index.
	(self widgetAt: #treeViewID) 
		when: #selectionChanged
		ask: self
		perform: #updateCadViewFromTreeView.
	self updateTreeViewMenu
]

{ #category : #'initialize-release' }
CADEditor >> updateTreeViewFromCadView1 [
	| geoSelection index |
	self updateTreeModel: (self builder componentAt: #treeViewID) widget controller.
	geoSelection := self interface soleSelection.
	index := self treeView list findFirst: [:elem | elem value geoItem == geoSelection]
				startingAt: 1.
	self treeView selectionIndexHolder retractInterestsFor: self.
	self treeView selectionIndex: index.
	self treeView selectionIndexHolder onChangeSend: #updateCadViewFromTreeView to: self
]

{ #category : #'initialize-release' }
CADEditor >> updateTreeViewFromCadView2 [
	| geoSelection index |
	self 
		updateTreeModel: (self builder componentAt: #treeViewID) widget controller.
	geoSelection := self interface soleSelection.
	index := self treeView list 
				findFirst: [:elem | elem value geoItem == geoSelection]
				startingAt: 1.
	(self widgetAt: #treeViewID) removeActionsWithReceiver: self
		forEvent: #selectionChanged.
	self treeView selectionIndex: index.
	(self widgetAt: #treeViewID) 
		when: #selectionChanged
		ask: self
		perform: #updateCadViewFromTreeView
]

{ #category : #'initialize-release' }
CADEditor >> updateTreeViewMenu [
	| treeViewController geoSelection cadObject cadObjectMenu |
	treeViewController := (self widgetAt: #treeViewID) controller.
	(self treeView selection notNil and: 
			[(geoSelection := self treeView selection geoItem) notNil and: 
					[(geoSelection class canUnderstand: #cadObject) and: 
							[(cadObject := geoSelection cadObject) notNil 
								and: [(cadObjectMenu := cadObject aTreeViewPopupMenu) notNil]]]]) 
		ifTrue: 
			[treeViewController menuHolder: cadObjectMenu.
			treeViewController performer: cadObject]
		ifFalse: 
			[treeViewController menuHolder: nil.
			treeViewController performer: nil]
]

{ #category : #'initialize-release' }
CADEditor >> updateTreeViewMenu1 [
	| treeViewController geoSelection cadObject popupMenu drawingMenu |
	treeViewController := (self widgetAt: #treeViewID) controller.
	(self treeView selection notNil and: 
			[(geoSelection := self treeView selection geoItem) notNil and: 
					[(geoSelection class canUnderstand: #cadObject) and: 
							[(cadObject := geoSelection cadObject) notNil 
								and: [(popupMenu := cadObject menu) notNil]]]]) 
		ifTrue: 
			[drawingMenu := Menu new.
			drawingMenu addItemLabel: '&Undo' value: [interface undo].
			drawingMenu addItemLabel: 'Cu&t' value: [interface cut].
			popupMenu addItemGroup: (Array 
						with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
			popupMenu addItemLabel: 'Rename' value: [treeViewController inplaceEdit].
			treeViewController menuHolder: popupMenu.
			treeViewController performer: cadObject]
		ifFalse: 
			[treeViewController menuHolder: nil.
			treeViewController performer: nil]
]

{ #category : #'initialize-release' }
CADEditor >> updateTreeViewMenu2 [
	| treeViewController geoSelection cadObject cadObjectMenu popupMenu drawingMenu |
	treeViewController := (self widgetAt: #treeViewID) controller.
	(self treeView selection notNil and: 
			[(geoSelection := self treeView selection geoItem) notNil and: 
					[(geoSelection class canUnderstand: #cadObject) and: 
							[(cadObject := geoSelection cadObject) notNil 
								and: [(cadObjectMenu := cadObject menu) notNil]]]]) 
		ifTrue: 
			[popupMenu := Menu new.
			popupMenu addItemLabel: 'Rename' value: [treeViewController inplaceEdit].
			popupMenu addLine.
			popupMenu addPart: cadObjectMenu.
			drawingMenu := Menu new.
			drawingMenu addItemLabel: '&Undo' value: [interface undo].
			drawingMenu addItemLabel: 'Cu&t' value: [interface cut].
			popupMenu addItemGroup: (Array 
						with: ((MenuItem labeled: interface menuLabel) submenu: drawingMenu)).
			treeViewController menuHolder: popupMenu.
			treeViewController performer: cadObject]
		ifFalse: 
			[treeViewController menuHolder: nil.
			treeViewController performer: nil]
]

{ #category : #private }
CADEditor >> value: aMessageSend [ 
	"The drawing editor gets sent this message with a message send 
	as a result of having a menu pick off of the menubar menu."

	^aMessageSend value
]
