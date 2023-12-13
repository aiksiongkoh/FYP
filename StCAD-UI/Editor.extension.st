Extension { #name : #Editor }

{ #category : #'*StCAD-UI-initialize-release' }
Editor >> initialize [
	super initialize.
	adButton := AdButton new.
	filename := ''
]
