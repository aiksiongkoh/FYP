Class {
	#name : #'ORIENTED_CLOSED_SHELL',
	#superclass : #'CLOSED_SHELL',
	#instVars : [
		'closed_shell_element',
		'orientation'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
ORIENTED_CLOSED_SHELL >> closed_shell_element [
	^closed_shell_element
]

{ #category : #accessing }
ORIENTED_CLOSED_SHELL >> closed_shell_element: anObject [
	closed_shell_element := anObject
]

{ #category : #accessing }
ORIENTED_CLOSED_SHELL >> orientation [
	^orientation
]

{ #category : #accessing }
ORIENTED_CLOSED_SHELL >> orientation: anObject [
	orientation := anObject
]
