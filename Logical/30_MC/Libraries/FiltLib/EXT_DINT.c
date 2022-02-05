/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: FiltLib
 * File: EXT_DINT.c
 * Author: passaglial
 * Created: August 29, 2012
 ********************************************************************
 * Implementation of library FiltLib
 ********************************************************************/

#include <bur/plctypes.h>
#include <math.h>
#ifdef __cplusplus
	extern "C"
	{
#endif

	#include "FiltLib.h"
    #include "Filtlib_defines.h"

#ifdef __cplusplus
	};
#endif

/* Auxiliary functions */
static void fnInitExtDint(struct EXT_DINT* inst);
static void fnCalcExtDint(struct EXT_DINT* inst);
static void fnCoeffExt(struct EXT_DINT* inst);

/* Extrapolator filter */
void EXT_DINT(struct EXT_DINT* inst)
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
        fnInitExtDint(inst);
    }

    /*** FB is enabled ***/

    if(inst->Error != 0)
    {
        inst->Busy = 1;
        inst->Valid = 0;
        return;
    }

    fnCalcExtDint(inst);
        
    inst->Busy = 1;
    inst->Valid = 1;
    return;
}

static void fnInitExtDint(struct EXT_DINT* inst)
{
    RTInfo_typ rti;

    rti.enable = 1;
    RTInfo(&rti);

    if(rti.status != ERR_OK)
    {
        inst->ErrorID = FLTLIB_ER_GET_TASKTIME;
        inst->Error = 1;
        return;
    }

    inst->Ts = (double)rti.cycle_time * 1E-6;

    if(inst->T_ext < 1.5 * inst->Ts)
    {
        inst->Error = 1;
        inst->ErrorID = FLTLIB_ER_EXT_TIME_TOO_LOW;
        return;
    }

    fnCoeffExt(inst);

    inst->u0 = (double)inst->U;
    inst->u1 = inst->u0;
    inst->x0 = inst->u0;
    inst->x1 = inst->u0;
    inst->U_old = (long signed int)inst->u0;
    return; 
}

static void fnCoeffExt(struct EXT_DINT* inst)
{
    /* Temporary variables */   
    double k, h, alpha, Tz1, Tz2, Tp, a0, m1, m2, q1, q2, r, rr;
    
    /* Initizlization  */
    k = 4;

    /* Zero at highest frequency */
    Tz2 = k * inst->Ts;

    /* alpha comptation (distance between singularities) */
    h = sqrt(Tz2 / inst->T_ext);
    alpha = h / (h + 1);

    /* Poles and Zeros for continuos time Transfer function */
    Tp  = Tz2 / alpha;
    Tz1 = Tz2 / (alpha * alpha);    

    /* Auxiliary parameters */
    m1 = Tz1 + Tz2;
    m2 = Tz1 * Tz2;
    q1 = 2 * Tp;
    q2 = Tp * Tp;
    r = 2 / inst->Ts;
    rr = r * r;
    
    /* Coefficients for discrete time transfer function */
    a0 = 1 + r*q1 + rr*q2;
    inst->a1 = (2 - 2*rr*q2) / a0;
    inst->a2 = (1 - r*q1 + rr*q2) / a0;
    inst->b0 = (1 + r*m1 + rr*m2) / a0;
    inst->b1 = (2 - 2*rr*m2) / a0;
    inst->b2 = (1 - r*m1 + rr*m2) / a0;    

    return;
}


static void fnCalcExtDint(struct EXT_DINT* inst)
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

