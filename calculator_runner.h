#ifndef CALCULATORRUNNER_H
#define CALCULATORRUNNER_H

#include <windows.h>
#include <QObject>
#include <QThread>
#include <QMutex>
#include <QString>
#include <QList>
#include <QSharedPointer>
#include "biosensor_information.h"

class ThreadedCalculator : public QObject
{
    Q_OBJECT
public:
    ThreadedCalculator(int progress_bar_id, QMutex *mutex);
    void callback_crunched(int time);
    void (*calculate_function_)(struct bio_params *, void *, void (*)(void *, int));
    struct bio_params *biosensor_information_;
public slots:
    void calculate();
private:
    //Šis metodas reikalingas todėl, kad iš C kaip callback funkciją galima iškviesti tik statinį metodą
    static void wrapper_callback_crunched(void *ptr, int time);
    int progress_bar_id_;
    QMutex *mutex_;
signals:
    void crunched(int id, int time);
    void finished(int id);
};

class CalculatorRunner : public QObject
{
    Q_OBJECT
public:
    CalculatorRunner();
    ~CalculatorRunner();
    Q_INVOKABLE  void runCalculator(int progress_bar_id);
    Q_INVOKABLE  void setBiosensorInformation(int explicit_scheme, int subs_inh, int prod_inh, \
                                 double k2, double km, double ks, double kp, double dt, int n, \
                                 int resp_t_meth, double min_t, double resp_t, \
                                 const QString &out_file_name, int ne, double s0, double p0, \
                                 int layer_count);
    Q_INVOKABLE  void setLayerInformation(int index, int enz_layer, double Ds, double Dp, double d, double e0);
public slots:
    void update_time(int id, int time);
    void close_progress(int id);
private:
    HINSTANCE calculator_lib_handle_;
    void (*calculate_function_)(struct bio_params *, void *, void (*)(void *, int));
    struct bio_params *biosensor_information_;
    QList<QSharedPointer<QThread> > thread_list_;
    QList<QSharedPointer<ThreadedCalculator> > calculator_list_;
    QMutex *mutex_;
signals:
    void crunched(int id, int time);
    void finished(int id);
};

#endif // CALCULATORRUNNER_H
