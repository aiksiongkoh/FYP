Class {
	#name : #KineIJ,
	#superclass : #RelativeConstraintSet,
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #accessing }
KineIJ class >> nameString [
	^'KinematicIJ'
]

{ #category : #'VisualWorks metadata' }
KineIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
KineIJ >> createMbD [
	"Do nothing."
]

{ #category : #accessing }
KineIJ >> cut [
	aSup cutKineIJ: self.
	super cut
]

{ #category : #accessing }
KineIJ >> dataClass [
	^GEOKineIKineJ.
]

{ #category : #accessing }
KineIJ >> dataSeriesForChart [
	| kineIs kineJs index kineIforceIkineJ |
	kineIs := markerI dataSeriesForChart.
	kineJs := markerJ dataSeriesForChart.
	^(kineIs isSequenceable and: [kineJs isSequenceable])
		ifTrue: 
			[index := 0.
			kineIs
				collect: 
					[:kineI | 
					index := index + 1.
					kineIforceIkineJ := self dataClass new.
					kineIforceIkineJ kineI: (kineIs at: index).
					kineIforceIkineJ kineJ: (kineJs at: index).
					kineIforceIkineJ]]
		ifFalse: 
			[Dialog warn: 'Simulation data is incomplete. Rerun a simulation.'.
			Array new]
]

{ #category : #testing }
KineIJ >> isKineIJ [
	^true
]

{ #category : #accessing }
KineIJ >> uncut [
	aSup addKineIJ: self
]

{ #category : #DYN }
KineIJ >> updateFromMbD [
	"Do nothing."
]
