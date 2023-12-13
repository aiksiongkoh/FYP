Class {
	#name : #DataRegistration,
	#superclass : #Data,
	#instVars : [
		'aProductID',
		'aHardwareID',
		'aInstallDate',
		'aFullName',
		'aEmail',
		'aRSAPublicKey2',
		'aRSAPrivateKey2',
		'aRegistrationDate',
		'aSupportExpirationDate',
		'aPatchID'
	],
	#category : #'StCAD-Misc'
}

{ #category : #'VisualWorks metadata' }
DataRegistration class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'StCAD.Misc'
	)

]

{ #category : #accessing }
DataRegistration >> aEmail [
	^aEmail
]

{ #category : #accessing }
DataRegistration >> aEmail: anObject [
	aEmail := anObject
]

{ #category : #accessing }
DataRegistration >> aFullName [
	^aFullName
]

{ #category : #accessing }
DataRegistration >> aFullName: anObject [
	aFullName := anObject
]

{ #category : #accessing }
DataRegistration >> aHardwareID [
	^aHardwareID
]

{ #category : #accessing }
DataRegistration >> aHardwareID: anObject [
	aHardwareID := anObject
]

{ #category : #accessing }
DataRegistration >> aInstallDate [
	^aInstallDate
]

{ #category : #accessing }
DataRegistration >> aInstallDate: anObject [
	aInstallDate := anObject
]

{ #category : #accessing }
DataRegistration >> aPatchID [
	^aPatchID
]

{ #category : #accessing }
DataRegistration >> aPatchID: anObject [
	aPatchID := anObject
]

{ #category : #accessing }
DataRegistration >> aProductID [
	^aProductID
]

{ #category : #accessing }
DataRegistration >> aProductID: anObject [
	aProductID := anObject
]

{ #category : #accessing }
DataRegistration >> aRSAPrivateKey2 [
	^aRSAPrivateKey2
]

{ #category : #accessing }
DataRegistration >> aRSAPrivateKey2: anObject [
	aRSAPrivateKey2 := anObject
]

{ #category : #accessing }
DataRegistration >> aRSAPublicKey2 [
	^aRSAPublicKey2
]

{ #category : #accessing }
DataRegistration >> aRSAPublicKey2: anObject [
	aRSAPublicKey2 := anObject
]

{ #category : #accessing }
DataRegistration >> aRegistrationDate [
	^aRegistrationDate
]

{ #category : #accessing }
DataRegistration >> aRegistrationDate: anObject [
	aRegistrationDate := anObject
]

{ #category : #accessing }
DataRegistration >> aSupportExpirationDate [
	^aSupportExpirationDate
]

{ #category : #accessing }
DataRegistration >> aSupportExpirationDate: anObject [
	aSupportExpirationDate := anObject
]

{ #category : #printing }
DataRegistration >> printOn: aStream [ 
	aStream nextPutAll: 'aProductID := '.
	aStream
		print: aProductID;
		cr.
	aStream nextPutAll: 'aHardwareID := '.
	aStream
		print: aHardwareID;
		cr.
	aStream nextPutAll: 'aInstallDate := '.
	aStream
		print: aInstallDate;
		cr.
	aStream nextPutAll: 'aFullName := '.
	aStream
		print: aFullName;
		cr.
	aStream nextPutAll: 'aEmail := '.
	aStream
		print: aEmail;
		cr.
	aStream nextPutAll: 'aRSAPublicKey2 := '.
	aStream
		print: aRSAPublicKey2;
		cr.
	aStream nextPutAll: 'aRSAPrivateKey2 := '.
	aStream
		print: aRSAPrivateKey2;
		cr.
	aStream nextPutAll: 'aRegistrationDate := '.
	aStream
		print: aRegistrationDate;
		cr.
	aStream nextPutAll: 'aSupportExpirationDate := '.
	aStream
		print: aSupportExpirationDate;
		cr.
	aStream nextPutAll: 'aPatchID := '.
	aStream print: aPatchID
]
