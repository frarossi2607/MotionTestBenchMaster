FUNCTION LftConAirPressSp
	VAR_PistonSurface 	:= amPI * (EXPT(CST_PistonDiameterExt, 2) - EXPT(CST_PistonDiameterInt, 2)) / 4.0;
	VAR_DeltaPProduct 	:= (EXPT(57.0, 2) - EXPT(RcpCanDiameter, 2)) * amPI / 4.0 * RcpPressureSp / 10.0;
	VAR_DeltaPrexPist  	:= (ABS(VAR_DeltaPProduct * 1000000.0 / VAR_PistonSurface / 100000.0)) * BOOL_TO_REAL((RcpCanDiameter > 57.0));
	VAR_PbasePiston 	:= CST_PistonSpringStrengthRse / (VAR_PistonSurface / 100.0) / 10;
	LftConAirPressSp	:= VAR_PbasePiston + VAR_DeltaPrexPist + 1.5;
END_FUNCTION