Class {
	#name : #JunDXFScanner,
	#superclass : #Object,
	#instVars : [
		'source',
		'mark',
		'groupCode',
		'dataKey',
		'dataString',
		'dataNumber',
		'failBlock',
		'debug',
		'lineSeparator',
		'lines'
	],
	#category : #'Jun-DXF-Support'
}

{ #category : #'VisualWorks metadata' }
JunDXFScanner class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
	)

]
