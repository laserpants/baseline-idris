#include "editline_idris.h"
#include <editline.h>
#include <stdlib.h>

char *
readline_gets (char *prompt)
{
    static char *input = NULL;

    if (NULL != input)
        free (input);

    input = readline (prompt);

    return input;
}
