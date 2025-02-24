%{
extern int yylex(); 
#include <stdio.h>

// Fonction d'affichage des erreurs
int yyerror (char const *message) { 
  fprintf(stderr, "<%s>", message);
  return 0;
}
%}

%error-verbose

// Définition des catégories lexicales
%token WORD ART TRANS_VRB COMM_NOUN PROP_NOUN
%token '.' '\n'

%%

// Définition principale : liste de phrases
Text:
      /* Vide */
    | Text Ligne
    ;

// Ligne vide ou phrase complète
Ligne:
      '\n'  { printf("Ligne vide détectée\n"); }
    | Phrase '\n'  { printf("Phrase détectée\n"); }
    ;

// Définition d'une phrase correcte : Sujet Verbe Complément
Phrase:
      GroupeNom TRANS_VRB GroupeNom '.'
      { printf("Phrase complète : Sujet Verbe Complément.\n"); }
    ;

// Définition d'un groupe nominal (nom propre OU article + nom commun)
GroupeNom:
      PROP_NOUN
      { printf("Nom propre détecté\n"); }
    | ART COMM_NOUN
      { printf("Groupe nominal (Article + Nom commun) détecté\n"); }
    ;

%%

// Fonction principale
int main(void) {
  return yyparse();
}

