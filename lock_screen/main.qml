import QtQuick 2.6
import QtQuick.Controls 2.0

ApplicationWindow {

    width: 360
    height: 640

//    LockScreen {
//        anchors.fill: parent
//    }


    Button {
        text: "fb"
        onClicked: {
            console.time("fb");
            console.log(fb(30));
            console.timeEnd("fb");
        }
    }


    function fb(a) {
        if(a <= 2) {
            return 1;
        } else {
            return fb(a-2)+fb(a-1);
        }
    }

}
