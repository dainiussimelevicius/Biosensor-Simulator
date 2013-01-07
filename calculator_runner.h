#ifndef CALCULATORRUNNER_H
#define CALCULATORRUNNER_H

#include <QObject>
#include <QString>
#include "biosensor_information.h"

class CalculatorRunner : public QObject
{
    Q_OBJECT
public:
    CalculatorRunner(QObject* parent = 0);
    ~CalculatorRunner();
    Q_INVOKABLE  void runCalculator();
    Q_INVOKABLE  void setBiosensorInformation(int explicitScheme, int substrateInhibition, int productInhibition, \
                                 double k2, double kM, double kS, double kP, double timeStep, int N, \
                                 int responseTimeMethod, double minTime, double responseTime, \
                                 const QString &outputFileName, int ne, double s0, double p0, \
                                 int noOfBiosensorLayers);
    Q_INVOKABLE  void setLayerInformation(int index, int enzymeLayer, double Ds, double Dp, double d, double e0);
private:
    void *calculatorLibHandle;
    void (*calculateFunction)(struct BiosensorInformation *);
    struct BiosensorInformation * biosensorInformation;
};

#endif // CALCULATORRUNNER_H
