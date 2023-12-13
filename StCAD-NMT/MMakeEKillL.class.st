Class {
	#name : #MMakeEKillL,
	#superclass : #MMakeE,
	#instVars : [
		'killedLoop'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
MMakeEKillL class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #executing }
MMakeEKillL >> execute [
	self halt
]
