Class {
	#name : #DATA,
	#superclass : #STEPParser,
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
DATA class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #parsing }
DATA >> ADVANCED_BREP_SHAPE_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := ADVANCED_BREP_SHAPE_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> ADVANCED_FACE [
	| aSTEPItem |
	aSTEPItem := ADVANCED_FACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem bounds: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem face_geometry: self readEntity.
	self readCharacter: $,.
	aSTEPItem same_sense: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPLICATION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := APPLICATION_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPLICATION_PROTOCOL_DEFINITION [
	| aSTEPItem |
	aSTEPItem := APPLICATION_PROTOCOL_DEFINITION new.
	self readCharacter: $(.
	aSTEPItem status: self readString.
	self readCharacter: $,.
	aSTEPItem application_interpreted_model_schema_name: self readString.
	self readCharacter: $,.
	aSTEPItem application_protocol_year: self readNumber.
	self readCharacter: $,.
	aSTEPItem application: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPROVAL [
	| aSTEPItem |
	aSTEPItem := APPROVAL new.
	self readCharacter: $(.
	aSTEPItem status: self readEntity.
	self readCharacter: $,.
	aSTEPItem level: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPROVAL_DATE_TIME [
	| aSTEPItem |
	aSTEPItem := APPROVAL_DATE_TIME new.
	self readCharacter: $(.
	aSTEPItem date_time: self readEntity.
	self readCharacter: $,.
	aSTEPItem dated_approval: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPROVAL_PERSON_ORGANIZATION [
	| aSTEPItem |
	aSTEPItem := APPROVAL_PERSON_ORGANIZATION new.
	self readCharacter: $(.
	aSTEPItem person_organization: self readEntity.
	self readCharacter: $,.
	aSTEPItem authorized_approval: self readEntity.
	self readCharacter: $,.
	aSTEPItem role: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPROVAL_ROLE [
	| aSTEPItem |
	aSTEPItem := APPROVAL_ROLE new.
	self readCharacter: $(.
	aSTEPItem role: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> APPROVAL_STATUS [
	| aSTEPItem |
	aSTEPItem := APPROVAL_STATUS new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> AXIS1_PLACEMENT [
	| aSTEPItem |
	aSTEPItem := AXIS1_PLACEMENT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem location: self readEntity.
	self readCharacter: $,.
	aSTEPItem axis: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> AXIS2_PLACEMENT_3D [
	| aSTEPItem |
	aSTEPItem := AXIS2_PLACEMENT_3D new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem location: self readEntity.
	self readCharacter: $,.
	aSTEPItem axis: self readEntity.
	self readCharacter: $,.
	aSTEPItem ref_direction: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> BOUNDARY_CURVE [
	| aSTEPItem |
	aSTEPItem := BOUNDARY_CURVE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem segments: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> BOUNDED_SURFACE [
	| aSTEPItem |
	aSTEPItem := BOUNDED_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> BREP_WITH_VOIDS [
	| aSTEPItem |
	aSTEPItem := BREP_WITH_VOIDS new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem outer: self readEntity.
	self readCharacter: $,.
	aSTEPItem voids: self readcEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> B_SPLINE_CURVE_WITH_KNOTS [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_CURVE_WITH_KNOTS new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem control_points_list: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem curve_form: self readDotName.
	self readCharacter: $,.
	aSTEPItem closed_curve: self readBoolean.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $,.
	aSTEPItem knot_multiplicities: self readcNumber.
	self readCharacter: $,.
	aSTEPItem knots: self readcNumber.
	self readCharacter: $,.
	aSTEPItem knot_spec: self readDotName.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> B_SPLINE_SURFACE [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_SURFACE new.
	self readCharacter: $(.
	aSTEPItem u_degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem v_degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem control_points_list: self readccEntity.
	self readCharacter: $,.
	aSTEPItem surface_form: self readDotName.
	self readCharacter: $,.
	aSTEPItem u_closed: self readBoolean.
	self readCharacter: $,.
	aSTEPItem v_closed: self readBoolean.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> B_SPLINE_SURFACE_WITH_KNOTS [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_SURFACE_WITH_KNOTS new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem u_degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem v_degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem control_points_list: self readccEntity.
	self readCharacter: $,.
	aSTEPItem surface_form: self readDotName.
	self readCharacter: $,.
	aSTEPItem u_closed: self readBoolean.
	self readCharacter: $,.
	aSTEPItem v_closed: self readBoolean.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $,.
	aSTEPItem u_multiplicities: self readcNumber.
	self readCharacter: $,.
	aSTEPItem v_multiplicities: self readcNumber.
	self readCharacter: $,.
	aSTEPItem u_knots: self readcNumber.
	self readCharacter: $,.
	aSTEPItem v_knots: self readcNumber.
	self readCharacter: $,.
	aSTEPItem knot_spec: self readDotName.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CALENDAR_DATE [
	| aSTEPItem |
	aSTEPItem := CALENDAR_DATE new.
	self readCharacter: $(.
	aSTEPItem year_component: self readNumber.
	self readCharacter: $,.
	aSTEPItem day_component: self readNumber.
	self readCharacter: $,.
	aSTEPItem month_component: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CARTESIAN_POINT [
	| aSTEPItem |
	aSTEPItem := CARTESIAN_POINT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem coordinates: self readcNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CC_DESIGN_APPROVAL [
	| aSTEPItem |
	aSTEPItem := CC_DESIGN_APPROVAL new.
	self readCharacter: $(.
	aSTEPItem aEntity: self readEntity.
	self readCharacter: $,.
	aSTEPItem cEntity: self readcEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CC_DESIGN_DATE_AND_TIME_ASSIGNMENT [
	| aSTEPItem |
	aSTEPItem := CC_DESIGN_DATE_AND_TIME_ASSIGNMENT new.
	self readCharacter: $(.
	aSTEPItem aEntity: self readEntity.
	self readCharacter: $,.
	aSTEPItem a2Entity: self readEntity.
	self readCharacter: $,.
	aSTEPItem cEntity: self readcEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT [
	| aSTEPItem |
	aSTEPItem := CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT new.
	self readCharacter: $(.
	aSTEPItem aEntity: self readEntity.
	self readCharacter: $,.
	aSTEPItem a2Entity: self readEntity.
	self readCharacter: $,.
	aSTEPItem cEntity: self readcEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CC_DESIGN_SECURITY_CLASSIFICATION [
	| aSTEPItem |
	aSTEPItem := CC_DESIGN_SECURITY_CLASSIFICATION new.
	self readCharacter: $(.
	aSTEPItem aEntity: self readEntity.
	self readCharacter: $,.
	aSTEPItem cEntity: self readcEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CIRCLE [
	| aSTEPItem |
	aSTEPItem := CIRCLE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $,.
	aSTEPItem radius: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CLOSED_SHELL [
	| aSTEPItem |
	aSTEPItem := CLOSED_SHELL new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem cfs_faces: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> COLOUR_RGB [
	| aSTEPItem |
	aSTEPItem := COLOUR_RGB new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem red: self readNumber.
	self readCharacter: $,.
	aSTEPItem green: self readNumber.
	self readCharacter: $,.
	aSTEPItem blue: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> COMPOSITE_CURVE_SEGMENT [
	| aSTEPItem |
	aSTEPItem := COMPOSITE_CURVE_SEGMENT new.
	self readCharacter: $(.
	aSTEPItem transition: self readDotName.
	self readCharacter: $,.
	aSTEPItem same_sense: self readBoolean.
	self readCharacter: $,.
	aSTEPItem parent_curve: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CONICAL_SURFACE [
	| aSTEPItem |
	aSTEPItem := CONICAL_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $,.
	aSTEPItem radius: self readNumber.
	self readCharacter: $,.
	aSTEPItem semi_angle: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CONTEXT_DEPENDENT_SHAPE_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := CONTEXT_DEPENDENT_SHAPE_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem representation_relation: self readEntity.
	self readCharacter: $,.
	aSTEPItem represented_product_relation: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> COORDINATED_UNIVERSAL_TIME_OFFSET [
	| aSTEPItem |
	aSTEPItem := COORDINATED_UNIVERSAL_TIME_OFFSET new.
	self readCharacter: $(.
	aSTEPItem hour_offset: self readNumber.
	self readCharacter: $,.
	aSTEPItem minute_offset: self readNumber.
	self readCharacter: $,.
	aSTEPItem sense: self readDotName.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> CURVE_BOUNDED_SURFACE [
	| aSTEPItem |
	aSTEPItem := CURVE_BOUNDED_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem basis_surface: self readEntity.
	self readCharacter: $,.
	aSTEPItem boundaries: self readcEntity.
	self readCharacter: $,.
	aSTEPItem implicit_outer: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> CURVE_STYLE [
	| aSTEPItem |
	aSTEPItem := CURVE_STYLE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem curve_font: self readEntity.
	self readCharacter: $,.
	aSTEPItem curve_width: self readSizeSelect.
	self readCharacter: $,.
	aSTEPItem curve_colour: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> CYLINDRICAL_SURFACE [
	| aSTEPItem |
	aSTEPItem := CYLINDRICAL_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $,.
	aSTEPItem radius: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> DATE_AND_TIME [
	| aSTEPItem |
	aSTEPItem := DATE_AND_TIME new.
	self readCharacter: $(.
	aSTEPItem date_component: self readEntity.
	self readCharacter: $,.
	aSTEPItem time_component: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> DATE_TIME_ROLE [
	| aSTEPItem |
	aSTEPItem := DATE_TIME_ROLE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> DEFINITIONAL_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := DEFINITIONAL_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> DESIGN_CONTEXT [
	| aSTEPItem |
	aSTEPItem := DESIGN_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem frame_of_reference: self readEntity.
	self readCharacter: $,.
	aSTEPItem life_cycle_stage: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> DIMENSIONAL_EXPONENTS [
	| aSTEPItem |
	aSTEPItem := DIMENSIONAL_EXPONENTS new.
	self readCharacter: $(.
	aSTEPItem length_exponent: self readNumber.
	self readCharacter: $,.
	aSTEPItem mass_exponent: self readNumber.
	self readCharacter: $,.
	aSTEPItem time_exponent: self readNumber.
	self readCharacter: $,.
	aSTEPItem electric_current_exponent: self readNumber.
	self readCharacter: $,.
	aSTEPItem thermodynamic_temperature_exponent: self readNumber.
	self readCharacter: $,.
	aSTEPItem amount_of_substance_exponent: self readNumber.
	self readCharacter: $,.
	aSTEPItem luminous_intensity_exponent: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> DIRECTION [
	| aSTEPItem |
	aSTEPItem := DIRECTION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem direction_ratios: self readcNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> DRAUGHTING_PRE_DEFINED_COLOUR [
	| aSTEPItem |
	aSTEPItem := DRAUGHTING_PRE_DEFINED_COLOUR new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #STEP }
DATA >> DRAUGHTING_PRE_DEFINED_CURVE_FONT [
	| aSTEPItem |
	aSTEPItem := DRAUGHTING_PRE_DEFINED_CURVE_FONT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> EDGE_CURVE [
	| aSTEPItem |
	aSTEPItem := EDGE_CURVE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem edge_start: self readEntity.
	self readCharacter: $,.
	aSTEPItem edge_end: self readEntity.
	self readCharacter: $,.
	aSTEPItem edge_geometry: self readEntity.
	self readCharacter: $,.
	aSTEPItem same_sense: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> EDGE_LOOP [
	| aSTEPItem |
	aSTEPItem := EDGE_LOOP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem edge_list: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> ELLIPSE [
	| aSTEPItem |
	aSTEPItem := ELLIPSE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $,.
	aSTEPItem semi_axis_1: self readNumber.
	self readCharacter: $,.
	aSTEPItem semi_axis_2: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> FACETED_BREP [
	| aSTEPItem |
	aSTEPItem := FACETED_BREP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem outer: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> FACETED_BREP_SHAPE_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := FACETED_BREP_SHAPE_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> FACE_BOUND [
	| aSTEPItem |
	aSTEPItem := FACE_BOUND new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem bound: self readEntity.
	self readCharacter: $,.
	aSTEPItem orientation: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> FACE_OUTER_BOUND [
	| aSTEPItem |
	aSTEPItem := FACE_OUTER_BOUND new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem bound: self readEntity.
	self readCharacter: $,.
	aSTEPItem orientation: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> FACE_SURFACE [
	| aSTEPItem |
	aSTEPItem := FACE_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem bounds: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem face_geometry: self readEntity.
	self readCharacter: $,.
	aSTEPItem same_sense: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> FILL_AREA_STYLE [
	| aSTEPItem |
	aSTEPItem := FILL_AREA_STYLE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem fill_styles: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> FILL_AREA_STYLE_COLOUR [
	| aSTEPItem |
	aSTEPItem := FILL_AREA_STYLE_COLOUR new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem fill_colour: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> GEOMETRICALLY_BOUNDED_SURFACE_SHAPE_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := GEOMETRICALLY_BOUNDED_SURFACE_SHAPE_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readcEntity.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> GEOMETRIC_REPRESENTATION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := GEOMETRIC_REPRESENTATION_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem coordinate_space_dimension: self readNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #STEP }
DATA >> GEOMETRIC_SET [
	| aSTEPItem |
	aSTEPItem := GEOMETRIC_SET new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem elements: self readcEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT [
	| aSTEPItem |
	aSTEPItem := GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem uncertainty: self readOrderedCollection.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> GLOBAL_UNIT_ASSIGNED_CONTEXT [
	| aSTEPItem |
	aSTEPItem := GLOBAL_UNIT_ASSIGNED_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem units: self readOrderedCollection.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> ITEM_DEFINED_TRANSFORMATION [
	| aSTEPItem |
	aSTEPItem := ITEM_DEFINED_TRANSFORMATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem transform_item_1: self readEntity.
	self readCharacter: $,.
	aSTEPItem transform_item_2: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> LENGTH_MEASURE [
	| aSTEPItem |
	aSTEPItem := LENGTH_MEASURE new.
	self readCharacter: $(.
	aSTEPItem value: self readNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> LENGTH_MEASURE_WITH_UNIT [
	| aSTEPItem |
	aSTEPItem := LENGTH_MEASURE_WITH_UNIT new.
	self readCharacter: $(.
	aSTEPItem value_component: self readKeyword.
	self readCharacter: $,.
	aSTEPItem unit_component: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> LENGTH_UNIT [
	| aSTEPItem |
	aSTEPItem := LENGTH_UNIT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> LINE [
	| aSTEPItem |
	aSTEPItem := LINE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem pnt: self readEntity.
	self readCharacter: $,.
	aSTEPItem dir: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> LOCAL_TIME [
	| aSTEPItem |
	aSTEPItem := LOCAL_TIME new.
	self readCharacter: $(.
	aSTEPItem hour_component: self readNumber.
	self readCharacter: $,.
	aSTEPItem minute_component: self readNumber.
	self readCharacter: $,.
	aSTEPItem second_component: self readNumber.
	self readCharacter: $,.
	aSTEPItem zone: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> MANIFOLD_SOLID_BREP [
	| aSTEPItem |
	aSTEPItem := MANIFOLD_SOLID_BREP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem outer: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> MANIFOLD_SURFACE_SHAPE_REPRESENTATION [

	| aSTEPItem |
	aSTEPItem := MANIFOLD_SURFACE_SHAPE_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> MECHANICAL_CONTEXT [
	| aSTEPItem |
	aSTEPItem := MECHANICAL_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem frame_of_reference: self readEntity.
	self readCharacter: $,.
	aSTEPItem discipline_type: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := MECHANICAL_DESIGN_GEOMETRIC_PRESENTATION_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> NAMED_UNIT [
	| aSTEPItem |
	aSTEPItem := NAMED_UNIT new.
	self readCharacter: $(.
	aSTEPItem dimensions: self readEntity.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> NEXT_ASSEMBLY_USAGE_OCCURRENCE [
	| aSTEPItem |
	aSTEPItem := NEXT_ASSEMBLY_USAGE_OCCURRENCE new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem relating_product_definition: self readEntity.
	self readCharacter: $,.
	aSTEPItem related_product_definition: self readEntity.
	self readCharacter: $,.
	aSTEPItem reference_designator: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> OPEN_SHELL [
	| aSTEPItem |
	aSTEPItem := OPEN_SHELL new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem cfs_faces: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> ORGANIZATION [
	| aSTEPItem |
	aSTEPItem := ORGANIZATION new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> ORIENTED_CLOSED_SHELL [
	| aSTEPItem |
	aSTEPItem := ORIENTED_CLOSED_SHELL new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem cfs_faces: self readcEntity.
	self readCharacter: $,.
	aSTEPItem closed_shell_element: self readEntity.
	self readCharacter: $,.
	aSTEPItem orientation: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> ORIENTED_EDGE [
	| aSTEPItem |
	aSTEPItem := ORIENTED_EDGE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem edge_start: self readEntity.
	self readCharacter: $,.
	aSTEPItem edge_end: self readEntity.
	self readCharacter: $,.
	aSTEPItem edge_element: self readEntity.
	self readCharacter: $,.
	aSTEPItem orientation: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> OUTER_BOUNDARY_CURVE [
	| aSTEPItem |
	aSTEPItem := OUTER_BOUNDARY_CURVE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem segments: self readcEntity.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> PCURVE [
	| aSTEPItem |
	aSTEPItem := PCURVE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem basis_surface: self readEntity.
	self readCharacter: $,.
	aSTEPItem reference_to_curve: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PERSON [
	| aSTEPItem |
	aSTEPItem := PERSON new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem last_name: self readString.
	self readCharacter: $,.
	aSTEPItem first_name: self readString.
	self readCharacter: $,.
	aSTEPItem middle_names: self readcString.
	self readCharacter: $,.
	aSTEPItem prefix_titles: self readcString.
	self readCharacter: $,.
	aSTEPItem suffix_titles: self readcString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PERSONAL_ADDRESS [
	| aSTEPItem |
	aSTEPItem := PERSONAL_ADDRESS new.
	self readCharacter: $(.
	aSTEPItem internal_location: self readString.
	self readCharacter: $,.
	aSTEPItem street_number: self readString.
	self readCharacter: $,.
	aSTEPItem street: self readString.
	self readCharacter: $,.
	aSTEPItem postal_box: self readString.
	self readCharacter: $,.
	aSTEPItem town: self readString.
	self readCharacter: $,.
	aSTEPItem region: self readString.
	self readCharacter: $,.
	aSTEPItem postal_code: self readString.
	self readCharacter: $,.
	aSTEPItem country: self readString.
	self readCharacter: $,.
	aSTEPItem facsimile_number: self readString.
	self readCharacter: $,.
	aSTEPItem telephone_number: self readString.
	self readCharacter: $,.
	aSTEPItem electronic_mail_address: self readString.
	self readCharacter: $,.
	aSTEPItem telex_number: self readString.
	self readCharacter: $,.
	aSTEPItem people: self readcEntity.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PERSON_AND_ORGANIZATION [
	| aSTEPItem |
	aSTEPItem := PERSON_AND_ORGANIZATION new.
	self readCharacter: $(.
	aSTEPItem the_person: self readEntity.
	self readCharacter: $,.
	aSTEPItem the_organization: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PERSON_AND_ORGANIZATION_ROLE [
	| aSTEPItem |
	aSTEPItem := PERSON_AND_ORGANIZATION_ROLE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PLANE [
	| aSTEPItem |
	aSTEPItem := PLANE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PLANE_ANGLE_MEASURE [

	| aSTEPItem |
	aSTEPItem := PLANE_ANGLE_MEASURE new.
	self readCharacter: $(.
	aSTEPItem value: self readNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> PLANE_ANGLE_MEASURE_WITH_UNIT [
	| aSTEPItem |
	aSTEPItem := PLANE_ANGLE_MEASURE_WITH_UNIT new.
	self readCharacter: $(.
	aSTEPItem value_component: self readKeyword.
	self readCharacter: $,.
	aSTEPItem unit_component: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PLANE_ANGLE_UNIT [
	| aSTEPItem |
	aSTEPItem := PLANE_ANGLE_UNIT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> POLY_LOOP [
	| aSTEPItem |
	aSTEPItem := POLY_LOOP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem polygon: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRESENTATION_LAYER_ASSIGNMENT [
	| aSTEPItem |
	aSTEPItem := PRESENTATION_LAYER_ASSIGNMENT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem assigned_items: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRESENTATION_STYLE_ASSIGNMENT [
	| aSTEPItem |
	aSTEPItem := PRESENTATION_STYLE_ASSIGNMENT new.
	self readCharacter: $(.
	aSTEPItem styles: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT [
	| aSTEPItem |
	aSTEPItem := PRODUCT new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem frame_of_reference: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_CATEGORY [
	| aSTEPItem |
	aSTEPItem := PRODUCT_CATEGORY new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_CATEGORY_RELATIONSHIP [
	| aSTEPItem |
	aSTEPItem := PRODUCT_CATEGORY_RELATIONSHIP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem category: self readEntity.
	self readCharacter: $,.
	aSTEPItem sub_category: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_CONTEXT [
	| aSTEPItem |
	aSTEPItem := PRODUCT_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem frame_of_reference: self readEntity.
	self readCharacter: $,.
	aSTEPItem discipline_type: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_DEFINITION [
	| aSTEPItem |
	aSTEPItem := PRODUCT_DEFINITION new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem formation: self readEntity.
	self readCharacter: $,.
	aSTEPItem frame_of_reference: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_DEFINITION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := PRODUCT_DEFINITION_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem frame_of_reference: self readEntity.
	self readCharacter: $,.
	aSTEPItem life_cycle_stage: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> PRODUCT_DEFINITION_FORMATION [
	| aSTEPItem |
	aSTEPItem := PRODUCT_DEFINITION_FORMATION new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem of_product: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE [
	| aSTEPItem |
	aSTEPItem := PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE new.
	self readCharacter: $(.
	aSTEPItem id: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem of_product: self readEntity.
	self readCharacter: $,.
	aSTEPItem make_or_buy: self readDotName.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_DEFINITION_SHAPE [
	| aSTEPItem |
	aSTEPItem := PRODUCT_DEFINITION_SHAPE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem definition: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> PRODUCT_RELATED_PRODUCT_CATEGORY [
	| aSTEPItem |
	aSTEPItem := PRODUCT_RELATED_PRODUCT_CATEGORY new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem products: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> QUASI_UNIFORM_CURVE [
	| aSTEPItem |
	aSTEPItem := QUASI_UNIFORM_CURVE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem control_points_list: self readcEntity.
	self readCharacter: $,.
	aSTEPItem curve_form: self readDotName.
	self readCharacter: $,.
	aSTEPItem closed_curve: self readBoolean.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> REPRESENTATION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem context_identifier: self readString.
	self readCharacter: $,.
	aSTEPItem context_type: self readString.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> REPRESENTATION_RELATIONSHIP [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_RELATIONSHIP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem rep_1: self readEntity.
	self readCharacter: $,.
	aSTEPItem rep_2: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION new.
	self readCharacter: $(.
	aSTEPItem transformation_operator: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SECURITY_CLASSIFICATION [
	| aSTEPItem |
	aSTEPItem := SECURITY_CLASSIFICATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem purpose: self readString.
	self readCharacter: $,.
	aSTEPItem security_level: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SECURITY_CLASSIFICATION_LEVEL [
	| aSTEPItem |
	aSTEPItem := SECURITY_CLASSIFICATION_LEVEL new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SHAPE_DEFINITION_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := SHAPE_DEFINITION_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem definition: self readEntity.
	self readCharacter: $,.
	aSTEPItem used_representation: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SHAPE_REPRESENTATION [
	| aSTEPItem |
	aSTEPItem := SHAPE_REPRESENTATION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem items: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem context_of_items: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SHAPE_REPRESENTATION_RELATIONSHIP [
	| aSTEPItem |
	aSTEPItem := SHAPE_REPRESENTATION_RELATIONSHIP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem rep_1: self readEntity.
	self readCharacter: $,.
	aSTEPItem rep_2: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SHELL_BASED_SURFACE_MODEL [

	| aSTEPItem |
	aSTEPItem := SHELL_BASED_SURFACE_MODEL new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem sbsm_boundary: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SI_UNIT [
	| aSTEPItem |
	aSTEPItem := SI_UNIT new.
	self readCharacter: $(.
	aSTEPItem prefix: self readDotName.
	self readCharacter: $,.
	aSTEPItem name: self readDotName.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> SOLID_ANGLE_UNIT [
	| aSTEPItem |
	aSTEPItem := SOLID_ANGLE_UNIT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> SPHERICAL_SURFACE [
	| aSTEPItem |
	aSTEPItem := SPHERICAL_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $,.
	aSTEPItem radius: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> STYLED_ITEM [
	| aSTEPItem |
	aSTEPItem := STYLED_ITEM new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem styles: self readOrderedCollection.
	self readCharacter: $,.
	aSTEPItem item: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> SURFACE_OF_LINEAR_EXTRUSION [
	| aSTEPItem |
	aSTEPItem := SURFACE_OF_LINEAR_EXTRUSION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem swept_curve: self readEntity.
	self readCharacter: $,.
	aSTEPItem extrusion_axis: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SURFACE_OF_REVOLUTION [
	| aSTEPItem |
	aSTEPItem := SURFACE_OF_REVOLUTION new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem swept_curve: self readEntity.
	self readCharacter: $,.
	aSTEPItem axis_position: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SURFACE_SIDE_STYLE [
	| aSTEPItem |
	aSTEPItem := SURFACE_SIDE_STYLE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem styles: self readOrderedCollection.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SURFACE_STYLE_FILL_AREA [
	| aSTEPItem |
	aSTEPItem := SURFACE_STYLE_FILL_AREA new.
	self readCharacter: $(.
	aSTEPItem fill_area: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> SURFACE_STYLE_USAGE [
	| aSTEPItem |
	aSTEPItem := SURFACE_STYLE_USAGE new.
	self readCharacter: $(.
	aSTEPItem side: self readPosNegBoth.
	self readCharacter: $,.
	aSTEPItem style: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> TOROIDAL_SURFACE [
	| aSTEPItem |
	aSTEPItem := TOROIDAL_SURFACE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem position: self readEntity.
	self readCharacter: $,.
	aSTEPItem major_radius: self readNumber.
	self readCharacter: $,.
	aSTEPItem minor_radius: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #STEP }
DATA >> TRIMMED_CURVE [
	| aSTEPItem |
	aSTEPItem := TRIMMED_CURVE new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem basis_curve: self readEntity.
	self readCharacter: $,.
	aSTEPItem trim_1: self readTrimmingSelect.
	self readCharacter: $,.
	aSTEPItem trim_2: self readTrimmingSelect.
	self readCharacter: $,.
	aSTEPItem sense_agreement: self readBoolean.
	self readCharacter: $,.
	aSTEPItem master_representation: self readDotName.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> UNCERTAINTY_MEASURE_WITH_UNIT [
	| aSTEPItem |
	aSTEPItem := UNCERTAINTY_MEASURE_WITH_UNIT new.
	self readCharacter: $(.
	aSTEPItem value_component: self readKeyword.
	self readCharacter: $,.
	aSTEPItem unit_component: self readEntity.
	self readCharacter: $,.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> VECTOR [
	| aSTEPItem |
	aSTEPItem := VECTOR new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem orientation: self readEntity.
	self readCharacter: $,.
	aSTEPItem magnitude: self readNumber.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> VERTEX_POINT [
	| aSTEPItem |
	aSTEPItem := VERTEX_POINT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem vertex_geometry: self readEntity.
	self readCharacter: $).
	aDict at: iLine put: aSTEPItem
]

{ #category : #parsing }
DATA >> modBOUNDED_CURVE [
	| aSTEPItem |
	aSTEPItem := BOUNDED_CURVE new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modBOUNDED_SURFACE [
	| aSTEPItem |
	aSTEPItem := BOUNDED_SURFACE new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modB_SPLINE_CURVE [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_CURVE new.
	self readCharacter: $(.
	aSTEPItem degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem control_points_list: self readcEntity.
	self readCharacter: $,.
	aSTEPItem curve_form: self readDotName.
	self readCharacter: $,.
	aSTEPItem closed_curve: self readBoolean.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modB_SPLINE_CURVE_WITH_KNOTS [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_CURVE_WITH_KNOTS new.
	self readCharacter: $(.
	aSTEPItem knot_multiplicities: self readcNumber.
	self readCharacter: $,.
	aSTEPItem knots: self readcNumber.
	self readCharacter: $,.
	aSTEPItem knot_spec: self readDotName.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modB_SPLINE_SURFACE [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_SURFACE new.
	self readCharacter: $(.
	aSTEPItem u_degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem v_degree: self readNumber.
	self readCharacter: $,.
	aSTEPItem control_points_list: self readccEntity.
	self readCharacter: $,.
	aSTEPItem surface_form: self readDotName.
	self readCharacter: $,.
	aSTEPItem u_closed: self readBoolean.
	self readCharacter: $,.
	aSTEPItem v_closed: self readBoolean.
	self readCharacter: $,.
	aSTEPItem self_intersect: self readBoolean.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modB_SPLINE_SURFACE_WITH_KNOTS [
	| aSTEPItem |
	aSTEPItem := B_SPLINE_SURFACE_WITH_KNOTS new.
	self readCharacter: $(.
	aSTEPItem u_multiplicities: self readcNumber.
	self readCharacter: $,.
	aSTEPItem v_multiplicities: self readcNumber.
	self readCharacter: $,.
	aSTEPItem u_knots: self readcNumber.
	self readCharacter: $,.
	aSTEPItem v_knots: self readcNumber.
	self readCharacter: $,.
	aSTEPItem knot_spec: self readDotName.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modCONVERSION_BASED_UNIT [
	| aSTEPItem |
	aSTEPItem := CONVERSION_BASED_UNIT new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem conversion_factor: self readEntity.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modCURVE [
	| aSTEPItem |
	aSTEPItem := CURVE new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modGEOMETRIC_REPRESENTATION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := GEOMETRIC_REPRESENTATION_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem coordinate_space_dimension: self readNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modGEOMETRIC_REPRESENTATION_ITEM [
	| aSTEPItem |
	aSTEPItem := GEOMETRIC_REPRESENTATION_ITEM new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modGLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT [
	| aSTEPItem |
	aSTEPItem := GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem uncertainty: self readOrderedCollection.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modGLOBAL_UNIT_ASSIGNED_CONTEXT [
	| aSTEPItem |
	aSTEPItem := GLOBAL_UNIT_ASSIGNED_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem units: self readOrderedCollection.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modLENGTH_UNIT [
	| aSTEPItem |
	aSTEPItem := LENGTH_UNIT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modNAMED_UNIT [
	| aSTEPItem |
	aSTEPItem := NAMED_UNIT new.
	self readCharacter: $(.
	aSTEPItem dimensions: self readEntity.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #STEP }
DATA >> modPARAMETER_VALUE [
	| aSTEPItem |
	aSTEPItem := PARAMETER_VALUE new.
	self readCharacter: $(.
	aSTEPItem value: self readNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #STEP }
DATA >> modPARAMETRIC_REPRESENTATION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := PARAMETRIC_REPRESENTATION_CONTEXT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modPLANE_ANGLE_UNIT [
	| aSTEPItem |
	aSTEPItem := PLANE_ANGLE_UNIT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #'As yet unclassified' }
DATA >> modPOSITIVE_LENGTH_MEASURE [
	| aSTEPItem |
	aSTEPItem := POSITIVE_LENGTH_MEASURE new.
	self readCharacter: $(.
	aSTEPItem length_measure: self readNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modRATIONAL_B_SPLINE_CURVE [
	| aSTEPItem |
	aSTEPItem := RATIONAL_B_SPLINE_CURVE new.
	self readCharacter: $(.
	aSTEPItem weights_data: self readcNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modRATIONAL_B_SPLINE_SURFACE [
	| aSTEPItem |
	aSTEPItem := RATIONAL_B_SPLINE_SURFACE new.
	self readCharacter: $(.
	aSTEPItem weights_data: self readccNumber.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modREPRESENTATION_CONTEXT [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_CONTEXT new.
	self readCharacter: $(.
	aSTEPItem context_identifier: self readString.
	self readCharacter: $,.
	aSTEPItem context_type: self readString.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modREPRESENTATION_ITEM [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_ITEM new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modREPRESENTATION_RELATIONSHIP [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_RELATIONSHIP new.
	self readCharacter: $(.
	aSTEPItem name: self readString.
	self readCharacter: $,.
	aSTEPItem description: self readString.
	self readCharacter: $,.
	aSTEPItem rep_1: self readEntity.
	self readCharacter: $,.
	aSTEPItem rep_2: self readEntity.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modREPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION [
	| aSTEPItem |
	aSTEPItem := REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION new.
	self readCharacter: $(.
	aSTEPItem transformation_operator: self readEntity.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modSHAPE_REPRESENTATION_RELATIONSHIP [
	| aSTEPItem |
	aSTEPItem := SHAPE_REPRESENTATION_RELATIONSHIP new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modSI_UNIT [
	| aSTEPItem |
	aSTEPItem := SI_UNIT new.
	self readCharacter: $(.
	aSTEPItem prefix: self readDotName.
	self readCharacter: $,.
	aSTEPItem name: self readDotName.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modSOLID_ANGLE_UNIT [
	| aSTEPItem |
	aSTEPItem := SOLID_ANGLE_UNIT new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> modSURFACE [
	| aSTEPItem |
	aSTEPItem := SURFACE new.
	self readCharacter: $(.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #STEP }
DATA >> modSURFACE_CURVE [
	| aSTEPItem |
	aSTEPItem := SURFACE_CURVE new.
	self readCharacter: $(.
	aSTEPItem curve_3d: self readEntity.
	self readCharacter: $,.
	aSTEPItem associated_geometry: self readcEntity.
	self readCharacter: $,.
	aSTEPItem master_representation: self readDotName.
	self readCharacter: $).
	^aSTEPItem
]

{ #category : #parsing }
DATA >> nextKeyword [
	| aWriteStream continue |
	self skipToNextToken.
	inStream peek = $# 
		ifTrue: 
			[iLine := self readEntityNumber.
			self readCharacter: $=.
			self skipToNextToken.
			aWriteStream := (inStream contentsSpecies new: 64) writeStream.
			continue := true.
			
			[inStream atEnd ifTrue: [continue := false].
			continue] whileTrue: 
						[| element |
						element := inStream next.
						(' (;' includes: element) 
							ifTrue: 
								[continue := false.
								inStream skip: -1]
							ifFalse: [aWriteStream nextPut: element]].
			aKeyword := aWriteStream contents.
			aKeyword isEmpty ifTrue: [aKeyword := #readGeneralCollection]]
		ifFalse: [aKeyword := inStream upTo: $;]
]

{ #category : #parsing }
DATA >> readDotName [
	self skipToNextToken.
	^inStream peek = $$ 
		ifTrue: [inStream next]
		ifFalse: 
			[self readCharacter: $..
			inStream upTo: $.]
]

{ #category : #parsing }
DATA >> readEntity [
	| peekChar answer |
	self skipToNextToken.
	peekChar := inStream peek.
	('*$' includes: peekChar) 
		ifTrue: 
			[inStream next.
			answer := nil]
		ifFalse: 
			[peekChar = $# 
				ifTrue: 
					[| aWriteStream continue |
					aWriteStream := (inStream contentsSpecies new: 64) writeStream.
					aWriteStream nextPut: inStream next.
					continue := true.
					
					[inStream atEnd ifTrue: [continue := false].
					continue] whileTrue: 
								[| element |
								element := inStream next.
								element isDigit 
									ifTrue: [aWriteStream nextPut: element]
									ifFalse: 
										[continue := false.
										inStream skip: -1]].
					answer := aWriteStream contents]
				ifFalse: [self expected: 'Entity number expected']].
	^answer
]

{ #category : #parsing }
DATA >> readGeneralCollection [
	| aStream |
	aStream := OrderedCollection new writeStream.
	self readCharacter: $(.
	
	[self skipToNextToken.
	aStream nextPut: self readModKeyword.
	inStream skipSeparators.
	inStream peek = $)] 
			whileFalse.
	self readCharacter: $).
	aDict at: iLine put: aStream contents.
	^aStream contents
]

{ #category : #parsing }
DATA >> readKeyword [
	| aWriteStream continue |
	self skipToNextToken.
	aWriteStream := (inStream contentsSpecies new: 64) writeStream.
	continue := true.
	
	[inStream atEnd ifTrue: [continue := false].
	continue] whileTrue: 
				[| element |
				element := inStream next.
				(' (;' includes: element) 
					ifTrue: 
						[continue := false.
						inStream skip: -1]
					ifFalse: [aWriteStream nextPut: element]].
	aKeyword := aWriteStream contents.
	^self perform: aKeyword asSymbol
]

{ #category : #parsing }
DATA >> readModKeyword [
	| aWriteStream continue |
	self skipToNextToken.
	aWriteStream := (inStream contentsSpecies new: 64) writeStream.
	aWriteStream nextPutAll: 'mod'.
	continue := true.
	
	[inStream atEnd ifTrue: [continue := false].
	continue] whileTrue: 
				[| element |
				element := inStream next.
				((' (;' includes: element) or: [element isSeparator]) 
					ifTrue: 
						[continue := false.
						inStream skip: -1]
					ifFalse: [aWriteStream nextPut: element]].
	aKeyword := aWriteStream contents.
	^self perform: aKeyword asSymbol
]

{ #category : #parsing }
DATA >> readSizeSelect [
	self skipToNextToken.
	^self readModKeyword
]

{ #category : #parsing }
DATA >> readTrimmingSelect [
	| aStream |
	aStream := OrderedCollection new writeStream.
	self readCharacter: $(.
	
	[self skipToNextToken.
	aStream nextPut: self readModKeyword.
	inStream skipSeparators.
	inStream peek = $)] 
			whileFalse.
	self readCharacter: $).
	^aStream contents
]

{ #category : #parsing }
DATA >> readcEntity [
	| peekChar aStream |
	self skipToNextToken.
	peekChar := inStream peek.
	^('*$' includes: peekChar) 
		ifTrue: 
			[inStream next.
			nil]
		ifFalse: 
			[aStream := OrderedCollection new writeStream.
			self readCharacter: $(.
			
			[self skipToNextToken.
			aStream nextPut: self readEntity.
			inStream skipSeparators.
			inStream peek = $,] 
					whileTrue: [self readCharacter: $,].
			self readCharacter: $).
			aStream contents]
]
