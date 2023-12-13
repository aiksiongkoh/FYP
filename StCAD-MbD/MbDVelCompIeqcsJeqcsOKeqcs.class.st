Class {
	#name : #MbDVelCompIeqcsJeqcsOKeqcs,
	#superclass : #MbDVelCompIeqcsJeqcOKeqcs,
	#instVars : [
		'pviIeJeOKepsJ'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcsJeqcsOKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcsJeqcsOKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isKindOf: MbDEndFrameqcs) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]
