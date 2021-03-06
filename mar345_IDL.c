/* File mar345_IDL.c
   This file is a thin wrapper layer which is called from IDL
   Mark Rivers
   March, 2006
*/

#ifdef _WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif

#include <stdio.h>
#include "mar3xx_pck.h"

EXPORT void mar345_IDL(int argc, char *argv[])
{
        char *filename =  (char *)argv[0];
        INT16 *data    = (INT16 *)argv[1];
        FILE *input;

        input = fopen(filename, "rb");
        if (input == NULL) {
           printf("Error opening input file %s\n", filename);
           return;
        }
	get_pck(input, data);
        fclose(input);
	return;
}

