#include <stdio.h>
#include <dlfcn.h>
#include <QDeclarativeProperty>
#include <stdio.h>
#include "calculator_runner.h"

CalculatorRunner::CalculatorRunner() : QObject(0) {
    calculator_lib_handle_ = dlopen("./libbiosensor_calculator.so", RTLD_NOW);
    if(calculator_lib_handle_ == NULL) {
        printf("Calculator library was not found!\n");
        exit(EXIT_FAILURE);
    }
    calculate_function_ = (void (*)(struct bio_params *, void *, void (*)(void *, int))) dlsym(calculator_lib_handle_, "calculate");
    if(calculate_function_ == NULL) {
        printf("Could not load calculator function!\n");
        exit(EXIT_FAILURE);
    }
    biosensor_information_ = NULL;
    mutex_ = new QMutex();
}

CalculatorRunner::~CalculatorRunner() {
    dlclose(calculator_lib_handle_);
    if (biosensor_information_ != NULL) {
        free(biosensor_information_->layers);
        free(biosensor_information_->out_file_name);
        free(biosensor_information_);
    }
    delete mutex_;
}

Q_INVOKABLE  void CalculatorRunner::runCalculator(int progress_bar_id) {
    struct bio_params *biosensor_information = biosensor_information_;
    biosensor_information_ = NULL;

    //Kalkulatorius sukuriamas ir įdedamas į calculator_list_, kad būtų galima sunaikinti destruktoriuje
    ThreadedCalculator *threaded_calculator = new ThreadedCalculator(progress_bar_id, mutex_);
    QSharedPointer<ThreadedCalculator> calculator_holder(threaded_calculator);
    calculator_list_ << calculator_holder;

    //Gija sukuriama ir įdedama į thread_list_, kad būtų galima sunaikinti destruktoriuje
    QThread *calculator_thread = new QThread;
    QSharedPointer<QThread> thread_holder(calculator_thread);
    thread_list_ << thread_holder;

    threaded_calculator->calculate_function_ = calculate_function_;
    threaded_calculator->biosensor_information_ = biosensor_information;
    threaded_calculator->moveToThread(calculator_thread);

    this->connect(threaded_calculator, SIGNAL(crunched(int,int)), SLOT(update_time(int,int)));
    this->connect(threaded_calculator, SIGNAL(finished(int)), SLOT(close_progress(int)));

    //Kai įvyks calculator_thread.started(), bus iškviestas threaded_calculator.calculate()
    threaded_calculator->connect(calculator_thread, SIGNAL(started()), SLOT(calculate()));

    //Kai kalkuliatorius baigia darbą, duodamas signalas finished() ir iškviečiamas gijos metodas quit()
    calculator_thread->connect(threaded_calculator, SIGNAL(finished(int)), SLOT(quit()));

    calculator_thread->start();
}

Q_INVOKABLE void CalculatorRunner::setBiosensorInformation(int explicit_scheme, int subs_inh, int prod_inh, \
                                                           double k2, double km, double ks, double kp, double dt, int n, \
                                                           int resp_t_meth, double min_t, double resp_t, \
                                                           const QString &out_file_name, int ne, double s0, double p0, \
                                                           int layer_count) {
    biosensor_information_ = (struct bio_params *) malloc(sizeof(*biosensor_information_));
    biosensor_information_->explicit_scheme = explicit_scheme;
    biosensor_information_->subs_inh = subs_inh;
    biosensor_information_->prod_inh = prod_inh;
    //[s^-1]
    biosensor_information_->k2 = k2;
    //[mol/l] -> [mol/cm^3]
    biosensor_information_->km = km * 1e-3;
    //[mol/l] -> [mol/cm^3]
    biosensor_information_->ks = ks * 1e-3;
    //[mol/l] -> [mol/cm^3]
    biosensor_information_->kp = kp * 1e-3;
    //[s]
    biosensor_information_->dt = dt;
    biosensor_information_->n = n;
    biosensor_information_->resp_t_meth = (enum resp_method) resp_t_meth;
    //[s]
    biosensor_information_->min_t = min_t;
    //[s]
    biosensor_information_->resp_t = resp_t;

    biosensor_information_->out_file_name = (char *) malloc(strlen(out_file_name.toLocal8Bit().data()) + 1);
    strcpy(biosensor_information_->out_file_name, out_file_name.toLocal8Bit().data());

    biosensor_information_->ne = ne;
    //[mol/l] -> [mol/cm^3]
    biosensor_information_->s0 = s0 * 1e-3;
    //[mol/l] -> [mol/cm^3]
    biosensor_information_->p0 = p0 * 1e-3;
    biosensor_information_->layer_count = layer_count;
    biosensor_information_->layers = (struct layer_params *) malloc(sizeof(*(biosensor_information_->layers)) * layer_count);
}

Q_INVOKABLE  void CalculatorRunner::setLayerInformation(int index, int enz_layer, double Ds, double Dp, double d, double e0) {
    biosensor_information_->layers[index].enz_layer = enz_layer;
    //[um^2/s] -> [cm^2/s]
    biosensor_information_->layers[index].Ds = Ds * 1e-8;
    //[um^2/s] -> [cm^2/s]
    biosensor_information_->layers[index].Dp = Dp * 1e-8;
    //[um] -> [cm]
    biosensor_information_->layers[index].d = d * 1e-4;
    //[mol/l] -> [mol/cm^3]
    biosensor_information_->layers[index].e0 = e0 * 1e-3;
}

void CalculatorRunner::update_time(int id, int time) {
    emit crunched(id, time);
}

void CalculatorRunner::close_progress(int id) {
    emit finished(id);
}

ThreadedCalculator::ThreadedCalculator(int progress_bar_id, QMutex *mutex) : QObject(0) {
    progress_bar_id_ = progress_bar_id;
    mutex_ = mutex;
}

void ThreadedCalculator::callback_crunched(int time) {
    emit crunched(progress_bar_id_, time);
}

void ThreadedCalculator::wrapper_callback_crunched(void *ptr, int time) {
    ThreadedCalculator *self = (ThreadedCalculator *) ptr;
    self->callback_crunched(time);
}

void ThreadedCalculator::calculate() {
    //Paleidžiame skaičiavimus
    (*calculate_function_)(biosensor_information_, (void*) this, &wrapper_callback_crunched);

    //Atlaisviname atmintį
    free(biosensor_information_->layers);
    free(biosensor_information_->out_file_name);
    free(biosensor_information_);

    //Progress bar pašalinimas nėra atominis veiksmas, todėl apsaugome jį su mutex
    mutex_->lock();
    emit finished(progress_bar_id_);
    mutex_->unlock();
}
