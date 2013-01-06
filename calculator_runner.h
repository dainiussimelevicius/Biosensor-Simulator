#ifndef CALCULATORRUNNER_H
#define CALCULATORRUNNER_H

#include <QObject>
#include "biosensor_information.h"

class CalculatorRunner : public QObject
{
    Q_OBJECT
public:
    CalculatorRunner(QObject* parent = 0);
    ~CalculatorRunner();
    Q_INVOKABLE  void runCalculator();
private:
    struct BiosensorInformation * collectBiosensorInformation();
    void *calculatorLibHandle;
    void (*calculateFunction)(struct BiosensorInformation *);
    struct BiosensorInformation * biosensorInformation;
};

#endif // CALCULATORRUNNER_H
