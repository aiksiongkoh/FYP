Extension { #name : #MD5 }

{ #category : #'*StCAD-Misc-StCAD-DEV' }
MD5 class >> example1 [
	"self example1"

	MD5 hash: 'aaa'.
	MD5 hashFrom: 'vxxa.im' asFilename readStream
]
