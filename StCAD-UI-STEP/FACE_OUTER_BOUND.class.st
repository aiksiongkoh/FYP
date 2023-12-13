Class {
	#name : #'FACE_OUTER_BOUND',
	#superclass : #'FACE_BOUND',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
FACE_OUTER_BOUND class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
FACE_OUTER_BOUND >> bound [
	^bound
]

{ #category : #accessing }
FACE_OUTER_BOUND >> bound: anObject [
	bound := anObject
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundConicalSurface: aConicalSurface [ 
	bound boundConicalSurface: aConicalSurface
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundCylindricalSurface: aCylindricalSurface [ 
	bound boundCylindricalSurface: aCylindricalSurface
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundNurbsSurface: aNurbsSurface [ 
	bound boundNurbsSurface: aNurbsSurface
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundRectSurface: aRectSurface [ 
	bound boundRectSurface: aRectSurface
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundSphericalSurface: aSphericalSurface [ 
	bound boundSphericalSurface: aSphericalSurface
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundSurfaceOfRevolution: aSurfaceOfRevolution [ 
	bound boundSurfaceOfRevolution: aSurfaceOfRevolution
]

{ #category : #accessing }
FACE_OUTER_BOUND >> boundToroidalSurface: aToroidalSurface [ 
	bound boundToroidalSurface: aToroidalSurface
]

{ #category : #accessing }
FACE_OUTER_BOUND >> orientation [
	^orientation
]

{ #category : #accessing }
FACE_OUTER_BOUND >> orientation: anObject [
	orientation := anObject
]
