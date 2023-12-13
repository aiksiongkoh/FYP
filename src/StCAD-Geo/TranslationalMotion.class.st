Class {
	#name : #TranslationalMotion,
	#superclass : #Motion,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
TranslationalMotion class >> mbdClass [
	^MbDZTranslation
]

{ #category : #accessing }
TranslationalMotion class >> nameString [
	^'TranslationalMotion'
]

{ #category : #'VisualWorks metadata' }
TranslationalMotion class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
TranslationalMotion >> createMbD [
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
TranslationalMotion >> createMbD1 [
	| mbdZTranslation |
	super createMbD.
	mbdZTranslation := self mbdObject.
	mbdZTranslation zBlk: zIJ simplified
]

{ #category : #accessing }
TranslationalMotion >> joint [
	^self interface jointList detect: [:joint | ((joint isMemberOf: TranslationalJoint)
			or: [joint isMemberOf: CylindricalJoint])
			and: [joint aMarkerI == markerI and: [joint aMarkerJ == markerJ]]]
]

{ #category : #printing }
TranslationalMotion >> storeOn: aStream level: level [ 
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
TranslationalMotion >> validateFormulas [
	self zFunc
]

{ #category : #DYN }
TranslationalMotion >> zFunc [
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
