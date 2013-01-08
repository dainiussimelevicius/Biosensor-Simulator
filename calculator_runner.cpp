#include <stdio.h>
#include <dlfcn.h>
#include <QDeclarativeProperty>
#include <stdio.h>
#include "calculator_runner.h"

CalculatorRunner::CalculatorRunner(QObject* parent) : QObject(parent) {
    calculatorLibHandle = dlopen("./libbiosensor_calculator.so", RTLD_NOW);
    if(calculatorLibHandle == NULL) {
        printf("Calculator library was not found!\n");
        exit(EXIT_FAILURE);
    }
    calculateFunction = (void (*)(struct BiosensorInformation *)) dlsym(calculatorLibHandle, "calculate");
    if(calculateFunction == NULL) {
        printf("Could not load calculator function!\n");
        exit(EXIT_FAILURE);
    }
    biosensorInformation = NULL;
}

CalculatorRunner::~CalculatorRunner() {
    dlclose(calculatorLibHandle);
}

Q_INVOKABLE  void CalculatorRunner::runCalculator() {
    struct BiosensorInformation *localBiosensorInformation = biosensorInformation;
    biosensorInformation = NULL;

    //Paleidžiame skaičiavimus
    (*calculateFunction)(localBiosensorInformation);

    //Atlaisviname atmintį
    free(localBiosensorInformation->biosensorLayers);
    free(localBiosensorInformation);
}

Q_INVOKABLE void CalculatorRunner::setBiosensorInformation(int explicitScheme, int substrateInhibition, int productInhibition, \
                                                           double k2, double kM, double kS, double kP, double timeStep, int N, \
                                                           int responseTimeMethod, double minTime, double responseTime, \
                                                           const QString &outputFileName, int ne, \
                                                           double s0, double p0, int noOfBiosensorLayers) {
    biosensorInformation = (struct BiosensorInformation *) malloc(sizeof(struct BiosensorInformation));
    biosensorInformation->explicitScheme = explicitScheme;
    biosensorInformation->substrateInhibition = substrateInhibition;
    biosensorInformation->productInhibition = productInhibition;
    //[s^-1]
    biosensorInformation->k2 = k2;
    //[mol/l] -> [mol/cm^3]
    biosensorInformation->kM = kM * 1e-3;
    //[mol/l] -> [mol/cm^3]
    biosensorInformation->kS = kS * 1e-3;
    //[mol/l] -> [mol/cm^3]
    biosensorInformation->kP = kP * 1e-3;
    //[s]
    biosensorInformation->timeStep = timeStep;
    biosensorInformation->N = N;
    biosensorInformation->responseTimeMethod = responseTimeMethod;
    //[s]
    biosensorInformation->minTime = minTime;
    //[s]
    biosensorInformation->responseTime = responseTime;
    biosensorInformation->outputFileName = outputFileName.toLocal8Bit().data();
    biosensorInformation->ne = ne;
    //[mol/l] -> [mol/cm^3]
    biosensorInformation->s0 = s0 * 1e-3;
    //[mol/l] -> [mol/cm^3]
    biosensorInformation->p0 = p0 * 1e-3;
    biosensorInformation->noOfBiosensorLayers = noOfBiosensorLayers;
    biosensorInformation->biosensorLayers = (struct LayerInformation *) malloc(sizeof(struct LayerInformation) * noOfBiosensorLayers);
}

Q_INVOKABLE  void CalculatorRunner::setLayerInformation(int index, int enzymeLayer, double Ds, double Dp, double d, double e0) {
    biosensorInformation->biosensorLayers[index].enzymeLayer = enzymeLayer;
    //[um^2/s] -> [cm^2/s]
    biosensorInformation->biosensorLayers[index].Ds = Ds * 1e-8;
    //[um^2/s] -> [cm^2/s]
    biosensorInformation->biosensorLayers[index].Dp = Dp * 1e-8;
    //[um] -> [cm]
    biosensorInformation->biosensorLayers[index].d = d * 1e-4;
    //[mol/l] -> [mol/cm^3]
    biosensorInformation->biosensorLayers[index].e0 = e0 * 1e-3;
}
