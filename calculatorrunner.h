#ifndef CALCULATORRUNNER_H
#define CALCULATORRUNNER_H

#include <stdio.h>
#include <QObject>
#include <dlfcn.h>

class CalculatorRunner : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE  void runCalculator(double v1, double v2);
};

#endif // CALCULATORRUNNER_H
