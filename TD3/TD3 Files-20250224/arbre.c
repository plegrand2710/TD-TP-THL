#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include "arbre.h"

#define MAX(a,b) (((a)>(b))?(a):(b))

arbre new_arbre(const char *name, ...) { //versions new_tree("Non", f1 ,f2 ,f3, NULL)
  arbre temp;                       
  int i;
  int n_args;
  va_list argp;

  temp = (arbre)malloc(sizeof(node));
  temp->name=strdup(name);
  temp->degre=0;
  temp->hpos=0;
  temp->height=0; 
  temp->fils=NULL;

  va_start(argp,name); n_args=0;
  while(va_arg(argp, arbre) != NULL) n_args++;
  va_end(argp);
  temp->degre=n_args;
  if (temp->degre !=0) {
    temp->fils=(arbre *) calloc(temp->degre, sizeof(arbre));
    va_start(argp,name);
    for(i=0; i<n_args; i++) {
      temp->fils[i]=va_arg(argp, arbre) ;
      temp->height=MAX(temp->fils[i]->height+1,temp->height);
    }
    va_end(argp);
  }
  return(temp);
}

// Traverse with Function as parameter
void Recurse(arbre tree, void (*PreFonct) (arbre) , void (*PostFonct) (arbre)) {
  int i;
    if (tree==NULL) return;
    if (PreFonct!=NULL) PreFonct(tree);
    for(i=0; i<tree->degre; i++)
      Recurse(tree->fils[i],PreFonct,PostFonct);
    if (PostFonct!=NULL) PostFonct(tree);
}

// Free
void free_arbre(arbre tree) {
  void free_node(arbre tree){
    free(tree->name);
    free(tree->fils);
    free(tree);
  }
  Recurse(tree,NULL, free_node);
}

/* impressions "classiques"  */
void print_arbre_bis(arbre tree) { /*impression verticale */
  void print_tree(arbre tree, int level) {
    int i;
    if (tree==NULL) return;
    for(i=0;i<level;i++) printf("   ");
    printf("%s (%d)\n", tree->name, tree->degre);
    for(i=0; i<tree->degre; i++)
      print_tree(tree->fils[i],level+1);
  }
  print_tree(tree,1);
}

void print_arbre(arbre tree) { /*avec les branches */
  char indent[256];
  void print_tree1(arbre tree, int level, int last) {
    int i;
    if (tree==NULL) return;
    indent[3*level]='\0';
    printf("%s|\n", indent);
    printf("%s", indent);
    if (last) {printf("\\--"); sprintf(indent,"%s   ",indent);}
    else {printf("|--"); sprintf(indent,"%s|  ",indent);}
    printf("%s (%d)\n", tree->name, tree->degre);
    for(i=0; i<tree->degre; i++)
      print_tree1(tree->fils[i],level+1,(i==(tree->degre-1)));
  }
  print_tree1(tree,0,1);
}


void print_arbre_pre(arbre tree) { /* prefixe */
  void pre(arbre tree){
    if (tree->degre !=0) printf(" (");
    printf(" %s", tree->name);
  }
  void post(arbre tree){
    if (tree->degre !=0) printf(" )");
  }
  Recurse(tree,pre,post);
}

void print_arbre_post(arbre tree) { /*postfixe */
  void pre(arbre tree){
    if (tree->degre !=0) printf(" (");
  }
  void post(arbre tree){
    printf(" %s", tree->name);
    if (tree->degre !=0) printf(" )");
  }
  Recurse(tree,pre,post);
}

void print_arbre_leaf(arbre tree) { /*feuille seule*/
  void pre(arbre tree){
    if (tree->degre ==0)  printf(" %s", tree->name);
  }
  Recurse(tree,pre,NULL);
}

void print_arbre_inf(arbre tree) { /*infixe */
  int i;
  if (tree==NULL) return;
  if (tree->degre !=0) { 
    printf(" (");
    print_arbre_inf(tree->fils[0]);
  }
  printf(" %s", tree->name);
  for(i=1; i<tree->degre; i++)
    print_arbre_inf(tree->fils[i]);
  if (tree->degre !=0)  printf(" )");
}

