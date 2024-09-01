#include <QGuiApplication>
#include <QLoggingCategory>
#include <QQmlApplicationEngine>
#include <QList>
#include "arcdraw.h"
#include "convexhull.h"
#include "crossline.h"

Q_LOGGING_CATEGORY(lcGcStats, "qt.qml.gc.statistics")
Q_DECLARE_LOGGING_CATEGORY(lcGcStats)
Q_LOGGING_CATEGORY(lcGcAllocatorStats, "qt.qml.gc.allocatorStats")
Q_DECLARE_LOGGING_CATEGORY(lcGcAllocatorStats)


using TPointList = QList<QPointF>;
Q_DECLARE_METATYPE(TPointList)

QObject* getInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    TConvexHullModel * inst = TConvexHullModel::getInstance(engine,
                                                          scriptEngine);
    return inst;
}

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    qmlRegisterType<TArcDraw>("ArcDraw", 1, 0, "TArcDraw");
    qmlRegisterType<TCrossline>("CrossLine", 1, 0, "TCrossLine");
    qmlRegisterType<TConvexHullModel>("hullmodel", 1, 0,
                                               "TConvexHullModel");
    qRegisterMetaType<TPointList>("TPointList");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
