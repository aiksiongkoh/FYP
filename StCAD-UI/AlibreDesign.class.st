"
This class does all the unique operations of AlibreDesign.
"
Class {
	#name : #AlibreDesign,
	#superclass : #Item,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #accessing }
AlibreDesign class >> aIADTransformationArray_rFfF: rFfF aAFf: aAFf [ 
	"Returns array of 16 elements in column order."

	| aStream |
	aStream := (Array new: 16) writeStream.
	1 to: 3
		do: 
			[:i | 
			aStream nextPutAll: (aAFf column: i).
			aStream nextPut: 0.0d].
	aStream nextPutAll: rFfF.
	aStream nextPut: 1.0d.
	^aStream contents
]

{ #category : #accessing }
AlibreDesign class >> rFfF_aAFf_IADTransformationArray: aArray [
	"Returns array of rFfF and aAFf."
	| rFfF aAFf aAFfi |
	rFfF := FullColumn new: 3.
	aAFf := FullMatrix new: 3 by: 3.
	1 to: 3
		do: 
			[:i |
			rFfF at: i put: (aArray at: i + 12) asDouble.
			aAFfi := aAFf at: i.
			1 to: 3
				do: [:j | aAFfi at: j put: (aArray at: i + (4 * (j - 1))) asDouble.].].
	^Array with: rFfF with: aAFf.
]

{ #category : #'VisualWorks metadata' }
AlibreDesign class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
	)

]
