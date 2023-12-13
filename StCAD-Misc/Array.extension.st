Extension { #name : #Array }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Array >> conditionSelfVectorWithTol: tol [ 
	| element |
	1 to: self size
		do: 
			[:i | 
			element := self at: i.
			element < 0.0d ifTrue: [element := 0.0d - element].
			element < tol ifTrue: [self at: i put: 0.0d]]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Array >> conditionSelfWithTol: tol [ 
	(self at: 1) isReal
		ifTrue: [self conditionSelfVectorWithTol: tol]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					conditionSelfWithTol: tol]]
]
