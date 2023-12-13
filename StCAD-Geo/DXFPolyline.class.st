Class {
	#name : #DXFPolyline,
	#superclass : #GEOPolyline,
	#instVars : [
		'cFlag'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'binary storage' }
DXFPolyline class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"
	Change order from 
	eventTable container refFrame rfpointsf isClosed 
	to
	eventTable container refFrame rfpointsf isClosed cFlag 
	"

	oldVersion == 20 
		ifTrue: 
			[| inst |
			inst := self new.
			^
			[:oldObj | 
			| new |
			new := Array new: 6.
			new 
				replaceFrom: 1
				to: 5
				with: oldObj
				startingAt: 1.
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
DXFPolyline class >> binaryRepresentationVersion [
	^30
]

{ #category : #'VisualWorks metadata' }
DXFPolyline class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
DXFPolyline >> cFlag [
	^cFlag
]

{ #category : #accessing }
DXFPolyline >> cFlag: anObject [
	cFlag := anObject
]

{ #category : #rendering }
DXFPolyline >> renderOn: aRenderingContext [ 
	self cadObject notNil 
		ifTrue: 
			[aRenderingContext pushTransformation: refFrame aMFf
				while: 
					[self hasPaint ifTrue: [aRenderingContext paint: self paint].
					self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
					aRenderingContext lineWidth: self lineWidth.
					self hasStipple 
						ifTrue: 
							[aRenderingContext lineStippleFactor: self stippleFactor
								pattern: self stipplePattern.
							aRenderingContext enableLineStipple].
					cFlag ifNil: [aRenderingContext displayLines: rfpointsf]
						ifNotNil: 
							[(cFlag detect: [:aFlag | aFlag == false] ifNone: nil) 
								ifNil: [aRenderingContext displayLines: rfpointsf]
								ifNotNil: 
									[1 to: cFlag size
										do: 
											[:i | 
											(cFlag at: i) 
												ifTrue: 
													[aRenderingContext 
														displayLines: (Array with: (rfpointsf at: i) with: (rfpointsf at: i + 1))]]]].
					self hasStipple ifTrue: [aRenderingContext disableLineStipple]]]
]
