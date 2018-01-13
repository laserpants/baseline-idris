#define _BSD_SOURCE

#include <stdio.h>
#include <editline.h>    /* Include after stdio.h */
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "editline_idris.h"

char *
readline_gets (char *prompt)
{
    static char *input = NULL;

    if (NULL != input)
        free (input);

    input = readline (prompt);

    return input;
}
