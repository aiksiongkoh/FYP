Extension { #name : #SmallInteger }

{ #category : #'*StCAD-Math-StCAD-Math' }
SmallInteger >> a123ToXYZ [
	(self < 1 or: [self > 3]) 
		ifTrue: [self error: 'Valid for 1, 2, or 3 only.'].
	^String with: (self - 1 + $X asInteger) asCharacter
]

{ #category : #'*StCAD-Math-StCAD-Math' }
SmallInteger >> a123Toxyz [
	(self < 1 or: [self > 3]) 
		ifTrue: [self error: 'Valid for 1, 2, or 3 only.'].
	^String with: (self - 1 + $x asInteger) asCharacter
]
