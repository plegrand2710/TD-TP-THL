%option nounput noinput

%{
#ifdef FLEXALONE  /* Mode flex seul */
  #define ENTIER 1001
  #define FLOTTANT 1002
  #define F_MIN 1003
  #define F_MAX 1004
#else             /* couplage flex/bison */
  #include "symtab.h"
  #include "yyparse.h"  
#endif

#include "proto-color.h"
void echo(char *lex_cat) {
  //  fprintf(stderr,GREEN("[%s:%s]"), lex_cat, yytext); 
}
void echo1(char *lex_cat) {
    fprintf(stderr,RED("[%s:%s]"), lex_cat, yytext); 
}
void echonl() {
  // fprintf(stderr,GREEN("[\\n]")"\n"); 
}

void PutValEntier() {
   sscanf( yytext, "%d", &yylval.entier ); 
}

void PutValFlottant() {
   sscanf( yytext, "%f", &yylval.flottant ); 
}

void PutValSymbol() {
  symbol s=lookup(yytext);
  if (s!=NULL) yylval.symbol=s;
  else {
    yylval.symbol = new_symb(yytext);
    yylval.symbol->data_type=0; /* flag variable non initialisé */
    yylval.symbol->double_data=0.0;  /* valeur variable */
  }
}

%}

DIGIT [0-9]
%%
Min|min|MIN          { echo("F_min"); return(F_MIN); }
Max|max|MAX          { echo("F_max"); return(F_MAX); }
[A-Za-z][A-Za-z0-9]* { echo("VAR");    PutValSymbol(); return(VAR); }
{DIGIT}+	     { echo("ENTIER"); PutValEntier(); return(ENTIER); }
{DIGIT}+\.{DIGIT}* |
{DIGIT}*\.{DIGIT}+   { echo("REEL");   PutValFlottant(); return(FLOTTANT); }
[-+*/%()^]	     { echo("Tokens"); return yytext[0]; }
[=]	             { echo("Affect"); return yytext[0]; }
[,]	             { echo("ArgSep"); return yytext[0]; }
[ \t]                ;
\n		     { echonl();     return yytext[0];}
.		     { echo1("UNK"); return yytext[0];}
%%

int yywrap (void) {return 1;}

#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif
