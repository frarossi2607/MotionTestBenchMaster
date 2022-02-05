/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: FiltLib
 * File: PT2_DINT.c
 * Author: passaglial
 * Created: July 23, 2010
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

/* private structure */
struct _pt1_coe_str
{
    double a1;
    double b0;
    double b1;
};


/* Auxiliary Functions */
static void fnInitPt2Dint(struct PT2_DINT* inst);
static void fnCalcPt2Dint(struct PT2_DINT* inst);
static void fnCoeffPt1(struct _pt1_coe_str* coe, double Tf, double Ts);


/*PT2 Filter for DINT source data*/
void PT2_DINT(struct PT2_DINT* inst)
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
       fnInitPt2Dint(inst);
    }

    /*** FB is enabled ***/

    if(inst->Error != 0)
    {
        inst->Busy = 1;
        inst->Valid = 0;
        return;
    }

    fnCalcPt2Dint(inst);
        
    inst->Busy = 1;
    inst->Valid = 1;
    return;

}

static void fnInitPt2Dint(struct PT2_DINT* inst)
{
    RTInfo_typ rti;
    struct _pt1_coe_str f1, f2;

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
    else if(inst->T2 < inst->Ts * 1.5)
    {
        inst->Error = 1;
        inst->ErrorID = FLTLIB_ER_T2_TOO_LOW ;
        return;
    }
    
    fnCoeffPt1(&f1, inst->T1, inst->Ts);
    fnCoeffPt1(&f2, inst->T2, inst->Ts);

    inst->b0 =  f1.b0 * f2.b0;
    inst->b1 = (f1.b0 * f2.b1) + (f1.b1 * f2.b0);
    inst->b2 = (f1.b1 * f2.b1);
    inst->a1 =  f2.a1 + f1.a1;
    inst->a2 = (f1.a1 * f2.a1);

    inst->u0 = (double)inst->U;
    inst->u1 = inst->u0;
    inst->x0 = inst->u0;
    inst->x1 = inst->u0;
    inst->U_old = (long signed int)inst->u0;
    return; 
}

static void fnCoeffPt1(struct _pt1_coe_str* coe, double Tf, double Ts)
{
    double alpha;
    
    alpha = 2.0 * Tf / Ts;
    
    coe->b0 = 1 / (1 + alpha);
    coe->b1 = 1 / (1 + alpha);
    coe->a1 = (1 - alpha) / (1 + alpha);
    
    return;   
}


static void fnCalcPt2Dint(struct PT2_DINT* inst)
{
    
    inst->x2 = inst->x1;
    inst->x1 = inst->x0;
    inst->u2 = inst->u1;
    inst->u1 = inst->u0;
    inst->u0 += (double)(inst->U - inst->U_old);
    inst->U_old = inst->U;
        
    inst->x0 = -(inst->a1 * inst->x1) -(inst->a2 * inst->x2)
               +(inst->b0 * inst->u0) +(inst->b1 * inst->u1) +(inst->b2 * inst->u2);

    if(inst->x0 > _MAX_DINT)
    {
        inst->x0 -= _RNG_DINT;
        inst->x1 -= _RNG_DINT;
        inst->x2 -= _RNG_DINT;        
        inst->u0 -= _RNG_DINT;
        inst->u1 -= _RNG_DINT;
        inst->u2 -= _RNG_DINT;                        
    }
    else if(inst->x0 < _MIN_DINT)
    {
        inst->x0 += _RNG_DINT;
        inst->x1 += _RNG_DINT;        
        inst->x2 += _RNG_DINT;        
        inst->u0 += _RNG_DINT;
        inst->u1 += _RNG_DINT;
        inst->u2 += _RNG_DINT;                        
    }
    
    inst->X =(signed long int)inst->x0;
    return;
}



