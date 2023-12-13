Class {
	#name : #GEOSpringDamperTorque,
	#superclass : #Obsolete,
	#category : #'StCAD-Geo-Obsolete classes'
}

{ #category : #'binary storage' }
GEOSpringDamperTorque class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Change 
	StCAD.StGeo.GEOSpringDamperTorque 
	(eventTable container markerI markerJ setAngle setTorque stiffness damping) 
	to 
	StCAD.StGeo.ForceTorqueGeneral 
	(eventTable container markerI markerJ markerK aFIeKe aTIeKe)"

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := GEOForceTorqueGeneral basicNew.
			^
			[:oldObj | 
			| new units angleIJz0 tor0 k c angleIJz omeIJz tor cadString geoName stop start |
			new := Array new: 7.
			new
				replaceFrom: 1
				to: 4
				with: oldObj
				startingAt: 1.
			units := Units new.
			angleIJz0 := oldObj at: oldObj size - 3.
			tor0 := oldObj at: oldObj size - 2.
			k := oldObj at: oldObj size - 1.
			c := oldObj at: oldObj size.
			angleIJz0 := angleIJz0 isNil
						ifTrue: [0.0d]
						ifFalse: [angleIJz0 / units angle].
			tor0 := tor0 isNil
						ifTrue: [0.0d]
						ifFalse: [tor0 / units torque].
			k := k isNil
						ifTrue: [0.0d]
						ifFalse: [k / units torque * units angle].
			c := c isNil
						ifTrue: [0.0d]
						ifFalse: [c / units torque * units omega].
			angleIJz0 := Constant with: angleIJz0.
			tor0 := Constant with: tor0.
			k := Constant with: k.
			c := Constant with: c.
			oldObj become: new.
			oldObj changeClassToThatOf: inst.
			angleIJz := GEOAngleIJz with: oldObj.
			omeIJz := GEOomeIJKi
						with: oldObj
						with: #I
						with: 3.
			tor := Sum
						with: tor0
						plus: k * (angleIJz - angleIJz0)
						plus: c * omeIJz.
			cadString := tor cadString.
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
			oldObj markerK: #I.
			oldObj aFIeKe: (FullColumn new: 3).
			oldObj aTIeKe: (FullColumn
					with: nil
					with: nil
					with: (BasicUserFunction
							with: cadString
							myUnit: units torque
							units: units)).
			oldObj]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
GEOSpringDamperTorque class >> binaryRepresentationVersion [
	^40
]

{ #category : #'VisualWorks metadata' }
GEOSpringDamperTorque class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
