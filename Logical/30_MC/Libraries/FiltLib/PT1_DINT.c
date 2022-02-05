/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: FiltLib
 * File: PT1_DINT.c
 * Author: passaglial
 * Created: July 16, 2010
 ********************************************************************
 * Implementation of library FiltLib
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef __cplusplus
	extern "C"
	{
#endif

#include "FiltLib.h"
#include "Filtlib_defines.h"

#ifdef __cplusplus
	};
#endif


/* Auxiliary Functions */
static void fnInitPt1Dint(struct PT1_DINT* inst);
static void fnCalcPt1Dint(struct PT1_DINT* inst);


/*PT1 Filter for DINT source data*/
void PT1_DINT(struct PT1_DINT* inst)
{

    if(inst->Enable == 0) /* Not enabled? */
    {
        inst->Busy = 0;
        inst->Valid = 0;
        inst->Error = 0;
        inst->ErrorID = 0;
        inst->X = 0;
        return;
    }
    else if(inst->Busy == 0) /* Just enabled? */
    {
       inst->Busy = 1;
       fnInitPt1Dint(inst);
    }

    /*** FB is enabled ***/

    if(inst->Error != 0)
    {
        inst->Busy = 1;
        inst->Valid = 0;
        return;
    }

    fnCalcPt1Dint(inst);
        
    inst->Busy = 1;
    inst->Valid = 1;
    return;
}


static void fnInitPt1Dint(struct PT1_DINT* inst)
{
    RTInfo_typ rti;
    double alpha;

    rti.enable = 1;
    RTInfo(&rti);

    if(rti.status != ERR_OK)
    {
        inst->ErrorID = FLTLIB_ER_GET_TASKTIME;
        inst->Error = 1;
        return;
    }

    inst->Ts = (double)rti.cycle_time * 1E-6;

    if(inst->T1 < inst->Ts * 1.5)
    {
        inst->Error = 1;
        inst->ErrorID = FLTLIB_ER_T1_TOO_LOW ;
        return;
    }
    
    alpha = 2.0 * inst->T1 / inst->Ts;
    
    inst->b0 = 1 / (1 + alpha);
    inst->b1 = 1 / (1 + alpha);
    inst->a1 = (1 - alpha) / (1 + alpha);
    
    inst->u0 = (double)inst->U;
    inst->u1 = inst->u0;
    inst->x0 = inst->u0;
    inst->U_old = (long signed int)inst->u0;
    return;
}


static void fnCalcPt1Dint(struct PT1_DINT* inst)
{

    inst->u1 = inst->u0;
    inst->x1 = inst->x0;
    inst->u0 += (double)(inst->U - inst->U_old);
    inst->U_old = inst->U;
        
    inst->x0 = -(inst->a1 * inst->x1) + (inst->b0 * inst->u0) + (inst->b1 * inst->u1);

    if(inst->x0 > _MAX_DINT)
    {
        inst->x0 -= _RNG_DINT;
        inst->u0 -= _RNG_DINT;
        inst->u1 -= _RNG_DINT;        
        inst->x1 -= _RNG_DINT;
    }
    else if(inst->x0 < _MIN_DINT)
    {
        inst->x0 += _RNG_DINT;
        inst->u0 += _RNG_DINT;
        inst->u1 += _RNG_DINT;        
        inst->x1 += _RNG_DINT;        
    }
    
    inst->X =(signed long int)inst->x0;

    return;         
}
