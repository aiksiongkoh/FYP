Extension { #name : #SmalltalkWorkbench }

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> cMethodOfCADSM [
	"SmalltalkWorkbench cMethodOfStCAD."

	| cMethod |
	cMethod := OrderedCollection new.
	self cPackageModelOfCADSM do: [:a | cMethod addAll: a methods].
	^cMethod
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> cPackageModelOfCADSM [
	"SmalltalkWorkbench cPackageModelOfStCAD."

	^PackageModel allInstances select: [:a | '*CADSM*' match: a name]
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> cProtocolOfCADSM [
	"SmalltalkWorkbench cProtocolOfStCAD."

	| cProtocol |
	cProtocol := Set new.
	self cMethodOfCADSM do: [:a | cProtocol add: a protocol].
	^cProtocol
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> exampleChangeProtocol [

	"SmalltalkWorkbench exampleChangeProtocol."

	| change |
	change := Refactory_Browser_RenameProtocolChange
		          class: Core_Collection
		          oldProtocol: #CADSM
		          newProtocol: #'CADSM-Misc'. "VW_TRANSLATION:Refactory.Browser.RenameProtocolChange:Refactory_Browser_RenameProtocolChange" "VW_TRANSLATION:Core.Collection:Core_Collection"
	change execute
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> exampleMisc [
	"self exampleMisc."

	SmalltalkWorkbench promptThenBrowseMethodsInProtocolFrom: nil
	"'koh', 'MbD', 'CAD', 'DYN', 'StMath', 'StDoc', 'StGeo', 'PDMS', 'UI', 'FEM', 'NMT', 'StGeo', 'CADSM'"
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> renameEveryProtocol: old to: new [
	"SmalltalkWorkbench renameEveryProtocol: 'CAD' to: 'CADSM-UI'"

	| filter mc cMethodWithProtocol cImplementingClass |
	mc := MethodCollector new.
	filter := mc protocol: old asSymbol.
	cMethodWithProtocol := mc select: filter.
	mc browseSelect: filter.
	(Dialog confirm: 'Proceed to make change?') ifFalse: [^self].
	cImplementingClass := (cMethodWithProtocol
				collect: [:a | a implementingClass]) asSet.
	cImplementingClass
		do: [:aClass | self renameProtocol: old to: new in: aClass]
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> renameEveryProtocol: old to: new in: classString [
	"SmalltalkWorkbench renameEveryProtocol: 'As yet unclassified' to: 'accessing' in: 'StCAD.NMT.*'"

	| filter mc cMethodWithProtocol cImplementingClass result |
	mc := MethodCollector new.
	filter := mc protocol: old asSymbol.
	cMethodWithProtocol := mc select: filter.
	result := cMethodWithProtocol select: 
					[:a |
					(a isMemberOf: MethodDefinition)
						and: [classString match: a implementingClass fullName]].
	result isEmpty
		ifTrue: 
			[Dialog warn: #NoMethodsFound << #dialogs >> 'No methods found'.
			^self]
		ifFalse: 
			[mc
				openListBrowserOn: result
				label: filter displayString
				initialSelection: filter initialSelection.
			(Dialog confirm: 'Proceed to make change?') ifFalse: [^self]].
	cImplementingClass := (result collect: [:a | a implementingClass]) asSet.
	cImplementingClass
		do: [:aClass | self renameProtocol: old to: new in: aClass]
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SmalltalkWorkbench classSide >> renameProtocol: old to: new in: class [

	"SmalltalkWorkbench renameProtocol: 'CAD' to: 'CADSM-UI' in: Core.Collection."

	| change |
	change := Refactory_Browser_RenameProtocolChange
		          class: class
		          oldProtocol: old asSymbol
		          newProtocol: new asSymbol. "VW_TRANSLATION:Refactory.Browser.RenameProtocolChange:Refactory_Browser_RenameProtocolChange"
	change execute
]
