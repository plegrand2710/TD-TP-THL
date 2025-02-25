%option nounput noinput

 /* %array positionne le type de yytext en tableau de char               
    la copie du contenu de yytext est alors absolument necessaire.
    Dans ce cas, les modifs de yytext ne pose pas de pb comme par ex.
    unput()
 */

 /* le defaut est %pointeur, dans ce cas la on peut imaginer que
    les fragments successifs sont les uns a la suite des autres
    dans le meme buffer. le pointeur du premier token pourrait
    ainsi pointer toute la phrase. Ce comportement n'est toutefois
    spécifié nullle part et peut donc etre dependant de l'implementation
 */
 
%array

%{
#include "yyparse.h"  
  /* Version invalide avec %array, eventuellement utilisable avec %pointeur */
void putString()  {
  yylval.string = yytext;
}
 /* Version correct avec recopie, faudra faire un free a terme */
void putStringVal() {
  yylval.string = strdup(yytext);
}

%}

%%
\n    return yytext[0];
le|la {putStringVal(); return ART;}
chat|souris {putStringVal(); return NOM;}
attrape|mange {putStringVal(); return VERBE;}
.
%%

int yywrap (void) {return 1;}
#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif
