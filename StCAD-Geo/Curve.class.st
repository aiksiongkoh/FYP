Class {
	#name : #Curve,
	#superclass : #Geometry,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Curve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Curve >> aEdgeUseFrom: rfstartf to: rfendf [

	| aEdgeUse aVertexUse aLine |
	self halt: 'Edge should only be created by Model.'.
	aEdgeUse := StCAD_NMT_Edge new newUse. "VW_TRANSLATION:StCAD.NMT.Edge:StCAD_NMT_Edge"
	aVertexUse := (StCAD_NMT_Vertex new: rfstartf) newUse. "VW_TRANSLATION:StCAD.NMT.Vertex:StCAD_NMT_Vertex"
	aEdgeUse aVertexUse: aVertexUse.
	aLine := self aLineFrom: rfstartf to: rfendf.
	aEdgeUse uvOFt: aLine.
	aEdgeUse isSameSense: true.
	aVertexUse t: 0.0 d.
	^ aEdgeUse
]

{ #category : #accessing }
Curve >> aLineFrom: rfstartf to: rfendf [ 
	| aLine |
	aLine := Line new.
	aLine aSup: aSup.
	aLine aRefFrame: aRefFrame copy.
	aLine rfstartf: rfstartf.
	aLine rfendf: rfendf.
	aLine calc.
	aLine privateCalcBoundingBox.
	^aLine
]

{ #category : #converting }
Curve >> asJunOpenGL3dObject [

	| polyline |
	polyline := JunOpenGL3dPolyline
				vertexes: ((self crFpF_n: 32) collect: [:a | a asJun3dPoint]).
	^polyline
]

{ #category : #accessing }
Curve >> asPolyline [
	| polyline |
	polyline := Polyline new.
	polyline aSup: aSup.
	polyline aRefFrame: aRefFrame copy.
	polyline rfpointsf: self rfpointsf.
	^polyline
]

{ #category : #accessing }
Curve >> cEdgeUse [
	| crfpointf n cEdgeUse |
	crfpointf := self crfpointf.
	n := crfpointf size - 1.
	cEdgeUse := OrderedCollection new: n.
	1 to: n
		do: 
			[:i | 
			cEdgeUse 
				add: (self aEdgeUseFrom: (crfpointf at: i) to: (crfpointf at: i + 1))].
	^cEdgeUse
]

{ #category : #accessing }
Curve >> cEdgeUse1 [
	| crSkpointSk n cEdgeUse |
	crSkpointSk := self crSkpointSk.
	n := crSkpointSk size - 1.
	cEdgeUse := OrderedCollection new: n.
	1 to: n
		do: 
			[:i | 
			cEdgeUse 
				add: (self aEdgeUseFrom: (crSkpointSk at: i) to: (crSkpointSk at: i + 1))].
	^cEdgeUse
]

{ #category : #accessing }
Curve >> crFpF_n: n [

	| rfpointsf rFpointsF |
	rfpointsf := self crfpf_n: n.
	rFpointsF := rfpointsf collect: [:rfpf | aRefFrame rFpFfromrfpf: rfpf].
	^rFpointsF
]

{ #category : #accessing }
Curve >> crSkpointSk [
	^self crfpointf collect: [:rfpointf | aRefFrame rFpFfromrfpf: rfpointf]
]

{ #category : #accessing }
Curve >> create_glCurve [
	^self create_glNurbs
]

{ #category : #accessing }
Curve >> create_glTrimCurve [
	^self create_glNurbs
]

{ #category : #accessing }
Curve >> crfpf_n: n [

	self subclassResponsibility
]

{ #category : #accessing }
Curve >> cuv [
	^self triggerEvent: #cuv
]

{ #category : #accessing }
Curve >> cuv: cuv [ 
	self removeActionsForEvent: #cuv.
	cuv ifNotNil: 
			[self 
				when: #cuv
				ask: cuv
				perform: #yourself]
]

{ #category : #accessing }
Curve >> cuvFirst [

	^self cuv first
]

{ #category : #accessing }
Curve >> cuvInto: cuv [

	cuv addAll: self cuv
]

{ #category : #accessing }
Curve >> cuvLast [

	^self cuv last
]

{ #category : #accessing }
Curve >> glCurve [
	^(self triggerEvent: #glCurve) ifNil: 
			[| answer |
			answer := self create_glCurve.
			self glCurve: answer.
			answer]
]

{ #category : #accessing }
Curve >> glCurve: glCurve [ 
	self removeActionsForEvent: #glCurve.
	glCurve ifNotNil: 
			[self 
				when: #glCurve
				ask: glCurve
				perform: #yourself]
]

{ #category : #accessing }
Curve >> glTrimCurve [
	^(self triggerEvent: #glTrimCurve) ifNil: 
			[| answer |
			answer := self create_glTrimCurve.
			self glTrimCurve: answer.
			answer]
]

{ #category : #accessing }
Curve >> glTrimCurve: glTrimCurve [ 
	self removeActionsForEvent: #glTrimCurve.
	glTrimCurve ifNotNil: 
			[self 
				when: #glTrimCurve
				ask: glTrimCurve
				perform: #yourself]
]

{ #category : #ops }
Curve >> magnifySelf: aDouble [ 
	super magnifySelf: aDouble.
	self glCurve: nil.
	self aNurbs: nil
]

{ #category : #accessing }
Curve >> rFpFNurbs [
	| aNurbs |
	aNurbs := self aNurbs copy.
	aNurbs transformSelfBy_rFfF: aRefFrame rFfF aAFf: aRefFrame aAFf.
	^aNurbs
]

{ #category : #accessing }
Curve >> rFpF_u: u [ 
	^aRefFrame rFpFfromrfpf: (self rfpf_u: u)
]

{ #category : #accessing }
Curve >> rfpf_u: u [ 
	self subclassResponsibility
]

{ #category : #accessing }
Curve >> uv_connectTo: aCurve [ 
	self cuv ifNotNil: 
			[:cuv | 
			| uvlast uvfirst |
			uvlast := cuv last.
			uvfirst := aCurve cuv first.
			uvfirst u: uvlast u.
			uvfirst v: uvlast v]
]
