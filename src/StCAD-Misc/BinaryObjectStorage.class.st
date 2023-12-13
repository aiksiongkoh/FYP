Class {
	#name : #BinaryObjectStorage,
	#superclass : #BinaryObjectStorage,
	#category : #'StCAD-Misc-Binary Storage'
}

{ #category : #'*StCAD-Misc-StCAD-Dev' }
BinaryObjectStorage class >> example2 [
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

{ #category : #'VisualWorks metadata' }
BinaryObjectStorage class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #'initialize-release' }
BinaryObjectStorage >> initialize [
	super initialize.
	readerClass := BOSSReader
]
