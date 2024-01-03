Class {
	#name : #DXFBLOCK,
	#superclass : #GEOSketch,
	#category : #'StCAD-UI-DXF'
}

{ #category : #accessing }
DXFBLOCK >> aBoundingBox [
	^self triggerEvent: #getBoundingBox
]

{ #category : #accessing }
DXFBLOCK >> aBoundingBox: aBoundingBox [ 
	self removeActionsForEvent: #getBoundingBox.
	aBoundingBox ifNotNil: 
			[self 
				when: #getBoundingBox
				ask: aBoundingBox
				perform: #yourself]
]

{ #category : #accessing }
DXFBLOCK >> aDisplayList [
	^self triggerEvent: #getDisplayList
]

{ #category : #accessing }
DXFBLOCK >> aDisplayList: aDisplayList [ 
	self removeActionsForEvent: #getDisplayList.
	aDisplayList notNil 
		ifTrue: 
			[self 
				when: #getDisplayList
				ask: aDisplayList
				perform: #yourself]
]

{ #category : #calc }
DXFBLOCK >> calcBoundingBox [

	| aBoundingBox aBox |
	aBoundingBox := graphics isEmpty
		                ifTrue: [ 
			                StCAD_Misc_BoundingBox new "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox" ]
		                ifFalse: [ 
			                aBox := StCAD_Misc_BoundingBox new.
			                graphics
				                inject: aBox
				                into: [ :bbox :graphic | 
				                bbox expandToBound: graphic aBoundingBoxF ].
			                aBox ].
	self aBoundingBox: aBoundingBox
]

{ #category : #accessing }
DXFBLOCK >> center [
	^self aBoundingBox center
]

{ #category : #copying }
DXFBLOCK >> postCopy [
	| aBoundingBox |
	aBoundingBox := self aBoundingBox.
	super postCopy.
	self aBoundingBox: aBoundingBox copy
]

{ #category : #'initialize-release' }
DXFBLOCK >> preSave [
	super preSave.
	self removeDisplayList
]

{ #category : #'initialize-release' }
DXFBLOCK >> release [
	self removeDisplayList.
	super release
]

{ #category : #accessing }
DXFBLOCK >> removeDisplayList [
	self aDisplayList ifNotNil: 
			[:listID | 
			self interface display aOpenGLContext removeDisplayList: listID.
			self aDisplayList: nil]
]

{ #category : #accessing }
DXFBLOCK >> removeSup [
	self removeDisplayList.
	self aSup ifNotNil: [:aaSup | aaSup removeDXFBLOCK: self]
]

{ #category : #rendering }
DXFBLOCK >> renderOn: aOpenGLContext [ 
	container isPart 
		ifTrue: 
			[| block |
			block := 
					[| listID |
					listID := aOpenGLContext createDisplayList: 
									[aOpenGLContext pushTransformation: refFrame aMFf
										while: [graphics do: [:graphic | graphic renderOn: aOpenGLContext]]]
								displayImmediately: false.
					self aDisplayList: listID.
					aOpenGLContext callDisplayList: listID].
			self aDisplayList ifNil: block
				ifNotNil: 
					[:listID | 
					(aOpenGLContext isDisplayList: listID) 
						ifTrue: [aOpenGLContext callDisplayList: listID]
						ifFalse: block]]
		ifFalse: 
			[aOpenGLContext pushTransformation: refFrame aMFf
				while: [graphics do: [:graphic | graphic renderOn: aOpenGLContext]]]
]

{ #category : #transforming }
DXFBLOCK >> scaledBy: aFullColumn [ 
	graphics do: [:aGraphic | aGraphic scaledBy: aFullColumn]
]
