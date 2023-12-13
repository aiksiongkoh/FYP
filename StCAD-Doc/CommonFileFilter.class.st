"
This class holds filters used by the file dialog to filter current directory contents

Instance Variables:

	filter	<Association>	 A filter used to filter contents
	description	<String>	 name of filter (Word Doc, Parcel, etc)
"
Class {
	#name : #CommonFileFilter,
	#superclass : #Object,
	#instVars : [
		'filter',
		'description'
	],
	#category : #'StCAD-Doc-Portable Common-Dialogs'
}

{ #category : #accessing }
CommonFileFilter class >> filter: aFilter description: aDescription [
	^self new filter: aFilter; description: aDescription
]

{ #category : #'VisualWorks metadata' }
CommonFileFilter class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
	)

]

{ #category : #accessing }
CommonFileFilter >> description [

	^description
]

{ #category : #accessing }
CommonFileFilter >> description: aValue [

	description := aValue
]

{ #category : #accessing }
CommonFileFilter >> filter [

	^filter
]

{ #category : #accessing }
CommonFileFilter >> filter: aValue [

	filter := aValue
]
