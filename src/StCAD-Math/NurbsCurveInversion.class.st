"
Refer to Nurbs Book pp 230.

Define
r(u) = S(u) - P
Minimize
r dot r

Solve
f(u) = r dot Su = 0
Therefore,
fu = (Su dot Su) + (r dot Suu)
"
Class {
	#name : #NurbsCurveInversion,
	#superclass : #ScalarNewtonRaphson,
	#instVars : [
		'rFpF',
		'r',
		'su',
		'suu'
	],
	#category : #'StCAD-Math'
}

{ #category : #'VisualWorks metadata' }
NurbsCurveInversion class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solving }
NurbsCurveInversion >> askSystemToUpdate [
	self initializeGlobally
]

{ #category : #solving }
NurbsCurveInversion >> fillPyPx [
	pypx := (su dot: su) + (r dot: suu)
]

{ #category : #solving }
NurbsCurveInversion >> fillY [
	y := r dot: su
]

{ #category : #solving }
NurbsCurveInversion >> passRootToSystem [
	"Do nothing."
]

{ #category : #solving }
NurbsCurveInversion >> postRun [
	"Do nothing."
]

{ #category : #solving }
NurbsCurveInversion >> preRun [
	"Do nothing."
]

{ #category : #accessing }
NurbsCurveInversion >> rFpF [
	^rFpF
]

{ #category : #accessing }
NurbsCurveInversion >> rFpF: anObject [ 
	rFpF := anObject
]

{ #category : #solving }
NurbsCurveInversion >> run [
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
