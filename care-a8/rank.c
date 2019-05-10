void compute_ranks(float *F, int N, int *R, 
    float *avg, float *passing_avg, int *num_passed) {
    int i, j;
    // non pointer variables to reduce memory aliasaing
    int num_passed2 = 0;
    float avg2 = 0.0;
    float passing_avg2 = 0.0;
    // single loop for all calculations
    for (i = 0; i < N; i++) {
        R[i] = 1;
        for (j = 0; j < N-2; j+=2) { // unrolled
            if (F[i] < F[j]) {
                R[i] += 1;
            }
            if (F[i] < F[j+1]) {
                R[i] += 1;  
            }
        }
        for (; j < N; j++) {
            if (F[i] < F[j]) {
            R[i] += 1;
            }
        }
                avg2 += F[i];
        if (F[i] >= 50.0) {
            passing_avg2 += F[i];
            num_passed2 += 1;
        }   // no more aliasing
    }


    if (N > 0) avg2 /= N; // no more aliasing
    if (num_passed) passing_avg2 /= num_passed2;
    
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
