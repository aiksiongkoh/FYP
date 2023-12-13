Extension { #name : #TextCollector }

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> getString: string [ 
	^string mbdMessage
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> logString: string [ 
	self show: string mbdMessage
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> logString: string withArgument: string1 [ 
	self show: (string mbdMessage expandWithArgument: string1)
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> logString: string withArguments: arrayOfStrings [ 
	self show: (string mbdMessage expandWithArguments: arrayOfStrings)
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> logString: string withFrameNumber: integer [ 
	self show: (string mbdMessage expandWithArgument: integer printString)
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> logString: string withTime: double [ 
	"Do nothing to avoid clutter."
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> logTime: double [ 
	"Do nothing to avoid clutter of Transcript."
]

{ #category : #'*StCAD-MbD-StCAD-MbD' }
TextCollector >> versionString [
	| fullname starti stopi name |
	fullname := SourceFileManager default targetFile name.
	starti := (fullname findLast: [:ch | ch = $\]) + 1.
	stopi := (fullname findLast: [:ch | ch = $.]) - 1.
	stopi = 0 ifTrue: [self error: ''].
	name := fullname copyFrom: starti to: stopi.
	^name
]
