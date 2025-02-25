%option nounput noinput

%{
#ifdef FLEXALONE 
  enum Return_Token_Values { ART=1000, NOM, VERBE, ADJ};
#else            
  #include "yyparse.h"  
#endif

#include "proto-color.h"
void echo(char *lex_cat) {
  fprintf(stdout,GREEN("[%s:%s]"), lex_cat, yytext); 
}

%}
%%
les?|la|une?	{ echo("ART");   return ART;  }
entreprise|PME	{ echo("NOM");   return NOM;  }
rachete		{ echo("VERBE"); return VERBE;}
grande?s? |
petite?s?	{ echo("ADJ");   return  ADJ; }
[.\n]		  return yytext[0];
" "		  ECHO;
.		  echo("UNK");
%%
int yywrap (void) {return 1;}
#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif
