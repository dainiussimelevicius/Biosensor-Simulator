#include "calculatorrunner.h"

CalculatorRunner::CalculatorRunner(QObject* parent) : QObject(parent) {
    calculatorLibHandle = dlopen("./libmean.so", RTLD_NOW);
    if(calculatorLibHandle == NULL) {
        printf("Calculator library was not found!\n");
        exit(EXIT_FAILURE);
    }
    meanFunction = (double (*)(double, double)) dlsym(calculatorLibHandle, "mean");
    if(meanFunction == NULL) {
        printf("Could not load calculator function!\n");
        exit(EXIT_FAILURE);
    }
}

CalculatorRunner::~CalculatorRunner() {
    dlclose(calculatorLibHandle);
}

Q_INVOKABLE  void CalculatorRunner::runCalculator(double v1, double v2) {
    printf("Return code is %f\n",(*meanFunction)(v1, v2));
}

