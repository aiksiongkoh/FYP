Extension { #name : #GFGraphicObject }

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject >> cadUnits [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container cadUnits]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject classSide >> createGOfor: geo [ 
	^self new geoObject: geo
]

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject classSide >> geoClass [
	^self subclassResponsibility
]

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject >> isRevolute [
	^false
]

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject >> isZRotational [
	^false
]

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject >> isZTranslational [
	^false
]

{ #category : #'*StCAD-UI-StCAD-UI' }
GFGraphicObject >> metaObject: metaObject [ 
	self removeActionsForEvent: #getMetaObject.
	metaObject notNil ifTrue: [self
			when: #getMetaObject
			ask: metaObject
			perform: #yourself]
]
