Class {
	#name : #MbDCouplerJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #calc }
MbDCouplerJoint >> aFXIjoint: n [ 
	"Answer constraint force on marker I of joint n."

	| con pGpXI |
	con := constraints first.
	n > con n ifTrue: [^(FullColumn zero: 3)].
	pGpXI := con pGpXIs at: n.
	^pGpXI asFullColumn times: con lam
]

{ #category : #calc }
MbDCouplerJoint >> aFXJjoint: n [ 
	"Answer constraint force on marker J of joint n."

	| con pGpXJ |
	con := constraints first.
	n > con n ifTrue: [^(FullColumn zero: 3)].
	pGpXJ := con pGpXJs at: n.
	^pGpXJ asFullColumn times: con lam
]

{ #category : #calc }
MbDCouplerJoint >> aTXIjoint: n [ 
	"Answer constraint torque on marker I of joint n."

	| con lam pGpXI pGpEI cForceT efrmI prOIeOpEIT aBOIp col term11 term12 |
	con := constraints first.
	n > con n ifTrue: [^(FullColumn zero: 3)].
	lam := con lam.
	pGpXI := con pGpXIs at: n.
	pGpEI := con pGpEIs at: n.
	cForceT := pGpXI times: lam.
	efrmI := (con kineIJs at: n) frmI.
	prOIeOpEIT := efrmI prOeOpE transpose.
	aBOIp := efrmI aBOp.
	col := FullColumn new: 4.
	1 to: 4 do: [:i | 
			term11 := (pGpEI at: i) * lam.
			term12 := cForceT dot: (prOIeOpEIT at: i).
			col at: i put: term11 - term12 / 2.0d].
	^aBOIp timesFullColumn: col
]

{ #category : #calc }
MbDCouplerJoint >> aTXJjoint: n [ 
	"Answer constraint torque on marker J of joint n."

	| con lam pGpXJ pGpEJ cForceT efrmJ prOJeOpEJT aBOJp col term11 term12 |
	con := constraints first.
	n > con n ifTrue: [^(FullColumn zero: 3)].
	lam := con lam.
	pGpXJ := con pGpXJs at: n.
	pGpEJ := con pGpEJs at: n.
	cForceT := pGpXJ times: lam.
	efrmJ := (con kineIJs at: n) frmJ.
	prOJeOpEJT := efrmJ prOeOpE transpose.
	aBOJp := efrmJ aBOp.
	col := FullColumn new: 4.
	1 to: 4 do: [:i | 
			term11 := (pGpEJ at: i) * lam.
			term12 := cForceT dot: (prOJeOpEJT at: i).
			col at: i put: term11 - term12 / 2.0d].
	^aBOJp timesFullColumn: col
]

{ #category : #accessing }
MbDCouplerJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Coupler Joint '
]

{ #category : #accessing }
MbDCouplerJoint >> constraint [
	^constraints at: 1
]

{ #category : #accessing }
MbDCouplerJoint >> fillContactEndFrames: set [ 
	"Do nothing."
]

{ #category : #accessing }
MbDCouplerJoint >> funcBlk: funcBlk [ 
	self constraint funcBlk: funcBlk
]

{ #category : #'initialize-release' }
MbDCouplerJoint >> initialize [
	constraints := OrderedCollection new.
	constraints add: MbDNonlinearCoupler new
]
