Extension { #name : #JunColorChoiceModel }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunColorChoiceModel classSide >> clearBarsAndPlates [
	bars := nil.
	plates := nil
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
JunColorChoiceModel classSide >> installColorBarsAndPlates [
	| filepath readStream bos |
	(bars isNil or: [bars first palette ~= Screen default colorPalette]) 
		ifTrue: 
			[
			[filepath := (Filename fromComponents: #('resource')) construct: 'bars.bos'.
			readStream := filepath asFilename readStream.
			
			[bos := BinaryObjectStorage onOldNoScan: readStream.
			bars := bos contents at: 1.
			bars first palette ~= Screen default colorPalette 
				ifTrue: [self error: 'Palettes do not match.']] 
					ensure: [readStream close]] 
					on: Error
					do: 
						[:ex | 
						self initializeBars.
						bos := BinaryObjectStorage onNew: filepath asFilename writeStream.
						[bos nextPut: bars] ensure: [bos close].
						ex return]].
	(plates isNil or: [plates first palette ~= Screen default colorPalette]) 
		ifTrue: 
			[
			[filepath := (Filename fromComponents: #('resource')) 
						construct: 'plates.bos'.
			readStream := filepath asFilename readStream.
			
			[bos := BinaryObjectStorage onOldNoScan: readStream.
			plates := bos contents at: 1.
			plates first palette ~= Screen default colorPalette 
				ifTrue: [self error: 'Palettes do not match.']] 
					ensure: [readStream close]] 
					on: Error
					do: 
						[:ex | 
						self initializePlates.
						bos := BinaryObjectStorage onNew: filepath asFilename writeStream.
						[bos nextPut: plates] ensure: [bos close].
						ex return]]
]
