%option nounput noinput

%{
#ifdef FLEXALONE 
  enum Return_Token_Values { GA=1000, BU, ZO, MEU};
#else            
  #include "yyparse.h"  
#endif

#include "proto-color.h"
void echo(char *lex_cat) {
  fprintf(stderr,GREEN("[%s:%s]"), lex_cat, yytext); 
}
void echonl() {
  fprintf(stderr,GREEN("[\\n]")"\n"); 
}
%}

%option case-insensitive

%%

Ga	{echo("GA"); return GA;}
Meu	{echo("MEU"); return MEU;}
Bu	{echo("BU"); return BU;}
Zo	{echo("ZO"); return ZO;}
\n	{echonl(); return yytext[0];}
.   	{ return yytext[0]; }

%%

int yywrap (void) {return 1;}
#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif

