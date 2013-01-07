#ifndef BIOSENSORINFORMATION_H
#define BIOSENSORINFORMATION_H

struct LayerInformation {
    //Laukas nurodo ar tai fermento sluoksnis
    int enzymeLayer;
    //Difuzijos koeficientai
    double Ds;
    double Dp;
    //Sluoksnio storis
    double d;
    //Fermento koncentracija
    double e0;
};

struct BiosensorInformation {
    //Laukas nurodo ar naudojama išreikštinė schema (priešingu atveju bus naudojama neišreikštinė schema)
    int explicitScheme;
    //Laukas nurodo ar vyksta substrato inhibicija
    int substrateInhibition;
    //Laukas nurodo ar vyksta produkto inhibicija
    int productInhibition;
    //Reakcijos greičio konstanta k2
    double k2;
    //Pusiausvyros konstantos
    double kM;
    double kS;
    double kP;
    //Žingsnis pagal laiką
    double timeStep;
    //Į kiek dalių dalinami sluoksniai
    int N;
    //Atsako laikas
    double responseTime;
    //Išvedimo failas
    char *outputFileName;
    //Elektronų, dalyvaujančių krūvio pernešime, skaičius
    int ne;
    //Substrato koncentracija tirpale
    double s0;
    //Produkto koncentracija tirpale
    double p0;
    //Biojutiklio sluoksnių skaičius
    int noOfBiosensorLayers;
    //Biojutiklio sluoksnių masyvas
    struct LayerInformation *biosensorLayers;
};

#endif // BIOSENSORINFORMATION_H
