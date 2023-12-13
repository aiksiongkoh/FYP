Extension { #name : #JunMesaInterface }

{ #category : #'*StCAD-UI-StCAD-UI' }
JunMesaInterface classSide >> libraryFilesSearchSignals [
	"Answer a SignalCollection used to handle exceptions raised when scanning for library
	 files. The signals answered by this method will result in those signals being ignored by
	 the library search machinery. Clients should not answer signals they wish to receive."

	^ExternalLibraryHolder libraryNotFoundSignal
]
