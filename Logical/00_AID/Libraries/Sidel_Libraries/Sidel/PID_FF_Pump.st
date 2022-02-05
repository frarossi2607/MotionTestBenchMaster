FUNCTION_BLOCK PID_FF_Pump
//Pressure Head = (Frequency * Frequency * Kf ) - (Kpc * Flow * Flow)
//To find Kf:
//1. Container Block
//2. Filler Empty with Filling Valves Closed
//3. Search for right Kf until FF = PID Out

//To Find Kpc:
//1. Filler at Max Speed
//2. Filler full of containers, filling containers
//3. Search for right Kpc until FF = PID Out

//                   /^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//Pump Frquency =  \/ ((Pressure Head) + Kpc * (Flow * Flow)) / Kf

//Pump Frequency [Hz]
//Pressure Head [mbar] --> mm
//Flow [m3/h]

IF NOT IN_Enable OR IN_Reset THEN
	OUT_FF	:= 0.0;
	RETURN;
END_IF

//Calculation of centrifugal force
//F_{cf}= m {\omega^2}{r} --> Omega is the Angular Velocity.
//Filler Angular Velocity
Omega := ((IN_Actual_Speed / IN_FV_Number) / (3600.0)) * 2.0 * 3.1415;

//Filler Radius
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	Radius := (IN_RingDiameter_mm / 2.0 / 1000.0);
ELSE
	Radius := 0.0;
END_IF

//Centrifugal Force [N], With Gravity Aceleration
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	CentrifugalForce := ((0.5 * Omega * Omega * Radius * Radius) / 9.81) * 1000.0;
ELSE
	CentrifugalForce := (((0.5 * Omega * Omega * Radius * Radius) / 9.81) * 1000.0)/100; //Convertion to mm of Product Pump In Ring Configuration
END_IF

IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	Level_SP_Calculated := IN_Actual_SPmm + IN_PTF_FromFloor + IN_PTF_FromFV - CentrifugalForce;	//[mm] Of Water From The Floor To The SP Product Pump
ELSE	
	Level_SP_Calculated := (IN_Actual_SPbar * 10197)- CentrifugalForce; // in test((IN_Actual_SPbar*1000) + IN_FV_FromFloor + 430 (*offset between fv and PTF on ring*)) - CentrifugalForce;	//[mm] Of Water From The Floor To The SP Product Pump In Ring Configuration
END_IF

IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	PV_Product_Pump:= (IN_Actual_PVmm + IN_PTF_FromFloor + IN_PTF_FromFV) - IN_TankLevel_mm; //[mm] Of Water From The Floor on The PV Product Pump -Used For Pump Autotuning
ELSE
	PV_Product_Pump:= ((IN_Actual_PVbar * 1000)+ IN_FV_FromFloor + 430) - IN_TankLevel_mm; //[mm] Of Water From The Floor on The PV Product Pump In Ring Configuration
END_IF

//Hz For Actual Flowrate
Kpc_FlowRate_Filling := IN_Pump_Kpc * EXPT(((IN_FMCActualFlowrate/ 10.0) * 60.0) / 1000.0 , 2); //FF Calc on Filling Valves OPENED From FMC

//Real Set Point 
Real_Level := Level_SP_Calculated - IN_TankLevel_mm;

//Calculated PV
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	Pid_PV_Calculated := (IN_Actual_PVmm + CentrifugalForce - IN_PTF_FromFV);
ELSE
	Pid_PV_Calculated := IN_Actual_PVbar;
END_IF

IF Pid_PV_Calculated > 0 THEN
	OUT_PID_PV := Pid_PV_Calculated;
ELSE
	OUT_PID_PV := 0.0;
END_IF

IF Pid_PV_Calculated > 0 THEN	
	IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
		OUT_PID_SP := IN_Actual_SPmm + IN_PTF_FromFV - CentrifugalForce;
	ELSE	
		OUT_PID_SP := IN_Actual_SPbar (*- (CentrifugalForce/1000)*);
	END_IF
ELSE
	OUT_PID_SP := 0.0;
END_IF

//Feed Forward Value for PID Control                                                    
IF SQRT((Kpc_FlowRate_Filling + Real_Level) / IN_Pump_Kf) >0 THEN 
	OUT_FF := LIMIT(0,SQRT((Kpc_FlowRate_Filling + Real_Level) / IN_Pump_Kf),IN_Pump_OutMax);
ELSE
	OUT_FF := 0.0;
END_IF
	
//Detecting Wrong Setting
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	OUT_Error := IN_RingDiameter_mm =0.0 OR IN_PTF_FromFloor=0.0 OR IN_PTF_FromFV=0.0 OR IN_Pump_Kf=0.0 OR IN_Pump_Kpc=0.0 OR IN_Pump_OutMax=0.0;
ELSE
	OUT_Error := IN_FV_FromFloor=0.0 OR IN_Pump_Kf=0.0 OR IN_Pump_Kpc=0.0 OR IN_Pump_OutMax=0.0;
END_IF
			
END_FUNCTION_BLOCK

