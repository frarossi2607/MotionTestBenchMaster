(*HMI_PAT_1 Initialization Action for Filler PLC*)
(*Author = ????*)
(*DB Version : 0.00*)
(*File Version : 3,17*)

ACTION HMI_PAT_1_Init :
        HMI_PAT_1._010 := 0;
        HMI_PAT_1._011 := 0;
        HMI_PAT_1._100 := 150;
        HMI_PAT_1._101 := 200;
        HMI_PAT_1._110 := 20;
        HMI_PAT_1._420 := 450;
        HMI_PAT_1._421 := 1000;
        HMI_PAT_1._422 := 200;
        HMI_PAT_1._423 := 7200;
        HMI_PAT_1._424 := 1800;
        HMI_PAT_1._425 := 20;
        HMI_PAT_1._426 := 600;
END_ACTION
