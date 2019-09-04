<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="17008000">
	<Property Name="SMProvider.SMVersion" Type="Int">201310</Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="SubVIs" Type="Folder">
			<Item Name="dataFGV.vi" Type="VI" URL="../SubVIs/dataFGV.vi"/>
			<Item Name="decomposeDataforGraph.vi" Type="VI" URL="../SubVIs/decomposeDataforGraph.vi"/>
			<Item Name="initListenFGV.vi" Type="VI" URL="../SubVIs/initListenFGV.vi"/>
			<Item Name="readDataIn.vi" Type="VI" URL="../SubVIs/readDataIn.vi"/>
			<Item Name="startStartStopFGV.vi" Type="VI" URL="../SubVIs/startStartStopFGV.vi"/>
			<Item Name="stateChange.vi" Type="VI" URL="../SubVIs/stateChange.vi"/>
			<Item Name="stopFGV.vi" Type="VI" URL="../SubVIs/stopFGV.vi"/>
			<Item Name="targetMet.vi" Type="VI" URL="../SubVIs/targetMet.vi"/>
			<Item Name="UDPListenFGV.vi" Type="VI" URL="../SubVIs/UDPListenFGV.vi"/>
			<Item Name="updateDataOut.vi" Type="VI" URL="../SubVIs/updateDataOut.vi"/>
		</Item>
		<Item Name="TypeDefs" Type="Folder">
			<Item Name="allData.ctl" Type="VI" URL="../TypeDefs/allData.ctl"/>
			<Item Name="basicFGVControl.ctl" Type="VI" URL="../TypeDefs/basicFGVControl.ctl"/>
			<Item Name="dataFGVState.ctl" Type="VI" URL="../TypeDefs/dataFGVState.ctl"/>
			<Item Name="dataIn.ctl" Type="VI" URL="../TypeDefs/dataIn.ctl"/>
			<Item Name="dataOut.ctl" Type="VI" URL="../TypeDefs/dataOut.ctl"/>
			<Item Name="starFGVControl.ctl" Type="VI" URL="../TypeDefs/starFGVControl.ctl"/>
			<Item Name="starState.ctl" Type="VI" URL="../TypeDefs/starState.ctl"/>
			<Item Name="UDPListenFGVCtrl.ctl" Type="VI" URL="../TypeDefs/UDPListenFGVCtrl.ctl"/>
			<Item Name="UDPLoopState.ctl" Type="VI" URL="../TypeDefs/UDPLoopState.ctl"/>
		</Item>
		<Item Name="MainHost.vi" Type="VI" URL="../MainHost.vi"/>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
