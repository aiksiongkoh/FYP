Extension { #name : #GFLineGO }

{ #category : #'*StCAD-UI-StCAD-UI' }
GFLineGO >> displayWith: aPen [ 
	"Modified by askoh.com to handle primitive failures."
	"The central display routine. Display the image of the receiver, 
	using aPen. The receiver should make no assumptions 
	regarding 
	the state of the pen, and is not responsible for resetting the pen 
	to the previous state. 
	"

	
	[super displayWith: aPen.
	aPen displayLineFrom: self lineStart to: self lineStop]
		on: Error do: [:ex | ex messageText = 'a primitive has failed'
			ifTrue: [ex return]
			ifFalse: [ex pass]]
]
