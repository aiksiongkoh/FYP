Extension { #name : #RuntimeManager }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
RuntimeManager >> startupApplication [
	Parcel loadParcelFrom: (ObjectMemory imagePrefix , '.pcl') asFilename
]
