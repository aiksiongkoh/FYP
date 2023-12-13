Class {
	#name : #GEOSpringDamperForce,
	#superclass : #Obsolete,
	#category : #'StCAD-Geo-Obsolete classes'
}

{ #category : #'binary storage' }
GEOSpringDamperForce class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Change 
	StCAD.StGeo.GEOSpringDamperForce 
	(eventTable container markerI markerJ setLength setForce stiffness damping) 
	to 
	StCAD.StGeo.ForceTorqueInLine 
	(eventTable container markerI markerJ tensionFunc twistFunc)"

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := GEOForceTorqueInLine basicNew.
			^
			[:oldObj | 
			| new units rIJ0 tension0 k c rIJ vrIJ tension cadString geoName stop start |
			new := Array new: 6.
			new
				replaceFrom: 1
				to: 4
				with: oldObj
				startingAt: 1.
			units := Units new.
			rIJ0 := oldObj at: oldObj size - 3.
			tension0 := oldObj at: oldObj size - 2.
			k := oldObj at: oldObj size - 1.
			c := oldObj at: oldObj size.
			rIJ0 := rIJ0 isNil
						ifTrue: [0.0d]
						ifFalse: [rIJ0 / units length].
			tension0 := tension0 isNil
						ifTrue: [0.0d]
						ifFalse: [tension0 / units force].
			k := k isNil
						ifTrue: [0.0d]
						ifFalse: [k / units force * units length].
			c := c isNil
						ifTrue: [0.0d]
						ifFalse: [c / units force * units velocity].
			rIJ0 := Constant with: rIJ0.
			tension0 := Constant with: tension0.
			k := Constant with: k.
			c := Constant with: c.
			oldObj become: new.
			oldObj changeClassToThatOf: inst.
			rIJ := GEOrIJ with: oldObj.
			vrIJ := GEOvrIJ with: oldObj.
			tension := Sum
						with: tension0
						plus: k * (rIJ - rIJ0)
						plus: c * vrIJ.
			cadString := tension cadString.
			geoName := oldObj name.
			stop := 1.
			
			[start := cadString findString: geoName startingAt: stop.
			start ~= 0]
				whileTrue: 
					[stop := start + geoName size - 1.
					cadString := cadString
								changeFrom: start
								to: stop
								with: 'self'.
					stop := start + 3].
			oldObj tensionFunc: (BasicUserFunction
					with: cadString
					myUnit: units force
					units: units).
			oldObj twistFunc: nil.
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
GEOSpringDamperForce class >> binaryRepresentationVersion [
	^40
]

{ #category : #'VisualWorks metadata' }
GEOSpringDamperForce class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
