#include <stdio.h>
#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "calculator_runner.h"
#include <QDeclarativeContext>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    //Kitu atveju naudojama tokia lokalė kaip nustatyta sistemoje ir esant lietuviškai lokalei į rezultatų failą rašo skaičius su kableliais
    setenv("LC_NUMERIC", "C", 1);

    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;

    CalculatorRunner calculator_runner;
    viewer.rootContext()->setContextProperty("calculator_runner", &calculator_runner);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/BiosensorSimulator/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