// Traversee a profondeur donné
// Evite optimasation avec queue pour parcours par niveau !!
void Recurse_prof(arbre tree, void (*PreFonct) (arbre ), int prof) {
  int i;
    if (tree==NULL) return;
    if (prof==0) {
      if (PreFonct!=NULL) PreFonct(tree);
      return;
    }
    for(i=0; i<tree->degre; i++)
      Recurse_prof(tree->fils[i],PreFonct,prof-1);
}

// impression horizontale
static void ComputeHpos(arbre tree) {  /* calcule indentations des noeuds (->hpos) before printing */
  /* H_PRINT_INDENT = indentation initiale en nb de char    */
  /* H_PRINT_TAB = espacement entre noeud en nb de char     */
  int indent=0;
  void set_pos(arbre tree) {
    int i,s;
    if (tree->degre ==0)
      tree->hpos=(H_PRINT_INDENT) + (H_PRINT_TAB) * indent++; 
    else  {
      for(i=0,s=0; i<tree->degre; i++) 
	s=s+tree->fils[i]->hpos;
      tree->hpos = s / tree->degre;
    }
  }
  Recurse(tree, NULL, set_pos);
}  

// horizontal printing, par profondeur
void print_arbre_prof(arbre tree) {
  char ligne[MAX_LIGNE+1];       /* one more for '\0' */
  void set_car(int i, char c) {
    if (i<MAX_LIGNE) ligne[i]=c; /* trunc out of line */
  }
  void reset_ligne() {
    int j;
    for (j=0; j<MAX_LIGNE; j++) set_car(j,' ');  /* ligne blanche */
  }
  void printf_ligne() {
    int j;
    for (j=MAX_LIGNE-1; (j>=0) && (ligne[j]==' '); j--) set_car(j,'\0'); /* ligne justifiée */
    ligne[MAX_LIGNE]='\0';
    printf("%s\n",ligne); 
  }
  int mode;
    /* generation d'une ligne impression avec les noeuds a profondeur prof
       mode==0, "node"            N1       
       mode==1, "veritical1"      |   
       mode==2, "horizontal"   ------- 
       mode==3, "vertical2"    |  |  | 
    */

  void print_node(arbre tree) { /* print 1 node in ligne */
    int i;
    switch (mode) {
    case 0: /* node */
      for(i=0; tree->name[i]!='\0'; i++)
	set_car(i+tree->hpos, tree->name[i]);
      break;
    case 1: /* vertical upper */
      if (tree->degre>0)
	set_car(tree->hpos,'|');
      break;
    case 2: /* horizontal branch */
      if (tree->degre>0){
	if (tree->degre==1) set_car(tree->fils[0]->hpos,'|');
	else
	  for(i=tree->fils[0]->hpos; i<tree->fils[tree->degre-1]->hpos+1; i++)
	    set_car(i,'-');
      }
      break;
    case 3: /* vertical lower */
      if (tree->degre>0)
	for(i=0; i<tree->degre; i++)
	  set_car(tree->fils[i]->hpos,'|');
      break;
    }
  }

  int i;
  if (tree==NULL) return;
  ComputeHpos(tree);
  for (i=0; i<tree->height+1; i++) { 
    mode=0; reset_ligne(); Recurse_prof(tree,print_node,i); printf_ligne();
    mode=1; reset_ligne(); Recurse_prof(tree,print_node,i); printf_ligne();
    mode=2; reset_ligne(); Recurse_prof(tree,print_node,i); printf_ligne();
    mode=3; reset_ligne(); Recurse_prof(tree,print_node,i); printf_ligne();
  }
}

