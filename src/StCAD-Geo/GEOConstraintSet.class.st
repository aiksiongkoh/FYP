"
Composite Pattern: composite is a subclass of component. Hence ConstraintSet is a subclass of Constraint.

Instance Variables:

constraints	<ClassOfVariable>	description of variable's function
"
Class {
	#name : #GEOConstraintSet,
	#superclass : #GEOConstraint,
	#instVars : [
		'constraints'
	],
	#category : #'StCAD-Geo-GEO'
}
