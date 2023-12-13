Class {
	#name : #CylindricalFrame,
	#superclass : #AbstractCylindricalFrame,
	#instVars : [
		'r',
		'theta',
		'z'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
CylindricalFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
	)

]

{ #category : #utilities }
CylindricalFrame class >> xyz_r: r theta: theta z: z [ 
	^FullColumn 
		with: r * theta cos
		with: r * theta sin
		with: z
]
