import QtQuick 2.4

Canvas {
    id:canvas
    property color arcColor:"lightgreen"
    property color arcBackgroundColor:"#ccc"
    property int arcWidth:2
    property real progress:0 // 0~360
    property real radius: 100 //
    property bool anticlockwise:false

    width: 2 * radius
    height:  2 * radius

    onPaint: {
        var ctx = getContext("2d")
        var text,text_w
        ctx.clearRect(0,0,width,height)
        ctx.beginPath()
        ctx.strokeStyle = arcBackgroundColor
        ctx.lineWidth = arcWidth
        ctx.arc(width/2,height/2,radius,0,Math.PI*2,anticlockwise)
        ctx.stroke()

        var r = progress*Math.PI/180
        ctx.beginPath()
        ctx.strokeStyle = arcColor
        ctx.lineWidth = arcWidth

        //object arc(real x, real y, real radius, real startAngle, real endAngle, bool anticlockwise)
        ctx.arc(width/2,height/2,radius,0-90*Math.PI/180,r-90*Math.PI/180,anticlockwise)
        ctx.stroke()
    }

    Connections {
        target: canvas
        onProgressChanged: canvas.requestPaint()
    }
}



