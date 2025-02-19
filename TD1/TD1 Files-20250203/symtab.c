/*  Implementation table de symbol "generique"  */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symtab.h"

#define HSIZE       127
static symbol Htab[HSIZE];
static int hash(char *str) {
  char c;
  int h=0;
  while((c=*str++)!='\0') h=(9*h) ^ c;
  return(h%HSIZE);
}

void init_symtab(){ /* free and init active table */
  free_symtab();
}

void free_symtab(){
  int i;
  void free_entry(symbol s){
    if (s==NULL) return;
    if (s->next !=NULL) free_entry(s->next);
    free(s->data);
    free(s->symb);
    free(s);
  }
  for(i=0;i<HSIZE;i++) {
    free_entry(Htab[i]);
    Htab[i]=NULL;
  }
}

symbol lookup( char *symb ) {
  symbol s;
  for (s=Htab[hash(symb)]; (s!=NULL) && strcmp(symb,s->symb); s=s->next) ;
  return(s);
}

symbol new_symb(char *symb) {
  /* si symbol existe recreation en tete (et ecrasement de fait)*/
  symbol s;  
  s = (symbol) malloc( sizeof(stab) );
  s->symb = strdup(symb);
  s->data=NULL;
  s->next = Htab[hash(symb)];
  Htab[hash(symb)] = s;
  return(s);
}  

symbol add_symb( char *symb){
  /* retun existing or create new */
  symbol s;
  
  s=lookup(symb);
  if (s!=NULL) return(s);
  else return(new_symb(symb));
}
 
symbol set_symb( char *symb, char *data ){
  symbol s;
   
  s=lookup(symb);
  if (s!=NULL) 
    s->data = strdup(data);
  return(s);
}
 
void print_entry(symbol s){
  if (s!=NULL) printf("Entry %s : %s\n",s->symb,s->data);
  else printf("No entry\n");
}

void dump_stab(){
  int i;
  stab *s;
  printf("Dump :\n");
  for(i=0;i<HSIZE;i++)
    for(s=Htab[i]; s!=NULL; s=s->next)
      print_entry(s);
}

#ifdef TESTING
static void test_stab(){
  stab *s;
  s=lookup("foo");
  print_entry(s);
  dump_stab();
  s=new_symb("foo");
  print_entry(s);
  s=set_symb("foo","data_foo");
  print_entry(s);
  s=lookup("foo");
  print_entry(s);
  new_symb("Foo");
  s=set_symb("Foo","data_Foo");
  print_entry(s);
  s=new_symb("foo");
  print_entry(s);
  s=lookup("XXX");
  print_entry(s);
  dump_stab();
}

int main() { test_stab(); return(0);}
#endif

