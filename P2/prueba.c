#define FILAS 3
#define COLUMNAS 3
int main(){
    char t[10];
    int i, j;
    for(i=0;i<FILAS;i++){
        for(j=0;j<COLUMNAS;j++){
            if(i==j){
                if(t[i+j]!= '1')
                    exit(0);
            }else{
                if(t[i+j]!= '0')
                    exit(0);
            }
        }
    }
    exit(0);
}