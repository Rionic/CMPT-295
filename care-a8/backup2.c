#include <string.h>
int BinSearch(float *array, int l, int r, float target){
    int mid = (r-l)/2+l;
    if (array[mid] == target)
        return mid+1;
    if (target > array[mid])
        return BinSearch(array,l,mid-1,target);
    return BinSearch(array,mid+1,r,target);
}
void QSort(float * array, int l, int r){
    if (l>r)
        return;
    int i = l;
    int j = r;
    float temp;
    int mid = (r-l)/2+l;
    float pivot = array[mid];
    while (i < j){
        while (array[i] > pivot)
            i++;
        while (array[j] < pivot)
            j--;
        if (i <= j){
            temp = array[i];
            array[i] = array[j];
            array[j] = temp;
            j--;
            i++;
        }
    }
    if (l < j) QSort(array, l, j);
    if (i < r) QSort(array, i, r);
}
void compute_ranks(float *F, int N, int *R, 
float *avg, float *passing_avg, int *num_passed){
   
    size_t size = sizeof(float)*N;
    float* tempArr = malloc(size);

    memcpy(tempArr, F, size);
    //non-pointer variables to reduce mem aliasing
    int num_passed2 = 0;
    float avg2 = 0.0;
    float passing_avg2 = 0.0;
    //scores will be in least to greatest order
    QSort(tempArr,0,N-1);
    //reduced the original 3 loops to 1
    //binary search finds index and uses it as rank
    for (int i = 0; i < N; i++) {
        R[i] = BinSearch(tempArr,0,N-1,F[i]);
        avg2 += F[i];
        if (F[i] >= 50.0) {       
            passing_avg2 += F[i]; //no aliasing
            num_passed2 += 1;     
        }
    }

    if (N > 0) avg2 /= N;   //no aliasing
    if (num_passed2) passing_avg2 /= num_passed2;
    //assigning values back
    *num_passed = num_passed2;
    *avg = avg2;
    *passing_avg = passing_avg2;
}

//            Name  Grade  Rank
//      ----------  -----  ----
//           Velia  73.41    9
//           Katia  40.68   29
//           Rosia  79.44    7
//          Lyndon  50.56   23
//          Salley  70.93   10
//         Quentin  63.15   15
//            Toni  69.08   13
//             Pok  44.53   27
//          Kenton  93.70    1
//          Adelia  83.53    6
//             Les  57.87   18
//          Reggie  45.29   26
//        Francene  56.46   20
//            Abel  68.39   14
//           Treva  73.53    8
//            Bert  70.03   11
//            Nila  90.78    2
//           Dayle  49.17   25
//           Tonie  87.11    4
//         Camelia  89.24    3
//           Elana  49.63   24
//          Vergie  56.79   19
//        Christel  85.70    5
//           Kirby  52.22   22
//        Leonardo  44.06   28
//         Tangela  56.07   21
//        Sharonda  58.99   16
//            Liza  69.27   12
//         Liliana  58.99   16
//         Cassidy  36.15   30

// Number who passed: 23/30
//   Passing average: 70.23
//   Overall average: 64.16
