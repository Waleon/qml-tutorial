import QtQuick
import QtQuick.Window
import QtWebEngine

Window {
    width: 1000
    height: 800
    visible: true

    WebEngineView {
        id: engineView
        anchors.fill: parent
        url: "https://waleon.blog.csdn.net/"

        // 加载开始、结束、成功、失败时
        onLoadingChanged: (loadingInfo)=> {
            switch (loadingInfo.status) {
                case WebEngineView.LoadStartedStatus:
                    console.info("load started: " + loadingInfo.url);
                    break;
                case WebEngineView.LoadStoppedStatus:
                    console.info("load stopped: " + loadingInfo.url);
                     break;
                case WebEngineView.LoadSucceededStatus:
                    console.info("load succeeded: " + loadingInfo.url);
                    break;
                case WebEngineView.LoadFailedStatus:
                    console.error("load failed, errorCode:%1, errorDomain:%2, errorString:%3"
                                  .arg(loadingInfo.errorCode).arg(loadingInfo.errorDomain).arg(loadingInfo.errorString));
                    break;
                default:
                    break;
                }
        }

        // 加载进度改变（0 ~ 100）
        onLoadProgressChanged: {
            console.info("load progress: " + loadProgress + "%");
        }
    }
}
