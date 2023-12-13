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
	#name : #CartesianFrame,
	#superclass : #AbstractCartesianFrame,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'triggering events' }
CartesianFrame class >> constructEventsTriggered [
	^(super constructEventsTriggered)
		add: #getvOfO;
		add: #getomeOfO;
		add: #getaOfO;
		add: #getalpOfO;
		yourself
]

{ #category : #utilities }
CartesianFrame class >> r_theta_z_xyz: xyz [ 
	| x y z |
	x := xyz at: 1.
	y := xyz at: 2.
	z := xyz at: 3.
	^MathArray 
		with: (x * x + (y * y)) sqrt
		with: (Double arcTan0to2piY: y overX: x)
		with: z
]

{ #category : #'instance creation' }
CartesianFrame class >> refFrame: frame rFfF: r aAFf: aA [ 
	^self new
		refFrame: frame
		rFfF: r
		aAFf: aA
]

{ #category : #'instance creation' }
CartesianFrame class >> refFrame: aFrame rFfF: origin xPoint: xPoint zPoint: zPoint [ 
	^self new
		refFrame: aFrame
		rFfF: origin
		xPoint: xPoint
		zPoint: zPoint
]

{ #category : #'VisualWorks metadata' }
CartesianFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
	)

]

{ #category : #comparing }
CartesianFrame >> = aObject [

	^self == aObject or: [aObject equalToCartesianFrame: self]
]

{ #category : #accessing }
CartesianFrame >> aAFf: aA [ 
	aAFf := aA.
	self changed
]

{ #category : #accessing }
CartesianFrame >> aAFfforF: aFrame [
	^self == aFrame
		ifTrue: [FullMatrix identity: 3.]
		ifFalse: 
			[| newSup aaAFf |
			newSup := aSup.
			aaAFf := aAFf.
			[newSup == aFrame.] whileFalse: 
					[aaAFf := aaAFf timesFullMatrix: newSup aAFf.
					newSup := newSup aSup.].
			aaAFf.].
]

{ #category : #accessing }
CartesianFrame >> aAOF [
	^aSup aAOf
]

{ #category : #accessing }
CartesianFrame >> aAfO [
	^self aAOf transpose
]

{ #category : #accessing }
CartesianFrame >> aMFf [
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
CartesianFrame >> aMFfT [
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
CartesianFrame >> aOfO [
	| answer |
	answer := self triggerEvent: #getaOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self aOfO: answer].
	^answer
]

{ #category : #accessing }
CartesianFrame >> aOfO: aOfO [ 
	self removeActionsForEvent: #getaOfO.
	aOfO notNil ifTrue: [self
			when: #getaOfO
			ask: aOfO
			perform: #yourself]
]

{ #category : #accessing }
CartesianFrame >> addDependentFrame: aFrame [ 
	cSub add: aFrame
]

{ #category : #accessing }
CartesianFrame >> addMarkersIn: set [ 
	"Do nothing."
]

{ #category : #accessing }
CartesianFrame >> alpOfO [
	| answer |
	answer := self triggerEvent: #getalpOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self alpOfO: answer].
	^answer
]

{ #category : #accessing }
CartesianFrame >> alpOfO: alpOfO [ 
	self removeActionsForEvent: #getalpOfO.
	alpOfO notNil ifTrue: [self
			when: #getalpOfO
			ask: alpOfO
			perform: #yourself]
]

{ #category : #calc }
CartesianFrame >> axis: i dotFrame: frame axis: j [ 
	^(self aAOf column: i)
		dot: (frame aAOf column: j)
]

{ #category : #calc }
CartesianFrame >> calc [
	self privateCalc.
	cSub do: [:aSub | aSub calc]
]

{ #category : #calc }
CartesianFrame >> calcAll [
	self calc.
	cSub do: [:aSub | aSub calcAll]
]

{ #category : #change }
CartesianFrame >> changed [
	rOfO := nil.
	aAOf := nil.
	cSub do: [:aSub | aSub changed]
]

{ #category : #change }
CartesianFrame >> conditionA [
	aAFf := FullMatrix 
				rotationMatrixFromOrigin: (FullColumn  zero: 3)
				zPoint: (aAFf column: 3)
				xPoint: (aAFf column: 1).
	cSub do: [:dependentFrame | dependentFrame conditionA]
]

{ #category : #copy }
CartesianFrame >> copyrFfFandAFfFrom: frame [ 
	rFfF := frame rFfF copy.
	aAFf := frame aAFf copy.
	self changed
]

{ #category : #accessing }
CartesianFrame >> crFpFfromcrfpf: crfpf forF: aFrame [ 
	| arFfF aaAFf |
	^self == aFrame 
		ifTrue: [crfpf copy]
		ifFalse: 
			[arFfF := aSup rFpFfromrfpf: rFfF forF: aFrame.
			aaAFf := self aAFfforF: aFrame.
			crfpf collect: [:arfpf | arFfF + (aaAFf timesFullColumn: arfpf)]]
]

{ #category : #accessing }
CartesianFrame >> crfpffromcrOpO: crOpO [ 
	| aAfO arOfO |
	aAfO := self aAfO.
	arOfO := self rOfO.
	^crOpO collect: [:arOpO | aAfO timesFullColumn: arOpO - arOfO]
]

{ #category : #'initialize-release' }
CartesianFrame >> cut [
	aSup removeSub: self.
	super cut
]

{ #category : #calc }
CartesianFrame >> dataAxesIntersectLine: geoLine axisLength: length tolerance: tol [ 
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
CartesianFrame >> dataXYPlaneIntersectLine: geoLine [ 
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
CartesianFrame >> distXYPlaneIntersectLine: geoLine [ 
	| data |
	data := self dataXYPlaneIntersectLine: geoLine.
	^data at: 3
]

{ #category : #comparing }
CartesianFrame >> equalToCartesianFrame: aCartesianFrame [

	^rFfF = aCartesianFrame rFfF and: [aAFf = aCartesianFrame aAFf]
]

{ #category : #accessing }
CartesianFrame >> fixedAtRef [
	rFfF := (FullColumn zero: 3).
	aAFf := (FullMatrix identity: 3).
	self changed
]

{ #category : #copy }
CartesianFrame >> frozenCopy [
	"Used in handle tracking."

	| answer |
	answer := self shallowCopy.
	answer copyrFfFandAFfFrom: self.
	^answer
]

{ #category : #accessing }
CartesianFrame >> interface [
	^aSup interface
]

{ #category : #testing }
CartesianFrame >> isAssembly [
	^false
]

{ #category : #accessing }
CartesianFrame >> isFace [
	^false
]

{ #category : #testing }
CartesianFrame >> isInterface [
	^false
]

{ #category : #testing }
CartesianFrame >> isPart [
	^false
]

{ #category : #printing }
CartesianFrame >> logString: string [ 
	aSup logString: string
]

{ #category : #accessing }
CartesianFrame >> menu [
	^nil
]

{ #category : #accessing }
CartesianFrame >> omeOfO [
	| answer |
	answer := self triggerEvent: #getomeOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self omeOfO: answer].
	^answer
]

{ #category : #accessing }
CartesianFrame >> omeOfO: omeOfO [ 
	self removeActionsForEvent: #getomeOfO.
	omeOfO notNil ifTrue: [self
			when: #getomeOfO
			ask: omeOfO
			perform: #yourself]
]

{ #category : #accessing }
CartesianFrame >> positionMemento [

	| aMemento |
	aMemento := Polymorphic_GFMemento originator: self. "VW_TRANSLATION:Polymorphic.GFMemento:Polymorphic_GFMemento"
	aMemento
		addActionSelector: #rFfF:aAFf:
		arguments: (Array with: rFfF copy with: aAFf copy).
	^ aMemento
]

{ #category : #copy }
CartesianFrame >> postCopy [
	super postCopy.
	rFfF := rFfF copy.
	aAFf := aAFf copy.
	rOfO := nil.
	aAOf := nil
]

{ #category : #copy }
CartesianFrame >> preSave [
	"Do nothing."
]

{ #category : #printing }
CartesianFrame >> printOn: aStream [ 
	| title |
	title := self class name.
	aStream 
		nextPutAll: ((title at: 1) isVowel ifTrue: ['an '] ifFalse: ['a ']).
	aStream print: self class.
	aStream nextPutAll: ' on '.
	aStream print: body.
	aStream
		cr;
		print: rFfF.
	aStream
		cr;
		print: aAFf
]

{ #category : #printing }
CartesianFrame >> printVerboseOn: aStream [ 
	aStream
		nextPutAll: 'rFfF = ';
		print: rFfF;
		cr;
		nextPutAll: 'aAFf = ';
		print: (aAFf at: 1);
		cr;
		print: (aAFf at: 2);
		cr;
		print: (aAFf at: 3)
]

{ #category : #calc }
CartesianFrame >> privateCalc [
	"Calculate all dependent instance variables."

	| rOFO aAOF |
	aSup isNil 
		ifTrue: 
			[rOfO := rFfF.
			aAOf := aAFf]
		ifFalse: 
			[rOFO := aSup rOfO.
			aAOF := aSup aAOf.
			rOfO := rOFO + (aAOF timesFullColumn: rFfF).
			aAOf := aAOF timesFullMatrix: aAFf]
]

{ #category : #change }
CartesianFrame >> quietlyChanged [
	self changed
]

{ #category : #accessing }
CartesianFrame >> quietlyrFfF: rFpF aAFf: aAFp [ 
	"Must be used from the root on down."
	"Then the root must perform changed."

	rFfF := rFpF.
	aAFf := aAFp.
	rOfO := nil.
	aAOf := nil
]

{ #category : #accessing }
CartesianFrame >> quietlyrOfO: rOpO aAOf: aAOp [ 
	"Must be used from the root on down."
	"Then the root must perform changed."

	rFfF := aSup rfpffromrOpO: rOpO.
	aAFf := aSup aAOf transpose timesFullMatrix: aAOp.
	rOfO := rOpO.
	aAOf := aAOp
]

{ #category : #accessing }
CartesianFrame >> quietlyvOfO: vOpO omeOfO: omeOfO [ 
	self vOfO: vOpO.
	self omeOfO: omeOfO
]

{ #category : #accessing }
CartesianFrame >> rDbodycenterPx [
	^self interface projectionFrame rDpPxfromrOpO: body rOcenterO
]

{ #category : #accessing }
CartesianFrame >> rDoriginPx [
	^self interface projectionFrame rDpPxfromrOpO: self rOfO
]

{ #category : #accessing }
CartesianFrame >> rDpPxfromrfpf: rfpf [ 
	^self interface projectionFrame rDpPxfromrOpO: (self rOpOfromrfpf: rfpf)
]

{ #category : #accessing }
CartesianFrame >> rFfF: r aAFf: aA [ 
	rFfF := r.
	aAFf := aA.
	self changed
]

{ #category : #accessing }
CartesianFrame >> rFfF: origin xPoint: xPoint yPoint: yPoint [ 
	| aA |
	aA := FullMatrix 
				rotationMatrixFromOrigin: origin
				xPoint: xPoint
				yPoint: yPoint.
	self rFfF: origin aAFf: aA
]

{ #category : #accessing }
CartesianFrame >> rFfF: origin xPoint: xPoint zPoint: zPoint [ 
	| aA |
	aA := FullMatrix 
				rotationMatrixFromOrigin: origin
				xPoint: xPoint
				zPoint: zPoint.
	self rFfF: origin aAFf: aA
]

{ #category : #accessing }
CartesianFrame >> rFfF: origin zPoint: zPoint xPoint: xPoint [ 
	| aA |
	aA := FullMatrix 
				rotationMatrixFromOrigin: origin
				zPoint: zPoint
				xPoint: xPoint.
	self rFfF: origin aAFf: aA
]

{ #category : #accessing }
CartesianFrame >> rFpFfromrOpO: rOpO [ 
	^self refFrame rfpffromrOpO: rOpO
]

{ #category : #accessing }
CartesianFrame >> rFpFfromrfpf2D: rfpf [ 
	"rFfF + (aAFf timesFullColumn: rfpf)"

	| u v |
	u := (rFfF at: 1) + ((aAFf at: 1 and: 1) * (rfpf at: 1) 
						+ ((aAFf at: 1 and: 2) * (rfpf at: 2))).
	v := (rFfF at: 2) + ((aAFf at: 2 and: 1) * (rfpf at: 1) 
						+ ((aAFf at: 2 and: 2) * (rfpf at: 2))).
	^u yd: v
]

{ #category : #accessing }
CartesianFrame >> rFpFfromrfpf: rfpf [ 
	^rFfF plusFullColumn: (aAFf timesFullColumn: rfpf)
]

{ #category : #accessing }
CartesianFrame >> rFpFfromrfpf: rfpf forF: aFrame [ 
	| rFpF |
	^self == aFrame 
		ifTrue: [rfpf]
		ifFalse: 
			[rFpF := self rFpFfromrfpf: rfpf.
			aSup rFpFfromrfpf: rFpF forF: aFrame]
]

{ #category : #accessing }
CartesianFrame >> rOpOfromrfpf: rfpf [ 
	^self rOfO + (self aAOf timesFullColumn: rfpf)
]

{ #category : #accessing }
CartesianFrame >> refFrame [
	^aSup
]

{ #category : #accessing }
CartesianFrame >> refFrame: aFrame [ 
	self setRefFrame: aFrame.
	self changed
]

{ #category : #accessing }
CartesianFrame >> refFrame: aFrame rFfF: r aAFf: aA [ 
	self setRefFrame: aFrame.
	rFfF := r.
	aAFf := aA.
	self changed
]

{ #category : #accessing }
CartesianFrame >> refFrame: aFrame rFfF: origin xPoint: xPoint yPoint: yPoint [ 
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
CartesianFrame >> refFrame: aFrame rFfF: origin xPoint: xPoint zPoint: zPoint [ 
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
CartesianFrame >> refFrame: aFrame rFfF: origin zPoint: zPoint xPoint: xPoint [ 
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
CartesianFrame >> release [
	"release self."

	aSup removeSub: self.
	aSup := nil.
	body notNil
		ifTrue: 
			[body releaseRefFrame.
			body := nil].
	super release
]

{ #category : #accessing }
CartesianFrame >> removeDependentFrame: frame [ 
	^cSub remove: frame ifAbsent: [nil]
]

{ #category : #calc }
CartesianFrame >> removeFramesBetweenSelfAnd: aFrame [ 
	| newrFfF newAFf |
	newrFfF := aFrame rfpffromrOpO: self rOfO.
	newAFf := aFrame aAOf transpose timesFullMatrix: self aAOf.
	self
		refFrame: aFrame
		rFfF: newrFfF
		aAFf: newAFf
]

{ #category : #calc }
CartesianFrame >> removeIntermediateFrame: aFrame [ 
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
CartesianFrame >> rfpffromrFpF: rFpF [ 
	^aAFf transpose timesFullColumn: rFpF - rFfF
]

{ #category : #calc }
CartesianFrame >> rotateAt_axisF: axisF theta: theta [ 
	"Right hand rotation about axisF thru o."

	self 
		rotateAt_rFpvF: rFfF
		axisF: axisF
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateAt_axisf: axisf theta: theta [ 
	"Right hand rotation about axisf thru o."

	self 
		rotateAt_rFpvF: rFfF
		axisf: axisf
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateAt_rFpvF: rFpvF axisF: axisF theta: theta [ 
	"Right hand rotation about axisF thru rFpvF."

	| eulerParameter aAthe |
	eulerParameter := EulerParameters withAxis: axisF theta: theta.
	aAthe := eulerParameter aA.
	rFfF := rFpvF + (aAthe timesFullColumn: rFfF - rFpvF).
	aAFf := aAthe timesFullMatrix: aAFf.
	self changed
]

{ #category : #calc }
CartesianFrame >> rotateAt_rFpvF: rFpvF axisf: axisf theta: theta [ 
	"Right hand rotation about axisf thru rFpvF."

	self 
		rotateAt_rFpvF: rFpvF
		axisF: (aAFf timesFullColumn: axisf)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateAt_rfpvf: rfpvf axisF: axisF theta: theta [ 
	"Right hand rotation about axisF thru rfpvf."

	self 
		rotateAt_rFpvF: (self rFpFfromrfpf: rfpvf)
		axisF: axisF
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateAt_rfpvf: rfpvf axisf: axisf theta: theta [ 
	"Right hand rotation about axisf thru rfpvf."

	self 
		rotateAt_rFpvF: (self rFpFfromrfpf: rfpvf)
		axisF: (aAFf timesFullColumn: axisf)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateX: theta [ 
	self rotateAt_axisF: (FullColumn 
				with: 1.0d
				with: 0.0d
				with: 0.0d)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateY: theta [ 
	self rotateAt_axisF: (FullColumn 
				with: 0.0d
				with: 1.0d
				with: 0.0d)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotateZ: theta [ 
	self rotateAt_axisF: (FullColumn 
				with: 0.0d
				with: 0.0d
				with: 1.0d)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotatex: theta [ 
	self rotateAt_axisf: (FullColumn 
				with: 1.0d
				with: 0.0d
				with: 0.0d)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotatey: theta [ 
	self rotateAt_axisf: (FullColumn 
				with: 0.0d
				with: 1.0d
				with: 0.0d)
		theta: theta
]

{ #category : #calc }
CartesianFrame >> rotatez: theta [ 
	self rotateAt_axisf: (FullColumn 
				with: 0.0d
				with: 0.0d
				with: 1.0d)
		theta: theta
]

{ #category : #accessing }
CartesianFrame >> setRefFrame: aFrame [ 
	"Receiver must be dependent on only one refFrame."

	aSup notNil ifTrue: [aSup removeDependentFrame: self].
	aSup := aFrame.
	aSup notNil ifTrue: [aSup addDependentFrame: self]
]

{ #category : #printing }
CartesianFrame >> store2DOn: aStream level: level [ 
	aStream tabToLevel: level; nextPutAll: 'Position2D'; cr.
	aStream tabToLevel: level; tab; nextPutAll: (rFfF at: 1) printForExport; tab; nextPutAll: (rFfF at: 2) printForExport; cr.
	aStream tabToLevel: level; nextPutAll: 'Angle'; cr.
	aStream tabToLevel: level; tab; nextPutAll: (aAFf bryantAngles at: 3) printForExport; cr
]

{ #category : #accessing }
CartesianFrame >> storeMemento: aMemento for: anObject [ 
	aSup notNil ifTrue: [aSup storeMemento: aMemento for: anObject]
]

{ #category : #printing }
CartesianFrame >> storeOn: aStream level: level [ 
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
CartesianFrame >> storePOVOn: aStream level1: level [
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
CartesianFrame >> storeVelocityOn: aStream level: level [ 
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
CartesianFrame >> translateSelfBy: delta [ 
	self rFfF: self rFfF + delta
]

{ #category : #accessing }
CartesianFrame >> trigAFf: aA [ 
	aAFf := aA.
	self changed
]

{ #category : #accessing }
CartesianFrame >> trigrFfF: col [ 
	rFfF := col.
	self changed
]

{ #category : #accessing }
CartesianFrame >> trigrefFrame: aFrame [ 
	self setRefFrame: aFrame.
	self changed
]

{ #category : #'initialize-release' }
CartesianFrame >> uncut [
	aSup addSub: self
]

{ #category : #accessing }
CartesianFrame >> unitx [
	^FullColumn
		with: 1.0d
		with: 0.0d
		with: 0.0d
]

{ #category : #accessing }
CartesianFrame >> unity [
	^FullColumn
		with: 0.0d
		with: 1.0d
		with: 0.0d
]

{ #category : #accessing }
CartesianFrame >> unitz [
	^FullColumn
		with: 0.0d
		with: 0.0d
		with: 1.0d
]

{ #category : #accessing }
CartesianFrame >> vOfO [
	| answer |
	answer := self triggerEvent: #getvOfO.
	answer == nil
		ifTrue: 
			[answer := FullColumn zero: 3.
			self vOfO: answer].
	^answer
]

{ #category : #accessing }
CartesianFrame >> vOfO: vOfO [ 
	self removeActionsForEvent: #getvOfO.
	vOfO notNil ifTrue: [self
			when: #getvOfO
			ask: vOfO
			perform: #yourself]
]

{ #category : #calc }
CartesianFrame >> xyPlaneIntersectLine: geoLine [
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
		ifTrue: [^rfstartf minus: lineVector times: (rfstartf at: 3) / denominator.]
		ifFalse: 
			[Dialog
				warn: 'It is not possible to locate a point \in a plane viewing it on edge.'
						withCRs.
			NearParallelIntersectionError raiseSignal.].
]

{ #category : #accessing }
CartesianFrame >> xyplaneCoeffs [
]
