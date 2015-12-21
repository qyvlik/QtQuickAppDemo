import QtQuick 2.5
import Sparrow 1.0
import "./Component/ImageExplorer"

PageStackWindow {
    id: mainWindow
    initialPage:  ImageExplorerPage {
        width: mainWindow.width
        height: mainWindow.height
        // windowsxp 后缀 windows7 下需要使用file:/前缀
        folder: "file:/F:/回忆/大二/新建文件夹"
    }
}

