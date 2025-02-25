%option nounput noinput

%{
#ifdef FLEXALONE 
  enum Return_Token_Values { TOK=1000, POINTVIRGULE };
#else            
  #include "yyparse.h"  
#endif
#include "proto-color.h"

void echo(char *lex_cat) {
  if (strcmp(lex_cat, "NB") == 0) {
    fprintf(stderr, GREEN("[%s:%s]"), lex_cat, yytext);
  } else if (strcmp(lex_cat, "PV") == 0) {
    fprintf(stderr, RED("[%s:%s]"), lex_cat, yytext);
  } else {
    fprintf(stderr, "[%s:%s]", lex_cat, yytext);
  }
}

%}

%%

[a-z]*		{ echo("CAR"); return yytext[0];} 
[0-9]+          { echo("NB"); sscanf(yytext, "%d", &yylval); return TOK; }
[;]             { echo("PV"); return POINTVIRGULE; }
[ \t]+          ;  
\n              { return '\n'; }
.               { return yytext[0]; }

%%

int yywrap (void) {return 1;}
#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif

