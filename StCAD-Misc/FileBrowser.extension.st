Extension { #name : #FileBrowser }

{ #category : #'*StCAD-Misc-StCAD-DEV' }
FileBrowser classSide >> renameFilesInDir [
	"FileBrowser renameFilesInDir"

	| dirName cFile tail newFilename aFilename |
	dirName := 'C:\Documents and Settings\LapTop4\Local Settings\Application Data\Mozilla\Profiles\default\Cache\dummy' 
				asFilename.
	cFile := dirName filesMatching: '*'.
	cFile do: 
			[:aFile | 
			aFilename := aFile asFilename.
			aFilename extension ifNil: 
					[tail := aFile asFilename tail , '.jpg'.
					newFilename := dirName construct: tail.
					aFilename renameTo: newFilename]]
]
