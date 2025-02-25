struct sGNom {
  char *art;
  char *nom;
  char *adj;
};

struct sGNom * creerGNom( char *art, char *nom, char *adj ) {
  struct sGNom * gns;
  gns = malloc( sizeof( struct sGNom ) );
  gns->art = art;
  gns->nom = nom;
  gns->adj = adj;
  return gns;
}