FUNCTION_BLOCK PID_FF_PumpH
//Pressure Head = (Frequency * Frequency * Kf ) - (Kpc * Flow * Flow)
//To find Kf:
//1. Container Block
//2. Filler Empty with Filling Valves Closed
//3. Search for right Kf until FF = PID Out

//To Find Kpc:
//1. Filler at Max Speed
//2. Filler full of containers, filling containers
//3. Search for right Kpc until FF = PID Out

//                  /^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//Pump Frquency =  \/ ((Pressure Head) + Kpc * (Flow * Flow)) / Kf

//Pump Frequency [Hz]
//Pressure Head [mbar] --> mm
//Flow [m3/h]

IF NOT IN_Enable OR IN_Reset THEN
	OUT_FF	:= 0.0;
	RETURN;
END_IF

//Calculation of centrifugal force
//F_{cf}= m {\omega^2}{r} --> Omega is the Angular Velocity.
//Filler Angular Velocity
Omega := ((IN_Actual_Speed / IN_FV_Number) / (3600.0)) * 2.0 * 3.1415;

//Filler Radius
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	Radius := (IN_RingDiameter_mm / 2.0 / 1000.0);
ELSE
	Radius := 0.0;
END_IF

//Centrifugal Force [N], With Gravity Aceleration
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	CentrifugalForce := ((0.5 * Omega * Omega * Radius * Radius) / 9.81) * 1000.0;
ELSE
	CentrifugalForce := (((0.5 * Omega * Omega * Radius * Radius) / 9.81) * 1000.0)/100; //Convertion to mm of Product Pump In Ring Configuration
END_IF

//MAX Filling Time
MAX_FillingTime := (1000.0 / (IN_Recipe_Speed /3600.0)) * IN_FMCStepExitCam;

//Actual Filling Time
IF IN_FMCAverFillingTime >= 0 THEN
	Calculated_FillingTime := IN_FMCAverFillingTime;
ELSE  
	Calculated_FillingTime := IN_PumpMaxFillingTime;
END_IF

FillingTime := MIN(Calculated_FillingTime,MAX_FillingTime);

//MAX Containers Number Into Filling Zone (Used only to control the value from the FMC "ITC_FMC_Tot_FV_Actual_In_Filling")
MAX_ContainersNumber := ((IN_Recipe_Speed * FillingTime / 3600000.0) - IN_FMCStepStartFilling);

IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	Level_SP_Calculated := IN_Actual_SPmm + IN_PTF_FromFloor + IN_PTF_FromFV - CentrifugalForce;	//[mm] Of Water From The Floor To The SP Product Pump
ELSE	
	Level_SP_Calculated := ((IN_Actual_SPbar*1000)+ IN_FV_FromFloor + 430(*offset between fv and PTF on ring*)) - CentrifugalForce;	//[mm] Of Water From The Floor To The SP Product Pump In Ring Configuration
END_IF

IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
	PV_Product_Pump:= (IN_Actual_PVmm + IN_PTF_FromFloor + IN_PTF_FromFV) - IN_TankLevel_mm; //[mm] Of Water From The Floor on The PV Product Pump -Used For Pump Autotuning
ELSE
	PV_Product_Pump:= ((IN_Actual_PVbar *1000)+ IN_FV_FromFloor + 430) - IN_TankLevel_mm; //[mm] Of Water From The Floor on The PV Product Pump In Ring Configuration
END_IF

//Hz For Actual Flowrate
Kpc_FlowRate_Filling := IN_Pump_Kpc * EXPT(((IN_FMCActualFlowrate/ 10.0) * 60.0) / 1000.0 , 2); //FF Calc on Filling Valves OPENED From FMC

//Real Set Point 
Real_Level := Level_SP_Calculated - IN_TankLevel_mm;

//Centrifugal Force 
OUT_Centifrugal := CentrifugalForce;

//Feed Forward Value for PID Control                                                    
IF SQRT((Kpc_FlowRate_Filling + Real_Level) / IN_Pump_Kf) >0 THEN 
	OUT_FF := LIMIT(0,SQRT((Kpc_FlowRate_Filling + Real_Level) / IN_Pump_Kf),IN_Pump_OutMax);
ELSE
	OUT_FF := 0.0;
END_IF

//Detecting Wrong Setting
IF IN_Control_Type THEN //0=Control on Ring;1=Control on Product Pipe
OUT_Error := IN_RingDiameter_mm =0.0 OR IN_PTF_FromFloor=0.0 OR IN_PTF_FromFV=0.0 OR
			 IN_Pump_Kf=0.0 OR IN_Pump_Kpc=0.0 OR IN_Pump_OutMax=0.0 OR IN_FMCAverFillingTime=0.0 OR
			 IN_FMCStepStartFilling= 0.0 OR IN_FMCStepExitCam=0.0;
ELSE
	OUT_Error := IN_FV_FromFloor=0.0 OR IN_Pump_Kf=0.0 OR IN_Pump_Kpc=0.0 OR IN_Pump_OutMax=0.0;
END_IF
	
END_FUNCTION_BLOCK
