#include <stdio.h>
#include <fun.h>

void function(void)
{
	printf("%s: test\n", __func__);
	printf("%s: fun.h var: %s\n", __func__, fun_string);
	printf("%s: test for 2\n", __func__);
}
