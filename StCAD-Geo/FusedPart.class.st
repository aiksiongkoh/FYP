"
Collection of Parts that are stuck together to behave like a single Part. Fixed joints create FusedParts.

Instance Variables:
	cPart	<Object>	description of cPart


"
Class {
	#name : #FusedPart,
	#superclass : #AnyPart,
	#instVars : [
		'cPart'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
FusedPart class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
