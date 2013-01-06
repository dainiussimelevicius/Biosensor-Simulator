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

    (*calculateFunction)(collectBiosensorInformation());
}

struct BiosensorInformation * CalculatorRunner::collectBiosensorInformation() {
    struct BiosensorInformation * biosensorInformation;

    biosensorInformation = (struct BiosensorInformation *) malloc(sizeof(struct BiosensorInformation));
    biosensorInformation->explicitScheme = 1;
    //biosensorInformation->kM = QDeclarativeProperty::read(this, "kmConstant").toDouble();

    printf("kM = %f\n", this->property("kM").toDouble());

    return biosensorInformation;
}
