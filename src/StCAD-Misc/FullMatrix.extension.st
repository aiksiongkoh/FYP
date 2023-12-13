Extension { #name : #FullMatrix }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
FullMatrix >> asJunMatrix [
	| nrow ncol answer |
	nrow := self nrow.
	ncol := self ncol.
	answer := JunMatrix new: nrow by: ncol.
	1 to: nrow
		do: [:i | 1 to: ncol do: [:j | answer atPoint: i @ j put: (self at: i and: j)]].
	^answer
]
