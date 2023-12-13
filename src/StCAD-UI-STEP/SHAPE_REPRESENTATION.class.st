Class {
	#name : #'SHAPE_REPRESENTATION',
	#superclass : #REPRESENTATION,
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
SHAPE_REPRESENTATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #testing }
SHAPE_REPRESENTATION >> = aObject [ 
	"Testing an alternative for Object>>="

	"Replace 'equality:' with '=' if this method is suitable for a subclass."

	^self == aObject or: 
			[self class == aObject class and: 
					[self basicSize == aObject basicSize and: 
							[1 to: self class instSize
								do: [:i | (self instVarAt: i) = (aObject instVarAt: i) ifFalse: [^false]].
							1 to: self basicSize
								do: [:i | (self at: i) = (aObject at: i) ifFalse: [^false]].
							true]]]
]

{ #category : #accessing }
SHAPE_REPRESENTATION >> cPart [

	| i aNMT aMassMarker aPart |
	REPRESENTATION CurrentRep: self.
	i := 0.
	^ items collect: [ :aGeoSet | "@__markp	11/14/2009 08:54:30 pm""@__markp	11/14/2009 08:55:28 pm""@__markp	11/14/2009 08:55:34 pm"
		  i := i + 1.
		  aNMT := aGeoSet aNMT
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
