#define _BSD_SOURCE

#include <stdio.h>
#include <editline.h>    /* Include after stdio.h */
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "editline_idris.h"

struct entry
{
    char         *str;
    struct entry *next;
};

static struct entry *dict = NULL;

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
    char **results = NULL;
    int count = 0;

    while (NULL != current)
    {
        if (0 == strncmp (current->str, token, len))
        {
            ++count;
            results = realloc (results, count * sizeof (char *));
            *(results + count - 1) = strdup (current->str);
        }
        current = current->next;
    }

    *av = results;

    return count;
}

char *
readline_gets (char *prompt)
{
    static char *input = NULL;

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
