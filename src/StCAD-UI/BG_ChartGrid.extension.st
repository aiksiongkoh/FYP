Extension { #name : #'BG_ChartGrid' }

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartGrid >> beEqualScale [
	x scale beEqualScaleTo: y scale
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartGrid >> composeWithXs: xs andYs: ys [ 
	x isAutoScaled & x isAutoLabeled ifTrue: [x scale autoWith: xs].
	y isAutoScaled & y isAutoLabeled ifTrue: [y scale autoWith: ys]
]

{ #category : #'*StCAD-UI-StCAD-UI' }
BG_ChartGrid >> displayVLabelsOn: aGraphicsContext [ 
	"Modified by askoh.com to make the numbers appear above the 
	grid lines."

	| gc v hs vs marks px images sizeOfLabels |
	vs := (v := self v) scale.
	hs := self h scale.	"Display axis labels"
	marks := vs applyToValues: v labelsMarks.
	px := ((hs includesZero and: [v isAutoLabeled])
				ifTrue: [hs applyTo: hs zero]
				ifFalse: [hs incrementalScaled
						ifTrue: [hs destMin]
						ifFalse: [hs destMax]]) rounded.
	gc := aGraphicsContext copy.
	images := v labelsStyle individualImages.
	sizeOfLabels := marks size min: images size.
	1 to: sizeOfLabels
		do: 
			[:i | 
			| image |
			image := images at: i.
			image displayOn: gc at: (hs incrementalScaled
					ifTrue: [px - 5 - image width]
					ifFalse: [px + 5])
					@ ((marks at: i) rounded - image height + 5)].
	(v unit notNil and: [sizeOfLabels > 0])
		ifTrue: ["Display axis unit"
			v unitStyle displayOn: aGraphicsContext at: (hs incrementalScaled
					ifTrue: [px - 5 - v unitStyle extent x]
					ifFalse: [px + 5])
					@ ((marks at: sizeOfLabels) rounded + (vs incrementalScaled
								ifTrue: [(images at: sizeOfLabels) bounds extent y // 2 + 5]
								ifFalse: [0 - ((images at: sizeOfLabels) bounds extent y // 2 + 5 + v unitStyle extent y)]))].
	v title notNil
		ifTrue: 
			["Display axis title"
			| lw |
			v titleStyle rotation ~= 3 ifTrue: [v titleStyle rotation: 3].
			v titleStyle scale ~= (1 @ 1) ifTrue: [v titleStyle scale: 1 @ 1].
			lw := v labelsStyle individualExtent x.
			v titleStyle displayOn: aGraphicsContext at: (hs incrementalScaled
					ifTrue: [px - (lw + 5 + v titleStyle extent x)]
					ifFalse: [px + (lw + 5)])
					@ (self insetBounds center y - (v titleStyle extent y // 2))]
]
