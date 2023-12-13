Extension { #name : #BinaryObjectStorage }

{ #category : #'*StCAD-Misc-StCAD-Dev' }
BinaryObjectStorage classSide >> example2 [
	"self example2."

	| filepath bos |
	filepath := 'date.bos'.
	bos := BinaryObjectStorage onNew: filepath asFilename writeStream.
	
	[bos nextPut: Date today.
	bos nextPut: 'Aik-Siong Koh'] 
			ensure: [bos close].
	bos := BinaryObjectStorage onOldNoScan: filepath asFilename readStream.
	^[bos contents] valueNowOrOnUnwindDo: [bos close]
]
