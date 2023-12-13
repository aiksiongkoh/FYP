Class {
	#name : #DataPosVelAcc,
	#superclass : #Data,
	#instVars : [
		'refData',
		'rFfF',
		'aAFf',
		'vFfF',
		'omeFfF',
		'aFfF',
		'alpFfF'
	],
	#category : #'StCAD-Misc'
}

{ #category : #'VisualWorks metadata' }
DataPosVelAcc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'StCAD.Misc'
	)

]
