Class {
	#name : #HEADER,
	#superclass : #STEPParser,
	#category : #'StCAD-UI-STEP'
}

{ #category : #parsing }
HEADER >> FILE_DESCRIPTION [
	self readCharacter: $(.
	self readCharacter: $(.
	self readString.
	self readCharacter: $).
	self readCharacter: $,.
	self readString.
	self readCharacter: $)
]

{ #category : #parsing }
HEADER >> FILE_NAME [
	self readCharacter: $(.
	self readString.
	self readCharacter: $,.
	self readString.
	self readCharacter: $,.
	self readCharacter: $(.
	self readString.
	self readCharacter: $).
	self readCharacter: $,.
	self readCharacter: $(.
	self readString.
	self readCharacter: $).
	self readCharacter: $,.
	self readString.
	self readCharacter: $,.
	self readString.
	self readCharacter: $,.
	self readString.
	self readCharacter: $)
]

{ #category : #parsing }
HEADER >> FILE_SCHEMA [
	self readCharacter: $(.
	self readcString.
	self readCharacter: $)
]

{ #category : #parsing }
HEADER >> nextKeyword [
	| aWriteStream continue |
	self skipToNextToken.
	aWriteStream := (inStream contentsSpecies new: 64) writeStream.
	continue := true.
	
	[inStream atEnd ifTrue: [continue := false].
	continue] whileTrue: 
				[| element |
				element := inStream next.
				(' (;' includes: element) 
					ifTrue: 
						[continue := false.
						inStream skip: -1]
					ifFalse: [aWriteStream nextPut: element]].
	aKeyword := aWriteStream contents
]

{ #category : #parsing }
HEADER >> skipComment [
	| continue |
	continue := true.
	
	[inStream atEnd ifTrue: [continue := false].
	continue] whileTrue: 
				[| element |
				element := inStream next.
				element = $* 
					ifTrue: 
						[element := inStream next.
						element = $/ ifTrue: [continue := false] ifFalse: [inStream skip: -1]]]
]
