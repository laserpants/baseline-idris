#define _BSD_SOURCE

#include <stdio.h>
#include <editline.h>    /* Include after stdio.h */
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include "editline_idris.h"

struct entry
{
    char         *str;
    struct entry *next;
};

struct entry *dict = NULL;
bool init_done = false;

static char *
complete (char *token, int *match)
{
    struct entry *current = dict;
    size_t len = strlen (token);
    char *result = NULL;
    int count = 0;

    while (NULL != current)
    {
        if (0 == strncmp (current->str, token, len))
        {
            result = current->str;
            ++count;
        }
        current = current->next;
    }

    if (1 == count)
    {
        *match = 1;
        return strdup (result + len);
    }

    return NULL;
}

static int
list_possible (char *token, char ***av)
{
    struct entry *current = dict;
    size_t len = strlen (token);
    int count = 0;

    *av = NULL;

    while (NULL != current)
    {
        if (0 == strncmp (current->str, token, len))
        {
            ++count;
            *av = realloc (*av, count * sizeof (char *));
            *(*av + count - 1) = strdup (current->str);
        }
        current = current->next;
    }

    return count;
}

char *
readline_gets (char *prompt)
{
    static char *input = NULL;

    if (false == init_done)
    {
        readline_init ();
        init_done = true;
    }

    if (NULL != input)
        free (input);

    input = readline (prompt);

    return input;
}

void 
readline_init ()
{
    rl_set_complete_func (&complete);
    rl_set_list_possib_func (&list_possible);
}

void
add_dict_entry (char *str)
{
    struct entry *entry = malloc (sizeof (struct entry));
    entry->str = strdup (str);
    entry->next = dict;
    dict = entry;
}
