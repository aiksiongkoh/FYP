Class {
	#name : #'BG_ChartScale',
	#superclass : #Object,
	#instVars : [
		'sourceMin',
		'sourceMax',
		'destMin',
		'destMax',
		'step',
		'zero',
		'increase',
		'div'
	],
	#category : #'BGOK-Business Graphics-Scales'
}

{ #category : #'VisualWorks metadata' }
BG_ChartScale class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
	)

]
