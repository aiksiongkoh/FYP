Class {
	#name : #Editor,
	#superclass : #ApplicationModel,
	#instVars : [
		'selection',
		'treeView',
		'cadView',
		'aMediator'
	],
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #resources }
Editor class >> handleImage [

	"Tools.UIMaskEditor new openOnClass: self andSelector: #handleImage"

	<resource: #image>
	^ CachedImage on: (Image
			   extent: 5 @ 5
			   depth: 1
			   bitsPerPixel: 1
			   palette:
				   (Graphics_MappedPalette withColors: ((Core_Array new: 1)
						     at: 1 put: Graphics_ColorValue black;
						     yourself))
			   usingBits: #[ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]) "VW_TRANSLATION:Graphics.ColorValue:Graphics_ColorValue" "VW_TRANSLATION:Core.Array:Core_Array" "VW_TRANSLATION:Graphics.MappedPalette:Graphics_MappedPalette"
]

{ #category : #resources }
Editor class >> handleImage2 [
	"Tools.UIMaskEditor new openOnClass: self andSelector: #handleImage2"

	<resource: #image>
	^CachedImage on: (Image extent: 5@5 depth: 1 bitsPerPixel: 1 palette: CoveragePalette monoMaskPalette usingBits: #[248 0 0 0 248 0 0 0 248 0 0 0 248 0 0 0 248 0 0 0])
]

{ #category : #resources }
Editor class >> menuBar [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Quick Test'
	                    #value: #menuExplainQuickTest )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Quick Start'
	                    #value: #menuExplainQuickStart )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Known Problems'
	                    #value: #menuExplainKnownProblems )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Introduction'
	                    #value: #menuExplainIntroduction )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Tree View'
	                    #value: #menuExplainTreeView )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Usage' #value:
	                    #menuExplainUsage )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'About' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'freeCAD' #value: #menuExplainAboutfreeCAD )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'StCAD' #value: #menuExplainAboutStCAD )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Patch' #value: #menuExplainAboutPatch ) )
	                       #( 3 ) nil ) ) )
	              #( 7 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'File' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #value: #menuFileExplain )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'New' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Assembly' #value: #menuFileNewAssembly )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Part' #enabled: false #value:
	                             #menuFileNewPart #hidden: true ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Open' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Assembly' #value: #menuFileOpenAssembly )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Part' #enabled: false #value:
	                             #menuFileOpenPart #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'MOSES *.ppo' #value: #menuFileOpenMOSESppo )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Sebert *.dat' #enabled:
	                             false #value: #menuFileOpenSebertdat
	                             #hidden: true ) )
	                       #( 4 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Save As'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Assembly' #value: #menuFileSaveAsAssembly )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Part' #value: #menuFileSaveAsPart ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Save As Text'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Assembly' #value: #menuFileSaveAsTextAssembly )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Part' #enabled: false #value:
	                             #menuFileSaveAsTextPart
	                             #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'PDMSReview' #value: #menuFileSaveAsTextPDMSReview )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'POV-Ray' #value: #menuFileSaveAsTextPOVRay
	                             #submenu: #( '#{VWQR:UI.Menu}'
	                                #( #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: 'Current State'
	                                      #value: #menuFileSaveAsTextPOVRayCurrent )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: 'Time Series'
	                                      #value: #menuFileSaveAsTextPOVRaySeries ) )
	                                #( 2 ) nil ) )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'LMU Path' #enabled:
	                             false #value: #menuFileSaveAsTextLMUPath
	                             #hidden: true ) )
	                       #( 5 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Properties'
	                    #enabled: false #value: #menuFileProperties
	                    #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Exit' #value:
	                    #menuFileExit ) )
	              #( 3 4 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Edit' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #value: #menuEditExplain )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Undo' #value:
	                    #menuEditUndo )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Find' #enabled:
	                    false #value: #menuEditFind #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Copy' #enabled:
	                    false #value: #menuEditCopy #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Cut' #value:
	                    #menuEditCut )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Paste' #enabled:
	                    false #value: #menuEditPaste #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Marker Size'
	                    #value: #menuEditMarkerSize )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Notes' #value:
	                    #menuEditNotes ) )
	              #( 6 2 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'View' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #value: #menuViewExplain )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Y up' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'X right' #value: #menuViewYupXright )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'X left' #value: #menuViewYupXleft )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Z right' #value: #menuViewYupZright )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Z left' #value: #menuViewYupZleft )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad + + +' #value: #menuViewYupQuadppp )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad - + +' #value: #menuViewYupQuadmpp )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad - + -' #value: #menuViewYupQuadmpm )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad + + -' #value: #menuViewYupQuadppm ) )
	                       #( 8 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Z up' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'X right' #value: #menuViewZupXright )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'X left' #value: #menuViewZupXleft )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Y right' #value: #menuViewZupYright )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Y left' #value: #menuViewZupYleft )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad + + +' #value: #menuViewZupQuadppp )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad + - +' #value: #menuViewZupQuadpmp )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad - - +' #value: #menuViewZupQuadmmp )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quad - + +' #value: #menuViewZupQuadmpp ) )
	                       #( 8 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'X right Y up'
	                    #enabled: false #value: #menuViewXrightYup
	                    #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'X right Z down'
	                    #enabled: false #value: #menuViewXrightZdown
	                    #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Y up Z left'
	                    #enabled: false #value: #menuViewYupZleft
	                    #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Tilt Rotate Universe'
	                    #value: #menuViewTiltRotateUniverse )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Zoom In'
	                    #value: #menuViewZoomIn )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Zoom Out'
	                    #value: #menuViewZoomOut )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Show' #enabled:
	                    false #value: #menuViewShow #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Transcript'
	                    #value: #menuViewTranscript )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Notes' #value:
	                    #menuViewNotes ) )
	              #( 12 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Select' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #value: #menuSelectExplain )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Plane' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'x=X y=Y' #value: #menuSelectPlaneXrightYup )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Rotate x' #submenu:
	                             #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '90 deg' #value:
	                                      #menuSelectPlaneRotatex90 )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '180 deg' #value:
	                                      #menuSelectPlaneRotatex180 )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '270 deg' #value:
	                                      #menuSelectPlaneRotatex270 ) )
	                                #( 3 ) nil ) )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Rotate y' #submenu:
	                             #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '90 deg' #value:
	                                      #menuSelectPlaneRotatey90 )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '180 deg' #value:
	                                      #menuSelectPlaneRotatey180 )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '270 deg' #value:
	                                      #menuSelectPlaneRotatey270 ) )
	                                #( 3 ) nil ) )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Rotate z' #submenu:
	                             #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '90 deg' #value:
	                                      #menuSelectPlaneRotatez90 )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '180 deg' #value:
	                                      #menuSelectPlaneRotatez180 )
	                                   #( '#{VWQR:UI.MenuItem}'
	                                      #rawLabel: '270 deg' #value:
	                                      #menuSelectPlaneRotatez270 ) )
	                                #( 3 ) nil ) )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'x=X y=-Z' #enabled:
	                             false #value: #menuSelectPlaneXrightZdown
	                             #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'x=-Z y=Y' #enabled:
	                             false #value: #menuSelectPlaneYupZleft
	                             #hidden: true ) )
	                       #( 6 ) nil ) ) )
	              #( 2 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Insert' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #value: #menuInsertExplain )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Assembly'
	                    #enabled: false #hidden: true #submenu: #( '#{VWQR:UI.Menu}'
	                       #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'New' #value: #menuInsertAssemblyNew )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'File' #value: #menuInsertAssemblyFile ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Part' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'New' #value: #menuInsertPartNew )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'File' #value: #menuInsertPartFile ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Sketch'
	                    #value: #menuInsertSketch )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Feature'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Extrusion' #value: #menuInsertFeatureExtrusion )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Cut' #enabled: false #value:
	                             #menuInsertFeatureCut
	                             #hidden: true ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Marker'
	                    #value: #menuInsertMarker )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Others'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'MOSES Frame' #value: #menuInsertMOSESFrame )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'PDMSReview Frame'
	                             #value: #menuInsertPDMSFrame )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'POV-Ray Frame'
	                             #enabled: false #value: #menuInsertPOVRayFrame
	                             #hidden: true ) )
	                       #( 3 ) nil ) ) )
	              #( 6 1 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Draw' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #value: #menuDrawExplain )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Line' #enabled:
	                    false #value: #menuDrawLine #hidden: true )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Rectangle'
	                    #value: #menuDrawRectangle )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Circle'
	                    #value: #menuDrawCircle )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Ellipse'
	                    #value: #menuDrawEllipse )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Polyline'
	                    #value: #menuDrawPolyline ) )
	              #( 6 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Kinematic' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #submenu: #( '#{VWQR:UI.Menu}'
	                       #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Joint' #value: #menuKinematicExplainJoint )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Motion' #value: #menuKinematicExplainMotion )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'KinematicIJ' #value: #menuKinematicExplainKineIJ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Coupler' #enabled: false
	                             #value: #menuKinematicExplainCoupler
	                             #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Redundant Constraint'
	                             #value: #menuKinematicExplainRedundantConstraint ) )
	                       #( 4 1 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Joint' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Constant VelocityZ'
	                             #value: #menuJointConstantVelocityZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Coupler' #enabled: false
	                             #value: #menuJointCoupler
	                             #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Curve On Curve'
	                             #value: #menuJointCurveOnCurve )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'CylindricalZ' #value:
	                             #menuJointCylindricalZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Fixed' #value: #menuJointFixed )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'No Rotation' #value: #menuJointNoRotation )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'ParallelZ' #value: #menuJointParallelZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'PerpendicularZ'
	                             #value: #menuJointPerpendicularZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'PlanarXY' #value: #menuJointPlanarXY )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Point In Curve'
	                             #enabled: false #value: #menuJointPointInCurve
	                             #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Point In LineZ'
	                             #value: #menuJointPointInLineZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Point In PlaneXY'
	                             #value: #menuJointPointInPlaneXY )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'RackX And PinionZ'
	                             #value: #menuJointRackXAndPinionZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'RevoluteZ' #value: #menuJointRevoluteZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'ScrewZ' #value: #menuJointScrewZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Spherical' #value: #menuJointSpherical )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'TranslationalZ'
	                             #value: #menuJointTranslationalZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'UniversalZ' #value: #menuJointUniversalZ ) )
	                       #( 18 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Motion'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'General' #value: #menuMotionGeneral )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'RotationalZ' #value: #menuMotionRotationalZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'TranslationalZ'
	                             #value: #menuMotionTranslationalZ ) )
	                       #( 3 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'KinematicIJ'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Create' #value: #menuKinematicKineIJCreate ) )
	                       #( 1 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Coupler'
	                    #enabled: false #value: #menuKinematicCoupler
	                    #hidden: true ) )
	              #( 5 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Dynamic' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #submenu: #( '#{VWQR:UI.Menu}'
	                       #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Mass' #value: #menuDynamicExplainMass )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'ForceTorque' #value: #menuDynamicExplainForceTorque )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Gravity' #value: #menuDynamicExplainGravity ) )
	                       #( 3 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'ForceTorque'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'General' #value: #menuDynamicForceTorqueGeneral )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'In-Line' #value: #menuDynamicForceTorqueInLine ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Gravity'
	                    #value: #menuDynamicGravity ) )
	              #( 3 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Simulation' #submenu:
	           #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Explain' #submenu: #( '#{VWQR:UI.Menu}'
	                       #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Initial Condition'
	                             #value: #menuSimulationExplainIC )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Quasi Static' #value:
	                             #menuSimulationExplainQuasiStatic )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Transient' #value: #menuSimulationExplainTransient )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Stop' #value: #menuSimulationExplainStop )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Animation' #value: #menuSimulationExplainAnimation )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Plot' #value: #menuSimulationExplainPlot )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Vector' #enabled: false
	                             #value: #menuSimulationExplainVector
	                             #hidden: true )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'FreeBody' #enabled:
	                             false #value: #menuSimulationExplainFreeBody
	                             #hidden: true ) )
	                       #( 8 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Initial Conditions'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Previous Input State'
	                             #value: #menuSimulationPreviousInputState )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Previous Assembled State'
	                             #value: #menuSimulationPreviousAssembledState )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Zero All Velocities'
	                             #value: #menuSimulationZeroAllVelocities ) )
	                       #( 3 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'QuasiStatic'
	                    #value: #menuSimulationQuasiStatic )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Transient'
	                    #value: #menuSimulationDynamic )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Stop' #value:
	                    #menuSimulationStop )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Animation'
	                    #value: #menuSimulationAnimation ) )
	              #( 1 1 3 1 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Sponsor    '
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'Corporate' #value: #menuSponsorCorporate )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Individual'
	                    #value: #menuSponsorIndividual )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Ashlar-Vellum'
	                    #enabled: false #value: #menuSponsorAshlarVellum
	                    #hidden: true ) )
	              #( 3 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''TiltRotate'''
	           #value: #menuViewTiltRotateUniverse )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''ZoomIn''' #value:
	           #menuViewZoomIn )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''ZoomOut''    '
	           #value: #menuViewZoomOut )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Solid''' #value:
	           #menuViewPresentationSolid )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''HideLine'''
	           #value: #menuViewPresentationHideLine )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Wireframe''    '
	           #value: #menuViewPresentationWireframe )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Animation'''
	           #value: #menuSimulationAnimation )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Inspect'''
	           #value: #menuInspect ) )
	     #( 19 ) nil ) decodeAsLiteralArray
]

{ #category : #resources }
Editor class >> menuTreeView [

	"MenuEditor new openOnClass: self andSelector: #menuTreeView"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Rename' #value: #inplaceEdit ) )
	     #( 1 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
Editor class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
Editor class >> windowSpec [

	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'CADSM' #min: #( '#{VWQR:Core.Point}'
	           40 20 ) #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           390 308 1030 788 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.InputFieldSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -32 1 300 0 0 1 )
	              #name: #selection #isOpaque: true #model: #selection
	              #isReadOnly: true )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 302 0 -32 1 0 1 0 1 )
	              #name: #adButton #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton )
	           #( '#{VWQR:UI.ArbitraryComponentSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.2 0 0 0 1 -33 1 )
	              #name: #cadView #flags: 11 #component: #cadView )
	           #( '#{VWQR:UI.TreeViewSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 0.2 -33 1 )
	              #name: #treeView #flags: 15 #model: #treeView #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #updateTreeModel:
	                 #doubleClickSelector: #doubleClick: )
	              #menu: #menuTreeView #useModifierKeys:
	              true #selectionType: #highlight #displayStringSelector:
	              #displayString #inPlaceEditedSelector:
	              #inPlaceEdit: #rootExpander: true ) ) ) )
]

{ #category : #accessing }
Editor >> aMediator [
	^aMediator
]

{ #category : #accessing }
Editor >> aMediator: anObject [ 
	aMediator := anObject
]

{ #category : #accessing }
Editor >> aTool [
	^aMediator aTool
]

{ #category : #accessing }
Editor >> animationWindow [
	^self dependents detect: 
			[:dependent | 
			(dependent isKindOf: ApplicationWindow) 
				and: [dependent model isMemberOf: Animation]]
		ifNone: nil
]

{ #category : #displaying }
Editor >> animationWindowRaise [
	| selfWindow animationWindow animationBuilder |
	animationWindow := self animationWindow.
	animationWindow isNil 
		ifTrue: 
			[animationBuilder := Animation openOn: aMediator.
			animationBuilder notNil 
				ifTrue: 
					[selfWindow := builder window.
					animationWindow := animationBuilder window.
					selfWindow application: self.
					animationWindow application: self.
					selfWindow beMaster.
					animationWindow beSlave]]
		ifFalse: 
			[animationWindow
				expand;
				raise]
]

{ #category : #accessing }
Editor >> buttonState [
	^#pick
]

{ #category : #aspects }
Editor >> cadView [
	^cadView isNil 
		ifTrue: [cadView := OpenGLView model: self]
		ifFalse: [cadView]
]

{ #category : #ad }
Editor >> changeAdTitle [
	self mainWindow 
		label: 'CADSM     ' , aMediator aFilename asString , '          ' 
				, self adTitle
]

{ #category : #aspects }
Editor >> doubleClick: aTreeController [ 
	"Let the tree toggle the state of expandation of the selected node."

	aTreeController toggleExpand
]

{ #category : #'initialize-release' }
Editor >> initialize [
	super initialize.
	aMediator := Mediator new.
	aMediator aEditor: self.
	self cadView aCamera: (aMediator aUniverse cCamera at: 1)
]

{ #category : #'*StCAD-UI-initialize-release' }
Editor >> initialize [
	super initialize.
	adButton := AdButton new.
	filename := ''
]

{ #category : #'menubar items' }
Editor >> menuFileOpenAssembly [
	self changeRequest ifTrue: [aMediator menuFileOpenAssembly]
]

{ #category : #'menubar items' }
Editor >> menuInspect [
	self inspect
]

{ #category : #'menubar items' }
Editor >> menuSimulationAnimation [
	self animationWindowRaise
]

{ #category : #'menubar items' }
Editor >> menuViewPresentationHideLine [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator menuViewPresentationHideLine.
			cadView invalidate.
			self triggerEvent: #projection]
]

{ #category : #'menubar items' }
Editor >> menuViewPresentationSolid [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator menuViewPresentationSolid.
			cadView invalidate.
			self triggerEvent: #projection]
]

{ #category : #'menubar items' }
Editor >> menuViewPresentationWireframe [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator menuViewPresentationWireframe.
			cadView invalidate.
			self triggerEvent: #projection]
]

{ #category : #'menubar items' }
Editor >> menuViewTiltRotateUniverse [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator doTiltRotateUniverseInView: cadView.
			self triggerEvent: #projection]
]

{ #category : #'menubar items' }
Editor >> menuViewYupQuadmpm [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator doYupQuadmpmInView: cadView.
			self triggerEvent: #projection]
]

{ #category : #'menubar items' }
Editor >> menuViewYupXright [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator doYupXrightInView: cadView.
			self triggerEvent: #projection]
]

{ #category : #'menubar items' }
Editor >> menuViewZoomIn [
	self changeRequest ifTrue: [aMediator doZoomIn]
]

{ #category : #'menubar items' }
Editor >> menuViewZupQuadmmp [
	self changeRequest 
		ifTrue: 
			[self adOpportunity.
			aMediator doZupQuadmmpInView: cadView.
			self triggerEvent: #projection]
]

{ #category : #'initialize-release' }
Editor >> postBuildWith: aBuilder [ 
	builder window application: self.
	self aMediator when: #select
		do: [self selectionValue: aMediator selections asArray].
	self aMediator when: #deselect
		do: [self selectionValue: aMediator selections asArray].
	self aMediator 
		when: #mousePointChanged
		ask: self
		perform: #rDcursorPxValue:.
	self aMediator 
		when: #handleInvoked
		ask: self
		perform: #handleValue:.
	self aMediator 
		when: #noHandleInvoked
		ask: self
		perform: #clearHandleValue.
	self treeView list root: TreeNode new displayIt: true.
	self treeView selectionIndexHolder 
		onChangeSend: #updateCadViewFromTreeView
		to: self.
	self aMediator 
		when: #select
		ask: self
		perform: #updateTreeViewFromCadView
]

{ #category : #displaying }
Editor >> renderOn: aRenderingContext [ 
	aMediator renderOn: aRenderingContext
]

{ #category : #'menubar items' }
Editor >> scroll: aPoint [ 
	aMediator scrollView: cadView by: aPoint
]

{ #category : #aspects }
Editor >> selection [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."

	^selection isNil
		ifTrue:
			[selection := String new asValue]
		ifFalse:
			[selection]
]

{ #category : #aspects }
Editor >> selectionValue: cadGO [ 
	self selection value: cadGO printString
]

{ #category : #aspects }
Editor >> treeView [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."

	^treeView isNil
		ifTrue:
			[treeView := SelectionInTree new]
		ifFalse:
			[treeView]
]

{ #category : #'initialize-release' }
Editor >> updateCadViewFromTreeView [
]

{ #category : #aspects }
Editor >> updateTreeModel: controller [
	| newRoot treeModel originalRoot |
	newRoot := aMediator aUniverse isNil
				ifTrue: [GEOTreeNode new.]
				ifFalse: [aMediator aUniverse asTreeNode.].
	treeModel := self treeView list.
	originalRoot := treeModel at: 1.
	originalRoot copyFrom: newRoot.
	treeModel refreshRoot.
	treeModel expand: 1.
]
