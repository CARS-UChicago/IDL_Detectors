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
        FILE *input, *debug;

        input = fopen(filename, "r");
        debug = fopen("mar345_debug.out", "w");
        if (input == NULL) {
           fprintf(debug, "Error opening input file %s\n", filename);
           goto done;
        }
	get_pck(input, data);
        fprintf(debug, "Read from file %s\n", filename);
        fprintf(debug, " data=%p, data[1000000]=%d\n", data, data[1000000]);
        done:
        fclose(input);
        fclose(debug);
	return;
}

