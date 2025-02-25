struct _node {
  struct _node **fils; /*data structure */
  int degre;           /* Arite du noeud, managed in data structure */
  char *name;          /* Etiquette */
  // some printing stuff
  int height;  /* hauteur du noeud (feuille==0) */
  int hpos;    /* indentation pour impression horizontale */
               // feuilles = pas fixe, autres noeud = barycentre des fils
};

typedef struct _node node;
typedef node *arbre;

/* data structure    */
extern arbre new_arbre(const char *name, ...); 
    // utilisation varargs :  new_arbre("Non", f1 ,f2 ,..., NULL) 
    // avec fi de type arbre 
extern void free_arbre(arbre tree);

/* macros pratiques */
#define N(args...)  new_arbre(args, NULL)   // arg0 = const char *, argi = arbre //
#define F(name)  new_arbre((name), NULL)    // Feuille   == N(name)

/* Impressions Ligne (avec parentheses) */
extern void print_arbre_pre(arbre tree);       // impr. ligne : prefixe
extern void print_arbre_post(arbre tree);      // impr. ligne  :postixe
extern void print_arbre_inf(arbre tree);       // impr. lign  : infixe
extern void print_arbre_leaf(arbre tree);      // impr. ligne : leaf-only 

/* Impresions Verticales */
extern void print_arbre(arbre tree);     // impression verticale avec branche
extern void print_arbre_bis(arbre tree); // version simple sans branche

/* Impressions Horizontales */
#define MAX_LIGNE 255      /* largeur max ligne, troncage des depassements */
#define H_PRINT_TAB 7      /* espacement entre noeud en nb de char         */
#define H_PRINT_INDENT 1   /* indentation initial en nb de char            */
extern void print_arbre_prof(arbre tree);      /* impr. par profondeur avec de belles branches */
extern void print_arbre_height(arbre tree);    /* impr. par hauteur avec les feuilles en haut  */

/* */
extern void Recurse(arbre tree, void (*PreFonct) (arbre) , void (*PostFonct) (arbre));
extern void Recurse_prof(arbre tree, void (*PreFonct) (arbre), int prof);
extern void Recurse_height(arbre tree, void (*PreFonct) (arbre ), int height);



