Extension { #name : #Time }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Time class >> example1 [
	"Time example1."

	Time microsecondClock.
	Time secondClock
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Time class >> secondsToRun: timedBlock [ 
	^((self microsecondsToRun: timedBlock) + 500000) // 1000000
]
