#ifndef EDITLINE_IDRIS_H
#define EDITLINE_IDRIS_H

char *bl_readline (char *prompt);
void  bl_init ();
void  bl_add_dict_entry (char *str);
void  bl_read_history (char *filename);
void  bl_write_history (char *filename);

#endif
