Class {
	#name : #ForceTorqueGeneralDialog,
	#superclass : #ArrayedFunctionDialog,
	#category : #'StCAD-UI-CADDialog'
}

{ #category : #resources }
ForceTorqueGeneralDialog class >> menuBar [

	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^ #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	           #rawLabel: 'Explain' #nameKey: #menuExplainID
	           #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                    #rawLabel: 'All' #nameKey: #menuExplainAllID
	                    #value: #menuExplainAll ) )
	              #( 1 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Function' #nameKey:
	           #menuFunctionID #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Intrinsic'
	                    #nameKey: #menuFunctionIntrinsicID )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Displacement'
	                    #nameKey: #menuFunctionDisplacementID )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Velocity'
	                    #nameKey: #menuFunctionVelocityID )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'ForceTorque'
	                    #enabled: false #nameKey: #menuFunctionForceTorqueID
	                    #hidden: true ) )
	              #( 4 ) nil ) )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Variable' #nameKey:
	           #menuVariableID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'GeoIJ' #nameKey:
	           #menuGeoIJID )
	        #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Example' #nameKey:
	           #menuExampleID #submenu: #( '#{VWQR:UI.Menu}'
	              #( #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Explain'
	                    #nameKey: #menuExampleExplainID
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Time' #value: #menuExampleExplainTime )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'SpringDamper' #value:
	                             #menuExampleExplainSpringDamper )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Bushing' #value: #menuExampleExplainBushing )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Beam' #value: #menuExampleExplainBeam )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'Aerodynamic' #value: #menuExampleExplainAerodynamic ) )
	                       #( 5 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Time' #nameKey:
	                    #menuExampleTimeID )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'SpringDamper'
	                    #nameKey: #menuExampleSpringDamperID
	                    #submenu: #( '#{VWQR:UI.Menu}' #( #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'ForceZ' #nameKey: #menuExampleSpringDamperForceZID )
	                          #( '#{VWQR:UI.MenuItem}'
	                             #rawLabel: 'TorqueZ' #nameKey: #menuExampleSpringDamperTorqueZID ) )
	                       #( 2 ) nil ) )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Bushing'
	                    #nameKey: #menuExampleBushingID )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Beam' #nameKey:
	                    #menuExampleBeamID )
	                 #( '#{VWQR:UI.MenuItem}' #rawLabel: 'Aerodynamic'
	                    #nameKey: #menuExampleAerodynamicID ) )
	              #( 6 ) nil ) ) )
	     #( 5 ) nil ) decodeAsLiteralArray
]

{ #category : #'VisualWorks metadata' }
ForceTorqueGeneralDialog class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
ForceTorqueGeneralDialog >> dialogTitle [
	^'Force Torque Functions'
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> getBlock1 [
	^
	[:cadModel | 
	| aFIeKei |
	aFIeKei := cadModel value aFIeKe at: 1.
	self units: aFIeKei units.
	aFIeKei funcText]
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> getBlock2 [
	^
	[:cadModel | 
	| aFIeKei |
	aFIeKei := cadModel value aFIeKe at: 2.
	self units: aFIeKei units.
	aFIeKei funcText]
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> getBlock3 [
	^
	[:cadModel | 
	| aFIeKei |
	aFIeKei := cadModel value aFIeKe at: 3.
	self units: aFIeKei units.
	aFIeKei funcText]
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> getBlock4 [
	^
	[:cadModel | 
	| aTIeKei |
	aTIeKei := cadModel value aTIeKe at: 1.
	self units: aTIeKei units.
	aTIeKei funcText]
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> getBlock5 [
	^
	[:cadModel | 
	| aTIeKei |
	aTIeKei := cadModel value aTIeKe at: 2.
	self units: aTIeKei units.
	aTIeKei funcText]
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> getBlock6 [
	^
	[:cadModel | 
	| aTIeKei |
	aTIeKei := cadModel value aTIeKe at: 3.
	self units: aTIeKei units.
	aTIeKei funcText]
]

{ #category : #'initialize-release' }
ForceTorqueGeneralDialog >> initialize [
	| block |
	super initialize.
	editFunction := nil asValue.
	block := 
			[:getSymbol | 
			| plugAdap |
			plugAdap := PluggableAdaptor on: cadItem.
			plugAdap
				getBlock: (self perform: getSymbol)
				putBlock: [:model :value | ]
				updateBlock: [:model :aspect :parameter | false].
			BufferedValueHolder subject: plugAdap triggerChannel: bufferTrigger].
	function1 := block value: #getBlock1.
	function2 := block value: #getBlock2.
	function3 := block value: #getBlock3.
	function4 := block value: #getBlock4.
	function5 := block value: #getBlock5.
	function6 := block value: #getBlock6.
	markerk := self bufferedAdaptorFor: #markerK
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuBar [
	| menu |
	menu := self class menuBar.
	(menu atNameKey: #menuFunctionIntrinsicID)
		submenu: [self menuFunction: #intrinsicFunctions].
	(menu atNameKey: #menuFunctionDisplacementID)
		submenu: [self menuFunction: #displacementFunctions].
	(menu atNameKey: #menuFunctionVelocityID)
		submenu: [self menuFunction: #velocityFunctions].
	(menu atNameKey: #menuVariableID)
		submenu: [self menuVariable].
	(menu atNameKey: #menuGeoIJID)
		submenu: [self menuGeoIJ].
	(menu atNameKey: #menuExampleTimeID)
		submenu: [self menuExample: #menuExampleTime].
	(menu atNameKey: #menuExampleSpringDamperForceZID)
		submenu: [self menuExample: #menuExampleSpringDamperForceZ].
	(menu atNameKey: #menuExampleSpringDamperTorqueZID)
		submenu: [self menuExample: #menuExampleSpringDamperTorqueZ].
	(menu atNameKey: #menuExampleBushingID)
		submenu: [self menuExample: #menuExampleBushing].
	(menu atNameKey: #menuExampleBeamID)
		submenu: [self menuExample: #menuExampleBeam].
	(menu atNameKey: #menuExampleAerodynamicID)
		submenu: [self menuExample: #menuExampleAerodynamic].
	^menu
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleAerodynamic [
	| examples |
	examples := OrderedCollection new.
	examples add: #Fx -> 'CD*vIJKi(self, I, 1)*vIJ(self)'.
	examples add: #Fy -> 'CD*vIJKi(self, I, 2)*vIJ(self)'.
	examples add: #Fz -> 'CD*vIJKi(self, I, 3)*vIJ(self)'.
	^examples
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleBeam [
	| examples |
	examples := OrderedCollection new.
	examples add: #Fx -> '(12*E*IYY/L^3)*rIJKi(self, I, 1) + (-6*E*IYY/L^2)*dAngleIJy(self)'.
	examples add: #Fy -> '(12*E*IXX/L^3)*rIJKi(self, I, 2) + (6*E*IXX/L^2)*dAngleIJx(self)'.
	examples add: #Fz -> '(E*A/L)*(rIJKi(self, I, 3) - L)'.
	examples add: #Tx -> '(6*E*IXX/L^2)*rIJKi(self, I, 2) + (4*E*IXX/L)*dAngleIJx(self)'.
	examples add: #Ty -> '(-6*E*IYY/L^2)*rIJKi(self, I, 1) + (4*E*IYY/L)*dAngleIJy(self)'.
	examples add: #Tz -> '(G*JZZ/L)*angleIJz(self)'.
	^examples
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleBushing [
	| examples |
	examples := OrderedCollection new.
	examples add: #Fx -> 'FX0 + KX*rIJKi(self, I, 1) + CX*vIJKi(self, I, 1)'.
	examples add: #Fy -> 'FY0 + KY*rIJKi(self, I, 2) + CY*vIJKi(self, I, 2)'.
	examples add: #Fz -> 'FZ0 + KZ*rIJKi(self, I, 3) + CZ*vIJKi(self, I, 3)'.
	examples add: #Tx -> 'TX0 + KTX*dAngleIJx(self) + CTX*omeIJKi(self, I, 1)'.
	examples add: #Ty -> 'TY0 + KTY*dAngleIJy(self) + CTY*omeIJKi(self, I, 2)'.
	examples add: #Tz -> 'TZ0 + KTZ*angleIJz(self) + CTZ*omeIJKi(self, I, 3)'.
	^examples
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleExplainAerodynamic [
	| labelString |
	labelString := 'Explain Aerodynamic Example'.
	self openExplainFile: 'StCADForceTorqueGeneralDialogMenuExampleExplainAerodynamic.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleExplainBeam [
	| labelString |
	labelString := 'Explain Beam Example'.
	self openExplainFile: 'StCADForceTorqueGeneralDialogMenuExampleExplainBeam.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleExplainBushing [
	| labelString |
	labelString := 'Explain Bushing Example'.
	self openExplainFile: 'StCADForceTorqueGeneralDialogMenuExampleExplainBushing.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleExplainSpringDamper [
	| labelString |
	labelString := 'Explain SpringDamper Example'.
	self openExplainFile: 'StCADForceTorqueGeneralDialogMenuExampleExplainSpringDamper.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleSpringDamperForceZ [
	| examples |
	examples := OrderedCollection new.
	examples add: #linear -> 'F0 + K*(rIJKi(self, I, 3) - L0) + C*vIJKi(self, I, 3)'.
	examples add: #hardening -> 'K*(rIJKi(self, I, 3) - L0) + EPSILON*(rIJKi(self, I, 3) - L0)^3 + C*vIJKi(self, I, 3)'.
	examples add: #softening -> 'FMAX*arctan((K/FMAX)*(rIJKi(self, I, 3) - L0)) + C*vIJKi(self, I, 3)'.
	examples add: #'van der Pol' -> '(rIJKi(self, I, 3) - L0) - EPSILON*(1.0d - (rIJKi(self, I, 3) - L0)^2)*vIJKi(self, I, 3)'.
	^examples
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExampleSpringDamperTorqueZ [
	| examples |
	examples := OrderedCollection new.
	examples add: #linear -> 'T0 + KT*(angleIJz(self) - A0) + CT*omeIJKi(self, I, 3)'.
	examples add: #hardening -> 'KT*(angleIJz(self) - A0) + EPSILON*(angleIJz(self) - A0)^3 + CT*omeIJKi(self, I, 3)'.
	examples add: #softening -> 'TMAX*arctan((KT/TMAX)*(angleIJz(self) - A0)) + CT*omeIJKi(self, I, 3)'.
	examples add: #'van der Pol' -> '(angleIJz(self) - A0) - EPSILON*(1.0d - (angleIJz(self) - A0)^2)*omeIJKi(self, I, 3)'.
	^examples
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> menuExplainAll [
	| labelString |
	labelString := 'Explain General ForceTorque Dialog'.
	self openExplainFile: 'StCADForceTorqueGeneralDialogMenuExplainAll.sdoc' label: labelString
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> radioLabel1 [
	^'Fx on I'
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> radioLabel2 [
	^'Fy on I'
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> radioLabel3 [
	^'Fz on I'
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> radioLabel4 [
	^'Tx on I'
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> radioLabel5 [
	^'Ty on I'
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> radioLabel6 [
	^'Tz on I'
]

{ #category : #private }
ForceTorqueGeneralDialog >> updateDomainObjects [
	| symbol block text |
	(symbol := editFunction value) notNil ifTrue: [(self perform: symbol)
			value: self eqnTextValue].
	block := [:func :unitSymbol | ((text := func value) notNil and: [text isEmpty not])
				ifTrue: [BasicUserFunction
						with: text
						myUnit: (units perform: unitSymbol)
						units: units]
				ifFalse: [nil]].
	cadItem value aFIeKe: (FullColumn
			with: (block value: function1 value: #force)
			with: (block value: function2 value: #force)
			with: (block value: function3 value: #force)).
	cadItem value aTIeKe: (FullColumn
			with: (block value: function4 value: #torque)
			with: (block value: function5 value: #torque)
			with: (block value: function6 value: #torque)).
	cadItem value markerK: markerk value
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> userFunction [
	| myUnit |
	myUnit := editFunction value last < $4
				ifTrue: [units force]
				ifFalse: [units torque].
	^BasicUserFunction
		with: self eqnTextValue
		myUnit: myUnit
		units: units
]

{ #category : #accessing }
ForceTorqueGeneralDialog >> userInputLabel [
	^'Enter force or torque components in SI units'
]
