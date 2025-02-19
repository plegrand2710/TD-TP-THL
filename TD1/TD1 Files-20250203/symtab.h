/*  Implementation table de symbol "generique"  */
/*  NB: On considere une portée unique des symboles
    dans la pratique les symboles ont une portée gérée 
    par une chaine (ou pile) de table de symbole...
*/

struct _stab {
  struct _stab    *next;    /* data struct */
  char          *symb;      /* symbol */
  char          *data;      /* open data, strdup and free managed */
  /* user data , unmanaged */
  int           data_type;       
  char          *char_data;
  int           int_data;
  double        double_data;
  int           lineno,charno;
};

typedef struct _stab stab;
typedef stab *symbol;

/* data structure */
extern void init_symtab(); /*==free_symtab()*/
extern void free_symtab();
extern symbol lookup(char *symb);
extern symbol new_symb(char *symb);
      /* si symbol exist deja : recreation et annulation de fait de l'ancien */
extern symbol add_symb(char *symb);
      /* si symbol existe deja : rien */
extern symbol set_symb(char *symb, char *data);
      /* affectation données, strdup end free managed */

/* printing */
extern void print_symb(symbol s);
extern void dump_stab();
