Class {
	#name : #AdData,
	#superclass : #Item,
	#instVars : [
		'company'
	],
	#classVars : [
		'Doc',
		'Doc',
		'Doc'
	],
	#category : #'StCAD-Doc-StDoc'
}

{ #category : #accessing }
AdData class >> adTitle [
	"Return an advertisement randomly."

	| index |
	index := Time millisecondClockValue \\ Titles size + 1.
	^Titles at: index
]

{ #category : #accessing }
AdData class >> adTitleFor: companyString [ 
	"Return an advertisement randomly for the particular company."

	| index coTitles |
	coTitles := Titles select: [:title | title company = companyString].
	coTitles isEmpty ifTrue: [self error: ('Sponsor name <1s> is not found.' expandMacrosWith: companyString printString)].
	index := Time millisecondClockValue \\ coTitles size + 1.
	^coTitles at: index
]

{ #category : #accessing }
AdData class >> adxxxBy32 [
	"Return an advertisement randomly."

	| index |
	index := Time millisecondClockValue \\ AdxxxBy32s size + 1.
	^AdxxxBy32s at: index
]

{ #category : #accessing }
AdData class >> adxxxBy32For: companyString [ 
	"Return an advertisement randomly for the particular company."

	| index coAdxxxBy32s |
	coAdxxxBy32s := AdxxxBy32s select: [:adxxxBy32 | adxxxBy32 company = companyString].
	coAdxxxBy32s isEmpty ifTrue: [self error: ('Sponsor name <1s> is not found.' expandMacrosWith: companyString printString)].
	index := Time millisecondClockValue \\ coAdxxxBy32s size + 1.
	^coAdxxxBy32s at: index
]

{ #category : #accessing }
AdData class >> adxxxBy60 [
	"Return an advertisement randomly."

	| index |
	index := Time millisecondClockValue \\ AdxxxBy60s size + 1.
	^AdxxxBy60s at: index
]

{ #category : #accessing }
AdData class >> adxxxBy60For: companyString [ 
	"Return an advertisement randomly for the particular company."

	| index coAdxxxBy60s |
	coAdxxxBy60s := AdxxxBy60s select: [:adxxxBy60 | adxxxBy60 company = companyString].
	coAdxxxBy60s isEmpty ifTrue: [self error: ('Sponsor name <1s> is not found.' expandMacrosWith: companyString printString)].
	index := Time millisecondClockValue \\ coAdxxxBy60s size + 1.
	^coAdxxxBy60s at: index
]

{ #category : #'class initialization' }
AdData class >> initialize [
	"self initialize."
	| sponsorDir |
	AdxxxBy32s := OrderedCollection new.
	AdxxxBy60s := OrderedCollection new.
	Titles := OrderedCollection new.
	sponsorDir := Filename fromComponents: #('.' 'resource' 'sponsor').
	sponsorDir directoryContents do: 
			[:dir |
			| companyDir adDir fileName |
			companyDir := sponsorDir construct: dir.
			adDir := companyDir construct: 'adxxxby32'.
			fileName := adDir construct: 'link.txt'.
			fileName definitelyExists
				ifTrue: 
					[| fileStream stringStream bmp http bmpFile adImage previousImage |
					previousImage := nil.
					fileStream := fileName readStream.
					
					[stringStream := fileStream contents cleanSourceFromSelf readStream.
					[stringStream atEnd.] whileFalse: 
							[stringStream skipSeparators.
							bmp := stringStream upToSeparator.
							stringStream skipSeparators.
							http := stringStream upToSeparator.
							bmp isEmpty not
								ifTrue: 
									[adImage := AdImage new.
									adImage company: dir.
									adImage image: (bmp = 'ditto'
												ifTrue: [previousImage image.]
												ifFalse: 
													[bmpFile := adDir construct: bmp.
													bmpFile definitelyExists
														ifTrue: [CachedImage on: (ImageReader fromFile: bmpFile) image.]
														ifFalse: [self halt: 'Ad bmp is not found. Check link.txt'.].]).
									adImage
										http: (http = 'ditto' ifTrue: [previousImage http.] ifFalse: [http.]).
									AdxxxBy32s add: adImage.
									previousImage := adImage.].].]
							ensure: [fileStream close.].].
			fileName := companyDir construct: 'title.txt'.
			fileName definitelyExists
				ifTrue: 
					[| fileStream stringStream title adTitle previousTitle |
					previousTitle := nil.
					fileStream := fileName readStream.
					
					[stringStream := fileStream contents cleanSourceFromSelf readStream.
					[stringStream atEnd.] whileFalse: 
							[stringStream skipSeparators.
							title := stringStream upTo: Character cr.
							adTitle := AdTitle new.
							adTitle company: dir.
							adTitle
								title: (title = 'ditto' ifTrue: [previousTitle title.] ifFalse: [title.]).
							Titles add: adTitle.
							previousTitle := adTitle.].]
							ensure: [fileStream close.].].].
]

{ #category : #'class initialization' }
AdData class >> initialize1 [
	"self initialize1."
	| sponsorDir |
	AdxxxBy32s := OrderedCollection new.
	AdxxxBy60s := OrderedCollection new.
	Titles := OrderedCollection new.
	sponsorDir := Filename fromComponents: #('.' 'resource' 'sponsor').
	sponsorDir directoryContents do: 
			[:dir |
			| companyDir adDir fileName |
			companyDir := sponsorDir construct: dir.
			adDir := companyDir construct: 'adxxxby32'.
			fileName := adDir construct: 'link.txt'.
			fileName definitelyExists
				ifTrue: 
					[| fileStream stringStream bmp http bmpFile adImage previousImage |
					fileStream := fileName readStream.
					
					[stringStream := fileStream contents cleanSourceFromSelf readStream.
					[stringStream atEnd.] whileFalse: 
							[stringStream skipSeparators.
							bmp := stringStream upToSeparator.
							stringStream skipSeparators.
							http := stringStream upToSeparator.
							bmpFile := adDir construct: bmp.
							bmpFile definitelyExists
								ifTrue: 
									[adImage := AdImage new.
									adImage company: dir.
									adImage image: (bmp = 'ditto'
												ifTrue: [previousImage image.]
												ifFalse: [CachedImage on: (ImageReader fromFile: bmpFile) image.]).
									adImage
										http: (http = 'ditto' ifTrue: [previousImage http.] ifFalse: [http.]).
									AdxxxBy32s add: adImage.
									previousImage := adImage.].].]
							ensure: [fileStream close.].].
			fileName := companyDir construct: 'title.txt'.
			fileName definitelyExists
				ifTrue: 
					[| fileStream stringStream title adTitle previousTitle |
					fileStream := fileName readStream.
					
					[stringStream := fileStream contents cleanSourceFromSelf readStream.
					[stringStream atEnd.] whileFalse: 
							[stringStream skipSeparators.
							title := stringStream upTo: Character cr.
							adTitle := AdTitle new.
							adTitle company: dir.
							adTitle
								title: (title = 'ditto' ifTrue: [previousTitle title.] ifFalse: [title.]).
							Titles add: adTitle.
							previousTitle := adTitle.].]
							ensure: [fileStream close.].].].
]

{ #category : #sponsor }
AdData class >> openAshlarVellumText [

	| labelString text stop block start app |
	labelString := 'Ashlar-Vellum          '
	               ,
	               (StCAD_StDoc_AdData adTitleFor: 'ashlar-vellum') title. "VW_TRANSLATION:StCAD.StDoc.AdData:StCAD_StDoc_AdData"
	text := #'
Ashlar-Vellum''s Argon
for MAC and Windows

The new 3D modeling tool that is exceptionally powerful, exceptionally easy and exceptionally affordable! Based on the award winning technology of Ashlar-Vellum Solids, Argon offers incredibly powerful and easy to use free-form Wireframe, Surfacing, and Solid modeling. Argon gives you everything you need to easily create virtually any shape you can dream up thanks to a smooth interface that allows you to concentrate on the task at hand, not the software... all at a breakthrough, affordable price! Now with Argon, anyone can do Advanced 3D Modeling...Just Create It!

Try Ashlar-Vellum''s Argon for free at 
http://www.ashlar-vellum.com
or click the Advertisement at the bottom of this window.
'.
	text := text asText.
	stop := 1.
	block := [ :string :emphasis | 
	         start := text findString: string startingAt: stop.
	         stop := start + string size - 1.
	         text emphasizeFrom: start to: stop with: emphasis ].
	block value: 'Ashlar-Vellum''s Argon' value: #( #bold #large ).
	block value: 'for MAC and Windows' value: #( #bold ).
	block value: 'Ashlar-Vellum Solids' value: #( #bold ).
	block
		value: 'free-form Wireframe, Surfacing, and Solid modeling'
		value: #( #bold ).
	block value: 'Advanced 3D Modeling' value: #( #bold ).
	block value: 'Ashlar-Vellum''s Argon' value: #( #bold ).
	block value: 'http://www.ashlar-vellum.com' value: #( #bold ).
	app := Editor new.
	app textHolder: text asText asValue.
	app adButton adImage:
		(StCAD_StDoc_AdData adxxxBy32For: 'ashlar-vellum').
	app openInterface: #readOnlyWindowSpec.
	app builder window label: labelString asString.
	^ app builder
]

{ #category : #'VisualWorks metadata' }
AdData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Doc'
		'superclassNamespace' 'StCAD.Doc'
	)

]

{ #category : #accessing }
AdData >> company [
	^company
]

{ #category : #accessing }
AdData >> company: string [ 
	company := string asString
]
