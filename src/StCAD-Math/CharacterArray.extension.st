Extension { #name : #CharacterArray }

{ #category : #'*StCAD-Math-StCAD-Math' }
CharacterArray >> importNumber [
	"Answer the number created by interpreting the receiver as the string
	representation of a number. The format is not necessary Smalltalk format.  First remove any leading seperators."

	"
	'   1 0' asNumber.
	'1.99999999999999999999999999' asNumber.
	'1.99999999999999999999999999' importNumber.
	'100000000000000000000000000000000000000' importNumber.
	"

	| stream |
	stream := self string readStream.
	stream skipSeparators.
	^Number importFrom: stream
]
