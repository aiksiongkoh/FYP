Class {
	#name : #MakeEKillS,
	#superclass : #MakeE,
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
MakeEKillS class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #executing }
MakeEKillS >> execute [
	| acVertex aModel outEdgeUse inEdgeUse aShellUse1 aShellUse2 |
	newEdge := (aRegion selectEdge: 
					[:aaEdge | 
					acVertex := aaEdge cVertex.
					(acVertex includes: aVertex1) 
						and: [(acVertex includes: aVertex2) and: [aaEdge aCurve = aCurve]]]) 
				soleItem.
	newEdge ifNil: 
			[aModel := aRegion aModel.
			newEdge := aModel 
						newEdgeWith: aVertex1
						and: aVertex2
						aCurve: aCurve.
			outEdgeUse := (newEdge newUse)
						aVertexUse: aVertex1 newUse;
						yourself.
			inEdgeUse := (newEdge newUse)
						aVertexUse: aVertex2 newUse;
						yourself.
			outEdgeUse mate: inEdgeUse.
			aShellUse1 := (aRegion 
						selectShellUse: [:aaShellUse | aaShellUse includesVertex: aVertex1]) 
							soleItem.
			aShellUse2 := (aRegion 
						selectShellUse: [:aaShellUse | aaShellUse includesVertex: aVertex2]) 
							soleItem.
			aShellUse1 addEdgeUse: outEdgeUse.
			aShellUse1 addEdgeUse: inEdgeUse.
			aShellUse2 cSub shallowCopy do: [:aSub | aShellUse1 addSub: aSub].
			aShellUse2 die]
]
