Extension { #name : #Object }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> equality: aObject [ 
	"Testing an alternative for Object>>="

	"Replace 'equality:' with '=' if this method is suitable for a subclass."

	^self == aObject or: 
			[self class == aObject class and: 
					[self basicSize == aObject basicSize and: 
							[1 to: self class instSize
								do: [:i | ((self instVarAt: i) equality: (aObject instVarAt: i)) ifFalse: [^false]].
							1 to: self basicSize
								do: [:i | ((self at: i) equality: (aObject at: i)) ifFalse: [^false]].
							true]]]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> performIfCan: selector else: block [ 
	^self 
		performIfCan: selector
		withArguments: Array new
		else: block
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> performIfCan: selector with: aObject else: block [ 
	^self 
		performIfCan: selector
		withArguments: (Array with: aObject)
		else: block
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> performIfCan: selector with: aObject with: bObject else: block [ 
	^self 
		performIfCan: selector
		withArguments: (Array with: aObject with: bObject)
		else: block
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> performIfCan: selector with: aObject with: bObject with: cObject else: block [ 
	^self 
		performIfCan: selector
		withArguments: (Array 
				with: aObject
				with: bObject
				with: cObject)
		else: block
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> performIfCan: selector withArguments: aArray else: block [ 
	^(self class canUnderstand: selector) 
		ifTrue: [self perform: selector withArguments: aArray]
		ifFalse: 
			[| nSize newArray |
			nSize := aArray size + 1.
			newArray := Array new: nSize.
			newArray at: 1 put: self.
			newArray 
				replaceFrom: 2
				to: nSize
				with: aArray.
			block valueWithArguments: newArray]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> postCOPY [
	"Testing an alternative for Object>>postCopy"

	1 to: self class instSize
		do: [:i | self instVarAt: i put: (self instVarAt: i) copy].
	1 to: self basicSize do: [:i | self basicAt: i put: (self basicAt: i) copy]
]

{ #category : #'*StCAD-Misc-StCAD-Debug' }
Object >> printOn1: aStream [ 
	| printLimit |
	printLimit := 5000.
	aStream position < printLimit 
		ifTrue: 
			[aStream nextPut: $a.
			aStream nextPutAll: self class printString.
			aStream nextPut: $(.
			1 to: self class instSize
				do: 
					[:i | 
					aStream
						print: (self instVarAt: i);
						space].
			1 to: self basicSize
				do: 
					[:i | 
					aStream
						print: (self at: i);
						space].
			aStream nextPut: $).
			aStream position > printLimit 
				ifTrue: [aStream nextPutAll: (#'...etc...' << #'StCAD.UI') expandMacros]]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> printVerbose [
	"Answer a String whose characters are a description of the receiver."

	| aStream |
	aStream := WriteStream on: (String new: 16).
	self printVerboseOn: aStream.
	^aStream contents
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> printVerboseOn: aStream [ 
	self printOn: aStream
]

{ #category : #'*StCAD-Misc-StCAD-Debug' }
Object >> toTranscriptShow: aString ifOverOne: aDouble [ 
	aDouble > 1.0d 
		ifTrue: 
			[Transcript
				cr;
				show: (aString expandMacrosWith: aDouble)]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> when: eventName ask: anObject perform: selector [ 
	self 
		when: eventName
		send: selector
		to: anObject
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> when: eventName ask: anObject perform: selector with: argument [ 
	self
		when: eventName
		send: selector
		to: anObject
		with: argument
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> when: eventName ask: anObject perform: selector with: firstArgument with: secondArgument [ 
	self
		when: eventName
		send: selector
		to: anObject
		with: firstArgument
		with: secondArgument
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Object >> when: eventName ask: anObject perform: selector withArguments: argumentList [ 
	self 
		when: eventName
		send: selector
		to: anObject
		withArguments: argumentList
]
