Class {
	#name : #'MANIFOLD_SOLID_BREP',
	#superclass : #'SOLID_MODEL',
	#instVars : [
		'outer'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
MANIFOLD_SOLID_BREP >> aNMT [

	| aNMT |
	aNMT := StCAD_NMT_Model new. "VW_TRANSLATION:StCAD.NMT.Model:StCAD_NMT_Model"
	outer buildIn: aNMT.
	self assert: [ aNMT cSub size = 2 ].
	^ aNMT
]

{ #category : #accessing }
MANIFOLD_SOLID_BREP >> aPart [

	| aNMT |
	aNMT := self aNMT.
	aNMT calcBoundingBox.
	^ aNMT aBoundingBox isDefined
		  ifTrue: [ 
			  | aPart aMassMarker rFfF aAFf |
			  aPart := StCAD_Geo_GEOPart new. "VW_TRANSLATION:StCAD.Geo.GEOPart:StCAD_Geo_GEOPart"
			  aPart name: name.
			  aPart aNMT: aNMT.
			  aMassMarker := StCAD_Geo_GEOMassMarker new. "VW_TRANSLATION:StCAD.Geo.GEOMassMarker:StCAD_Geo_GEOMassMarker"
			  aMassMarker name: 'MassMarker'.
			  aMassMarker refFrame
				  rFfF: aPart aNMT aBoundingBox center
				  aAFf: (StCAD_Math_FullMatrix identity: 3). "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
			  aPart aMassMarker: aMassMarker.
			  rFfF := 0 yd: 0 zd: 0.
			  aAFf := StCAD_Math_FullMatrix identity: 3.
			  aPart refFrame rFfF: rFfF aAFf: aAFf.
			  aPart ]
		  ifFalse: [ self halt: 'Check this.' ]
]

{ #category : #accessing }
MANIFOLD_SOLID_BREP >> outer [
	^outer
]

{ #category : #accessing }
MANIFOLD_SOLID_BREP >> outer: anObject [
	outer := anObject
]
