Class {
	#name : #CADAssemblyGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #resources }
CADAssemblyGO class >> standardMenu [

	"Tools.MenuEditor new openOnClass: self andSelector: #standardMenu"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Size' #value: #aSizeDialog ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
CADAssemblyGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADAssemblyGO >> aSizeDialog [
	| magnification interface |
	magnification := Dialog prompt: 'Magnify Assembly by'
				defaultExpression: 1.0d printString.
	magnification isNil ifTrue: [^self].
	(magnification isReal and: [magnification positive]) 
		ifTrue: 
			[magnification ~= 1 
				ifTrue: 
					[interface := self interface.
					(interface geoRootItem)
						magnifySelf: magnification asDouble;
						changed.
					interface projectWorld.
					interface cadApp menuViewRegen]]
		ifFalse: [Dialog warn: 'Magnification must be a positive number.']
]

{ #category : #accessing }
CADAssemblyGO >> dimension [
	^3
]

{ #category : #accessing }
CADAssemblyGO >> geoObject: geoAssembly [ 
	| interface block |
	super geoObject: geoAssembly.
	interface := geoAssembly interface.
	block := [:item | interface createGOfor: item].
	geoAssembly cLighting do: block.
	geoAssembly markers do: block.
	geoAssembly anyParts do: block.
	geoAssembly constraintSets do: block.
	geoAssembly forcesTorques do: block.
	interface createGOfor: geoAssembly gravity.
	geoAssembly aDXFBLOCK ifNotNil: block.
	geoAssembly aNMT ifNotNil: block
]
