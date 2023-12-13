Class {
	#name : #BOSSReader,
	#superclass : #BOSSReader,
	#category : #'StCAD-Misc-Binary Storage'
}

{ #category : #'VisualWorks metadata' }
BOSSReader class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #'reading-imports' }
BOSSReader >> importClass: info [

	| classSymbol newClassSymbol aBlock |
	classSymbol := info first.
	classSymbol asStrictReference isDefined
		ifFalse: 
			[aBlock :=
					[:a :b |
					newClassSymbol := (classSymbol copyReplaceAll: a with: b) asSymbol].
			('StCAD.*' match: classSymbol)
				ifTrue: 
					[('StCAD.StGeo.*' match: classSymbol)
						ifTrue: 
							[(('StCAD.StGeo.ForceTorqueInLine' match: classSymbol)
								or: ['StCAD.StGeo.ForceTorqueGeneral' match: classSymbol])
									ifTrue: [aBlock value: 'StCAD.StGeo.' value: 'StCAD.Geo.GEO']
									ifFalse: [aBlock value: 'StCAD.StGeo.' value: 'StCAD.Geo.']]
						ifFalse: 
							[('StCAD.StMath.StMArray' match: classSymbol)
								ifTrue: [aBlock value: 'StCAD.StMath.StMArray' value: 'StCAD.Math.MathArray']
								ifFalse: 
									[('StCAD.StMath.StM*' match: classSymbol)
										ifTrue: [aBlock value: 'StCAD.StMath.StM' value: 'StCAD.Math.']
										ifFalse: 
											[('StCAD.StMath.*' match: classSymbol)
												ifTrue: [aBlock value: 'StCAD.StMath.' value: 'StCAD.Math.']
												ifFalse: 
													[('StCAD.StMbD.*' match: classSymbol)
														ifTrue: [aBlock value: 'StCAD.StMbD.' value: 'StCAD.MbD.']
														ifFalse: [self checkThis]]]]]]
				ifFalse: 
					[('CADSM.*' match: classSymbol)
						ifTrue: 
							[('CADSM.Misc.CADSMMisc*' match: classSymbol)
								ifTrue: [aBlock value: 'CADSM.Misc.CADSMMisc' value: 'StCAD.Misc.']
								ifFalse: 
									[('CADSM.Geo.CADSMGeo*' match: classSymbol)
										ifTrue: [aBlock value: 'CADSM.Geo.CADSMGeo' value: 'StCAD.Geo.']
										ifFalse: 
											[('CADSM.UI.DXFBLOCK' match: classSymbol)
												ifTrue: [aBlock value: 'CADSM.UI.DXFBLOCK' value: 'StCAD.UI.DXF.DXFBLOCK']
												ifFalse: 
													[('CADSM.Math.StM*' match: classSymbol)
														ifTrue: [aBlock value: 'CADSM.Math.StM' value: 'StCAD.Math.']
														ifFalse: 
															[('CADSM.Math.Sym*' match: classSymbol)
																ifTrue: [aBlock value: 'CADSM.Math.Sym' value: 'StCAD.Math.']
																ifFalse: 
																	[('CADSM.Math.CADSMArray' match: classSymbol)
																		ifTrue: [aBlock value: 'CADSM.Math.CADSMArray' value: 'StCAD.Math.MathArray']
																		ifFalse: 
																			[('CADSM.NMT.CADSMNMT*' match: classSymbol)
																				ifTrue: [aBlock value: 'CADSM.NMT.CADSMNMT' value: 'StCAD.NMT.']
																				ifFalse: [aBlock value: 'CADSM.' value: 'StCAD.']]]]]]]]
						ifFalse: 
							[('GEO*' match: classSymbol)
								ifTrue: [aBlock value: 'GEO' value: 'StCAD.Geo.GEO']
								ifFalse: 
									[('MbD*' match: classSymbol)
										ifTrue: [aBlock value: 'MbD' value: 'StCAD.MbD.MbD']
										ifFalse: 
											[('StMArray' match: classSymbol)
												ifTrue: [aBlock value: 'StMArray' value: 'StCAD.Math.MathArray']
												ifFalse: 
													[('StM*' match: classSymbol)
														ifTrue: [aBlock value: 'StM' value: 'StCAD.Math.']
														ifFalse: [newClassSymbol := ('Core.' , classSymbol) asSymbol]]]]]].
			newClassSymbol asStrictReference isDefined
				ifTrue: [info at: 1 put: newClassSymbol]
				ifFalse: [self checkThis]].
	^super importClass: info
]
