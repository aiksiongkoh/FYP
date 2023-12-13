"
VelCompIeqcsJeqcsO is the relative velocity of fixed material points defined by the parameters sI, sJ. Hence its not a function of sdotI, sdotJ. Keqcs is just the instantaneous fixed frame to express the velocity component.
"
Class {
	#name : #MbDVelCompIeqcsJeqcOKeqcs,
	#superclass : #MbDVelCompIeqcJeqcOKeqcs,
	#instVars : [
		'pviIeJeOKepsI'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDVelCompIeqcsJeqcOKeqcs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDVelCompIeqcsJeqcOKeqcs class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isKindOf: MbDEndFrameqcs)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]
