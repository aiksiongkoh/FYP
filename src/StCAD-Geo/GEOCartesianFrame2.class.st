"
Cartesian frame system.

Instance Variables:

refFrame	<nil or GEOCartesianFrame>	base frame of current frame.
rFfF	<StMFullColumn>	displacement from base frame origin to current frame origin in base frame components.
aAFf	<StMFullMatrix>	transformation matrix such that {IJK}F := [aAFf] {ijk}f.
rOfO	<StMFullColumn>	displacement from world frame origin to current frame origin in world frame components.
aAOf	<StMFullMatrix>	transformation matrix such that {IJK}O := [aAOf] {ijk}f.
dependentFrames	<IdentitySet>	set of dependent frames.
body	<aObject>	any object associated with the current frame.
"
Class {
	#name : #GEOCartesianFrame2,
	#superclass : #NewEventModel,
	#instVars : [
		'refFrame',
		'rFfF',
		'aAFf',
		'rOfO',
		'aAOf',
		'dependentFrames',
		'body'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOCartesianFrame2 >> aAFf [
	^aAFf
]

{ #category : #accessing }
GEOCartesianFrame2 >> aAFf: aA [ 
	aAFf := aA.
	self changed
]

{ #category : #accessing }
GEOCartesianFrame2 >> aAOF [
	^refFrame aAOf
]

{ #category : #accessing }
GEOCartesianFrame2 >> aAOf [
	^aAOf ifNil: 
			[aAOf := refFrame ifNil: [aAFf]
						ifNotNil: [refFrame aAOf timesFullMatrix: aAFf]]
]

{ #category : #accessing }
GEOCartesianFrame2 >> aMFf [
	| aAFf1 aAFf2 aAFf3 answer |
	aAFf1 := aAFf at: 1.
	aAFf2 := aAFf at: 2.
	aAFf3 := aAFf at: 3.
	answer := Jun3dTransformation basicNew.
	answer
		setA: (aAFf1 at: 1);
		setB: (aAFf2 at: 1);
		setC: (aAFf3 at: 1);
		setP: 0.0d.
	answer
		setD: (aAFf1 at: 2);
		setE: (aAFf2 at: 2);
		setF: (aAFf3 at: 2);
		setQ: 0.0d.
	answer
		setG: (aAFf1 at: 3);
		setH: (aAFf2 at: 3);
		setI: (aAFf3 at: 3);
		setR: 0.0d.
	answer
		setL: (rFfF at: 1);
		setM: (rFfF at: 2);
		setN: (rFfF at: 3);
		setS: 1.0d.
	^answer
]

{ #category : #accessing }
GEOCartesianFrame2 >> aMFfT [
	| aAFf1 aAFf2 aAFf3 answer |
	aAFf1 := aAFf at: 1.
	aAFf2 := aAFf at: 2.
	aAFf3 := aAFf at: 3.
	answer := Jun3dTransformation basicNew.
	answer
		setA: (aAFf1 at: 1);
		setB: (aAFf1 at: 2);
		setC: (aAFf1 at: 3);
		setP: 0.0d.
	answer
		setD: (aAFf2 at: 1);
		setE: (aAFf2 at: 2);
		setF: (aAFf2 at: 3);
		setQ: 0.0d.
	answer
		setG: (aAFf3 at: 1);
		setH: (aAFf3 at: 2);
		setI: (aAFf3 at: 3);
		setR: 0.0d.
	answer
		setL: (rFfF at: 1);
		setM: (rFfF at: 2);
		setN: (rFfF at: 3);
		setS: 1.0d.
	^answer
]

{ #category : #accessing }
GEOCartesianFrame2 >> aOfO [
	| answer |
	answer := self triggerEvent: #getaOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self aOfO: answer].
	^answer
]

{ #category : #accessing }
GEOCartesianFrame2 >> aOfO: aOfO [ 
	self removeActionsForEvent: #getaOfO.
	aOfO notNil ifTrue: [self
			when: #getaOfO
			ask: aOfO
			perform: #yourself]
]

{ #category : #accessing }
GEOCartesianFrame2 >> aSup [
	^refFrame
]

{ #category : #accessing }
GEOCartesianFrame2 >> aSup: aaRefFrame [ 
	refFrame := aaRefFrame.
	^aaRefFrame
]

{ #category : #accessing }
GEOCartesianFrame2 >> addDependentFrame: aFrame [ 
	dependentFrames add: aFrame
]

{ #category : #accessing }
GEOCartesianFrame2 >> addMarkersIn: set [ 
	"Do nothing."
]

{ #category : #accessing }
GEOCartesianFrame2 >> addSub: aSub [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aSub removeSup.
	self cSub add: aSub.
	aSub aSup: self.
	^aSub
]

{ #category : #accessing }
GEOCartesianFrame2 >> alpOfO [
	| answer |
	answer := self triggerEvent: #getalpOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self alpOfO: answer].
	^answer
]

{ #category : #accessing }
GEOCartesianFrame2 >> alpOfO: alpOfO [ 
	self removeActionsForEvent: #getalpOfO.
	alpOfO notNil ifTrue: [self
			when: #getalpOfO
			ask: alpOfO
			perform: #yourself]
]

{ #category : #calc }
GEOCartesianFrame2 >> axis: i dotFrame: frame axis: j [ 
	^(self aAOf column: i)
		dot: (frame aAOf column: j)
]

{ #category : #accessing }
GEOCartesianFrame2 >> body [
	^body
]

{ #category : #accessing }
GEOCartesianFrame2 >> body: aObject [ 
	body := aObject
]

{ #category : #accessing }
GEOCartesianFrame2 >> cSub [
	^dependentFrames
]

{ #category : #calc }
GEOCartesianFrame2 >> calc [
	"Calculate all dependent instance variables."

	| rOFO aAOF |
	refFrame isNil
		ifTrue: 
			[rOfO := rFfF.
			aAOf := aAFf]
		ifFalse: 
			[rOFO := refFrame rOfO.
			aAOF := refFrame aAOf.
			rOfO := rOFO + (aAOF timesFullColumn: rFfF).
			aAOf := aAOF timesFullMatrix: aAFf]
]

{ #category : #calc }
GEOCartesianFrame2 >> calcAll [
	self calc.
	dependentFrames do: [:dependentFrame | dependentFrame calcAll]
]

{ #category : #change }
GEOCartesianFrame2 >> changed [
	rOfO := nil.
	aAOf := nil.
	dependentFrames do: [:dependentFrame | dependentFrame changed].
	body == nil ifFalse: [body refFrameChanged].
	super changed
]

{ #category : #'initialize-release' }
GEOCartesianFrame2 >> coincideWithRefFrame [
	self rFfF: (FullColumn zero: 3) aAFf: (FullMatrix identity: 3)
]

{ #category : #change }
GEOCartesianFrame2 >> conditionA [
	aAFf := FullMatrix 
				rotationMatrixFromOrigin: (FullColumn  zero: 3)
				zPoint: (aAFf column: 3)
				xPoint: (aAFf column: 1).
	dependentFrames do: [:dependentFrame | dependentFrame conditionA]
]

{ #category : #copy }
GEOCartesianFrame2 >> copyrFfFandAFfFrom: frame [ 
	rFfF := frame rFfF copy.
	aAFf := frame aAFf copy.
	self changed
]

{ #category : #'initialize-release' }
GEOCartesianFrame2 >> cut [
	refFrame removeDependentFrame: self.
	super cut
]

{ #category : #calc }
GEOCartesianFrame2 >> dataAxesIntersectLine: geoLine axisLength: length tolerance: tol [ 
	"
	Find the minimum distance to any axis. 
	General formula: 
	Line is P(t) = P0 + tv. 
	Line is Q(u) = Q0 + uw. 
	Minimize P(t) - Q(u). 
	Therefore 
	t = w*(P0 - Q0) v*w - v*(P0 - Q0) w*w / (v*v w*w - v*w v*w). 
	u = w*(P0 - Q0) v*v - v*(P0 - Q0) w*v / (v*v w*w - v*w v*w). 
	
	For x axis, P0 = (0,0,0), v = (1,0,0). 
	t = w*(- Q0) w1 - (- Q01) w*w / (w*w - w1w1) = Q01 w*w - w*Q0 w1 / (w*w - w1w1). 
	u = w*(- Q0) - (- Q01) w1 / (w*w - w1w1) = Q01 w1 - w*Q0 / (w*w - w1w1). 
	For y axis, P0 = (0,0,0), v = (0,1,0). 
	For z axis, P0 = (0,0,0), v = (0,0,1). 
	"

	| rfstartf rfendf q0 w wdotw i q0i wi wwmwiwi t u qIntsec minVector minDist wdotq0 |
	rfstartf := self rfpffromrOpO: geoLine rOstartO.
	rfendf := self rfpffromrOpO: geoLine rOendO.
	q0 := rfstartf.
	w := rfendf - rfstartf.
	wdotw := w sumOfSquares.
	wdotq0 := w dot: q0.
	i := 0.
	
	[i := i + 1.
	i <= 3]
		whileTrue: 
			[q0i := q0 at: i.
			wi := w at: i.
			wwmwiwi := wdotw - (wi * wi).
			wwmwiwi > MachineAccuracy OfDoubleTimesFour
				ifTrue: 
					[t := q0i * wdotw - (wdotq0 * wi) / wwmwiwi.
					u := q0i * wi - wdotq0 / wwmwiwi.
					qIntsec := q0 + (w times: u).
					minVector := qIntsec copy at: i minusNumber: t.
					minDist := minVector length.
					minDist <= tol ifTrue: [^Array
							with: true
							with: i
							with: t
							with: u]]].
	^Array with: false
]

{ #category : #calc }
GEOCartesianFrame2 >> dataAxesIntersectLine: geoLine tolerance: tol [
	"
	Find the minimum distance to any axis. 
	General formula: 
	Line is P(t) = P0 + tv. 
	Line is Q(t) = Q0 + uw. 
	Substitute x = Q(t) gives (Q + tw - P) dot v = 0. 
	Therefore 
	t = (P - Q) dot v / (w dot v). 
	Intersection point is at 
	Q + ((P - Q) dot v / (w dot v)) w. 
	
	For xy plane P = (0,0,0), v = (0,0,1). 
	"

	| rfstartf rfendf lineVector parameter rfIntsecf distStartIntsec |
	rfstartf := self rfpffromrOpO: geoLine rOstartO.
	rfendf := self rfpffromrOpO: geoLine rOendO.
	lineVector := rfendf - rfstartf.
	parameter := (rfstartf at: 3)
				/ (lineVector at: 3).
	rfIntsecf := rfstartf minus: lineVector times: parameter.
	distStartIntsec := parameter * lineVector length.
	^Array
		with: parameter
		with: rfIntsecf
		with: distStartIntsec
]

{ #category : #calc }
GEOCartesianFrame2 >> dataXYPlaneIntersectLine: geoLine [ 
	"
	Find the intesection of the line on the xy plane. 
	General formula: 
	Plane is (x - P) dot v = 0. 
	Line is Q(t) = Q + tw. 
	Substitute x = Q(t) gives (Q + tw - P) dot v = 0. 
	Therefore 
	t = (P - Q) dot v / (w dot v). 
	Intersection point is at 
	Q + ((P - Q) dot v / (w dot v)) w. 
	
	For xy plane P = (0,0,0), v = (0,0,1). 
	"

	| rfstartf rfendf lineVector parameter rfIntsecf distStartIntsec |
	rfstartf := self rfpffromrOpO: geoLine rOstartO.
	rfendf := self rfpffromrOpO: geoLine rOendO.
	lineVector := rfendf - rfstartf.
	parameter := 0.0d - (rfstartf at: 3) / (lineVector at: 3).
	rfIntsecf := rfstartf plus: lineVector times: parameter.
	distStartIntsec := parameter * lineVector length.
	^Array
		with: parameter
		with: rfIntsecf
		with: distStartIntsec
]

{ #category : #calc }
GEOCartesianFrame2 >> distXYPlaneIntersectLine: geoLine [ 
	| data |
	data := self dataXYPlaneIntersectLine: geoLine.
	^data at: 3
]

{ #category : #accessing }
GEOCartesianFrame2 >> fixedAtRef [
	rFfF := (FullColumn zero: 3).
	aAFf := (FullMatrix identity: 3).
	self changed
]

{ #category : #copy }
GEOCartesianFrame2 >> frozenCopy [
	"Used in handle tracking."

	| answer |
	answer := self shallowCopy.
	answer copyrFfFandAFfFrom: self.
	^answer
]

{ #category : #'initialize-release' }
GEOCartesianFrame2 >> initialize [

	dependentFrames := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #accessing }
GEOCartesianFrame2 >> interface [
	^refFrame interface
]

{ #category : #testing }
GEOCartesianFrame2 >> isAssembly [
	^false
]

{ #category : #accessing }
GEOCartesianFrame2 >> isFace [
	^false
]

{ #category : #testing }
GEOCartesianFrame2 >> isInterface [
	^false
]

{ #category : #testing }
GEOCartesianFrame2 >> isPart [
	^false
]

{ #category : #printing }
GEOCartesianFrame2 >> logString: string [ 
	refFrame logString: string
]

{ #category : #accessing }
GEOCartesianFrame2 >> magnifySelf: aDouble [ 
	self rFfF magnifySelf: aDouble.
	self rOfO: nil.
	self vOfO: nil.
	self aOfO: nil
]

{ #category : #accessing }
GEOCartesianFrame2 >> menu [
	^nil
]

{ #category : #accessing }
GEOCartesianFrame2 >> omeOfO [
	| answer |
	answer := self triggerEvent: #getomeOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self omeOfO: answer].
	^answer
]

{ #category : #accessing }
GEOCartesianFrame2 >> omeOfO: omeOfO [ 
	self removeActionsForEvent: #getomeOfO.
	omeOfO notNil ifTrue: [self
			when: #getomeOfO
			ask: omeOfO
			perform: #yourself]
]

{ #category : #accessing }
GEOCartesianFrame2 >> positionMemento [

	| aMemento |
	aMemento := Polymorphic_GFMemento originator: self. "VW_TRANSLATION:Polymorphic.GFMemento:Polymorphic_GFMemento"
	aMemento
		addActionSelector: #rFfF:aAFf:
		arguments: (Array with: rFfF copy with: aAFf copy).
	^ aMemento
]

{ #category : #copy }
GEOCartesianFrame2 >> postCopy [

	"OK for copy to reference the refFrame and body. But they do not know of this new copy. User still 
	needs to connect explicitly."

	super postCopy.
	rFfF := rFfF copy.
	aAFf := aAFf copy.
	rOfO := nil.
	aAOf := nil.
	dependentFrames := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #copy }
GEOCartesianFrame2 >> preSave [
	"Do nothing."
]

{ #category : #printing }
GEOCartesianFrame2 >> printOn: aStream [ 
	| title |
	title := self class name.
	aStream nextPutAll: ((title at: 1) isVowel
			ifTrue: ['an ']
			ifFalse: ['a ']).
	aStream print: self class.
	aStream space.
	aStream nextPutAll: 'on'.
	aStream space.
	aStream print: body
]

{ #category : #change }
GEOCartesianFrame2 >> quietlyChanged [
	rOfO := nil.
	aAOf := nil.
	dependentFrames do: [:dependentFrame | dependentFrame quietlyChanged]
]

{ #category : #accessing }
GEOCartesianFrame2 >> quietlyrFfF: rFpF aAFf: aAFp [ 
	"Must be used from the root on down."
	"Then the root must perform changed."

	rFfF := rFpF.
	aAFf := aAFp.
	rOfO := nil.
	aAOf := nil
]

{ #category : #accessing }
GEOCartesianFrame2 >> quietlyrOfO: rOpO aAOf: aAOp [ 
	"Must be used from the root on down."
	"Then the root must perform changed."

	rFfF := refFrame rfpffromrOpO: rOpO.
	aAFf := refFrame aAOf transpose timesFullMatrix: aAOp.
	rOfO := rOpO.
	aAOf := aAOp
]

{ #category : #accessing }
GEOCartesianFrame2 >> quietlyvOfO: vOpO omeOfO: omeOfO [ 
	self vOfO: vOpO.
	self omeOfO: omeOfO
]

{ #category : #accessing }
GEOCartesianFrame2 >> rDbodycenterPx [
	^self interface projectionFrame rDpPxfromrOpO: body rOcenterO
]

{ #category : #accessing }
GEOCartesianFrame2 >> rDfD [
	^self interface projectionFrame rDpPxfromrOpO: rOfO
]

{ #category : #accessing }
GEOCartesianFrame2 >> rDoriginPx [
	^self interface projectionFrame rDpPxfromrOpO: self rOfO
]

{ #category : #accessing }
GEOCartesianFrame2 >> rDpPxfromrfpf: rfpf [ 
	^self interface projectionFrame rDpPxfromrOpO: (self rOpOfromrfpf: rfpf)
]

{ #category : #accessing }
GEOCartesianFrame2 >> rFfF [
	^rFfF
]

{ #category : #accessing }
GEOCartesianFrame2 >> rFfF: col [ 
	rFfF := col.
	self changed
]

{ #category : #accessing }
GEOCartesianFrame2 >> rFfF: r aAFf: aA [ 
	rFfF := r.
	aAFf := aA.
	self changed
]

{ #category : #accessing }
GEOCartesianFrame2 >> rFpFfromrOpO: rOpO [ 
	^self refFrame rfpffromrOpO: rOpO
]

{ #category : #accessing }
GEOCartesianFrame2 >> rFpFfromrfpf: rfpf [ 
	^rFfF + (aAFf timesFullColumn: rfpf)
]

{ #category : #accessing }
GEOCartesianFrame2 >> rOfO [
	^rOfO ifNil: 
			[rOfO := refFrame ifNil: [rFfF]
						ifNotNil: [refFrame rOfO + (refFrame aAOf timesFullColumn: rFfF)]]
]

{ #category : #accessing }
GEOCartesianFrame2 >> rOfO: aFullColumn [ 
	rOfO := aFullColumn
]

{ #category : #accessing }
GEOCartesianFrame2 >> rOpOfromrfpf: rfpf [ 
	^self rOfO + (self aAOf timesFullColumn: rfpf)
]

{ #category : #accessing }
GEOCartesianFrame2 >> refFrame [
	^refFrame
]

{ #category : #accessing }
GEOCartesianFrame2 >> refFrame: aFrame [ 
	self setRefFrame: aFrame.
	self changed
]

{ #category : #accessing }
GEOCartesianFrame2 >> refFrame: aFrame rFfF: r aAFf: aA [ 
	self setRefFrame: aFrame.
	rFfF := r.
	aAFf := aA.
	self changed
]

{ #category : #accessing }
GEOCartesianFrame2 >> refFrame: aFrame rFfF: origin xPoint: xPoint yPoint: yPoint [ 
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: origin
				xPoint: xPoint
				yPoint: yPoint.
	self
		refFrame: aFrame
		rFfF: origin
		aAFf: aA
]

{ #category : #accessing }
GEOCartesianFrame2 >> refFrame: aFrame rFfF: origin xPoint: xPoint zPoint: zPoint [ 
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: origin
				xPoint: xPoint
				zPoint: zPoint.
	self
		refFrame: aFrame
		rFfF: origin
		aAFf: aA
]

{ #category : #accessing }
GEOCartesianFrame2 >> refFrame: aFrame rFfF: origin zPoint: zPoint xPoint: xPoint [ 
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: origin
				zPoint: zPoint
				xPoint: xPoint.
	self
		refFrame: aFrame
		rFfF: origin
		aAFf: aA
]

{ #category : #'initialize-release' }
GEOCartesianFrame2 >> release [
	"release self."

	refFrame ifNotNil: [refFrame removeDependentFrame: self].
	refFrame := nil.
	body notNil 
		ifTrue: 
			[body releaseRefFrame.
			body := nil].
	super release
]

{ #category : #accessing }
GEOCartesianFrame2 >> removeDependentFrame: frame [ 
	^dependentFrames remove: frame ifAbsent: [nil]
]

{ #category : #calc }
GEOCartesianFrame2 >> removeFramesBetweenSelfAnd: aFrame [ 
	| newrFfF newAFf |
	newrFfF := aFrame rfpffromrOpO: self rOfO.
	newAFf := aFrame aAOf transpose timesFullMatrix: self aAOf.
	self
		refFrame: aFrame
		rFfF: newrFfF
		aAFf: newAFf
]

{ #category : #calc }
GEOCartesianFrame2 >> removeIntermediateFrame: aFrame [ 
	| aboveFrame middleFrame belowFrame newrFfF newAFf |
	aboveFrame := self.
	
	[middleFrame := aboveFrame refFrame.
	middleFrame ~~ aFrame and: [middleFrame isInterface not]]
		whileTrue: [aboveFrame := middleFrame].
	middleFrame == aFrame
		ifTrue: 
			[belowFrame := middleFrame refFrame.
			newrFfF := middleFrame rFpFfromrfpf: aboveFrame rFfF.
			newAFf := middleFrame aAFf timesFullMatrix: aboveFrame aAFf.
			aboveFrame
				refFrame: belowFrame
				rFfF: newrFfF
				aAFf: newAFf]
]

{ #category : #accessing }
GEOCartesianFrame2 >> removeSub: aSub [ 
	^(self cSub remove: aSub ifAbsent: [nil]) ifNotNil: 
			[:aaSub | 
			aaSub aSup: nil.
			aaSub]
]

{ #category : #accessing }
GEOCartesianFrame2 >> removeSup [
	self aSup ifNotNil: [:aaSup | aaSup removeSub: self]
]

{ #category : #accessing }
GEOCartesianFrame2 >> rfpffromrFpF: rFpF [ 
	^aAFf transpose timesFullColumn: rFpF - rFfF
]

{ #category : #accessing }
GEOCartesianFrame2 >> rfpffromrOpO: rOpO [ 
	^self aAOf transpose timesFullColumn: rOpO - self rOfO
]

{ #category : #calc }
GEOCartesianFrame2 >> rotateAt: rFpvF axisF: axisF theta: theta [
	"Right hand rotation about axisF thru rFpvF."
	| eulerParameter aAthe |
	eulerParameter := GEOEulerParameters withAxis: axisF theta: theta.
	aAthe := eulerParameter aA.
	rFfF := rFpvF + (aAthe timesFullColumn: rFfF - rFpvF).
	aAFf := aAthe timesFullMatrix: aAFf.
	self changed.
]

{ #category : #calc }
GEOCartesianFrame2 >> rotateAt: rFpvF axisf: axisf theta: theta [ 
	"Right hand rotation about axisf thru rFpvF."

	| axisF |
	axisF := aAFf timesFullColumn: axisf.
	self
		rotateAt: rFpvF
		axisF: axisF
		theta: theta
]

{ #category : #calc }
GEOCartesianFrame2 >> rotateAxisF: i theta: theta [ 
	| axisF |
	axisF := (FullColumn zero: 3).
	axisF at: i put: 1.0d.
	self
		rotateAt: rFfF
		axisF: axisF
		theta: theta
]

{ #category : #calc }
GEOCartesianFrame2 >> rotateAxisf: i theta: theta [ 
	| axisf |
	axisf := (FullColumn zero: 3).
	axisf at: i put: 1.0d.
	self
		rotateAt: rFfF
		axisf: axisf
		theta: theta
]

{ #category : #accessing }
GEOCartesianFrame2 >> setRefFrame: aFrame [ 
	"Receiver must be dependent on only one refFrame."

	refFrame notNil ifTrue: [refFrame removeDependentFrame: self].
	refFrame := aFrame.
	refFrame notNil ifTrue: [refFrame addDependentFrame: self]
]

{ #category : #printing }
GEOCartesianFrame2 >> store2DOn: aStream level: level [ 
	aStream tabToLevel: level; nextPutAll: 'Position2D'; cr.
	aStream tabToLevel: level; tab; nextPutAll: (rFfF at: 1) printForExport; tab; nextPutAll: (rFfF at: 2) printForExport; cr.
	aStream tabToLevel: level; nextPutAll: 'Angle'; cr.
	aStream tabToLevel: level; tab; nextPutAll: (aAFf bryantAngles at: 3) printForExport; cr
]

{ #category : #accessing }
GEOCartesianFrame2 >> storeMemento: aMemento for: anObject [ 
	refFrame notNil ifTrue: [refFrame storeMemento: aMemento for: anObject]
]

{ #category : #printing }
GEOCartesianFrame2 >> storeOn: aStream level: level [ 
	aStream
		storeLevel: level
		title: 'Position3D'
		object: rFfF.
	aStream
		storeLevel: level
		title: 'RotationMatrix'
		object: aAFf
]

{ #category : #printing }
GEOCartesianFrame2 >> storePOVOn: aStream level1: level [
	| array |
	array := GEOEulerAngleszyx fromA: aAFf.
	array := array
				collect: [:angle | angle radiansToDegrees asFloat printString.].
	aStream storePOVLevel: level
		title: ('rotate %<<3s>,<2s>,<1s>>' expandMacrosWithArguments: array).
	array := rFfF collect: [:disp | disp asFloat printString.].
	aStream storePOVLevel: level
		title: ('translate %<<1s>,<2s>,<3s>>' expandMacrosWithArguments: array).
]

{ #category : #printing }
GEOCartesianFrame2 >> storeVelocityOn: aStream level: level [ 
	aStream
		storeLevel: level
		title: 'Velocity3D'
		object: (self vOfO notNil
				ifTrue: [self vOfO]
				ifFalse: [(FullColumn zero: 3)]).
	aStream
		storeLevel: level
		title: 'Omega3D'
		object: (self omeOfO notNil
				ifTrue: [self omeOfO]
				ifFalse: [(FullColumn zero: 3)])
]

{ #category : #accessing }
GEOCartesianFrame2 >> translateBy: shiftXYZ [ 
	self rFfF: rFfF + shiftXYZ
]

{ #category : #accessing }
GEOCartesianFrame2 >> translateSelfBy: delta [ 
	self rFfF: self rFfF + delta
]

{ #category : #'initialize-release' }
GEOCartesianFrame2 >> uncut [
	refFrame addDependentFrame: self
]

{ #category : #accessing }
GEOCartesianFrame2 >> unitx [
	^FullColumn
		with: 1.0d
		with: 0.0d
		with: 0.0d
]

{ #category : #accessing }
GEOCartesianFrame2 >> unity [
	^FullColumn
		with: 0.0d
		with: 1.0d
		with: 0.0d
]

{ #category : #accessing }
GEOCartesianFrame2 >> unitz [
	^FullColumn
		with: 0.0d
		with: 0.0d
		with: 1.0d
]

{ #category : #accessing }
GEOCartesianFrame2 >> vOfO [
	| answer |
	answer := self triggerEvent: #getvOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self vOfO: answer].
	^answer
]

{ #category : #accessing }
GEOCartesianFrame2 >> vOfO: vOfO [ 
	self removeActionsForEvent: #getvOfO.
	vOfO notNil ifTrue: [self
			when: #getvOfO
			ask: vOfO
			perform: #yourself]
]

{ #category : #calc }
GEOCartesianFrame2 >> xyPlaneIntersectLine: geoLine [ 
	"
	Find the intesection of the line on the xy plane. 
	General formula: 
	Plane is (x - P) dot v = 0. 
	Line is Q(t) = Q + tw. 
	Substitute x = Q(t) gives (Q + tw - P) dot v = 0. 
	Therefore 
	t = (P - Q) dot v / (w dot v). 
	Intersection point is at 
	Q + ((P - Q) dot v / (w dot v)) w. 
	
	For xy plane P = (0,0,0), v = (0,0,1). 
	"

	| rfstartf rfendf lineVector denominator |
	rfstartf := self rfpffromrOpO: geoLine rOstartO.
	rfendf := self rfpffromrOpO: geoLine rOendO.
	lineVector := rfendf - rfstartf.
	denominator := lineVector at: 3.
	denominator abs > 0.1d
		ifTrue: [^rfstartf minus: lineVector times: (rfstartf at: 3)
					/ denominator]
		ifFalse: 
			[Dialog warn: 'It is not possible to locate a point \in a plane viewing it on edge.' withCRs.
			NearParallelIntersectionError raiseSignal]
]

{ #category : #accessing }
GEOCartesianFrame2 >> xyplaneCoeffs [
]
