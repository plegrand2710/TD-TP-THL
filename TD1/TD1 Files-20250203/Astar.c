#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TAILLE_MAX 236

char *alphabet;
char result[TAILLE_MAX];

void recurse(int index, int Taille, int Card) {
  int i;
  if ( index == Taille ) {
    result[Taille]='\0';
    printf("%s\n",result);
  }
  else {
    for ( i = 0; i < Card; i++ ) {
      result[index] = alphabet[i];
      recurse( index + 1 ,Taille,Card);
    }
  }
}

int main(int argc, char **argv ){
  int C,N,i;
  if (argc!=3) {
    printf("Syntaxe :\n");
    printf("> Astar str N      #mots de taille =N \n");
    printf("> Astar str -N     #mots de taille <=N \n");
    printf("     et str = alphabet = string de char. ASCII\n");
    printf("Exemples:\n");
    printf("> Astar 01 13  => les nombres binaires de 13 bits\n");
    printf("> Astar abc -10  => les mots sur {a,b,c} de taille 1 a 10\n");
  } else {
    alphabet=argv[1];
    C=strlen(alphabet);
    N=atoi(argv[2]);
    if (N>TAILLE_MAX) {
      printf("Taille trop grande\n");
    } else {
      if (N<0) {
	for (i=1; i<=-N; i++) 
	  recurse(0, i, C);
      } else
	recurse(0, N, C);
    }
  }
}
