/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: FiltLib
 * File: FDT_DINT.c
 * Author: passaglial
 * Created: September 08, 2010
 ********************************************************************
 * Implementation of library FiltLib
 ********************************************************************/

#include <bur/plctypes.h>
#include "FiltLib.h"
#include "Filtlib_defines.h"

/* Auxiliary functions */
static void fnInitFdtDint(struct FDT_DINT* inst);
static void fnCalcFdtDint(struct FDT_DINT* inst);

/*Generic Transfer function*/
void FDT_DINT(struct FDT_DINT* inst)
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
       fnInitFdtDint(inst);
    }

    /*** FB is enabled ***/

    if(inst->Error != 0)
    {
        inst->Busy = 1;
        inst->Valid = 0;
        return;
    }

    fnCalcFdtDint(inst);
        
    inst->Busy = 1;
    inst->Valid = 1;
    return;

}

static void fnInitFdtDint(struct FDT_DINT* inst)
{
    inst->u0 = (double)inst->U;
    inst->u1 = inst->u0;
    inst->x0 = inst->u0;
    inst->x1 = inst->u0;
    inst->U_old = (long signed int)inst->u0;
    return; 
}

static void fnCalcFdtDint(struct FDT_DINT* inst)
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

