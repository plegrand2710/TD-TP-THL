%option nounput noinput

%{
#ifdef FLEXALONE  
  enum Return_Token_Values { WORD=1000};
#else             
  #include "yyparse.h"  
#endif

#include "proto-color.h"
void echo(char *lex_cat) {
  fprintf(stderr,GREEN("[%s:%s]"), lex_cat, yytext); 
}
void echo1(char *lex_cat) {
  fprintf(stderr,RED("[%s:%s]"), lex_cat, yytext); 
}
void echonl() {
  fprintf(stderr,GREEN("[\\n]")"\n"); 
}
%}

%%
\n		echonl(); return(yytext[0]);
\.		echo("DOT"); return(yytext[0]);
[[:alpha:]]*	echo("WORD"); return(WORD);
[ ]             ;
.               echo1("UNK");
%%

int yywrap (void) {return 1;}
#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif
