"
Refer to Nurbs Book pp 232.

Define
r(u,v) = S(u,v) - P
Minimize
r dot r

Solve
f(u,v) = r dot Su = 0
g(u,v) = r dot Sv = 0
Therefore,
fu = (Su dot Su) + (r dot Suu)
fv = (Su dot Sv) + (r dot Suv)
gu = (Su dot Sv) + (r dot Suv) = fv
gv = (Sv dot Sv) + (r dot Svv)
"
Class {
	#name : #NurbsSurfaceInversion,
	#superclass : #VectorNewtonRaphson,
	#instVars : [
		'rFpF',
		'r',
		'su',
		'sv',
		'suu',
		'suv',
		'svv'
	],
	#category : #'StCAD-Math'
}

{ #category : #'VisualWorks metadata' }
NurbsSurfaceInversion class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solving }
NurbsSurfaceInversion >> askSystemToUpdate [
	self initializeGlobally
]

{ #category : #solving }
NurbsSurfaceInversion >> fillPyPx [
	| a12 |
	(pypx at: 1)
		at: 1 put: (su dot: su) + (r dot: suu);
		at: 2 put: (a12 := (su dot: sv) + (r dot: suv)).
	(pypx at: 2)
		at: 1 put: a12;
		at: 2 put: (sv dot: sv) + (r dot: svv)
]

{ #category : #solving }
NurbsSurfaceInversion >> fillY [
	y at: 1 put: (r dot: su).
	y at: 2 put: (r dot: sv)
]

{ #category : #'initialize-release' }
NurbsSurfaceInversion >> initialize [
	super initialize.
	y := FullColumn new: 2.
	pypx := FullMatrix new: 2 by: 2
]

{ #category : #accessing }
NurbsSurfaceInversion >> matrixSolverClass [
	^GEFullMatFullPv
]

{ #category : #solving }
NurbsSurfaceInversion >> passRootToSystem [
	"Do nothing."
]

{ #category : #solving }
NurbsSurfaceInversion >> postRun [
	"Do nothing."
]

{ #category : #solving }
NurbsSurfaceInversion >> preRun [
	"Do nothing."
]

{ #category : #accessing }
NurbsSurfaceInversion >> rFpF [
	^rFpF
]

{ #category : #accessing }
NurbsSurfaceInversion >> rFpF: anObject [
	rFpF := anObject
]

{ #category : #solving }
NurbsSurfaceInversion >> run [
	^
	[self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterate.
	self finalize.
	self postRun.
	x] 
			on: Error
			do: [:ex | ex pass]
]
