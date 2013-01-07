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
    biosensorInformation->k2 = k2;
    biosensorInformation->kM = kM;
    biosensorInformation->kS = kS;
    biosensorInformation->kP = kP;
    biosensorInformation->timeStep = timeStep;
    biosensorInformation->N = N;
    biosensorInformation->responseTimeMethod = responseTimeMethod;
    biosensorInformation->minTime = minTime;
    biosensorInformation->responseTime = responseTime;
    biosensorInformation->outputFileName = outputFileName.toLocal8Bit().data();
    biosensorInformation->ne = ne;
    biosensorInformation->s0 = s0;
    biosensorInformation->p0 = p0;
    biosensorInformation->noOfBiosensorLayers = noOfBiosensorLayers;
    biosensorInformation->biosensorLayers = (struct LayerInformation *) malloc(sizeof(struct LayerInformation) * noOfBiosensorLayers);
}

Q_INVOKABLE  void CalculatorRunner::setLayerInformation(int index, int enzymeLayer, double Ds, double Dp, double d, double e0) {
    biosensorInformation->biosensorLayers[index].enzymeLayer = enzymeLayer;
    biosensorInformation->biosensorLayers[index].Ds = Ds;
    biosensorInformation->biosensorLayers[index].Dp = Dp;
    biosensorInformation->biosensorLayers[index].d = d;
    biosensorInformation->biosensorLayers[index].e0 = e0;
}
