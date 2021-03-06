(*HMI_PAR_1 Database for Filler PLC*)
(*Author = UTERF*)
(*DB Version : 0.01*)
(*File Version : 2.99*)

TYPE
        HMI_PAR_1_Type:     STRUCT
                            _000 : REAL; (*General - Recipe Number *)
                            _001 : REAL; (*General - Container Size [ml]*)
                            _002 : REAL; (*General - Container Material *)
                            _003 : REAL; (*General - Product type for APCO *)
                            _004 : REAL; (*General - Centering Cup Pressure Control Coefficent *)
                            _005 : REAL; (*General - Doser Enabling *)
                            _006 : REAL; (*General - Nitro Doser Enabling *)
                            _007 : REAL; (*General - Spare *)
                            _008 : REAL; (*General - Spare *)
                            _009 : REAL; (*General - Head Rotation Direction *)
                            _010 : REAL; (*General - Closing Turret Type *)
                            _011 : REAL; (*General - Cap Type *)
                            _012 : REAL; (*General - Bottle PCO *)
                            _013 : REAL; (*General - Bottle Cooling Enabling *)
                            _014 : REAL; (*General - Neck Washing Enabling *)
                            _015 : REAL; (*General - Bottle Rinse Enabling *)
                            _016 : REAL; (*General - Valve Washing Enabling *)
                            _017 : REAL; (*General - Container Shower Enabling *)
                            _018 : REAL; (*General - Container Shower Opening *)
                            _019 : REAL; (*General - Spare *)
                            _020 : REAL; (*Speed - Max Size Speed [c/h]*)
                            _021 : REAL; (*Speed - Head Rotation Capper Max Speed [Hz]*)
                            _022 : REAL; (*Speed - Bottle Cooling Pump Set Point [l/min]*)
                            _023 : REAL; (*Speed - Head Rotation Speed [Hz]*)
                            _024 : REAL; (*Speed - Buffer Production Speed [Hz]*)
                            _025 : REAL; (*Speed - Buffer Emptying Speed [Hz]*)
                            _026 : REAL; (*Speed - Water Cooling Pump Speed [Hz]*)
                            _027 : REAL; (*Speed - Water Cooling Delta Temperatue For Antifreeze [�C]*)
                            _028 : REAL; (*Speed - Spare *)
                            _029 : REAL; (*Speed - Spare *)
                            _030 : REAL; (*Speed - Spare *)
                            _031 : REAL; (*Speed - Spare *)
                            _032 : REAL; (*Speed - Spare *)
                            _033 : REAL; (*Speed - Spare *)
                            _034 : REAL; (*Speed - Spare *)
                            _035 : REAL; (*Speed - Spare *)
                            _036 : REAL; (*Speed - Spare *)
                            _037 : REAL; (*Speed - Spare *)
                            _038 : REAL; (*Speed - Spare *)
                            _039 : REAL; (*Speed - Spare *)
                            _040 : REAL; (*Limit Value - Spare *)
                            _041 : REAL; (*Limit Value - Spare *)
                            _042 : REAL; (*Limit Value - Spare *)
                            _043 : REAL; (*Limit Value - Spare *)
                            _044 : REAL; (*Limit Value - Spare *)
                            _045 : REAL; (*Limit Value - Spare *)
                            _046 : REAL; (*Limit Value - Spare *)
                            _047 : REAL; (*Limit Value - Spare *)
                            _048 : REAL; (*Limit Value - Spare *)
                            _049 : REAL; (*Limit Value - Spare *)
                            _050 : REAL; (*Limit Value - Spare *)
                            _051 : REAL; (*Limit Value - Spare *)
                            _052 : REAL; (*Limit Value - Spare *)
                            _053 : REAL; (*Limit Value - Spare *)
                            _054 : REAL; (*Limit Value - Spare *)
                            _055 : REAL; (*Limit Value - Spare *)
                            _056 : REAL; (*Limit Value - Spare *)
                            _057 : REAL; (*Limit Value - Spare *)
                            _058 : REAL; (*Limit Value - Spare *)
                            _059 : REAL; (*Limit Value - Spare *)
                            _060 : REAL; (*Limit Value - Spare *)
                            _061 : REAL; (*Limit Value - Spare *)
                            _062 : REAL; (*Limit Value - Spare *)
                            _063 : REAL; (*Limit Value - Spare *)
                            _064 : REAL; (*Limit Value - Spare *)
                            _065 : REAL; (*Limit Value - Spare *)
                            _066 : REAL; (*Limit Value - Spare *)
                            _067 : REAL; (*Limit Value - Spare *)
                            _068 : REAL; (*Limit Value - Spare *)
                            _069 : REAL; (*Limit Value - Spare *)
                            _070 : REAL; (*Limit Value - Spare *)
                            _071 : REAL; (*Limit Value - Spare *)
                            _072 : REAL; (*Limit Value - Spare *)
                            _073 : REAL; (*Limit Value - Spare *)
                            _074 : REAL; (*Limit Value - Spare *)
                            _075 : REAL; (*Limit Value - Spare *)
                            _076 : REAL; (*Limit Value - Spare *)
                            _077 : REAL; (*Limit Value - Spare *)
                            _078 : REAL; (*Limit Value - Spare *)
                            _079 : REAL; (*Limit Value - Spare *)
                            _080 : REAL; (*Limit Value - Spare *)
                            _081 : REAL; (*Limit Value - Spare *)
                            _082 : REAL; (*Limit Value - Spare *)
                            _083 : REAL; (*Limit Value - Product Priming Into Container - Caps Release Disable *)
                            _084 : REAL; (*Limit Value - Product Priming Into Container - Crown Release Disable *)
                            _085 : REAL; (*Limit Value - Product Priming Into Container - Labeling Disable *)
                            _086 : REAL; (*Limit Value - Spare *)
                            _087 : REAL; (*Limit Value - Spare *)
                            _088 : REAL; (*Limit Value - Spare *)
                            _089 : REAL; (*Limit Value - Spare *)
                            _090 : REAL; (*Limit Value - Spare *)
                            _091 : REAL; (*Limit Value - Spare *)
                            _092 : REAL; (*Limit Value - Spare *)
                            _093 : REAL; (*Limit Value - Spare *)
                            _094 : REAL; (*Limit Value - Spare *)
                            _095 : REAL; (*Limit Value - Spare *)
                            _096 : REAL; (*Limit Value - Spare *)
                            _097 : REAL; (*Limit Value - Spare *)
                            _098 : REAL; (*Limit Value - Spare *)
                            _099 : REAL; (*Limit Value - Spare *)
                            _100 : REAL; (*Adjustment Height - Rinser position [mm]*)
                            _101 : REAL; (*Adjustment Height - Tank position [mm]*)
                            _102 : REAL; (*Adjustment Height - Cam position [mm]*)
                            _103 : REAL; (*Adjustment Height - Capper Position [mm]*)
                            _104 : REAL; (*Adjustment Height - Closing Unit Position [mm]*)
                            _105 : REAL; (*Adjustment Height - Inlet Camma Size position [mm]*)
                            _106 : REAL; (*Adjustment Height - Outlet Camma Size position [mm]*)
                            _107 : REAL; (*Adjustment Height - Rinsing Camma Size position [mm]*)
                            _108 : REAL; (*Adjustment Height - Spare *)
                            _109 : REAL; (*Adjustment Height - Spare *)
                            _110 : REAL; (*Adjustment Height - Spare *)
                            _111 : REAL; (*Adjustment Height - Closing Camma Size position [mm]*)
                            _112 : REAL; (*Adjustment Height - Spare *)
                            _113 : REAL; (*Adjustment Height - Spare *)
                            _114 : REAL; (*Adjustment Height - Spare *)
                            _115 : REAL; (*Adjustment Height - Spare *)
                            _116 : REAL; (*Adjustment Height - Outlet Conveyor Height [mm]*)
                            _117 : REAL; (*Adjustment Height - Outlet Conveyor Guide Size [mm]*)
                            _118 : REAL; (*Adjustment Height - Spare *)
                            _119 : REAL; (*Adjustment Height - Spare *)
                            _120 : REAL; (*AROL_Equatorque - Start Main Angle [�]*)
                            _121 : REAL; (*AROL_Equatorque - Down Main Angle [�]*)
                            _122 : REAL; (*AROL_Equatorque - Close Main Angle [�]*)
                            _123 : REAL; (*AROL_Equatorque - End Main Angle [�]*)
                            _124 : REAL; (*AROL_Equatorque - Lock Mode *)
                            _125 : REAL; (*AROL_Equatorque - Closure Torque [Nm]*)
                            _126 : REAL; (*AROL_Equatorque - Gearing Ratio *)
                            _127 : REAL; (*AROL_Equatorque - Slow Torque [Nm]*)
                            _128 : REAL; (*AROL_Equatorque - Gearing Holding [�]*)
                            _129 : REAL; (*AROL_Equatorque - Closure Speed [rpm]*)
                            _130 : REAL; (*AROL_Equatorque - Closing Aceleration [rot/s2]*)
                            _131 : REAL; (*AROL_Equatorque - Stop Factor Speed [%]*)
                            _132 : REAL; (*AROL_Equatorque - Blind Input Angle [�]*)
                            _133 : REAL; (*AROL_Equatorque - Torque Time [ms]*)
                            _134 : REAL; (*AROL_Equatorque - Unwrap Angle [�]*)
                            _135 : REAL; (*AROL_Equatorque - Unwrap Speed [rpm]*)
                            _136 : REAL; (*AROL_Equatorque - Unwrap Aceleration [rot/s2]*)
                            _137 : REAL; (*AROL_Equatorque - Unwrap Blind Main Angle [�]*)
                            _138 : REAL; (*AROL_Equatorque - Cap Turns [�]*)
                            _139 : REAL; (*AROL_Equatorque - Spare *)
                            _140 : REAL; (*AROL_Equatorque - Spare *)
                            _141 : REAL; (*AROL_Equatorque - Spare *)
                            _142 : REAL; (*AROL_Equatorque - Spare *)
                            _143 : REAL; (*AROL_Equatorque - Spare *)
                            _144 : REAL; (*AROL_Equatorque - Spare *)
                            _145 : REAL; (*AROL_Equatorque - Fault Enabling: No In Torque *)
                            _146 : REAL; (*AROL_Equatorque - Fault Enabling Bad Closure *)
                            _147 : REAL; (*AROL_Equatorque - Multi Body Option: Central Guide Position *)
                            _148 : REAL; (*AROL_Equatorque - Multi Body Option: Body Skate Position *)
                            _149 : REAL; (*AROL_Equatorque - Multi Body Option: Extract Skate Position *)
                            _150 : REAL; (*AROL_Equatorque - Spare *)
                            _151 : REAL; (*AROL_Equatorque - Spare *)
                            _152 : REAL; (*AROL_Equatorque - Spare *)
                            _153 : REAL; (*AROL_Equatorque - Spare *)
                            _154 : REAL; (*AROL_Equatorque - Spare *)
                            _155 : REAL; (*Zalkin Brushless - Closure Torque [Ncm]*)
                            _156 : REAL; (*Zalkin Brushless - Closure Torque Low Limit [Ncm]*)
                            _157 : REAL; (*Zalkin Brushless - Closure Torque High Limit [Ncm]*)
                            _158 : REAL; (*AROL_Equatorque - Spare *)
                            _159 : REAL; (*AROL_Equatorque - Spare *)
                            _160 : REAL; (*Inlet Conveyor - Inlet motor 1 speed adjustement [%]*)
                            _161 : REAL; (*Inlet Conveyor - Inlet motor 2 speed adjustement [%]*)
                            _162 : REAL; (*Outlet Conveyor - Outlet motor 1 speed adjustement [%]*)
                            _163 : REAL; (*Outlet Conveyor - Outlet motor 2 speed adjustement [%]*)
                            _164 : REAL; (*Rinser - Air treatment flow setpoint [Nm3/h]*)
                            _165 : REAL; (*Rinser - Low limit deviation air treatment flow setpoint (Warning) [Nm3/h]*)
                            _166 : REAL; (*Rinser - Low limit alrm air treatment flow setpoint (Alarm) [Nm3/h]*)
                            _167 : REAL; (*Rinser - Water treatment flow setpoint [l/min]*)
                            _168 : REAL; (*Rinser - Low limit deviation water treatment flow setpoint (Warning) [l/min]*)
                            _169 : REAL; (*Rinser - Low limit alrm water treatment flow setpoint (Alarm) [l/min]*)
                            _170 : REAL; (*Rinser - RinserTreatment Selection (0= Full, 1= Water, 2= Air) *)
                            _171 : REAL; (*Rinser - Rinser Control Selection (0= Continous, 1= Insercion) *)
                            _172 : REAL; (*SPARE - Spare *)
                            _173 : REAL; (*SPARE - Spare *)
                            _174 : REAL; (*SPARE - Spare *)
                            _175 : REAL; (*SPARE - Spare *)
                            _176 : REAL; (*SPARE - Spare *)
                            _177 : REAL; (*SPARE - Spare *)
                            _178 : REAL; (*SPARE - Spare *)
                            _179 : REAL; (*SPARE - Spare *)
                            _180 : REAL; (*AROL HRM - Head Rotation - Acceleration Ramp [rot/s2]*)
                            _181 : REAL; (*AROL HRM - Head Rotation - Deceleration Ramp [rot/s2]*)
                            _182 : REAL; (*AROL HRM - Head Rotation - Speed AT 0 Rpm [rpm]*)
                            _183 : REAL; (*AROL HRM - Head Rotation - Speed AT 5000 Rpm [rpm]*)
                            _184 : REAL; (*AROL HRM - Head Rotation - Speed AT 10000 Rpm [rpm]*)
                            _185 : REAL; (*AROL HRM - Head Rotation - Speed AT 15000 Rpm [rpm]*)
                            _186 : REAL; (*AROL HRM - Head Rotation - Speed AT 20000 Rpm [rpm]*)
                            _187 : REAL; (*AROL HRM - Head Rotation - Speed AT 25000 Rpm [rpm]*)
                            _188 : REAL; (*AROL HRM - Head Rotation - Speed AT 30000 Rpm [rpm]*)
                            _189 : REAL; (*AROL HRM - Head Rotation - Speed AT 35000 Rpm [rpm]*)
                            _190 : REAL; (*AROL HRM - Head Rotation - Speed AT 40000 Rpm [rpm]*)
                            _191 : REAL; (*AROL HRM - Head Rotation - Speed AT 45000 Rpm [rpm]*)
                            _192 : REAL; (*AROL HRM - Head Rotation - Speed AT 50000 Rpm [rpm]*)
                            _193 : REAL; (*AROL HRM - Head Rotation - Speed AT 55000 Rpm [rpm]*)
                            _194 : REAL; (*AROL HRM - Head Rotation - Speed AT 60000 Rpm [rpm]*)
                            _195 : REAL; (*AROL HRM - Head Rotation - Speed AT 65000 Rpm [rpm]*)
                            _196 : REAL; (*AROL HRM - Head Rotation - Speed AT 70000 Rpm [rpm]*)
                            _197 : REAL; (*AROL HRM - Head Rotation - Speed AT 75000 Rpm [rpm]*)
                            _198 : REAL; (*AROL HRM - Head Rotation - Speed AT 80000 Rpm [rpm]*)
                            _199 : REAL; (*AROL HRM - Head Rotation - Speed AT 85000 Rpm [rpm]*)
                            _200 : REAL; (*AROL HRM - Head Rotation - Speed AT 90000 Rpm [rpm]*)
                            _201 : REAL; (*AROL HRM - Head Rotation - Speed AT 95000 Rpm [rpm]*)
                            _202 : REAL; (*AROL HRM - Head Rotation - Speed AT 100000 Rpm [rpm]*)
                            _203 : REAL; (*AROL HRM - Head Rotation - Closing Mode [rpm]*)
                            _204 : REAL; (*AROL HRM - Head Rotation - JogSpeed [rpm]*)
                            _205 : REAL; (*AROL HRM - Head Rotation - JogAcc [rot/s2]*)
                            _206 : REAL; (*AROL HRM - Head Rotation - JogDec [rot/s2]*)
                            _207 : REAL; (*SPARE - Spare *)
                            _208 : REAL; (*SPARE - Spare *)
                            _209 : REAL; (*SPARE - Spare *)
                            _210 : REAL; (*SPARE - Spare *)
                            _211 : REAL; (*SPARE - Spare *)
                            _212 : REAL; (*SPARE - Spare *)
                            _213 : REAL; (*SPARE - Spare *)
                            _214 : REAL; (*SPARE - Spare *)
                            _215 : REAL; (*SPARE - Spare *)
                            _216 : REAL; (*SPARE - Spare *)
                            _217 : REAL; (*SPARE - Spare *)
                            _218 : REAL; (*SPARE - Spare *)
                            _219 : REAL; (*SPARE - Spare *)
                            _220 : REAL; (*SPARE - Spare *)
                            _221 : REAL; (*SPARE - Spare *)
                            _222 : REAL; (*SPARE - Spare *)
                            _223 : REAL; (*SPARE - Spare *)
                            _224 : REAL; (*SPARE - Spare *)
                            _225 : REAL; (*SPARE - Spare *)
                            _226 : REAL; (*SPARE - Spare *)
                            _227 : REAL; (*SPARE - Spare *)
                            _228 : REAL; (*SPARE - Spare *)
                            _229 : REAL; (*SPARE - Spare *)
                            _230 : REAL; (*SPARE - Spare *)
                            _231 : REAL; (*SPARE - Spare *)
                            _232 : REAL; (*SPARE - Spare *)
                            _233 : REAL; (*SPARE - Spare *)
                            _234 : REAL; (*SPARE - Spare *)
                            _235 : REAL; (*SPARE - Spare *)
                            _236 : REAL; (*SPARE - Spare *)
                            _237 : REAL; (*SPARE - Spare *)
                            _238 : REAL; (*SPARE - Spare *)
                            _239 : REAL; (*SPARE - Spare *)
                            _240 : REAL; (*SPARE - Spare *)
                            _241 : REAL; (*SPARE - Spare *)
                            _242 : REAL; (*SPARE - Spare *)
                            _243 : REAL; (*SPARE - Spare *)
                            _244 : REAL; (*SPARE - Spare *)
                            _245 : REAL; (*SPARE - Spare *)
                            _246 : REAL; (*SPARE - Spare *)
                            _247 : REAL; (*SPARE - Spare *)
                            _248 : REAL; (*SPARE - Spare *)
                            _249 : REAL; (*SPARE - Spare *)
                            _250 : REAL; (*SPARE - Spare *)
                            _251 : REAL; (*SPARE - Spare *)
                            _252 : REAL; (*SPARE - Spare *)
                            _253 : REAL; (*SPARE - Spare *)
                            _254 : REAL; (*SPARE - Spare *)
                            _255 : REAL; (*PID Product Recycle - Spare *)
                            _256 : REAL; (*SPARE - Spare *)
                            _257 : REAL; (*SPARE - Spare *)
                            _258 : REAL; (*SPARE - Spare *)
                            _259 : REAL; (*SPARE - Spare *)
                            _260 : REAL; (*SPARE - Spare *)
                            _261 : REAL; (*SPARE - Spare *)
                            _262 : REAL; (*SPARE - Spare *)
                            _263 : REAL; (*SPARE - Spare *)
                            _264 : REAL; (*SPARE - Spare *)
                            _265 : REAL; (*SPARE - Spare *)
                            _266 : REAL; (*SPARE - Spare *)
                            _267 : REAL; (*SPARE - Spare *)
                            _268 : REAL; (*SPARE - Spare *)
                            _269 : REAL; (*SPARE - Spare *)
                            _270 : REAL; (*SPARE - Spare *)
                            _271 : REAL; (*SPARE - Spare *)
                            _272 : REAL; (*SPARE - Spare *)
                            _273 : REAL; (*SPARE - Spare *)
                            _274 : REAL; (*SPARE - Spare *)
                            _275 : REAL; (*SPARE - Spare *)
                            _276 : REAL; (*SPARE - Spare *)
                            _277 : REAL; (*SPARE - Spare *)
                            _278 : REAL; (*SPARE - Spare *)
                            _279 : REAL; (*SPARE - Spare *)
                            _280 : REAL; (*SPARE - Spare *)
                            _281 : REAL; (*SPARE - Spare *)
                            _282 : REAL; (*SPARE - Spare *)
                            _283 : REAL; (*SPARE - Spare *)
                            _284 : REAL; (*SPARE - Spare *)
                            _285 : REAL; (*SPARE - Spare *)
                            _286 : REAL; (*SPARE - Spare *)
                            _287 : REAL; (*SPARE - Spare *)
                            _288 : REAL; (*SPARE - Spare *)
                            _289 : REAL; (*SPARE - Spare *)
                            _290 : REAL; (*SPARE - Spare *)
                            _291 : REAL; (*SPARE - Spare *)
                            _292 : REAL; (*SPARE - Spare *)
                            _293 : REAL; (*SPARE - Spare *)
                            _294 : REAL; (*SPARE - Spare *)
                            _295 : REAL; (*SPARE - Spare *)
                            _296 : REAL; (*SPARE - Spare *)
                            _297 : REAL; (*SPARE - Spare *)
                            _298 : REAL; (*SPARE - Spare *)
                            _299 : REAL; (*SPARE - Spare *)
                            _300 : REAL; (*SPARE - Spare *)
                            _301 : REAL; (*SPARE - Spare *)
                            _302 : REAL; (*SPARE - Spare *)
                            _303 : REAL; (*SPARE - Spare *)
                            _304 : REAL; (*SPARE - Spare *)
                            _305 : REAL; (*SPARE - Spare *)
                            _306 : REAL; (*SPARE - Spare *)
                            _307 : REAL; (*SPARE - Spare *)
                            _308 : REAL; (*SPARE - Spare *)
                            _309 : REAL; (*SPARE - Spare *)
                            _310 : REAL; (*SPARE - Spare *)
                            _311 : REAL; (*SPARE - Spare *)
                            _312 : REAL; (*SPARE - Spare *)
                            _313 : REAL; (*SPARE - Spare *)
                            _314 : REAL; (*SPARE - Spare *)
                            _315 : REAL; (*SPARE - Spare *)
                            _316 : REAL; (*SPARE - Spare *)
                            _317 : REAL; (*SPARE - Spare *)
                            _318 : REAL; (*SPARE - Spare *)
                            _319 : REAL; (*SPARE - Spare *)
                            _320 : REAL; (*SPARE - Spare *)
                            _321 : REAL; (*SPARE - Spare *)
                            _322 : REAL; (*SPARE - Spare *)
                            _323 : REAL; (*SPARE - Spare *)
                            _324 : REAL; (*SPARE - Spare *)
                            _325 : REAL; (*SPARE - Spare *)
                            _326 : REAL; (*SPARE - Spare *)
                            _327 : REAL; (*SPARE - Spare *)
                            _328 : REAL; (*SPARE - Spare *)
                            _329 : REAL; (*SPARE - Spare *)
                            _330 : REAL; (*SPARE - Spare *)
                            _331 : REAL; (*SPARE - Spare *)
                            _332 : REAL; (*SPARE - Spare *)
                            _333 : REAL; (*SPARE - Spare *)
                            _334 : REAL; (*SPARE - Spare *)
                            _335 : REAL; (*SPARE - Spare *)
                            _336 : REAL; (*SPARE - Spare *)
                            _337 : REAL; (*SPARE - Spare *)
                            _338 : REAL; (*SPARE - Spare *)
                            _339 : REAL; (*SPARE - Spare *)
                            _340 : REAL; (*SPARE - Spare *)
                            _341 : REAL; (*SPARE - Spare *)
                            _342 : REAL; (*SPARE - Spare *)
                            _343 : REAL; (*SPARE - Spare *)
                            _344 : REAL; (*SPARE - Spare *)
                            _345 : REAL; (*SPARE - Spare *)
                            _346 : REAL; (*SPARE - Spare *)
                            _347 : REAL; (*SPARE - Spare *)
                            _348 : REAL; (*SPARE - Spare *)
                            _349 : REAL; (*SPARE - Spare *)
                            _350 : REAL; (*SPARE - Spare *)
                            _351 : REAL; (*SPARE - Spare *)
                            _352 : REAL; (*SPARE - Spare *)
                            _353 : REAL; (*SPARE - Spare *)
                            _354 : REAL; (*SPARE - Spare *)
                            _355 : REAL; (*SPARE - Spare *)
                            _356 : REAL; (*SPARE - Spare *)
                            _357 : REAL; (*SPARE - Spare *)
                            _358 : REAL; (*SPARE - Spare *)
                            _359 : REAL; (*SPARE - Spare *)
                            _360 : REAL; (*SPARE - Spare *)
                            _361 : REAL; (*SPARE - Spare *)
                            _362 : REAL; (*SPARE - Spare *)
                            _363 : REAL; (*SPARE - Spare *)
                            _364 : REAL; (*SPARE - Spare *)
                            _365 : REAL; (*SPARE - Spare *)
                            _366 : REAL; (*SPARE - Spare *)
                            _367 : REAL; (*SPARE - Spare *)
                            _368 : REAL; (*SPARE - Spare *)
                            _369 : REAL; (*SPARE - Spare *)
                            _370 : REAL; (*SPARE - Spare *)
                            _371 : REAL; (*SPARE - Spare *)
                            _372 : REAL; (*SPARE - Spare *)
                            _373 : REAL; (*SPARE - Spare *)
                            _374 : REAL; (*SPARE - Spare *)
                            _375 : REAL; (*SPARE - Spare *)
                            _376 : REAL; (*SPARE - Spare *)
                            _377 : REAL; (*SPARE - Spare *)
                            _378 : REAL; (*SPARE - Spare *)
                            _379 : REAL; (*SPARE - Spare *)
                            _380 : REAL; (*SPARE - Spare *)
                            _381 : REAL; (*SPARE - Spare *)
                            _382 : REAL; (*SPARE - Spare *)
                            _383 : REAL; (*SPARE - Spare *)
                            _384 : REAL; (*SPARE - Spare *)
                            _385 : REAL; (*SPARE - Spare *)
                            _386 : REAL; (*SPARE - Spare *)
                            _387 : REAL; (*SPARE - Spare *)
                            _388 : REAL; (*SPARE - Spare *)
                            _389 : REAL; (*SPARE - Spare *)
                            _390 : REAL; (*SPARE - Spare *)
                            _391 : REAL; (*SPARE - Spare *)
                            _392 : REAL; (*SPARE - Spare *)
                            _393 : REAL; (*SPARE - Spare *)
                            _394 : REAL; (*SPARE - Spare *)
                            _395 : REAL; (*SPARE - Spare *)
                            _396 : REAL; (*SPARE - Spare *)
                            _397 : REAL; (*SPARE - Spare *)
                            _398 : REAL; (*SPARE - Spare *)
                            _399 : REAL; (*SPARE - Spare *)
                            _400 : REAL; (*SPARE - Spare *)
                            _401 : REAL; (*SPARE - Spare *)
                            _402 : REAL; (*SPARE - Spare *)
                            _403 : REAL; (*SPARE - Spare *)
                            _404 : REAL; (*SPARE - Spare *)
                            _405 : REAL; (*SPARE - Spare *)
                            _406 : REAL; (*SPARE - Spare *)
                            _407 : REAL; (*SPARE - Spare *)
                            _408 : REAL; (*SPARE - Spare *)
                            _409 : REAL; (*SPARE - Spare *)
                            _410 : REAL; (*SPARE - Spare *)
                            _411 : REAL; (*SPARE - Spare *)
                            _412 : REAL; (*SPARE - Spare *)
                            _413 : REAL; (*SPARE - Spare *)
                            _414 : REAL; (*SPARE - Spare *)
                            _415 : REAL; (*SPARE - Spare *)
                            _416 : REAL; (*SPARE - Spare *)
                            _417 : REAL; (*SPARE - Spare *)
                            _418 : REAL; (*SPARE - Spare *)
                            _419 : REAL; (*SPARE - Spare *)
                            _420 : REAL; (*PID Rinser - Set Point [%]*)
                            _421 : REAL; (*PID Rinser - Proportiona Gain *)
                            _422 : REAL; (*PID Rinser - Integral Time [s]*)
                            _423 : REAL; (*PID Rinser - Derivative Time [s]*)
                            _424 : REAL; (*PID Rinser - Feed Forward [%]*)
                            _425 : REAL; (*PID Rinser - Spare *)
                            _426 : REAL; (*PID Rinser - Spare *)
                            _427 : REAL; (*PID Rinser - Spare *)
                            _428 : REAL; (*PID Rinser - Spare *)
                            _429 : REAL; (*PID Rinser - Spare *)
                            _430 : REAL; (*SPARE - Spare *)
                            _431 : REAL; (*SPARE - Spare *)
                            _432 : REAL; (*SPARE - Spare *)
                            _433 : REAL; (*SPARE - Spare *)
                            _434 : REAL; (*SPARE - Spare *)
                            _435 : REAL; (*SPARE - Spare *)
                            _436 : REAL; (*SPARE - Spare *)
                            _437 : REAL; (*SPARE - Spare *)
                            _438 : REAL; (*SPARE - Spare *)
                            _439 : REAL; (*SPARE - Spare *)
                            _440 : REAL; (*SPARE - Spare *)
                            _441 : REAL; (*SPARE - Spare *)
                            _442 : REAL; (*SPARE - Spare *)
                            _443 : REAL; (*SPARE - Spare *)
                            _444 : REAL; (*SPARE - Spare *)
                            _445 : REAL; (*SPARE - Spare *)
                            _446 : REAL; (*SPARE - Spare *)
                            _447 : REAL; (*SPARE - Spare *)
                            _448 : REAL; (*SPARE - Spare *)
                            _449 : REAL; (*SPARE - Spare *)
                            _450 : REAL; (*SPARE - Spare *)
                            _451 : REAL; (*SPARE - Spare *)
                            _452 : REAL; (*SPARE - Spare *)
                            _453 : REAL; (*SPARE - Spare *)
                            _454 : REAL; (*SPARE - Spare *)
                            _455 : REAL; (*SPARE - Spare *)
                            _456 : REAL; (*SPARE - Spare *)
                            _457 : REAL; (*SPARE - Spare *)
                            _458 : REAL; (*SPARE - Spare *)
                            _459 : REAL; (*SPARE - Spare *)
                            _460 : REAL; (*SPARE - Spare *)
                            _461 : REAL; (*SPARE - Spare *)
                            _462 : REAL; (*SPARE - Spare *)
                            _463 : REAL; (*SPARE - Spare *)
                            _464 : REAL; (*SPARE - Spare *)
                            _465 : REAL; (*SPARE - Spare *)
                            _466 : REAL; (*SPARE - Spare *)
                            _467 : REAL; (*SPARE - Spare *)
                            _468 : REAL; (*SPARE - Spare *)
                            _469 : REAL; (*SPARE - Spare *)
                            _470 : REAL; (*SPARE - Spare *)
                            _471 : REAL; (*SPARE - Spare *)
                            _472 : REAL; (*SPARE - Spare *)
                            _473 : REAL; (*SPARE - Spare *)
                            _474 : REAL; (*SPARE - Spare *)
                            _475 : REAL; (*SPARE - Spare *)
                            _476 : REAL; (*SPARE - Spare *)
                            _477 : REAL; (*SPARE - Spare *)
                            _478 : REAL; (*SPARE - Spare *)
                            _479 : REAL; (*SPARE - Spare *)
                            _480 : REAL; (*SPARE - Spare *)
                            _481 : REAL; (*SPARE - Spare *)
                            _482 : REAL; (*SPARE - Spare *)
                            _483 : REAL; (*SPARE - Spare *)
                            _484 : REAL; (*SPARE - Spare *)
                            _485 : REAL; (*SPARE - Spare *)
                            _486 : REAL; (*SPARE - Spare *)
                            _487 : REAL; (*SPARE - Spare *)
                            _488 : REAL; (*SPARE - Spare *)
                            _489 : REAL; (*SPARE - Spare *)
                            _490 : REAL; (*SPARE - Spare *)
                            _491 : REAL; (*SPARE - Spare *)
                            _492 : REAL; (*SPARE - Spare *)
                            _493 : REAL; (*SPARE - Spare *)
                            _494 : REAL; (*SPARE - Spare *)
                            _495 : REAL; (*SPARE - Spare *)
                            _496 : REAL; (*SPARE - Spare *)
                            _497 : REAL; (*SPARE - Spare *)
                            _498 : REAL; (*SPARE - Spare *)
                            _499 : REAL; (*HMI - Reserved For Recipe Coherence *)
        END_STRUCT;
END_TYPE
