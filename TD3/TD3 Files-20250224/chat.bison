%{
extern int yylex(); 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yyerror (char const *message) { 
  fprintf(stderr,"<%s>""\n", message);
  return 0;
}
%}

%error-verbose
%token  '\n'
%token  <string>ART NOM VERBE

%union {
  char *string;
}

%% 
Texte        :
             |  Texte    Phrase '\n'
             ;
Phrase       : ART  NOM  VERBE  ART  NOM 
              { printf("%s %s %s %s %s => PHRASE\n", $1, $2, $3, $4, $5); 
                free($1); free($2); free($3); free($4); free($5);
}
             ;
%%
int main(void) { return yyparse(); }
