import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import B2.Sound 1.0

Item {
    id: mainWindow
    visible: true
    width: 960
    height: 640
    focus: true

    FontLoader{id:myFont; source:'qrc:/fonts/PingFangM.ttf'}

    Rectangle{
        id: headPhoneMask
        anchors.fill: parent
        color: 'black'
        z: 9999
        opacity: 1
        Behavior on opacity {NumberAnimation {duration:2500}}
    }
    Text{
        id: headPhoneText
        anchors.horizontalCenter: parent.horizontalCenter
        y: 250
        text: "For better effect, please use headphones."
        font.family: myFont.name
        font.pixelSize: 40
        color: 'white'
        z: 10000
        Behavior on opacity {NumberAnimation {duration:1000}}
    }
    Button{
        id: headPhoneOk
        text: 'English'
        anchors.centerIn: parent
        onClicked: {
            headPhoneMask.opacity=0
            headPhoneText.opacity=0
            startStage()
            visible=false
            headPhoneOkChs.visible=false
        }
        z:10001
    }
    Button{
        id: headPhoneOkChs
        text: '简体中文'
        anchors.horizontalCenter: headPhoneOk.horizontalCenter
        anchors.top: headPhoneOk.bottom
        anchors.topMargin: 10
        onClicked: {
            headPhoneMask.opacity=0
            headPhoneText.opacity=0
            startStage('chs')
            visible=false
            headPhoneOk.visible=false
        }
        z: 10002
    }

    // root bg
    Rectangle{
        id: root
        anchors.fill: parent
        color: 'gray'
        Image{
            id: bgParadise
            anchors.fill: parent
            source: 'qrc:/images/paradise-color.jpg'
            visible: false
        }
        Desaturate {
            id: bgAdjust
            anchors.fill: bgParadise
            source: bgParadise
            desaturation: 0.1
            opacity: 0.6
            Behavior on desaturation {NumberAnimation {duration: 3000}}
            Behavior on opacity {NumberAnimation {duration: 3000}}
        }
    }

    // key events
    property var directions: [0,0,0,0]
    Keys.onPressed: function(e){
        e.accepted=true
        if(e.key===Qt.Key_W)
            directions[0]=1
        else if(e.key===Qt.Key_S)
            directions[1]=1
        else if(e.key===Qt.Key_A)
            directions[2]=1
        else if(e.key===Qt.Key_D)
            directions[3]=1
        you.setVel(directions[3]-directions[2], directions[1]-directions[0])
    }
    Keys.onReleased: function(e){
        e.accepted=true
        if(e.key===Qt.Key_W)
            directions[0]=0
        else if(e.key===Qt.Key_S)
            directions[1]=0
        else if(e.key===Qt.Key_A)
            directions[2]=0
        else if(e.key===Qt.Key_D)
            directions[3]=0
        you.setVel(directions[3]-directions[2], directions[1]-directions[0])
    }

    // instructor
    Text{
        id: inst
        anchors.horizontalCenter: parent.horizontalCenter
        text: " "
        x: 100
        y: 175
        font.family: myFont.name
        font.pixelSize: 38
        color: 'white'
        z: 10
        Text{
            id: instShadow
            x: 1
            y: 1
            z: -1
            font.family: myFont.name
            font.pixelSize: inst.font.pixelSize
            color: 'black'
            text: inst.text
            opacity: 0.7
        }
    }

    // the mask above all
    Rectangle{
        id: mask
        anchors.fill: parent
        color: 'black'
        opacity: 0
        z: 9999
        Behavior on opacity {NumberAnimation {duration: 2500}}
        Text{
            anchors.centerIn: parent
            text: "The End"
            font.pixelSize: 35
            color: 'white'
        }
    }

    // image mod
    B2Image{id: image}
    // parser mod
    B2Parser{ id: parser }
    // function mod
    B2Func{ id:func }

    // You
    You{id: you}

    // start
    function startStage(chs){
        if(chs)
            parser.reset('chs-stage1.script')
        else
            parser.reset('stage1.script')
        parser.run()
    }
}
