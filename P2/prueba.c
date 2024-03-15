#define FILAS 3
#define COLUMNAS 3

int t[FILAS][COLUMNAS] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};
int i, j;

int main(){
    
    for(i=0;i<FILAS;i++){
        for(j=0;j<COLUMNAS;j++){
            if(i==j){
                if(t[i][j]!= 1)
                    return 0;
            }else{
                if(t[i][j]!= 0)
                    return 0;
            }
        }
    }
    return 0;
}