// Traversee a hauteur donné
void Recurse_height(arbre tree, void (*PreFonct) (arbre ), int height) {
  int i;
    if (tree==NULL) return;
    if (tree->height==height) {
      if (PreFonct!=NULL) PreFonct(tree);
      return;
    }
    for(i=0; i<tree->degre; i++)
      Recurse_height(tree->fils[i],PreFonct,height);
}

// horizontal printing, par hauteur
void print_arbre_height(arbre tree) {
  char ligne[MAX_LIGNE+1]; /* one more for '\0' */
  void set_car(int i, char c) {
    if (i<MAX_LIGNE) ligne[i]=c; /* trunc out of line */
  }
  void reset_ligne() {
    int j;
    for (j=0; j<MAX_LIGNE; j++) set_car(j,' ');  /* ligne blanche */
  }
  void partial_reset_ligne() {
    int j;
    for (j=0; j<MAX_LIGNE; j++) if (ligne[j]!='|') set_car(j,' ');  /* ligne blanche */
  }
  void printf_ligne() {
    int j;
    for (j=MAX_LIGNE-1; (j>=0) && (ligne[j]==' '); j--) set_car(j,'\0'); /* ligne justifiée */
    ligne[MAX_LIGNE]='\0';
    printf("%s\n",ligne); 
  }
  int mode;
  /* generation d'une ligne impression avec les noeuds a meme auteur
     mode==2, "horizontal"   ------- |      
     mode==1, "vertical1"       |    |  ou 
     mode==0, "node"            N2   |       F1 F2
     mode==3, "veritical2"      |    |       |  |
  */
  void print_node(arbre tree) { /* print 1 node in ligne */
    int i;
    switch (mode) {
    case 0: /* node */
      for(i=0; tree->name[i]!='\0'; i++) 
	set_car(i+tree->hpos, tree->name[i]);
      break;
    case 1: /* vertical 1 */
      if (tree->degre>0) 
	set_car(tree->hpos,'|');
      break;
    case 2: /* horizontal branch */
      if (tree->degre>0){
	if (tree->degre==1) set_car(tree->fils[0]->hpos,'|');
	else
	  for(i=tree->fils[0]->hpos; i<tree->fils[tree->degre-1]->hpos+1; i++)
	    set_car(i,'-');
      }
      break;
    case 3: /* vertical 2 */
      set_car(tree->hpos,'|');
      break;
    }
  }

  int i;
  if (tree==NULL) return;
  ComputeHpos(tree);
  reset_ligne();
  for (i=0; i<tree->height+1; i++) { 
    mode=2; partial_reset_ligne(); Recurse_height(tree,print_node,i); printf_ligne();
    mode=1; partial_reset_ligne(); Recurse_height(tree,print_node,i); printf_ligne();
    mode=0; partial_reset_ligne(); Recurse_height(tree,print_node,i); printf_ligne();
    if (i<tree->height) { /* evite branche apres racine */
      mode=3; partial_reset_ligne(); Recurse_height(tree,print_node,i); printf_ligne();
    }
  }
}

#ifdef TESTING
static void test_arbre(){
  arbre arbre=NULL;

  void t1(){
  print_arbre(arbre); printf("\n");
  print_arbre_bis(arbre); printf("\n");
  print_arbre_pre(arbre); printf("\n");
  print_arbre_post(arbre); printf("\n");
  print_arbre_leaf(arbre); printf("\n");
  print_arbre_inf(arbre); printf("\n");
  printf("\n"); print_arbre_prof(arbre); printf("\n"); printf("\n");
  printf("\n"); print_arbre_height(arbre); printf("\n"); printf("\n");
  free_arbre(arbre); arbre=NULL;
  }    

  arbre=new_arbre("+",new_arbre("2",NULL),new_arbre("3",NULL),NULL);
  t1();
  arbre=NULL;
  t1();
  arbre=N("R*",N("R+",F("4"),N("+"), N("R*",N("2"),N("*"),N("1"))),N("*"),N("R*",N("2"),N("*"),N("1")));
  t1();
}

int main() { test_arbre(); return(0);}
#endif
