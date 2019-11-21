/*
 * Code for class WEL_TCN_CONSTANTS
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"


#ifdef __cplusplus
extern "C" {
#endif

extern EIF_TYPED_VALUE F1052_10081(EIF_REFERENCE);
extern EIF_TYPED_VALUE F1052_10082(EIF_REFERENCE);
extern EIF_TYPED_VALUE F1052_10083(EIF_REFERENCE);
extern void EIF_Minit1052(void);

#ifdef __cplusplus
}
#endif

#include "cctrl.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {WEL_TCN_CONSTANTS}.tcn_keydown */
EIF_TYPED_VALUE F1052_10081 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "tcn_keydown";
	RTEX;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	RTLU (SK_INT32, &Result);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 1051, Current, 0, 0, 16428);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 1);
	RTDBGEAA(1051, Current, 16428);
	RTIV(Current, RTAL);
	Result = (EIF_INTEGER_32) TCN_KEYDOWN;
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(1);
	RTDBGLE;
	RTMD(1);
	RTLE;
	RTLO(2);
	RTEE;
	{ EIF_TYPED_VALUE r; r.type = SK_INT32; r.it_i4 = Result; return r; }
}

/* {WEL_TCN_CONSTANTS}.tcn_selchange */
EIF_TYPED_VALUE F1052_10082 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "tcn_selchange";
	RTEX;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	RTLU (SK_INT32, &Result);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 1051, Current, 0, 0, 16429);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 1);
	RTDBGEAA(1051, Current, 16429);
	RTIV(Current, RTAL);
	Result = (EIF_INTEGER_32) TCN_SELCHANGE;
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(1);
	RTDBGLE;
	RTMD(1);
	RTLE;
	RTLO(2);
	RTEE;
	{ EIF_TYPED_VALUE r; r.type = SK_INT32; r.it_i4 = Result; return r; }
}

/* {WEL_TCN_CONSTANTS}.tcn_selchanging */
EIF_TYPED_VALUE F1052_10083 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "tcn_selchanging";
	RTEX;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	RTLU (SK_INT32, &Result);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 1051, Current, 0, 0, 16430);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 1);
	RTDBGEAA(1051, Current, 16430);
	RTIV(Current, RTAL);
	Result = (EIF_INTEGER_32) TCN_SELCHANGING;
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(1);
	RTDBGLE;
	RTMD(1);
	RTLE;
	RTLO(2);
	RTEE;
	{ EIF_TYPED_VALUE r; r.type = SK_INT32; r.it_i4 = Result; return r; }
}

void EIF_Minit1052 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
