Class {
	#name : #'ADVANCED_BREP_SHAPE_REPRESENTATION',
	#superclass : #'SHAPE_REPRESENTATION',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'As yet unclassified' }
ADVANCED_BREP_SHAPE_REPRESENTATION >> aPart [

	| aNMT |
	self assert: [ 
		(items select: [ :item | item isKindOf: SOLID_MODEL ]) size = 1 ].
	REPRESENTATION CurrentRep: self.
	aNMT := (items at: 1) aNMT.
	aNMT magnifySelf: self lengthFactor.
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

{ #category : #'As yet unclassified' }
ADVANCED_BREP_SHAPE_REPRESENTATION >> angleFactor [
	^(context_of_items 
		detect: [:a | a isMemberOf: GLOBAL_UNIT_ASSIGNED_CONTEXT]) angleFactor
]

{ #category : #'As yet unclassified' }
ADVANCED_BREP_SHAPE_REPRESENTATION >> cPart [

	| i cSOLID aNMT aMassMarker aPart |
	REPRESENTATION CurrentRep: self.
	i := 0.
	cSOLID := items select: [ :item | item isKindOf: MANIFOLD_SOLID_BREP ].
	^ cSOLID collect: [ :solid | 
		  i := i + 1.
		  aNMT := solid aNMT
			          magnifySelf: self lengthFactor;
			          calcBoundingBox;
			          yourself.
		  self assert: [ aNMT aBoundingBox isDefined ].
		  aMassMarker := StCAD_Geo_GEOMassMarker new
			                 name: 'MassMarker';
			                 yourself. "VW_TRANSLATION:StCAD.Geo.GEOMassMarker:StCAD_Geo_GEOMassMarker"
		  aMassMarker refFrame
			  rFfF: aNMT aBoundingBox center
			  aAFf: (StCAD_Math_FullMatrix identity: 3). "VW_TRANSLATION:StCAD.Math.FullMatrix:StCAD_Math_FullMatrix"
		  aPart := StCAD_Geo_GEOPart new
			           name: ((name isString and: [ name isEmpty not ])
					            ifTrue: [ name ]
					            ifFalse: [ 'part' , i printString ]);
			           aNMT: aNMT;
			           aMassMarker: aMassMarker;
			           yourself. "VW_TRANSLATION:StCAD.Geo.GEOPart:StCAD_Geo_GEOPart"
		  aPart refFrame
			  rFfF: (0 yd: 0 zd: 0)
			  aAFf: (StCAD_Math_FullMatrix identity: 3).
		  aPart ]
]
