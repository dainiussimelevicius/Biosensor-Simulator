#ifndef CALCULATORRUNNER_H
#define CALCULATORRUNNER_H

#include <QObject>
#include <QString>
#include "biosensor_information.h"

class CalculatorRunner : public QObject
{
    Q_OBJECT
public:
    CalculatorRunner(QObject *parent = 0);
    ~CalculatorRunner();
    Q_INVOKABLE  void runCalculator();
    Q_INVOKABLE  void setBiosensorInformation(int explicit_scheme, int subs_inh, int prod_inh, \
                                 double k2, double km, double ks, double kp, double dt, int n, \
                                 int resp_t_meth, double min_t, double resp_t, \
                                 const QString &out_file_name, int ne, double s0, double p0, \
                                 int layer_count);
    Q_INVOKABLE  void setLayerInformation(int index, int enz_layer, double Ds, double Dp, double d, double e0);
private:
    void *calculator_lib_handle_;
    void (*calculate_function_)(struct bio_params *);
    struct bio_params *biosensor_information_;
};

#endif // CALCULATORRUNNER_H
