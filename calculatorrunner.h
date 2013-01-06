#ifndef CALCULATORRUNNER_H
#define CALCULATORRUNNER_H

#include <stdio.h>
#include <QObject>
#include <dlfcn.h>

class CalculatorRunner : public QObject
{
    Q_OBJECT
public:
    CalculatorRunner(QObject* parent = 0);
    ~CalculatorRunner();
    Q_INVOKABLE  void runCalculator(double v1, double v2);
private:
    void *calculatorLibHandle;
    double (*meanFunction)(double, double);
};

#endif // CALCULATORRUNNER_H
