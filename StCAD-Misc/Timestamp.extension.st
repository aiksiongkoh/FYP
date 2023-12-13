Extension { #name : #Timestamp }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Timestamp >> addDays: dayCount [ 
	| aDate aTime |
	aDate := self asDate.
	aTime := self asTime.
	^self class fromDate: (aDate addDays: dayCount) andTime: aTime
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Timestamp >> addHours: aHourCount [ 
	^self addSeconds: aHourCount * 3600
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Timestamp >> addMinutes: aMinuteCount [ 
	^self addSeconds: aMinuteCount * 60
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Timestamp >> addYears: yearCount [ 
	| aDate aTime |
	aDate := self asDate.
	aTime := self asTime.
	^self class fromDate: (aDate addYears: yearCount) andTime: aTime
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Timestamp class >> example1 [
	"Timestamp example1."

	Timestamp now.
	Timestamp fromSeconds: 0.
	Timestamp new fromSeconds: 0.
	Timestamp new setFromMicroseconds: 0.
	Time aTime: 0
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Timestamp >> postCopy [
	super postCOPY
]
