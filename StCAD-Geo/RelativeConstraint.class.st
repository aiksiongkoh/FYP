"
Composite Pattern: composite is a subclass of component. Hence ConstraintSet is a subclass of Constraint.

Instance Variables:

constraints	<ClassOfVariable>	description of variable's function
"
Class {
	#name : #RelativeConstraint,
	#superclass : #Constraint,
	#instVars : [
		'markerI',
		'markerJ'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #'VisualWorks metadata' }
RelativeConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
