Class {
	#name : #GEOTranslationalMotion,
	#superclass : #GEOMotion,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #DYN }
GEOTranslationalMotion >> createMbD [
	| zFunc parser stack func mbdZTranslation |
	super createMbD.
	zFunc := zIJ isNil
				ifTrue: [Constant with: 0]
				ifFalse: [zIJ isUserFunction
						ifTrue: 
							[parser := self functionParser.
							stack := parser
										parseUserFunction: zIJ
										notifying: nil
										ifFail: nil.
							func := stack last.
							func]
						ifFalse: [zIJ]].
	zFunc := (zFunc / self mbdUnits length) createMbD simplified.
	mbdZTranslation := self mbdObject.
	mbdZTranslation zBlk: zFunc
]

{ #category : #DYN }
GEOTranslationalMotion >> createMbD1 [
	| mbdZTranslation |
	super createMbD.
	mbdZTranslation := self mbdObject.
	mbdZTranslation zBlk: zIJ simplified
]

{ #category : #accessing }
GEOTranslationalMotion >> joint [
	^self interface jointList detect: [:joint | ((joint isMemberOf: GEOTranslationalJoint)
			or: [joint isMemberOf: GEOCylindricalJoint])
			and: [joint aMarkerI == markerI and: [joint aMarkerJ == markerJ]]]
]

{ #category : #printing }
GEOTranslationalMotion >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self nameString.
	aStream
		storeLevel: level + 1
		title: 'Name'
		object: self name.
	aStream
		storeLevel: level + 1
		title: 'MotionJoint'
		object: self joint fullName.
	aStream
		storeLevel: level + 1
		title: 'TranslationZ'
		object: zIJ
]

{ #category : #DYN }
GEOTranslationalMotion >> validateFormulas [
	self zFunc
]

{ #category : #DYN }
GEOTranslationalMotion >> zFunc [
	| parser stack func |
	^zIJ isNil
		ifTrue: [Constant with: 0]
		ifFalse: [zIJ isUserFunction
				ifTrue: 
					[parser := self functionParser.
					stack := parser
								parseUserFunction: zIJ
								notifying: nil
								ifFail: nil.
					func := stack last.
					func]
				ifFalse: [zIJ]]
]
