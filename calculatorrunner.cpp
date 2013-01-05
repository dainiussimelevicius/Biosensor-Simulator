#include "calculatorrunner.h"

Q_INVOKABLE  void CalculatorRunner::runCalculator(double v1, double v2) {
   void *calculatorLibHandle;
   double (*meanFunction)(double, double);

   calculatorLibHandle = dlopen("libmean.so",RTLD_NOW);
   if(calculatorLibHandle == NULL) {
       printf("Calculator library was not found!\n");
   }
   meanFunction = (double (*)(double, double)) dlsym(calculatorLibHandle,"mean");
   if(meanFunction==NULL) {
       printf("Could not load calculator function!\n");
   }
   printf("Return code is %f\n",(*meanFunction)(v1, v2));
}

