#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "fnvlib/fnv.h"

static int
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(char *name, int len, int arg)
{
    errno = 0;
    if (0 + 7 >= len ) {
	errno = EINVAL;
	return 0;
    }
    switch (name[0 + 7]) {
    case 'A':
	if (strEQ(name + 0, "FNV1_32A_INIT")) {	/*  removed */
#ifdef FNV1_32A_INIT
	    return FNV1_32A_INIT;
#else
	    goto not_there;
#endif
	}
    case '_':
	if (strEQ(name + 0, "FNV1_32_INIT")) {	/*  removed */
#ifdef FNV1_32_INIT
	    return FNV1_32_INIT;
#else
	    goto not_there;
#endif
	}
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


MODULE = Digest::FNV		PACKAGE = Digest::FNV		


double
constant(sv,arg)
    PREINIT:
	STRLEN		len;
    INPUT:
	SV *		sv
	char *		s = SvPV(sv, len);
	int		arg
    CODE:
	RETVAL = constant(s,len,arg);
    OUTPUT:
	RETVAL

Fnv32_t
fnv(sv)
        SV *        sv
    PROTOTYPE: $
    CODE:
        RETVAL = fnv_32_str(SvPV_nolen(sv), FNV1_32_INIT);
    OUTPUT:
        RETVAL

