Class {
	#name : #'StCAD_XYChartView',
	#superclass : #'BG_XYChartView',
	#instVars : [
		'controller',
		'isEqualScale'
	],
	#category : #'StCAD-UI-StCAD'
}

{ #category : #'VisualWorks metadata' }
StCAD_XYChartView class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #private }
StCAD_XYChartView >> composeGrid [
	| gridx xscale gridy yscale matrix |
	gridx := grid x.
	xscale := gridx scale.
	gridy := grid y.
	yscale := gridy scale.
	gridx isAutoScaled & gridx isAutoLabeled
		ifTrue: 
			[matrix := self dataRangeMatrixX.
			xscale autoMin: (self min: matrix)
				max: (self max: matrix)].
	gridy isAutoScaled & gridy isAutoLabeled
		ifTrue: 
			[matrix := self dataRangeMatrix.
			yscale autoMin: (self min: matrix)
				max: (self max: matrix)].
	isEqualScale ifTrue: [xscale beEqualScaleTo: yscale].
	grid bounds: self plotArea
]

{ #category : #accessing }
StCAD_XYChartView >> controller [
	"Answer the receiver`s current controller. If the receiver's controller 
	is nil (the default case), an initialized instance of the receiver's 
	default controller is installed and returned."

	^self getController
]

{ #category : #accessing }
StCAD_XYChartView >> controller: aController [ 
	"Set the receiver's controller to aController.  An instance of NoController can be
	specified to indicate that the receiver will not have a controller.  The model of
	aController is set to the receiver's model."

	self setController: aController
]

{ #category : #accessing }
StCAD_XYChartView >> defaultController [
	"Answer an initialized instance of the receiver's default controller.
	Subclasses should redefine this message only if the default controller 
	instances need to be initialized in a nonstandard way."

	^self defaultControllerClass new
]

{ #category : #accessing }
StCAD_XYChartView >> defaultControllerClass [
	^StCAD_XYChartController
]

{ #category : #displaying }
StCAD_XYChartView >> displayOn: aGraphicsContext [ 
	| gc fgColor |
	self compose.
	gc := aGraphicsContext copy.
	(fgColor := self lookPreferences foregroundColor) isNil ifFalse: ["fgColor might not be defined"
		gc paint: fgColor].
	gc intersectClip: self bounds.
	self displayGridLinesOn: gc.
	self displayAxisOn: gc.
	self data isNil
		ifFalse: 
			[self isDataVisible ifTrue: [self displayDataOn: gc].
			self isLegendVisible ifTrue: [self displayLegendOn: gc]].
	self displayOptionsOn: gc.
	(self data isNil or: [self data isEmpty])
		ifFalse: 
			[gc intersectClip: grid insetBounds.
			self displayPlotOn: gc]
]

{ #category : #private }
StCAD_XYChartView >> getController [
	"Answer the receiver`s current controller. If the receiver's controller 
	is nil (the default case), an initialized instance of the receiver's 
	default controller is installed and returned."

	controller == nil ifTrue: [self setController: self defaultController].
	^controller
]

{ #category : #'initialize-release' }
StCAD_XYChartView >> initialize [
	super initialize.
	isEqualScale := false
]

{ #category : #accessing }
StCAD_XYChartView >> isEqualScale [
	^isEqualScale
]

{ #category : #accessing }
StCAD_XYChartView >> isEqualScale: boolean [ 
	isEqualScale := boolean
]

{ #category : #private }
StCAD_XYChartView >> setController: aController [ 
	"Set the receiver's controller to aController. If aController is not nil, its view is set to the receiver 
	and its model is set to aModel."

	aController == nil
		ifFalse: 
			[aController view: self.
			aController model: model].
	controller := aController
]

{ #category : #private }
StCAD_XYChartView >> setModel: aModel [ 
	"Set the receiver's model to be aModel. Also set the receiver's 
	controllers model."

	super setModel: aModel.
	controller == nil ifFalse: [controller model: aModel]
]
