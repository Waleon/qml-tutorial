/****************************************
* @brief    QML 中的 z-order
* @blog     https://waleon.blog.csdn.net/article/details/129351643
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Rectangle {
    id: zorderPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 同级元素（z 值相同），晚创建的元素会显示在早创建的之上。
        Item {
            width: 200; height: 200

            Rectangle {
                width: 100; height: 100
                color: "green"
            }

            Rectangle {
                x: 50; y: 50; width: 100; height: 100
                color: "blue"
            }
        }

        // 2. 同级元素（z 值不同），z 值大的在上面
        Item {
            width: 200; height: 200

            Rectangle {
                z: 1
                width: 100; height: 100
                color: "green"
            }

            Rectangle {
                x: 50; y: 50; width: 100; height: 100
                color: "blue"
            }
        }

        // 3. 父子关系（z 值相同），子在父之上
        Item {
            width: 200; height: 200

            Rectangle {
                width: 100; height: 100
                color: "green"

                Rectangle {
                    x: 50; y: 50; width: 100; height: 100
                    color: "blue"
                }
            }
        }

        // 4. 父子关系（子元素 z 值为负数）
        // 要让子元素显示在父元素之下，只能给子元素的 z 值设置负数。
        Item {
            width: 200; height: 200

            Rectangle {
                width: 100; height: 100
                color: "green"

                Rectangle {
                    z: -1
                    x: 50; y: 50; width: 100; height: 100
                    color: "blue"
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
