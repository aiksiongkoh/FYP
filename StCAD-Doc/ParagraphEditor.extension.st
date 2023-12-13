Extension { #name : #ParagraphEditor }

{ #category : #'*StCAD-Doc-StCAD-Doc' }
ParagraphEditor >> addEmphasis: additions removeEmphasis: deletions allowDuplicates: bool [ 
	| t |
	self selectionStartIndex = self selectionStopIndex
		ifTrue: 
			["only change emphasisHere while typing"
			t := Text string: 'x' emphasis: emphasisHere.
			t
				addEmphasis: additions
				removeEmphasis: deletions
				allowDuplicates: bool.
			emphasisHere := t emphasisAt: 1]
		ifFalse: 
			[t := self selection.
			t
				addEmphasis: additions
				removeEmphasis: deletions
				allowDuplicates: bool.
			self replaceSelectionWith: t]
]
