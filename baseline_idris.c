#define _BSD_SOURCE

#include <stdio.h>
#include <editline.h>    /* Include after stdio.h */
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include "baseline_idris.h"

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
    const size_t len = strlen (token);
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
    const size_t len = strlen (token);
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
bl_readline (char *prompt)
{
    static char *input = NULL;

    if (false == init_done)
        bl_init ();

    if (NULL != input)
        free (input);

    input = readline (prompt);

    return input;
}

void
bl_init ()
{
    if (true == init_done)
        return;

    rl_set_complete_func (&complete);
    rl_set_list_possib_func (&list_possible);

    init_done = true;
}

void
bl_add_dict_entry (char *str)
{
    struct entry *entry = malloc (sizeof (struct entry));
    entry->str = strdup (str);
    entry->next = dict;
    dict = entry;
}

void
bl_read_history (char *filename)
{
    read_history (filename);
}

void
bl_write_history (char *filename)
{
    write_history (filename);
}
