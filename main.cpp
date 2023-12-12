#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStandardPaths>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

//    app.setOrganizationName("waleon");
//    app.setOrganizationDomain("waleon.blog.csdn.net");
//    app.setApplicationName("qmltutorial");

//    // 注册单例类型
//    qmlRegisterSingletonType(QUrl("qrc:/qml/global/Constants.qml"), "qml.tutorial.singleton", 1, 0, "Constants");

    QQmlApplicationEngine engine("qrc:/qml/main.qml");

    // 获取默认的数据库存储路径
    qInfo() << "old storage path:" << engine.offlineStoragePath();

    // 更改数据库所在路径为“我的文档”
    QString documentsLocation = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    engine.setOfflineStoragePath(documentsLocation);

    // 获取更改后的数据库存储路径
    qInfo() << "new storage path:" << engine.offlineStoragePath();

    return app.exec();
}
