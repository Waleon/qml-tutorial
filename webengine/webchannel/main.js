// 初始化 QWebChannel
window.onload = function()
{
    new QWebChannel(qt.webChannelTransport, function(channel) {
        // 访问 QML 端发布的对象，backend 是由 WebChannel.id 指定的标识符
        window.backend = channel.objects.backend;

        // 连接对象的信号
        backend.messageSent.connect(function(message) {
            document.getElementById("message").innerText = message;
        });
    });
}

// 操作对象的属性
function getName()
{
    // 读取属性值
    document.getElementById("name").innerText = backend.name;

    // 更改属性值
    // backend.name = "another value";
}

// 调用对象的方法
function changeStyle()
{
    // 异步接收返回值（由于是异步的，因此弹窗后才会改变样式）
    backend.randomColor(function(returnValue) {
        document.body.style.backgroundColor = returnValue;
    });

    alert("get random color");
}
