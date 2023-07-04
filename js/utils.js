// 绘制边框，更容易看出效果
function drawBorder(ctx) {
    ctx.save()
    ctx.strokeStyle = "lightgray"
    ctx.beginPath()
    ctx.strokeRect(0, 0, ctx.canvas.width, ctx.canvas.height)
    ctx.restore()
}
