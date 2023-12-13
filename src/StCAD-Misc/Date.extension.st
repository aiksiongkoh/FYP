Extension { #name : #Date }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Date >> addYears: yearCount [ 
	| newYear newIsLeapYear newDay |
	newYear := year + yearCount.
	newIsLeapYear := (self class leapYear: newYear) == 1.
	newDay := day.
	self isAfterFebruary28 
		ifTrue: 
			[self isLeapYear 
				ifTrue: [newIsLeapYear ifFalse: [newDay := day - 1]]
				ifFalse: [newIsLeapYear ifTrue: [newDay := day + 1]]].
	^self class newDay: newDay year: newYear
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
Date class >> example1 [
	"self example1"

	| stream |
	stream := (String new: 100) writeStream.
	Date today storeOn: stream.
	^stream contents
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
Date class >> example2 [
	"self example2"

	^Compiler evaluate: self example1
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
Date class >> example3 [
	"self example3."

	Date 
		newDay: 1
		month: #Mar
		year: 2004.
	Date dateAndTimeNow.
	Date readFrom: '5 April 1982' readStream.
	Date readFrom: '5-APR-82' readStream.
	Date readFrom: 'April 5, 1982' readStream.
	Date readFrom: '2/29/82' readStream.
	(Date readFrom: '8/12/2004' readStream) isLeapYear.
	(Date readFrom: '2/29/2004' readStream) isLeapDay.
	(Date readFrom: '2/29/2004' readStream) addYears: 2.
	(Date readFrom: '3/29/2004' readStream) addYears: 2.
	(Date readFrom: '1/29/2004' readStream) addYears: 2.
	(Date readFrom: '2/29/2004' readStream) addYears: 4.
	(Date readFrom: '3/29/2004' readStream) addYears: 4.
	(Date readFrom: '1/29/2004' readStream) addYears: 4.
	(Date readFrom: '2/29/2004' readStream) subtractYears: 2.
	(Date readFrom: '3/29/2004' readStream) subtractYears: 2.
	(Date readFrom: '1/29/2004' readStream) subtractYears: 2.
	(Date readFrom: '2/29/2004' readStream) subtractYears: 4.
	(Date readFrom: '3/29/2004' readStream) subtractYears: 4.
	(Date readFrom: '1/29/2004' readStream) subtractYears: 4
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Date >> isAfterFebruary28 [
	^day > (31 + 28)
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Date >> isLeapDay [
	^self isLeapYear and: [day == (31 + 29)]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Date >> isLeapYear [
	^self leap == 1
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Date >> subtractYears: yearCount [ 
	| newYear newIsLeapYear newDay |
	newYear := year - yearCount.
	newIsLeapYear := (self class leapYear: newYear) == 1.
	newDay := day.
	self isAfterFebruary28 
		ifTrue: 
			[self isLeapYear 
				ifTrue: [newIsLeapYear ifFalse: [newDay := day - 1]]
				ifFalse: [newIsLeapYear ifTrue: [newDay := day + 1]]].
	^self class newDay: newDay year: newYear
]
