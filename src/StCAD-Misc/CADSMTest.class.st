Class {
	#name : #CADSMTest,
	#superclass : #TestCase,
	#category : #'StCAD-Misc'
}

{ #category : #testing }
CADSMTest >> testSymbolicAssembly [

	"CADSMTest new testSymbolicAssembly"

	| aUniverse aAssembly iPart jPart iRefPoint jRefPoint iEndFrame jEndFrame aKinematicIJ |
	aUniverse := StCAD_MbD_Universe new. "VW_TRANSLATION:StCAD.MbD.Universe:StCAD_MbD_Universe"
	aAssembly := StCAD_MbD_Assembly new. "VW_TRANSLATION:StCAD.MbD.Assembly:StCAD_MbD_Assembly"
	aUniverse addAssembly: aAssembly.
	iPart := StCAD_MbD_Part new. "VW_TRANSLATION:StCAD.MbD.Part:StCAD_MbD_Part"
	jPart := StCAD_MbD_Part new.
	aAssembly addAnyPart: iPart.
	aAssembly addAnyPart: jPart.
	iRefPoint := StCAD_MbD_RefPoint new. "VW_TRANSLATION:StCAD.MbD.RefPoint:StCAD_MbD_RefPoint"
	jRefPoint := StCAD_MbD_RefPoint new.
	iPart addRefGeo: iRefPoint.
	jPart addRefGeo: jRefPoint.
	iEndFrame := StCAD_MbD_EndFrame new. "VW_TRANSLATION:StCAD.MbD.EndFrame:StCAD_MbD_EndFrame"
	jEndFrame := StCAD_MbD_EndFrame new.
	iRefPoint addEndFrame: iEndFrame.
	jRefPoint addEndFrame: jEndFrame.
	aKinematicIJ := StCAD_MbD_KinematicIJ
		                aEndI: iEndFrame
		                aEndJ: jEndFrame. "VW_TRANSLATION:StCAD.MbD.KinematicIJ:StCAD_MbD_KinematicIJ"
	aUniverse aRefFrame beSymbolic.
	aKinematicIJ inspect
]
