Class {
	#name : #JunOpenGLDisplayController,
	#superclass : #JunAbstractControllerWithMenu,
	#instVars : [
		'movementVector',
		'enableMovementProcess'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #'VisualWorks metadata' }
JunOpenGLDisplayController class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
		'superclassNamespace' 'Jun'
	)

]
