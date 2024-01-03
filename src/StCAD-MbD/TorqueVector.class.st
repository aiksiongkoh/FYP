Class {
	#name : #TorqueVector,
	#superclass : #ForTorVector,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'initialize-release' }
TorqueVector >> onFrmI: efrmI andFrmJ: efrmJ [ 
	| comp1 comp2 comp3 |
	comp1 := ForTorActReactOComp
				torqueOnFrmI: efrmI
				andFrmJ: efrmJ
				axis: 1.
	comp2 := ForTorActReactOComp
				torqueOnFrmI: efrmI
				andFrmJ: efrmJ
				axis: 2.
	comp3 := ForTorActReactOComp
				torqueOnFrmI: efrmI
				andFrmJ: efrmJ
				axis: 3.
	components := Array
				with: comp1
				with: comp2
				with: comp3
]

{ #category : #'initialize-release' }
TorqueVector >> onFrmI: efrmI andFrmJ: efrmJ wrtFrmK: efrmK [ 
	| comp1 comp2 comp3 |
	comp1 := ForTorActReactKComp
				torqueOnFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
				axis: 1.
	comp2 := ForTorActReactKComp
				torqueOnFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
				axis: 2.
	comp3 := ForTorActReactKComp
				torqueOnFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
				axis: 3.
	components := Array
				with: comp1
				with: comp2
				with: comp3
]
