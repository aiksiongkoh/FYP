Class {
	#name : #GraphicsContext,
	#superclass : #Object,
	#instVars : [
		'medium',
		'clipOriginX',
		'clipOriginY',
		'clipWidth',
		'clipHeight',
		'lineWidth',
		'capStyle',
		'joinStyle',
		'deviceFont',
		'devicePaint',
		'offsetX',
		'offsetY',
		'phaseX',
		'phaseY',
		'scaleX',
		'scaleY',
		'font',
		'paint',
		'paintPolicy',
		'fontPolicy',
		'clientData',
		'paintPreferences'
	],
	#category : #'Graphics-Support'
}

{ #category : #'VisualWorks metadata' }
GraphicsContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'Graphics'
	)

]
