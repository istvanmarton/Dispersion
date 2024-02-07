//g++ CTMC_RKPD_SCR_OMP_CPP_GDD.cpp -fopenmp -o CTMC_RKPD_SCR_OMP_CPP_GDD -lgsl -lgslcblas -lm
#include<omp.h>
#include<dirent.h>
#include <unistd.h>
#include<iostream>
#include<new>
#include<cstring>
#include<string>

#include<cstdio>
#include<cmath>
#include<cstdlib>
#include<ctime>
#include<cstdarg>
#include<gsl/gsl_errno.h>
#include<gsl/gsl_spline.h>
#include<gsl/gsl_math.h>
#include<vector>
#include<fstream>
#define M_PI 3.14159265358979323846

const int electron_x = 0;
const int electron_y = 1;
const int electron_z = 2;
const int electron_vx = 3;
const int electron_vy = 4;
const int electron_vz = 5;

const long double dVector_kszi0[] = {0, 1, 2.625, 2.164, 1.3, 1.031, 1.065, 1.179, 1.36, 1.508, 1.792, 1.712, 1.492, 1.17, 1.012, 0.954, 0.926, 0.933, 0.957, 0.964, 0.941, 0.95, 0.998, 1.061, 1.138, 1.207, 1.308, 1.397, 1.455, 1.52, 1.538, 1.541, 1.512, 1.492, 1.46, 1.407, 1.351, 1.286, 0, 1.129, 0, 1.139, 1.136, 0, 1.197, 0, 1.246, 0, 1.205, 0, 1.13, 0, 1.05, 0, 1.044};
const long double dVector_kszi1[] = {0, 1, 1.2996, 0.9764, 0.6465, 0.4924, 0.48, 0.4677, 0.4613, 0.4602, 0.4515, 0.3923, 0.3452, 0.3191, 0.2933, 0.2659, 0.2478, 0.2368, 0.2165, 0.2151, 0.2248, 0.2324, 0.2345, 0.2243, 0.2291, 0.2408, 0.2391, 0.2462, 0.2397, 0.2246, 0.2106, 0.1988, 0.1914, 0.199, 0.1857, 0.1897, 0.1872, 0.1686, 0, 0.1784, 0, 0.1702, 0.1694, 0, 0.1601, 0, 0.1587, 0, 0.1358, 0, 0.1395, 0, 0.1354, 0, 0.1107};
const long double dVector_eta0[] = {0, 1, 1.77, 1.75, 1.88, 2, 2.13, 2.27, 2.41, 2.59, 2.71, 2.85, 3.01, 3.17, 3.26, 3.33, 3.392, 3.447, 3.5, 3.516, 3.57, 3.627, 3.667, 3.709, 3.745, 3.803, 3.84, 3.891, 3.973, 4, 4.05, 4.11, 4.182, 4.23, 4.29, 4.369, 4.418, 4.494, 0, 4.618, 0, 4.68, 4.749, 0, 4.769, 0, 4.829, 0, 4.904, 0, 4.99, 0, 5.05, 0, 5.101};
const long double dVector_eta1[] = {0, 1, 1.1402, 0.6821, 0.5547, 0.4939, 0.4434, 0.4143, 0.3925, 0.3755, 0.3671, 0.3469, 0.3269, 0.3087, 0.2958, 0.2857, 0.2739, 0.2633, 0.256, 0.2509, 0.2404, 0.2328, 0.2238, 0.2171, 0.2187, 0.209, 0.2088, 0.2048, 0.1925, 0.1985, 0.1878, 0.2001, 0.1897, 0.1782, 0.1772, 0.1686, 0.1611, 0.1619, 0, 0.1509, 0, 0.1485, 0.1412, 0, 0.1435, 0, 0.1397, 0, 0.1414, 0, 0.1324, 0, 0.1314, 0, 0.1316};
const long double dBinding_energy_of_elements[36][36] = {
{13.59843449, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //H
{24.58738880, 54.4177650, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //He
{5.39171495, 75.6400964, 122.4543581, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Li
{9.322699, 18.21115, 153.896203, 217.7185843, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Be
{8.298019, 25.15483, 37.93058, 259.3715, 340.226020, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //B
{11.2602880, 24.383154, 47.88778, 64.49352, 392.090515, 489.993194, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //C
{14.53413, 29.60125, 47.4453,  77.4735, 97.8901, 552.06732, 667.046116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //N
{13.618055, 35.12112, 54.93554, 77.41350, 113.8990, 138.1189, 739.32682, 871.40988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //O
{17.42282, 34.97081,  62.70798, 87.175, 114.249, 157.16311, 185.1868, 953.89804, 1103.11747,0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //F
{21.564540, 40.96297, 63.4233, 97.1900, 126.247, 157.934, 207.271, 239.0970, 1195.80783, 1362.19915, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Ne
{ 5.1390769,  47.28636, 71.6200, 98.936,  138.404, 172.23, 208.504, 264.192, 299.856, 1465.13449, 1648.70218, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Na
{7.646236, 15.035271, 80.1436, 109.2654, 141.33, 186.76, 225.02, 265.924, 327.99, 367.489, 1761.80487, 1962.66365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Mg
{5.985769,  18.82855, 28.447642, 119.9924, 153.8252, 190.49, 241.76, 284.64, 330.21, 398.65, 442.005, 2085.97700, 2304.14005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Al
{8.15168,  16.34585,  33.49300,  45.14179,  166.767, 205.279, 246.57, 303.59, 351.28, 401.38, 476.273, 523.415, 2437.65813, 2673.17753, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //Si
{10.486686, 19.76949, 30.20264, 51.44387, 65.02511, 220.430, 263.57, 309.60, 372.31, 424.40, 479.44, 560.62, 611.741, 2816.90876, 3069.8415, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//P
{10.36001, 23.33788, 34.86, 47.222, 72.5945,  88.0529, 280.954, 328.794, 379.84, 447.7, 504.55, 564.41, 651.96, 706.994, 3223.7807, 3494.1879, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//S
{12.967632, 23.81364, 39.80, 53.24, 67.68, 96.94, 114.2013, 348.306, 400.851, 456.7, 530.0, 591.58, 656.30, 750.23, 809.198, 3658.3437, 3946.2909,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Cl
{15.7596117, 27.62967, 40.735, 59.58, 74.84,  91.290, 124.41, 143.4567, 422.60, 479.76, 540.4, 619.0, 685.5, 755.13, 855.5, 918.375, 4120.6656, 4426.2228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Ar
{4.34066369, 31.62500, 45.8031, 60.917, 82.66, 99.44, 117.56, 154.87, 175.8174, 503.67, 565.6, 631.1, 714.7, 786.3, 860.92, 967.7, 1034.542, 4610.8701, 4934.0483, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//K
{6.11315547,  11.871719,  50.91316, 67.2732, 84.34, 108.78, 127.21, 147.24, 188.54, 211.275, 591.60, 658.2, 728.6, 817.2, 894.0, 973.7, 1086.8, 1157.726, 5128.8578, 5469.8616, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Ca
{6.56149,  12.79977, 24.756839, 73.4894, 91.95, 110.68, 137.99, 158.08,  180.03, 225.18, 249.798, 687.36, 757.7, 833.2, 926.5, 1008.6, 1093.5, 1213.1, 1287.957, 5674.9037, 6033.7542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Sc
{6.828120, 13.5755, 27.49171, 43.26717, 99.299, 119.533, 140.68, 170.5, 192.1, 215.92, 265.07, 291.500, 787.67, 864.0, 944.5, 1042.5, 1130.2, 1220.3, 1346.3, 1425.257, 6249.0226, 6625.8073, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Ti
{6.746187, 14.634,  29.3111, 46.709,  65.28165,  128.125, 150.72, 173.55, 206.0, 230.5, 254.8, 308.5, 336.274, 896.0, 977.2, 1062.9, 1165.2, 1258.9, 1354.2, 1486.7, 1569.656, 6851.3109, 7246.1226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//V
{6.76651,  16.486305, 30.959, 49.16, 69.46, 90.6349, 160.29, 184.76, 209.5, 244.5, 270.8, 296.7, 354.7, 384.163, 1011.6, 1097.2, 1188.0, 1294.8, 1394.5, 1495.1, 1634.1, 1721.183, 7481.8628, 7894.7992, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Cr
{7.4340380,  15.63999, 33.668, 51.21, 72.41,  95.604,  119.203, 195.5, 221.89, 248.6, 286.1, 314.4, 343.6, 402.95, 435.172, 1133.7, 1224.1, 1320.3, 1430.9, 1537.2, 1643.2, 1788.7, 1879.873, 8140.7872, 8571.9488, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Mn
{7.9024681,  16.19921, 30.651, 54.91, 75.00,  98.985,  124.976, 151.060, 233.6, 262.10, 290.9, 330.8, 361.0, 392.2, 456.2, 489.312, 1262.7, 1357.8, 1460, 1575.6, 1687.0, 1798.4, 1950.4, 2045.759, 8828.1879, 9277.6818, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Fe
{7.88101, 17.0844, 33.50, 51.27, 79.50, 102.00, 128.9, 157.8, 186.14, 275.4, 305.32, 336.1, 378.5, 410.0, 441.1, 511.96, 546.588,  1397.2,  1504.5, 1606, 1724, 1844.0, 1960.8, 2119.4, 2218.876, 9544.1833, 10012.122, 0, 0, 0, 0, 0, 0, 0, 0, 0},//Co
{7.639878, 18.168838, 35.187, 54.92, 76.06, 108.0, 132.0, 162.0, 193.2, 224.7, 319.5, 351.6, 384.5, 429.3, 462.8, 495.4, 571.07, 607.020, 1541.0, 1646, 1758, 1880, 2008.1, 2130.5, 2295.6, 2399.259, 10288.8862, 10775.386, 0, 0, 0, 0, 0, 0, 0, 0},//Ni
{7.726380, 20.29239, 36.841, 57.38, 79.8, 103.0, 139.0, 166.0, 198.0, 232.2,  265.33, 367.0, 401.0, 436.0, 483.1, 518.7, 552.8, 632.5, 670.608, 1690.5, 1800, 1918, 2044, 2179.4, 2307.3, 2479.1, 2586.954, 11062.4313, 11567.613, 0, 0, 0, 0, 0, 0, 0},//Cu
{9.394197, 17.96439, 39.72330, 59.573, 82.6, 108.0, 133.9, 173.9, 203.0, 238.0, 274.4, 310.8, 417.6, 453.4, 490.6, 540.0, 577.8, 613.3, 697.5, 737.366, 1846.8, 1961, 2085, 2214, 2358.0, 2491.5, 2669.9, 2781.996, 11864.9399, 12388.929, 0, 0, 0, 0, 0, 0},//Zn
{5.9993020,  20.51514, 30.72576, 63.241, 86.01, 112.7, 140.8, 169.9, 211.0, 244.0, 280.0, 319.0, 356, 471.2, 508.8, 548.3, 599.8, 640.0, 677, 765.7, 807.308, 2010.0, 2129, 2258, 2391, 2543.9, 2683.0, 2868, 2984.426, 12696.5575, 13239.489, 0, 0, 0, 0, 0},//Ga
{7.899435, 15.934610, 34.0576, 45.7155, 90.500, 115.90, 144.9, 176.4, 212.5, 252.1, 286, 326.0, 367, 407, 527.9, 567.3, 609.1, 662.8, 706.7, 744, 837.1, 880.44, 2180.1, 2304, 2439, 2575, 2737.1, 2881.9, 3074, 3194.293, 13557.4208, 14119.430, 0, 0, 0, 0},//Ge
{9.78855, 18.5892, 28.349, 50.15, 62.77, 121.19, 147.0, 180.0, 213.0, 247.0, 296.0, 333.0, 375, 418, 460, 587.6, 628.8, 672.9, 728.9, 774.0, 814, 911.7, 956.79, 2356.9, 2486, 2626, 2766, 2938, 3088.1, 3287, 3411.643, 14447.678, 15028.907, 0, 0, 0},//As
{9.752392,  21.196, 31.697, 42.947, 68.30, 81.83, 155.327, 184.0, 219.0, 255.0, 291.0, 342.9, 383, 426, 473, 517, 650.5, 693.4, 739.8, 798, 845.8, 887, 989.6, 1036.36, 2540.7, 2674, 2820, 2964, 3146, 3301.8, 3507, 3636.526, 15367.491, 15968.084, 0, 0},//Se
{11.81381, 21.591, 34.871, 47.782, 59.595, 87.390, 103.03, 192.61, 224.0, 261.0, 301.0, 338.0, 393, 436, 481, 530, 577, 716.3, 761.0, 809.8, 870, 920.8, 963, 1070.6, 1119.17, 2731.4, 2869, 3021, 3169, 3361, 3523.1, 3735, 3868.986, 16317.011, 16937.127, 0},//Br
{13.9996055, 24.35984, 35.838, 50.85, 64.69, 78.49, 109.13, 125.802, 233.0, 268, 308, 350, 391, 446, 492, 540, 591, 640, 785, 831.6, 882.8, 945, 999.0, 1042, 1155.0, 1205.23, 2928.9, 3072, 3228, 3380, 3584, 3752.0, 3971, 4109.083, 17296.421, 17936.209},//Kr
};

std::string elements[] = {"H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar","K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn", "Sb", "Te", "I", "Xe", "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn", "Fr", "Ra", "Ac", "Th", "Pa", "U", "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "Nh", "Fl", "Mc", "Lv", "Ts", "Og" };
long double dMass_of_elements[] = {0, 1, 4, 6.938, 9.012, 10.806, 12, 14, 16, 19, 20.18, 22.98, 24.304, 26.981, 28.084, 30.973, 32.059, 35.446, 39.948, 39.0983, 40.078, 44.955, 47.867, 50.9415, 51.9961, 54.938, 55.845, 58.933, 58.6934, 63.546, 65.38, 69.723, 72.63, 74.922, 78.971, 79.901, 83.798, 85.4678, 87.62, 88.905, 91.224, 92.906, 95.95, 98, 101.07, 102.905, 106.42, 107.8682, 112.414, 114.818, 118.71, 121.76, 127.6, 126.904, 131.293, 132.905, 137.327, 138.905, 140.116, 140.907, 144.242, 145, 105.36, 151.964, 157.25, 158.925, 162.5, 164.93, 167.259, 168.934, 173.054, 174.9668, 178.49, 180.948, 183.84, 186.207, 190.23, 192.217, 195.084, 196.967, 200.592, 204.382, 207.2, 208.98, 209, 210, 222, 223, 226, 227, 232.037, 231.035, 238.028, 237, 244};

typedef struct data {
		long double dr, drDistribution, *r, *OmegaR, *Fuggveny, *rDistribution, *energyDistribution, *error_of_rDistribution, *error_of_energyDistribution, rMax, OmegaRmax, VelocityMax;
		long double RedukaltTomeg, kszi, kszi0, kszi1, eta, eta0, eta1;
		int meret, meretrDistribution, size;
		int iz_electron, iz_target, iN_electron;
                long double dm_electron, dm_target, dBindingEnergy;
		long double Period, RandNum_bmax;
                int iValue, iSize, waveForm_size;
                long double dElectron_prefactor, dTarget_prefactor, dTwoBody_Mass_Prefactor;
                double *waveForm_t, *waveForm_A, c, dEnd;
				double ldIntensity, ldPulseWidth, ldGDD, ldTOD, ldFOD, ldCEP, dt;
                std::string additionalInfo, additionalInfo1;
} DATA;

class IonisationStatistics{
    public:
            int excitation, ionization, anomal_Ete_Epe, anomal_dt;
            std::vector<std::vector<long double>> ionisedElectron;

    void initialize(){
            excitation = 0;
            ionization = 0;
            anomal_Ete_Epe = 0;
            anomal_dt = 0;
            ionisedElectron.clear();
            }

            IonisationStatistics(){
            initialize();

            }
};

char *strrev(char *str)
{
    if (!str || ! *str)
        return str;

    int i = strlen(str) - 1, j = 0;

    char ch;
    while (i > j)
    {
        ch = str[i];
        str[i] = str[j];
        str[j] = ch;
        i--;
        j++;
    }
    return str;
}

template <typename T>
void crossProduct(long double* input1, T* input2, T* result){
    result[0] = input1[1] * input2[2] - input1[2] * input2[1];
    result[1] = input1[2] * input2[0] - input1[0] * input2[2];
    result[2] = input1[0] * input2[1] - input1[1] * input2[0];
}

long double dotProduct_simple(long double* input){
    long double result;
    result = pow(input[0], 2) + pow(input[1], 2) + pow(input[2], 2);
    return result;
}

long double FACT(long double r, DATA* parameters){
    long double exponential, denominator, fscr, fscr_comma, factResult;

    if(parameters->iN_electron == 1) {fscr=parameters->iz_target; fscr_comma = 0; }
    else if(std::isinf(exponential = exp(parameters->kszi*r))) {fscr=parameters->iz_target-(parameters->iN_electron-1); fscr_comma = 0; }
    else if(std::isinf(denominator = (exponential-1)*(parameters->eta)/(parameters->kszi)+1)) {fscr=parameters->iz_target-(parameters->iN_electron-1); fscr_comma = 0; }
    else {fscr=parameters->iz_target-(parameters->iN_electron-1)*(1-1/denominator); fscr_comma=parameters->eta*(1-parameters->iN_electron)/denominator*exponential/denominator; }
if(!std::isnormal(fscr) && (fscr != 0)) {printf("fscr is wrong, distance: %Lf, exponential: %Lf, denominator: %Lf, fscr_comma: %Lf\n", r, exponential, denominator, fscr); }
if(!std::isnormal(fscr_comma) && (fscr_comma != 0)) {printf("fscr_comma is wrong, distance: %Lf, exponential: %Lf, denominator: %Lf, fscr_comma: %Lf\n", r, exponential, denominator, fscr_comma); }
	factResult=fscr/r-fscr_comma;
    return factResult;
    }

long double potential_fscr(long double r, DATA* parameters){
    long double fscr, denominator, exponential;

	if(parameters->iN_electron == 1) {fscr=parameters->iz_target; }
    else if(std::isinf(exponential = exp(parameters->kszi*r))) {fscr=parameters->iz_target-(parameters->iN_electron-1); }
    else if(std::isinf(denominator=(exponential-1)*(parameters->eta)/(parameters->kszi)+1)) {fscr=parameters->iz_target-(parameters->iN_electron-1); }
    else{fscr=parameters->iz_target-(parameters->iN_electron-1)*(1-1/denominator); }
if(!std::isnormal(fscr) && (fscr != 0)) {printf("fscr is wrong, distance: %Lf\n", r); }
        return fscr;
}

long double potential(long double r, DATA* parameters){
	long double potentialEnergy;
	potentialEnergy=parameters->iz_electron*potential_fscr(r, parameters)/r;
return potentialEnergy;
}

long double BindingEnergy_minus_potential(long double r, DATA* parameters){
	long double totalEnergy=parameters->dBindingEnergy-potential(r, parameters);
	return totalEnergy;
}

void table(DATA* parameters){
	int i;
    parameters->OmegaR[0]=0;
    parameters->r[0]=0;
    parameters->Fuggveny[0]=0;
	              for(i = 1 ; i < parameters->meret ; i++ ){
                          parameters->r[i]=i*parameters->dr;
		                  parameters->Fuggveny[i]=parameters->RedukaltTomeg*pow(parameters->r[i],2)*sqrt(2*parameters->RedukaltTomeg*BindingEnergy_minus_potential(parameters->r[i], parameters));
		                  parameters->OmegaR[i]=parameters->OmegaR[i-1]+(parameters->Fuggveny[i-1]+parameters->Fuggveny[i])*parameters->dr/2;
                  }
                  parameters->OmegaRmax=parameters->OmegaR[parameters->meret-1];

	if(parameters->r[parameters->meret-1] != parameters->rMax) {
		printf("r[meret-1] not equal to rMax");
		getchar();
		exit(1);
	}
}


void func_calc_rMax(DATA* parameters){
	long double min=((parameters->dr < parameters->drDistribution) ? parameters->dr : parameters->drDistribution);
	int i_mid, i_max=1, i_min;

	while( BindingEnergy_minus_potential(i_max*min, parameters) > 0){
		i_max*=2;
	}
		
	i_min=i_max/2;
	i_mid=(i_max+i_min)/2;

	while( !((BindingEnergy_minus_potential(i_mid*min, parameters) >= 0) && (BindingEnergy_minus_potential((i_mid+1)*min, parameters) < 0))){
		if( BindingEnergy_minus_potential(i_min*min, parameters) * BindingEnergy_minus_potential(i_mid*min, parameters) < 0 ) i_max=i_mid;
		else i_min=i_mid;
        i_mid=(i_max+i_min+1)/2;
	}
parameters->rMax=i_mid*min;
}

template <class T>
void initialize_to_zero(int size, int num_of_arr, ... ){
int i, j;
T *val;
va_list vl;
va_start(vl, num_of_arr);
	for(i=0; i < num_of_arr; i++){
		val=va_arg(vl, T*);
			for(j=0; j < size; j++){
				val[j]=0;
			}
	}
}

void calc_radius_from_randnum(DATA* parameters, long double* y, long double RandNum){
	int i=0, j=parameters->meret-1, kozep=j/2;
	long double m, b;
            
                                while(!(RandNum <= parameters->OmegaR[kozep+1] && parameters->OmegaR[kozep]<RandNum )){                                         
                                       //        if(OmegaR[j]==RandNum) i=j;
                                       if(RandNum < parameters->OmegaR[kozep]) j=kozep;                 
                                       /*if(OmegaR[kozep]<=RandNum)*/ else i=kozep;
                                       kozep=(i+j+1)/2;
                                }
              m=(parameters->r[kozep+1]-parameters->r[kozep])/(parameters->OmegaR[kozep+1]-parameters->OmegaR[kozep]);
              b=parameters->r[kozep]-m*parameters->OmegaR[kozep];
              *y=m*RandNum+b;
}

void initial_Conditions(DATA* parameters, long double* y_t,  long double* y){
long double Velocity, RandNum, RandNum_Nu_r, RandNum_Fi_r, RandNum_Nu_v, RandNum_Fi_v, r_tenyezo, v_tenyezo, m_tenyezo;
int energyIndex;

        RandNum=(long double) parameters->OmegaRmax*rand()/RAND_MAX;
        RandNum_Nu_r= (2*(long double) rand()/RAND_MAX-1);
        RandNum_Nu_v= (2*(long double) rand()/RAND_MAX-1);
        RandNum_Fi_r=(long double) 2*M_PI*rand()/RAND_MAX;
        RandNum_Fi_v=(long double) 2*M_PI*rand()/RAND_MAX;

        r_tenyezo=sqrt(1-RandNum_Nu_r*RandNum_Nu_r);

        v_tenyezo=sqrt(1-RandNum_Nu_v*RandNum_Nu_v);

        calc_radius_from_randnum(parameters, y, RandNum);

        Velocity=sqrt(2*BindingEnergy_minus_potential(*y, parameters)/parameters->RedukaltTomeg);

        y_t[electron_x]= *y*r_tenyezo*cos(RandNum_Fi_r); //Ax_t0;
        y_t[electron_y]= *y*r_tenyezo*sin(RandNum_Fi_r); //Ay_t0;
        y_t[electron_z]= *y*RandNum_Nu_r; //Az_t0;
        y_t[electron_vx]= Velocity*v_tenyezo*cos(RandNum_Fi_v); //v_Ax_t0;
        y_t[electron_vy]= Velocity*v_tenyezo*sin(RandNum_Fi_v); //v_Ay_t0;
        y_t[electron_vz]= Velocity*RandNum_Nu_v; //v_Az_t0;

        if(*y != 0) parameters->rDistribution[(int) (*y/(parameters->drDistribution))]+=1;
        energyIndex=(int) (Velocity*parameters->rMax/(parameters->drDistribution*parameters->VelocityMax));
        if(energyIndex<parameters->meretrDistribution) parameters->energyDistribution[energyIndex]+=1;
}

void calc_eccentricity(DATA* parameters, long double* eccentricity, long double* xx, long double* y_t){
        long double l_momentum, l[3];
        crossProduct<long double>(&y_t[electron_x], &y_t[electron_vx], l);
        l[0] *= parameters->RedukaltTomeg;
        l[1] *= parameters->RedukaltTomeg;
        l[2] *= parameters->RedukaltTomeg;
        l_momentum=pow(l[0],2)+pow(l[1],2)+pow(l[2],2);
	*xx=1+2*(parameters->dBindingEnergy)*l_momentum/(parameters->RedukaltTomeg*pow(parameters->iz_electron*parameters->iz_target,2));
	*eccentricity=sqrt(*xx);
}

void Lorentz_simple_calc(DATA* parameters, long double* t_ld, long double* y_t, long double* dEplusvxB, long double* dEplusvxB_electron, gsl_interp_accel *acc, gsl_spline *spline){

	double dElectric[3], dB[3], dElectric_electron[3], dB_electron[3], vxB_electron[3];
    double t, t_electron;
	t = *t_ld;
	t_electron = t+y_t[electron_x]/parameters->c;

	dElectric[0] = 0;
	dElectric[1] = 0;
	if(t < parameters->waveForm_t[parameters->waveForm_size-1]){
		dElectric[2] = gsl_spline_eval(spline, t, acc);
	}
	else{
		dElectric[2] = 0;
	}

	dElectric_electron[0] = 0;
	dElectric_electron[1] = 0;
	if( (t_electron < parameters->waveForm_t[parameters->waveForm_size-1]) && (t_electron > parameters->waveForm_t[0])){
		dElectric_electron[2] = gsl_spline_eval(spline, t_electron, acc);
	}
	else{
		dElectric_electron[2] = 0;
	}

	dB[0]=0;
    dB[1]=dElectric[2]/parameters->c;
    dB[2]=dElectric[1]/parameters->c;

    dB_electron[0]=0;
    dB_electron[1]=dElectric_electron[2]/parameters->c;
    dB_electron[2]=dElectric_electron[1]/parameters->c;

    dEplusvxB[0] = dElectric[0]; //+ y_t[1]*dB[2]-y_t[2]*dB[1];
    dEplusvxB[1] = dElectric[1]; // + y_t[2]*dB[0]-y_t[0]*dB[2];
    dEplusvxB[2] = dElectric[2]; // + y_t[0]*dB[1]-y_t[1]*dB[0];

    dEplusvxB_electron[0] = dElectric_electron[0]; //+ vxB_electron[0];
    dEplusvxB_electron[1] = dElectric_electron[1]; //+ vxB_electron[1];
    dEplusvxB_electron[2] = dElectric_electron[2]; //+ vxB_electron[2];
}

void coefficients_simple(DATA* parameters, long double y_t[], long double* t_giv, long double k_giv[], long double k_calc[], long double dt, gsl_interp_accel *acc, gsl_spline *spline){
long double ycalc_t[parameters->iSize], F_A, A, FACTAA, squareA, cubicA;
long double dEplusvxB[3], dEplusvxB_electron[3];

        ycalc_t[electron_x]=y_t[electron_x]+k_giv[electron_x];
        ycalc_t[electron_y]=y_t[electron_y]+k_giv[electron_y];
        ycalc_t[electron_z]=y_t[electron_z]+k_giv[electron_z];
        ycalc_t[electron_vx]=y_t[electron_vx]+k_giv[electron_vx];
        ycalc_t[electron_vy]=y_t[electron_vy]+k_giv[electron_vy];
        ycalc_t[electron_vz]=y_t[electron_vz]+k_giv[electron_vz];

        Lorentz_simple_calc(parameters, t_giv, ycalc_t , dEplusvxB, dEplusvxB_electron, acc, spline);

        squareA = dotProduct_simple(&ycalc_t[electron_x]); //pow(ycalc_t[electron_x],2) + pow(ycalc_t[1],2) + pow(ycalc_t[2],2);
	A=sqrt(squareA);

	FACTAA=FACT(A, parameters); //potential_fscr(A, parameters)/A-potential_fscr_comma(A, parameters);

	F_A=parameters->dTwoBody_Mass_Prefactor*parameters->iz_electron/squareA*FACTAA;

        k_calc[electron_x]=ycalc_t[electron_vx]*dt;
        k_calc[electron_y]=ycalc_t[electron_vy]*dt;
        k_calc[electron_z]=ycalc_t[electron_vz]*dt;

        k_calc[electron_vx]=(F_A*ycalc_t[electron_x]+parameters->dElectron_prefactor*dEplusvxB_electron[0]-parameters->dTarget_prefactor*dEplusvxB[0])*dt;
        k_calc[electron_vy]=(F_A*ycalc_t[electron_y]+parameters->dElectron_prefactor*dEplusvxB_electron[1]-parameters->dTarget_prefactor*dEplusvxB[1])*dt;
        k_calc[electron_vz]=(F_A*ycalc_t[electron_z]+parameters->dElectron_prefactor*dEplusvxB_electron[2]-parameters->dTarget_prefactor*dEplusvxB[2])*dt;
}

void collision_process(DATA* parameters, long double* y_t, int *validity, long double* time_of_ionization, gsl_interp_accel *acc, gsl_spline *spline/*, int *k*/){
        const long double dt_original = 1e-6;
	long double t = parameters->waveForm_t[0];
        long double t_in, time_of_ionization_prev, E_all_prev, m, b;
        long double k_in[parameters->iSize], k1[parameters->iSize], k2[parameters->iSize], k3[parameters->iSize], k4[parameters->iSize], k5[parameters->iSize], k6[parameters->iSize], k7[parameters->iSize], zk[parameters->iSize], fk[parameters->iSize], epsilon=parameters->dt;
        long double dt=dt_original, R_max, delta, R[parameters->iSize];
	long double E_kin, E_pot, E_All;
        int i, j, errorCounter = 0, errorMax = 1 * (parameters->waveForm_t[parameters->waveForm_size] - parameters->waveForm_t[0]), ionizationCheck = 0;
	bool bCondition = true;
        parameters->iValue = 6;

//	FILE *fp;
//	fp=fopen("trajectory.txt","w");

for(i=0; bCondition; i++){

	t_in = t;
	for(j=0; j<parameters->iValue; j++) { k_in[j]=0; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k1, dt, acc, spline);

	t_in = t+dt/5;
	for(j=0; j<parameters->iValue; j++) { k_in[j]=k1[j]/5; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k2, dt, acc, spline);

	t_in = t+3*dt/10;
	for(j=0; j<parameters->iValue; j++) { k_in[j]=3*k1[j]/40+9*k2[j]/40; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k3, dt, acc, spline);

	t_in = t+4*dt/5;
	for(j=0; j<parameters->iValue; j++) { k_in[j]=44*k1[j]/45-56*k2[j]/15+32*k3[j]/9; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k4, dt, acc, spline);

	t_in = t+8*dt/9;
	for(j=0; j<parameters->iValue; j++) { k_in[j]=19372*k1[j]/6561-25360*k2[j]/2187+64448*k3[j]/6561-212*k4[j]/729; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k5, dt, acc, spline);

	t_in = t+dt;
	for(j=0; j<parameters->iValue; j++) { k_in[j]=9017*k1[j]/3168-355*k2[j]/33+46732*k3[j]/5247+49*k4[j]/176-5103*k5[j]/18656; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k6, dt, acc, spline);

        for(j=0; j<parameters->iValue; j++) { k_in[j]=35*k1[j]/384+500*k3[j]/1113+125*k4[j]/192-2187*k5[j]/6784+11*k6[j]/84; }
	coefficients_simple(parameters, y_t, &t_in, k_in, k7, dt, acc, spline);

	for(j=0; j<parameters->iValue; j++) {

		zk[j]=y_t[j]+5179*k1[j]/57600+7571*k3[j]/16695+393*k4[j]/640-92097*k5[j]/339200+187*k6[j]/2100+k7[j]/40;
		fk[j]=y_t[j]+k_in[j];
		R[j]=fabs(fk[j]-zk[j])/dt;
		
		}
		
		R_max = 0;
		for(j = 0; j < parameters->iValue; j++){
			if(std::isnormal(R[j]) && (R[j] > R_max) ) {R_max = R[j]; }  
		}

	if( R_max <= epsilon ){
		time_of_ionization_prev = t;
		E_all_prev = E_All;
		t+=dt;
		
		for(j=0; j<parameters->iValue; j++){
			y_t[j]=fk[j];
		}

		E_kin=0.5*parameters->RedukaltTomeg*(pow(y_t[electron_vx],2) + pow(y_t[electron_vy],2) + pow(y_t[electron_vz],2));
                E_pot=potential(sqrt(pow(y_t[electron_x],2) + pow(y_t[electron_y],2) + pow(y_t[electron_z],2)), parameters);
		E_All = E_kin + E_pot;
		bCondition = (t < parameters->waveForm_t[parameters->waveForm_size-1]) || ( (E_All >= 0) && (t < parameters->dEnd) && ((-E_kin/E_pot) < 5e4) ); 
		if((E_All >= 0) && (ionizationCheck == 0)) {
			m = (E_All - E_all_prev)/(t - time_of_ionization_prev);
			b = E_all_prev - m * time_of_ionization_prev;
			*time_of_ionization = -b/m; 
			ionizationCheck = 1;
		}
//		fprintf(fp,"%Lf\t%Lf\n",t, E_kin+E_pot); 

		delta = pow((epsilon/R_max/2), 0.2);
        }
	else {delta = pow((epsilon/R_max/2), 0.25); }

	dt*=delta;
if( !std::isnormal(dt) ) {dt = dt_original; errorCounter++; }

        if(errorCounter > errorMax ) {*validity=0; goto end_of_function; }

}
*validity=1;
end_of_function:;
//fclose(fp);
}

void Statistics(DATA* parameters, IonisationStatistics* local_IonisationStatist ,long double* y_t, int validity, int Num, int* k, long double* time_of_ionization){
int my_rank;
long double E_Te, E_kin_Te, E_pot_Te, E_kin_Pe;
std::vector<long double> electronData;

if(validity==0) {(local_IonisationStatist->anomal_dt)++; /*(*k)++;*/ }
if(validity==1){
	E_kin_Te = 0.5*parameters->RedukaltTomeg*dotProduct_simple(&y_t[electron_vx]);
	E_pot_Te = potential(sqrt(dotProduct_simple(&y_t[electron_x])), parameters);
	E_Te = E_kin_Te + E_pot_Te;
	if(E_Te<0) { (local_IonisationStatist->excitation)++; (*k)++; }
        else if(E_Te>0) {(local_IonisationStatist->ionization)++;
        	electronData.push_back(y_t[electron_x]); 
		electronData.push_back(y_t[electron_y]); 
		electronData.push_back(y_t[electron_z]); 
		electronData.push_back(y_t[electron_vx]); 
		electronData.push_back(y_t[electron_vy]); 
		electronData.push_back(y_t[electron_vz]); 
		electronData.push_back(parameters->dm_electron * y_t[electron_vx]); 
		electronData.push_back(parameters->dm_electron * y_t[electron_vy]); 
		electronData.push_back(parameters->dm_electron * y_t[electron_vz]); 
		electronData.push_back(E_Te);  
		electronData.push_back(E_kin_Te); 
		electronData.push_back(E_pot_Te);
		electronData.push_back(*time_of_ionization);
		local_IonisationStatist->ionisedElectron.push_back(electronData); 
		(*k)++; 
	}
	else { (local_IonisationStatist->anomal_Ete_Epe)++; }
        if(*k%250==0) {my_rank = omp_get_thread_num(); printf("Thread %d is ready of %d cycle is ready from %d.\n", my_rank, *k, Num); }
        }
}

void distribution(int iCount, int iRemainder, int thread_count, DATA* parameters, IonisationStatistics* IonisationStatist){
		
	gsl_interp_accel *acc = gsl_interp_accel_alloc();
	gsl_spline *spline = gsl_spline_alloc(gsl_interp_cspline, parameters->waveForm_size);
	gsl_spline_init (spline, parameters->waveForm_t, parameters->waveForm_A, parameters->waveForm_size);

	int k, i, iNumjob_per_Thread ,validity;
	long double y /*=sqrt(2*(BindingEnergy+1/rMax/RedukaltTomeg))*/;

	if (omp_get_thread_num() < iRemainder) {iNumjob_per_Thread = iCount + 1;}
	else {iNumjob_per_Thread = iCount;}

	long double eccentricity, xx;
	long double y_t[parameters->iSize];
	class IonisationStatistics local_IonisationStatist;
	long double local_rDistribution[parameters->meretrDistribution], local_energyDistribution[parameters->meretrDistribution];
	long double time_of_ionization;
	initialize_to_zero<long double>(parameters->meretrDistribution, 2, local_rDistribution, local_energyDistribution);
     
	for(k=0; iNumjob_per_Thread > k; ){
		initial_Conditions(parameters, y_t, &y);
		calc_eccentricity(parameters, &eccentricity, &xx, y_t);
		//printf("%Lf\n", eccentricity);
		if((y!=0) && (xx>=0) && (eccentricity < 0.999)) {
        		collision_process(parameters, y_t, &validity, &time_of_ionization, acc, spline/*, &k*/);
			Statistics(parameters, &local_IonisationStatist ,y_t, validity, iNumjob_per_Thread, &k, &time_of_ionization);
        	}
	 }
	 
	gsl_spline_free (spline);
	gsl_interp_accel_free (acc);

#pragma omp critical
        {
                IonisationStatist->ionisedElectron.insert(std::end(IonisationStatist->ionisedElectron), std::begin(local_IonisationStatist.ionisedElectron), std::end(local_IonisationStatist.ionisedElectron)); //ionisation_px.insert(std::end(IonisationStatist->ionisation_px), std::begin(local_IonisationStatist.ionisation_px), std::end(local_IonisationStatist.ionisation_px));
		
                IonisationStatist->excitation += local_IonisationStatist.excitation;
                IonisationStatist->ionization += local_IonisationStatist.ionization;
                IonisationStatist->anomal_Ete_Epe += local_IonisationStatist.anomal_Ete_Epe;
                IonisationStatist->anomal_dt += local_IonisationStatist.anomal_dt;

                for(i=0; i < parameters->meretrDistribution; i++){
                	parameters->rDistribution[i] += local_rDistribution[i];
                	parameters->energyDistribution[i] += local_energyDistribution[i];
                }
     }
}

void StatisticsKiir(DATA* parameters, IonisationStatistics* IonisationStatist){

        long double a0=5.2917721067e-9;
        
        std::string waveform ,fileName = "Statistics_" + parameters->additionalInfo1 + ".txt";

        std::ofstream myfile;
        myfile.open(fileName);
				myfile << "#z target: " << parameters->iz_target <<", N electron: "<< parameters->iN_electron << ", z electron: " << parameters->iz_electron <<'\n';
                myfile << "#m target: " << parameters->dm_target <<", m electron: "<< parameters->dm_electron << '\n';
                myfile << "#two body mass prefactor: " << parameters->dTwoBody_Mass_Prefactor <<", target prefactor: "<< parameters->dTarget_prefactor << ", electron prefactor: "<< parameters->dElectron_prefactor << ", Reduced mass: " << parameters->RedukaltTomeg <<'\n';
                myfile << "#Binding energy: " << parameters->dBindingEnergy << " (" << parameters->dBindingEnergy*2*dBinding_energy_of_elements[0][0] << " eV)" <<", kszi: " << parameters->kszi << ", eta: " << parameters->eta << ", kszi0: " << parameters->kszi0 << ", kszi1: " << parameters->kszi1 << ", eta0: " << parameters->eta0 << ", eta1: " << parameters->eta1 << '\n';
                myfile << "#excitation: " << IonisationStatist->excitation << '\n';
                myfile << "#ionisation: " << IonisationStatist->ionization << '\n';
                myfile << "#anomal_Ete: " << IonisationStatist->anomal_Ete_Epe << '\n';
                myfile << "#anomal_dt: " << IonisationStatist->anomal_dt << '\n';
                myfile << "# ex\tey\tez\tvx\tvy\tvz\tpx\tpy\tpz\tEtotal\tEkin\tEpot\ttime_of_ionization\n";

        for(std::vector<std::vector<long double>>::iterator it = IonisationStatist->ionisedElectron.begin(); it != IonisationStatist->ionisedElectron.end(); ++it){
                for(std::vector<long double>::iterator col = it->begin(); col != it->end(); ++col){
			myfile << (*col) << '\t';
                }
        	myfile << '\n' ;
        }
        myfile.close();
}

void normal(long double *Distribution, int meretrDistribution, int Num, long double drDistribution, long double* error_of_distribution){
	int i;
        for(i=0; i<meretrDistribution; i++){
        	error_of_distribution[i]=sqrt(Distribution[i]);
        }
	for(i=0; i<meretrDistribution; i++){
        	Distribution[i]/=Num*drDistribution;
                error_of_distribution[i]/=Num*drDistribution;
        }
}

void eloszlasKiir(DATA* parameters, int Num){
        int l;

        normal(parameters->rDistribution, parameters->meretrDistribution, Num, parameters->drDistribution, parameters->error_of_rDistribution);
        normal(parameters->energyDistribution, parameters->meretrDistribution, Num, parameters->VelocityMax/parameters->rMax*parameters->drDistribution, parameters->error_of_energyDistribution);

        FILE *fp;
        fp=fopen("eloszlas.txt","w");
        for(l=0; l<parameters->meretrDistribution-1; l++){
        	fprintf(fp,"%Lf\t%Lf\t%Lf\t%Lf\t%Lf\t%Lf\n",(l+0.5)*parameters->drDistribution, parameters->rDistribution[l], parameters->error_of_rDistribution[l] ,(l+0.5)*parameters->drDistribution*parameters->VelocityMax/parameters->rMax, parameters->energyDistribution[l], parameters->error_of_energyDistribution[l]);
        }
	fclose(fp);
}

void Intensity (DATA* parameters, char* waveFormFilename){
	double telj;
	char* c;
	char f[128];
	int j=0;
	c=strstr(waveFormFilename,"Wcm");
	for (j=0 ;((*(c-j-1)-'0')<10) && ((*(c-j-1)-'0')>=0) || (*(c-j-1)=='e') || (*(c-j-1)=='+') || (*(c-j-1)=='.'); j++){ *(f+j)=*(c-j-1);}
	*(f+j)='\0';
	strrev(f);
	telj=atof(f);
	parameters->ldIntensity = telj;
}
	 
void Pulsewidth (DATA* parameters, char* waveFormFilename){
	double telj;
	char* c;
	char f[128];
	int j=0;
	c=strstr(waveFormFilename,"fs");
	for (j=0 ;(((*(c-j-1)-'0')<10) && ((*(c-j-1)-'0')>=0) || (*(c-j-1)=='e') || (*(c-j-1)=='.')); j++){ *(f+j)=*(c-j-1);}
	*(f+j)='\0';
	strrev(f);
	sscanf(f, "%le",&telj);
	parameters->ldPulseWidth = telj;
}
	 
void GroupDelayDispersion (DATA* parameters, char* waveFormFilename){
	double telj;
	char* c;
	char f[128];
	int j=0;
	c=strstr(waveFormFilename,"GDD");
	for (j=0 ;(((*(c-j-1)-'0')<10) && ((*(c-j-1)-'0')>=0) || (*(c-j-1)=='e') || (*(c-j-1)=='.') || (*(c-j-1)=='-')); j++){ *(f+j)=*(c-j-1);}
	*(f+j)='\0';
	strrev(f);
	telj=atof(f);
	parameters->ldGDD = telj;
}

void ThirdOrderDispersion (DATA* parameters, char* waveFormFilename){
	double telj;
	char* c;
	char f[128];
	int j=0;
	c=strstr(waveFormFilename,"TOD");
	for (j=0 ;(((*(c-j-1)-'0')<10) && ((*(c-j-1)-'0')>=0) || (*(c-j-1)=='e') || (*(c-j-1)=='.') || (*(c-j-1)=='-')); j++){ *(f+j)=*(c-j-1);}
	*(f+j)='\0';
	strrev(f);
	telj=atof(f);
	parameters->ldTOD= telj;
}
	 
void FourthOrderDispersion (DATA* parameters, char* waveFormFilename){
	double telj;
	char* c;
	char f[128];
	int j=0;
	c=strstr(waveFormFilename,"FOD");
	for (j=0 ;(((*(c-j-1)-'0')<10) && ((*(c-j-1)-'0')>=0) || (*(c-j-1)=='e') || (*(c-j-1)=='.') || (*(c-j-1)=='-')); j++){ *(f+j)=*(c-j-1);}
	*(f+j)='\0';
	strrev(f);
	telj=atof(f);
	parameters->ldFOD= telj;
}
	 
void CEP_read (DATA* parameters, char* waveFormFilename){
	double telj;
	char* c;
	char f[128];
	int j=0;
	c=strstr(waveFormFilename,"CEP");
	for (j=0 ;(((*(c-j-1)-'0')<10) && ((*(c-j-1)-'0')>=0) || (*(c-j-1)=='-')); j++){ *(f+j)=*(c-j-1);}
	*(f+j)='\0';
	strrev(f);
	telj=atof(f);
	parameters->ldCEP= telj;
}
	 
void additionalInformationModify(DATA* parameters){
	char add[4096];
	sprintf(add, "_%gWcm_%gfs_%gCEP_%gGDD_%gTOD_%gFOD_%gepsilon", parameters->ldIntensity, parameters->ldPulseWidth,parameters->ldCEP ,parameters->ldGDD, parameters->ldTOD, parameters->ldFOD, parameters->dt);
	parameters->additionalInfo1 = parameters->additionalInfo + add;
}

void waveForm_read(DATA* parameters, char* waveFormFilename){
	Intensity (parameters, waveFormFilename);
	Pulsewidth (parameters, waveFormFilename);
	GroupDelayDispersion (parameters, waveFormFilename);
	ThirdOrderDispersion (parameters, waveFormFilename);
	FourthOrderDispersion (parameters, waveFormFilename);
	CEP_read (parameters, waveFormFilename);
	additionalInformationModify(parameters);
	
	FILE *fp;
	double t, Amplitude, Envelope;
	int i, size1 = 0;
	parameters->waveForm_t = NULL;
	parameters->waveForm_A = NULL;
		if((fp=fopen(waveFormFilename,"r"))==NULL) {perror("I can't open the waveForm file!\n");}
	 
	for(i=0;!feof(fp);i++){
                size1+=sizeof(double);
                fscanf(fp,"%le %le %le\n",&t, &Amplitude, &Envelope);
                parameters->waveForm_t = (double*) realloc (parameters->waveForm_t,size1);
                parameters->waveForm_A = (double*) realloc (parameters->waveForm_A,size1);
                parameters->waveForm_t[i] = t;
                parameters->waveForm_A[i] = Amplitude;
        }
	fclose(fp);
	
	parameters->waveForm_size = i;
	parameters->dEnd = parameters->waveForm_t[parameters->waveForm_size-1] + 41341000;
}

void atnevez(DATA* parameters, char* waveFormFilename){
	int ret;
	char new_name[2048];
	sprintf(new_name, "a%s", waveFormFilename);
	
	ret = rename(waveFormFilename, new_name);
	
	if(ret == 0) {
      		printf("File renamed successfully");
   	} 
   	else {
      		printf("Error: unable to rename the file");
   	}	
	
}

class Electron{
	public:
		DATA parameters;
                Electron(int z_electron, long double m_electron, int z_target, long double m_target, int N_electron) {
			parameters.iz_electron = z_electron;
			parameters.dm_electron = m_electron;
			parameters.iz_target = z_target;
			parameters.dm_target = m_target;
			parameters.iN_electron = N_electron;
                        parameters.c = 137.04;

                        parameters.dTarget_prefactor = 1/parameters.dm_target*(parameters.iz_target-parameters.iN_electron+1);
                        parameters.dElectron_prefactor = 1/parameters.dm_electron*parameters.iz_electron;
                        parameters.dTwoBody_Mass_Prefactor = 1/parameters.dm_electron + 1/parameters.dm_target;

			parameters.dBindingEnergy = -dBinding_energy_of_elements[parameters.iz_target-1][parameters.iz_target-parameters.iN_electron]/(2*dBinding_energy_of_elements[0][0]);
			parameters.size = 51; parameters.dr = 0.0001; parameters.drDistribution = 0.05; parameters.VelocityMax = 3; parameters.RandNum_bmax=2;
                        parameters.iSize = 12;
				
			parameters.kszi0 = dVector_kszi0[parameters.iN_electron];
			parameters.kszi1 = dVector_kszi1[parameters.iN_electron];
			parameters.eta0 = dVector_eta0[parameters.iN_electron];
			parameters.eta1 = dVector_eta1[parameters.iN_electron];
			parameters.kszi = parameters.kszi0+parameters.kszi1*(parameters.iz_target-parameters.iN_electron); 
			parameters.eta = parameters.eta0+parameters.eta1*(parameters.iz_target-parameters.iN_electron);
			parameters.RedukaltTomeg = parameters.dm_target*parameters.dm_electron/(parameters.dm_target+parameters.dm_electron);
			
			func_calc_rMax(&parameters);
				
			parameters.Period=2*M_PI*parameters.rMax/sqrt(2*fabs(parameters.dBindingEnergy)/parameters.RedukaltTomeg);
				
			parameters.meret = (int) round(parameters.rMax/parameters.dr+1); parameters.meretrDistribution=(int) round(parameters.rMax/parameters.drDistribution+1);
			
			if(parameters.dBindingEnergy == 0) {std::cout << "The Binding energy of the target is zero. The program exit." << std::endl; exit(1); }

			parameters.r = new long double [parameters.meret];
			if(parameters.r == NULL) std::cout << "Nincs eleg memoria az 'r' valtozonak." << std::endl;
				
			parameters.Fuggveny = new long double [parameters.meret];
			if(parameters.Fuggveny == NULL) std::cout << "Nincs eleg memoria 'Fuggveny' valtozonak." << std::endl;;
				
			parameters.OmegaR = new long double [parameters.meret];
			if(parameters.OmegaR == NULL) std::cout << "Nincs eleg memoria 'OmegaR' valtozonak." << std::endl;
				
			parameters.rDistribution = new long double [parameters.meretrDistribution];
			if(parameters.rDistribution == NULL) std::cout << "Nincs eleg memoria 'rDistribution' valtozonak." << std::endl;
				
			parameters.energyDistribution = new long double [parameters.meretrDistribution];
			if(parameters.energyDistribution == NULL) std::cout << "Nincs eleg memoria 'energyDistribution' valtozonak."<< std::endl;
				
			parameters.error_of_rDistribution = new long double [parameters.meretrDistribution];
			if(parameters.error_of_rDistribution == NULL) std::cout << "Nincs eleg memoria 'error_of_rDistribution' valtozonak." << std::endl;
				
			parameters.error_of_energyDistribution = new long double [parameters.meretrDistribution];
			if(parameters.error_of_energyDistribution == NULL) std::cout << "Nincs eleg memoria 'error_of_energyDistribution' valtozonak." << std::endl;
								
			initialize_to_zero<long double>(parameters.meretrDistribution, 2, parameters.rDistribution, parameters.energyDistribution);

                        table (&parameters);
																
			std::string add;
			if((parameters.iz_target - parameters.iN_electron ) == 0) {add = ""; }
			else {add = std::to_string(parameters.iz_target - parameters.iN_electron) + "+"; }

			parameters.additionalInfo = elements[parameters.iz_target - 1] + add;									
		}
		~Electron () {
				delete[] parameters.r;
				delete[] parameters.Fuggveny;
				delete[] parameters.OmegaR;
				delete[] parameters.rDistribution;
				delete[] parameters.energyDistribution;
				delete[] parameters.error_of_rDistribution;
				delete[] parameters.error_of_energyDistribution;
		}
};

void num_of_Threads(int* argc, int* thread_count, char** argv){
    if(*argc == 1){
        std::cout << "Give me the number of cores in the processor: ";
        std::cin >> *thread_count;
    }
    else {
	*thread_count = strtol(argv[1], NULL, 10);
    }
}

int main(int argc, char* argv[]){
	clock_t t;
	long double run_time_stop, run_time_start=omp_get_wtime();
	
	t=clock();
        srand(time(NULL));
	
	char *buffer;
	if( (buffer = getcwd(NULL,0 ) ) == NULL ) perror("_getcwd error");
	DIR *dir;
	struct dirent *entry;
        int thread_count;
        num_of_Threads(&argc, &thread_count, argv);

        int Num = 320, iCount, iRemainder;
        iCount = Num/thread_count;
        iRemainder = Num%thread_count;
	char waveFormFilename[2048];
        int z_electron = -1, z_target = 1, N_electron = 1;
        long double m_electron = 1;
	int m_target_int = 1836 * dMass_of_elements[z_target];
	long double m_target = m_target_int;

        class IonisationStatistics IonisationStatist;
        class Electron atom(z_electron, m_electron, z_target, m_target, N_electron);

	for(atom.parameters.dt = 1e-6; atom.parameters.dt >= 1e-6; atom.parameters.dt /= 10){
	if((dir=opendir(buffer))==NULL) perror("Error during Opendir() error");
		while((entry=readdir(dir))!=NULL){
			if(entry->d_name[0] =='w' && entry->d_name[1] =='a' && entry->d_name[2] =='v' && entry->d_name[3] =='e' && entry->d_name[4] =='F' && entry->d_name[5] =='o' && entry->d_name[6] =='r' && entry->d_name[7] =='m' && entry->d_name[8] =='_'){
				IonisationStatist.initialize();
				waveForm_read(&atom.parameters, entry->d_name);
				#pragma omp parallel num_threads(thread_count)
				{
					distribution(iCount, iRemainder, thread_count, &atom.parameters, &IonisationStatist);
				}
				free(atom.parameters.waveForm_t);
				free(atom.parameters.waveForm_A);
				StatisticsKiir(&atom.parameters, &IonisationStatist);
//				eloszlasKiir(&atom.parameters ,Num);
				atnevez(&atom.parameters, entry->d_name);
			}
		}
	}

	run_time_stop=omp_get_wtime();
	t = clock() - t;
	printf ("It took me %ld clicks (%f seconds) in CPU time.\nIt took me %Lf seconds in run time.\n",t,((float)t)/CLOCKS_PER_SEC, run_time_stop-run_time_start);
	return 0;
}
