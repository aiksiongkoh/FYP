Class {
	#name : #AnyNMT,
	#superclass : #NMTSubItem,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
AnyNMT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
AnyNMT >> aColor [
	^aSup aColor
]

{ #category : #accessing }
AnyNMT >> aModel [
	^aSup aModel
]

{ #category : #accessing }
AnyNMT >> aRegion [
	^aSup aRegion
]

{ #category : #accessing }
AnyNMT >> aShell [
	^aSup aShell
]

{ #category : #accessing }
AnyNMT >> aShellUse [
	^aSup aShellUse
]

{ #category : #accessing }
AnyNMT >> alpha [
	^(self triggerEvent: #getalpha) ifNil: 
			[| answer |
			answer := 1.0d.
			self alpha: answer.
			answer]
]

{ #category : #accessing }
AnyNMT >> alpha: alpha [ 
	self removeActionsForEvent: #getalpha.
	alpha ifNotNil: 
			[self 
				when: #getalpha
				ask: alpha
				perform: #yourself]
]

{ #category : #accessing }
AnyNMT >> cSub [
	self subclassResponsibility
]

{ #category : #calc }
AnyNMT >> calcBoundingBox [
	aSup ifNotNil: [aSup clearBoundingBox]
]

{ #category : #testing }
AnyNMT >> hasAlpha [
	^self alpha notNil
]

{ #category : #testing }
AnyNMT >> hasPaint [
	^self paint notNil
]

{ #category : #testing }
AnyNMT >> hasStipple [
	^self stipplePattern notNil
]

{ #category : #testing }
AnyNMT >> includesEdge: aEdge [ 
	^(self selectEdge: [:item | item == aEdge]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesEdgeUse: aEdgeUse [ 
	^(self selectEdgeUse: [:item | item == aEdgeUse]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesFace: aFace [ 
	^(self selectFace: [:item | item == aFace]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesFaceUse: aFaceUse [ 
	^(self selectFaceUse: [:item | item == aFaceUse]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesLoop: aLoop [ 
	^(self selectLoop: [:item | item == aLoop]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesLoopUse: aLoopUse [ 
	^(self selectLoopUse: [:item | item == aLoopUse]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesRegion: aRegion [ 
	^(self selectRegion: [:item | item == aRegion]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesShell: aShell [ 
	^(self selectShell: [:item | item == aShell]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesVertex: aVertex [ 
	^(self selectVertex: [:item | item == aVertex]) notEmpty
]

{ #category : #testing }
AnyNMT >> includesVertexUse: aVertexUse [ 
	^(self selectVertexUse: [:item | item == aVertexUse]) notEmpty
]

{ #category : #testing }
AnyNMT >> isVertexUse [
	^false
]

{ #category : #accessing }
AnyNMT >> lineWidth [
	^(self triggerEvent: #getlineWidth) ifNil: 
			[| answer |
			answer := 1.0d.
			self lineWidth: answer.
			answer]
]

{ #category : #accessing }
AnyNMT >> lineWidth: lineWidth [ 
	self removeActionsForEvent: #getlineWidth.
	lineWidth ifNotNil: 
			[self 
				when: #getlineWidth
				ask: lineWidth
				perform: #yourself]
]

{ #category : #accessing }
AnyNMT >> paint [
	^(self triggerEvent: #getpaint) ifNil: 
			[| answer |
"			answer := ColorValue green copy."
			answer := ColorValue cyan copy.
			self paint: answer.
			answer]
]

{ #category : #accessing }
AnyNMT >> paint: paint [ 
	self removeActionsForEvent: #getpaint.
	paint ifNotNil: 
			[self 
				when: #getpaint
				ask: paint
				perform: #yourself]
]

{ #category : #'initialize-release' }
AnyNMT >> preSave [
	self subclassResponsibility
]

{ #category : #accessing }
AnyNMT >> removeSub: aSub [ 
	^(self cSub remove: aSub ifAbsent: [nil]) ifNotNil: 
			[:aaSub | 
			aaSub aSup: nil.
			aaSub]
]

{ #category : #enumerating }
AnyNMT >> selectCurve: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectCurve: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectEdge: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectEdge: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectEdge: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectEdgeUse: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectEdgeUse: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectEdgeUse: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectFace: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectFace: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectFace: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectFaceUse: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectFaceUse: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectFaceUse: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectLoop: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectLoop: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectLoop: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectLoopUse: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectLoopUse: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectLoopUse: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectModel: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectModel: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectRegion: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectRegion: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectRegion: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectShell: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectShell: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectShell: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectShellUse: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectShellUse: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectShellUse: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectSurface: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectSurface: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectVertex: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectVertex: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectVertex: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #enumerating }
AnyNMT >> selectVertexUse: aBlock [

	| aSet |
	aSet := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self selectVertexUse: aBlock into: aSet.
	^ aSet
]

{ #category : #enumerating }
AnyNMT >> selectVertexUse: aBlock into: aSet [ 
	self subclassResponsibility
]

{ #category : #accessing }
AnyNMT >> stipplePattern [
	| answer |
	answer := self triggerEvent: #getstipplePattern.
	^answer
]
