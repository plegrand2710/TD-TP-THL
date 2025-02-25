#include <stdio.h>
 

int id (int a) {
    fprintf(stderr,"ID=%d",a);
    return a;
}
int somme(int a, int b) { return a + b; }
 
int main() {
    int a;
    a=1; printf(" -(++a*++a) =  %d\n", -(++a*++a)); 
    a=1; printf(" (-++a)*++a =  %d\n", (-++a)*++a); 
    a=1; printf(" -++a*++a   =  %d\n", -++a*++a);

    /* Ordre evalition des arguments indeterminé en C */ 
    a=1; printf(" somme(++a,a)  %d\n",somme(++a,a));
    a=1; printf(" somme(a,++a)  %d\n",somme(a,++a));
    a=1; printf(" somme(id(a),id(++a))  %d\n",somme(id(a),id(++a)));
    a=1; printf(" somme(id(++a),id(a))  %d\n",somme(id(++a),id(a)));
    /* !?! */
    return 0;
}
