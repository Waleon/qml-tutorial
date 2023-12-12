.pragma library

function sendRequestAsync(url, successfulCallback, failedCallback) {
    // 1. 创建 XMLHttpRequest 对象
    let xhr = new XMLHttpRequest()

    // 2. 为 onreadystatechange 事件分配一个回调函数
    xhr.onreadystatechange = function() {

        // 在请求完成后，根据 HTTP 状态码来判断请求是否成功，然后进行相应的业务处理和错误提示。
        if (xhr.readyState === XMLHttpRequest.DONE) {

            console.info("status: " + xhr.status)


            if (xhr.status === 200) {
                let response = {
                    headers : xhr.getAllResponseHeaders(),
                    content : xhr.response
                }

                successfulCallback(response)
            } else {
                let error = {
                    status : xhr.status,
                    statusText : xhr.statusText
                }

                failedCallback(error)
            }
        }
    }

    // 3. 指定 HTTP 请求参数
    xhr.open("GET", url)

    // 4. 将请求发送给服务器
    xhr.send()

    return xhr
}

function abort(xhr) {
    xhr.abort()
}
