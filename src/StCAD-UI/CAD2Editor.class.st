Class {
	#name : #CAD2Editor,
	#superclass : #CADEditor,
	#category : #'StCAD-UI-CADApp'
}

{ #category : #resources }
CAD2Editor class >> menuBar [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Quick Test'
	                    #value: #menuExplainQuickTest )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Quick Start'
	                    #value: #menuExplainQuickStart )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Introduction'
	                    #value: #menuExplainIntroduction )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Tree View'
	                    #value: #menuExplainTreeView )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Usage' #value:
	                    #menuExplainUsage )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Troubleshoot'
	                    #value: #menuExplainTroubleshoot )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'About' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'freeCAD' #value: #menuExplainAboutfreeCAD )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'StCAD' #value: #menuExplainAboutStCAD )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Patch' #value: #menuExplainAboutPatch ) )
	                       #( 3 ) nil ) ) )
	              #( 2 5 ) nil ) )
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
	                             #rawLabel: 'DXF New' #value: #menuFileOpenDXFNew )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'DXF Update' #value: #menuFileOpenDXFUpdate )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'STEP New' #value: #menuFileOpenSTEPNew )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'STEP Update' #value: #menuFileOpenSTEPUpdate )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'MOSES *.ppo' #value: #menuFileOpenMOSESppo
	                             #hidden: true ) )
	                       #( 7 ) nil ) )
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
	                             #rawLabel: 'PDMSReview' #value: #menuFileSaveAsTextPDMSReview
	                             #hidden: true )
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
	                             #rawLabel: 'Robot Axes' #value: #menuFileSaveAsTextRobotAxes ) )
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
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Assembly Size'
	                    #value: #menuEditAssemblySize )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Part Size'
	                    #value: #menuEditPartSize )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Marker Size'
	                    #value: #menuEditMarkerSize )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Notes' #value:
	                    #menuEditNotes ) )
	              #( 6 4 ) nil ) )
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
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Wireframe'
	                    #value: #menuViewWireframe )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Solid' #value:
	                    #menuViewSolid )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Tilt Rotate World'
	                    #value: #menuViewTiltRotateWorld )
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
	              #( 6 2 6 ) nil ) )
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
	                    #value: #menuInsertAssembly )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Part' #submenu:
	                    #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'New' #value: #menuInsertPartNew )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'File' #value: #menuInsertPartFile )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'DXF' #value: #menuInsertPartDXF )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'STEP' #value: #menuInsertPartSTEP ) )
	                       #( 4 ) nil ) )
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
	                    #hidden: true #submenu: #( '#{VWQR:UI.Menu}'
	                       #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'MOSES Frame' #value: #menuInsertMOSESFrame )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'PDMSReview Frame'
	                             #value: #menuInsertPDMSFrame ) )
	                       #( 2 ) nil ) ) )
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
	                             #rawLabel: 'AngleIzJz' #value: #menuJointAngle )
	                          #( '#{VWQR:UI.MenuItem}'
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
	                             #rawLabel: 'ParallelGearZ'
	                             #value: #menuJointParallelGear )
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
	                             #rawLabel: 'RevCyl' #value: #menuJointRevCyl )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'ScrewZ' #value: #menuJointScrewZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Spherical' #value: #menuJointSpherical )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'SphSph' #value: #menuJointSphSph )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'TranslationalZ'
	                             #value: #menuJointTranslationalZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'UniversalZ' #value: #menuJointUniversalZ ) )
	                       #( 22 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Motion'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'General' #value: #menuMotionGeneral )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'RotationalZ' #value: #menuMotionRotationalZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'TranslationalZ'
	                             #value: #menuMotionTranslationalZ )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'AllowZRotation'
	                             #value: #menuAllowZRotation ) )
	                       #( 4 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'KinematicIJ'
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Create' #value: #menuKinematicKineIJCreate )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Robot Axis' #value: #menuKinematicKineIJRobotAxis ) )
	                       #( 2 ) nil ) )
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
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Wireframe'''
	           #value: #menuViewWireframe )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Solid''' #value:
	           #menuViewSolid )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Regen''    '
	           #value: #menuViewRegen )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''TiltRotate'''
	           #value: #menuViewTiltRotateWorld )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''ZoomIn''' #value:
	           #menuViewZoomIn )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''ZoomOut''    '
	           #value: #menuViewZoomOut )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Animation'''
	           #value: #menuSimulationAnimation )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Inspect'''
	           #value: #menuInspect ) )
	     #( 18 ) nil ) decodeAsLiteralArray
]

{ #category : #resources }
CAD2Editor class >> menuBar1 [

	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar1"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Quick Test'
	                    #value: #menuExplainQuickTest )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Quick Start'
	                    #value: #menuExplainQuickStart )
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
	              #( 6 ) nil ) )
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
	              #( 7 ) nil ) )
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
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Tilt Rotate World'
	                    #value: #menuViewTiltRotateWorld )
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
	           #value: #menuViewTiltRotateWorld )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''ZoomIn''' #value:
	           #menuViewZoomIn )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''ZoomOut''    '
	           #value: #menuViewZoomOut )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Animation'''
	           #value: #menuSimulationAnimation )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: '''Inspect'''
	           #value: #menuInspect ) )
	     #( 16 ) nil ) decodeAsLiteralArray
]

{ #category : #'parcel load/unload/save' }
CAD2Editor class >> postLoadFor: pkg [ 
	"self postLoadFor: nil."

	self new menuExplainAboutStCAD
]

{ #category : #'interface specs' }
CAD2Editor class >> subcanvasAdButtonSpec [

	"UIPainter new openOnClass: self andSelector: #subcanvasAdButtonSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'freeCAD                                Advertise Your Logo Here'
	        #min: #( '#{VWQR:Core.Point}' 40 20 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           362 246 1002 726 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.InputFieldSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -32 1 300 0 0 1 )
	              #name: #selection #isOpaque: true #model: #selection
	              #isReadOnly: true )
	           #( '#{VWQR:UI.ArbitraryComponentSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.2 0 0 0 1 -33 1 )
	              #name: #cadView #flags: 11 #component: #cadView )
	           #( '#{VWQR:UI.TreeViewSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 0.2 -33 1 )
	              #name: #treeViewID #flags: 15 #model: #treeView
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #updateTreeModel:
	                 #doubleClickSelector: #doubleClick: )
	              #menu: #menuTreeView #useModifierKeys:
	              true #selectionType: #highlight #displayStringSelector:
	              #displayString #inPlaceEditedSelector:
	              #inPlaceEdit: )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 302 0 -32 1 0 1 0 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #'VisualWorks metadata' }
CAD2Editor class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'interface specs' }
CAD2Editor class >> windowSpec [

	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'freeCAD                                Advertise Your Logo Here'
	        #min: #( '#{VWQR:Core.Point}' 40 20 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           365 256 1005 736 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.InputFieldSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -32 1 300 0 0 1 )
	              #name: #selection #isOpaque: true #model: #selection
	              #isReadOnly: true )
	           #( '#{VWQR:UI.ArbitraryComponentSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.2 0 0 0 1 -33 1 )
	              #name: #cadView #flags: 11 #component: #cadView )
	           #( '#{VWQR:UI.TreeViewSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 0.2 -33 1 )
	              #name: #treeViewID #flags: 15 #model: #treeView
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #updateTreeModel:
	                 #doubleClickSelector: #doubleClick: )
	              #menu: #menuTreeView #useModifierKeys:
	              true #selectionType: #highlight #displayStringSelector:
	              #displayString #inPlaceEditedSelector:
	              #inPlaceEdit: )
	           #( '#{VWQR:UI.SubCanvasSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 302 0 -32 1 0 1 0 1 )
	              #name: #adButtonID #flags: 0 #majorKey: '#{VWQR:StCAD.Doc.AdButton}'
	              #minorKey: #windowSpec #clientKey: #adButton ) ) ) )
]

{ #category : #'interface specs' }
CAD2Editor class >> windowSpec1 [

	"UIPainter new openOnClass: self andSelector: #windowSpec1"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'freeCAD                                Advertise Your Logo Here'
	        #min: #( '#{VWQR:Core.Point}' 40 20 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           199 144 825 624 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.RegionSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 -1 0 -29 1 1 1 1 1 )
	              #name: #region #lineWidth: 1 )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 7 0 -27 1 300 0 0 1 )
	              #name: #selection #model: #selection #isReadOnly:
	              true )
	           #( '#{VWQR:UI.InputFieldSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 327 0 -27 1 472 0 -2 1 )
	              #name: #handleInfo #flags: 24 #model: #handle #style:
	              #systemDefault #isReadOnly: true )
	           #( '#{VWQR:UI.DividerSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -30 1 0 1 -26 1 )
	              #name: #divider1 )
	           #( '#{VWQR:UI.ArbitraryComponentSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.2 0 0 0 1 -30 1 )
	              #name: #cadView #flags: 11 #component: #cadView )
	           #( '#{VWQR:UI.LabelSpec}' #layout: #( '#{VWQR:Graphics.LayoutOrigin}'
	                 -140 1 -26 1 )
	              #isOpaque: true #colors: #( '#{VWQR:UI.LookPreferences}'
	                 #setBackgroundColor: #( #ColorValue #orange ) )
	              #label: 'Advertise Here' )
	           #( '#{VWQR:TreeViewSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 0.2 -30 1 )
	              #flags: 15 #model: #treeView #callbacksSpec:
	              #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #updateTreeModel:
	                 #doubleClickSelector: #doubleClick: )
	              #menu: #menuTreeView #useModifierKeys:
	              true #selectionType: #highlight #displayStringSelector:
	              #displayString #inPlaceEditedSelector:
	              #inPlaceEdit: ) ) ) )
]

{ #category : #'interface specs' }
CAD2Editor class >> windowSpec2 [

	"UIPainter new openOnClass: self andSelector: #windowSpec2"

	<resource: #canvas>
	^ #( '#{VWQR:UI.FullSpec}' #window: #( '#{VWQR:UI.WindowSpec}'
	        #label: 'freeCAD                                Advertise Your Logo Here'
	        #min: #( '#{VWQR:Core.Point}' 40 20 )
	        #bounds: #( '#{VWQR:Graphics.Rectangle}'
	           336 244 976 724 )
	        #flags: 4 #menu: #menuBar #isEventDriven: true )
	     #component: #( '#{VWQR:UI.SpecCollection}'
	        #collection: #( #( '#{VWQR:UI.InputFieldSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 -32 1 300 0 0 1 )
	              #name: #selection #isOpaque: true #model: #selection
	              #isReadOnly: true )
	           #( '#{VWQR:UI.ArbitraryComponentSpec}'
	              #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0.2 0 0 0 1 -32 1 )
	              #name: #cadView #flags: 11 #component: #cadView )
	           #( '#{VWQR:UI.TreeViewSpec}' #layout: #( '#{VWQR:Graphics.LayoutFrame}'
	                 0 0 0 0 0 0.2 -32 1 )
	              #name: #treeViewID #flags: 15 #model: #treeView
	              #callbacksSpec: #( '#{VWQR:UI.UIEventCallbackSubSpec}'
	                 #focusInSelector: #updateTreeModel:
	                 #doubleClickSelector: #doubleClick: )
	              #menu: #menuTreeView #useModifierKeys:
	              true #selectionType: #highlight #displayStringSelector:
	              #displayString #inPlaceEditedSelector:
	              #inPlaceEdit: )
	           #( '#{VWQR:UI.ActionButtonSpec}'
	              #layout: #( '#{VWQR:UI.AlignmentOrigin}'
	                 300 0 4 1 0 1 )
	              #name: #adxxxBy32ID #flags: 0 #model: #visitWebSite
	              #tabable: false #helpText: 'Click to Visit Web Site.'
	              #label: #adxxxBy32 #hasCharacterOrientedLabel:
	              false ) ) ) )
]

