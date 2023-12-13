Class {
	#name : #GEOKineIJ,
	#superclass : #GEORelativeConstraintSet,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOKineIJ class >> nameString [
	^'KinematicIJ'
]

{ #category : #'VisualWorks metadata' }
GEOKineIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOKineIJ >> createMbD [
	"Do nothing."
]

{ #category : #accessing }
GEOKineIJ >> cut [
	container cutKineIJ: self.
	super cut
]

{ #category : #accessing }
GEOKineIJ >> dataClass [
	^GEOKineIKineJ
]

{ #category : #accessing }
GEOKineIJ >> dataSeriesForChart [
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
GEOKineIJ >> isKineIJ [
	^true
]

{ #category : #accessing }
GEOKineIJ >> uncut [
	container addKineIJ: self
]

{ #category : #DYN }
GEOKineIJ >> updateFromMbD [
	"Do nothing."
]
