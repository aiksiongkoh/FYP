Class {
	#name : #'CONTEXT_DEPENDENT_SHAPE_REPRESENTATION',
	#superclass : #Item,
	#instVars : [
		'representation_relation',
		'represented_product_relation'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'As yet unclassified' }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> _cRELATIONSHIP1: cRELATIONSHIP [ 
	| aRELATIONSHIP rep_2 aSHAPE_RELATIONSHIP |
	aRELATIONSHIP := representation_relation at: 1.
	rep_2 := aRELATIONSHIP rep_2.
	aSHAPE_RELATIONSHIP := cRELATIONSHIP detect: [:a | a rep_1 = rep_2].
	representation_relation at: 3 put: aSHAPE_RELATIONSHIP
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> _cRELATIONSHIP: cRELATIONSHIP [ 
	| aREPRESENTATION_RELATIONSHIP aSHAPE_REPRESENTATION_RELATIONSHIP |
	aREPRESENTATION_RELATIONSHIP := self aREPRESENTATION_RELATIONSHIP.
	aSHAPE_REPRESENTATION_RELATIONSHIP := cRELATIONSHIP detect: 
					[:a | 
					a rep_1 = aREPRESENTATION_RELATIONSHIP rep_1 or: 
							[a rep_1 = aREPRESENTATION_RELATIONSHIP rep_2 or: 
									[a rep_2 = aREPRESENTATION_RELATIONSHIP rep_1 
										or: [a rep_2 = aREPRESENTATION_RELATIONSHIP rep_2]]]] ifNone: [nil].
	representation_relation at: 3 put: aSHAPE_REPRESENTATION_RELATIONSHIP
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> aPart [

	| aSHAPE_RELATIONSHIP aPart lengthFactor aTRANSFORMATION rFfF aAFf |
	aSHAPE_RELATIONSHIP := representation_relation at: 3.
	^aSHAPE_RELATIONSHIP
		ifNotNil: 
			[aPart := aSHAPE_RELATIONSHIP aPart.
			lengthFactor := aSHAPE_RELATIONSHIP lengthFactor.
			aTRANSFORMATION := representation_relation at: 2.
			rFfF := (aTRANSFORMATION rFfF)
						magnifySelf: lengthFactor;
						yourself.
			aAFf := aTRANSFORMATION aAFf.
			aPart aRefFrame rFfF: rFfF aAFf: aAFf.
			aPart]
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> aREPRESENTATION_RELATIONSHIP [
	^representation_relation at: 1
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> representation_relation [
	^representation_relation
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> representation_relation: anObject [
	representation_relation := anObject
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> represented_product_relation [
	^represented_product_relation
]

{ #category : #accessing }
CONTEXT_DEPENDENT_SHAPE_REPRESENTATION >> represented_product_relation: anObject [
	represented_product_relation := anObject
]
