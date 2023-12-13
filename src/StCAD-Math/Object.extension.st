Extension { #name : #Object }

{ #category : #'*StCAD-Math-StCAD-Math' }
Object >> isReal [
	"Answer whether the receiver is a Real number.  This
	means essentially that it's an instance of a subclass of
	Number.  Since many mathematical operations in the
	system are designed only to work with the Real numbers,
	it's convenient to be able to test for this property."

	^false
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Object >> printForExport [
	^self printString
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Object >> raiseTranscript [
	| window |
	ScheduledControllers scheduledControllers
		do: 
			[:controller | 
			window := controller view.
			('VisualWorks*' match: window label)
				ifTrue: [window raise]]
]
