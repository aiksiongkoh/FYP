Class {
	#name : #ApplicationModel,
	#superclass : #Model,
	#instVars : [
		'builder',
		'uiSession',
		'eventHandlers'
	],
	#classInstVars : [
		'savedWindowInformation'
	],
	#category : #'UIBuilder-Framework'
}

{ #category : #'VisualWorks metadata' }
ApplicationModel class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]
