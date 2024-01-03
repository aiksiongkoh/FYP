Class {
	#name : #ForceVector,
	#superclass : #ForTorVector,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'initialize-release' }
ForceVector >> onFrmI: efrmI andFrmJ: efrmJ [ 
	| comp1 comp2 comp3 |
	comp1 := ForTorActReactOComp
				forceOnFrmI: efrmI
				andFrmJ: efrmJ
				axis: 1.
	comp2 := ForTorActReactOComp
				forceOnFrmI: efrmI
				andFrmJ: efrmJ
				axis: 2.
	comp3 := ForTorActReactOComp
				forceOnFrmI: efrmI
				andFrmJ: efrmJ
				axis: 3.
	components := Array
				with: comp1
				with: comp2
				with: comp3
]

{ #category : #'initialize-release' }
ForceVector >> onFrmI: efrmI andFrmJ: efrmJ wrtFrmK: efrmK [ 
	| comp1 comp2 comp3 |
	comp1 := ForTorActReactKComp
				forceOnFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
				axis: 1.
	comp2 := ForTorActReactKComp
				forceOnFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
				axis: 2.
	comp3 := ForTorActReactKComp
				forceOnFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
				axis: 3.
	components := Array
				with: comp1
				with: comp2
				with: comp3
]
