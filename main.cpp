#include <stdio.h>
#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "calculator_runner.h"
#include <QDeclarativeContext>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;

    CalculatorRunner calculatorRunner;
    viewer.rootContext()->setContextProperty("calculatorRunner", &calculatorRunner);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/BiosensorSimulator/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