{ #category : #accessing }
CAD2Editor >> interfaceClass [
	^CADDrawingInterface.
]

{ #category : #menuExplain }
CAD2Editor >> menuExplainAboutPatch [

	| labelString text stop block start |
	labelString := 'Explain Patch          ' , AdData adTitle title.
	text := #'Copyright (C) 2001-2003, A-S Koh, All Rights Reserved.

The current patch being used is
patch83.zip

For the latest information, freeware downloads, patches, examples and open source of ''freeCAD'', visit:
http://www.askoh.com
'.
	text := text asText.
	stop := 1.
	block := [ :string :emphasis | 
	         start := text findString: string startingAt: stop.
	         stop := start + string size - 1.
	         text emphasizeFrom: start to: stop with: emphasis ].
	block value: 'patch83.zip' value: #( #bold #large ).
	block value: 'http://www.askoh.com' value: #( #bold #large ).
	StCAD_Doc_Editor openOn: text readOnly: true label: labelString "VW_TRANSLATION:StCAD.Doc.Editor:StCAD_Doc_Editor"
]

{ #category : #menuExplain }
CAD2Editor >> menuExplainAboutStCAD [
	| labelString |
	labelString := 'What is StCAD?'.
	self openExplainFile: 'StCADEditorMenuExplainAboutStCAD.sdoc' label: labelString
]

{ #category : #menuExplain }
CAD2Editor >> menuExplainAboutfreeCAD [
	| labelString |
	labelString := 'About freeCAD          By God''s Grace'.
	self openExplainFile: 'StCADEditorMenuExplainAboutfreeCAD.sdoc' label: labelString
]

{ #category : #menuExplain }
CAD2Editor >> menuExplainIntroduction [
	| labelString |
	labelString := 'What is freeCAD?'.
	self openExplainFile: 'StCADEditorMenuExplainIntroduction.sdoc' label: labelString
]

{ #category : #menuExplain }
CAD2Editor >> menuSponsorAshlarVellum [
	| appBuilder appWindow selfWindow |
	appBuilder := AdData openAshlarVellumText.
	appWindow := appBuilder window.
	builder notNil
		ifTrue: 
			[appWindow application: self.
			appWindow beSlave.
			selfWindow := builder window.
			selfWindow application: self.
			selfWindow beMaster]
]

{ #category : #menuExplain }
CAD2Editor >> menuSponsorCorporate [
	| labelString |
	labelString := 'Explain Corporate Sponsorship'.
	self openExplainFile: 'StCADEditorMenuSponsorCorporate.sdoc' label: labelString
]

{ #category : #menuExplain }
CAD2Editor >> menuSponsorIndividual [
	| labelString |
	labelString := 'Explain Individual Sponsorship'.
	self openExplainFile: 'StCADEditorMenuSponsorIndividual.sdoc' label: labelString
]

{ #category : #accessing }
CAD2Editor >> pclString [
	^'freecad*.pcl'
]

{ #category : #'initialize-release' }
CAD2Editor >> postBuildWith1: aBuilder [ 
	super postBuildWith: aBuilder.
	self treeView list root: GEOTreeNode new displayIt: true.
	self treeView selectionIndexHolder onChangeSend: #updateCadViewFromTreeView to: self.
	self interface
		when: #select
		ask: self
		perform: #updateTreeViewFromCadView
]

{ #category : #'initialize-release' }
CAD2Editor >> postBuildWith2: aBuilder [ 
	super postBuildWith: aBuilder.
	self treeView list root: GEOTreeNode new displayIt: true.
	(self widgetAt: #treeViewID) 
		when: #selectionChanged
		ask: self
		perform: #updateCadViewFromTreeView.
	self interface 
		when: #select
		ask: self
		perform: #updateTreeViewFromCadView
]

{ #category : #'menubar items' }
CAD2Editor >> stringPOVcam [
	^'// freeCAD: 3D CAD with Motion Simulation  by  askoh.com

camera {
  direction < 0, 0, -1>    //-1 = right hand rule. 1 = left hand rule.
  up    < 0, 1, 0>            //Do not change.
  right   < 4/3, 0, 0>         //Must equal Width/Height ratio of the image.'
]

{ #category : #accessing }
CAD2Editor >> title [
	^'freeCAD          Sponsor Message'
]
