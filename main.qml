import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    id: root
    property alias window: root
    width: 400
    height: 500
    visible: true
    title: qsTr("Alarms")

    ListView {
        id: alarmListView
        anchors.fill: parent
        model: AlarmModel {}
        delegate: AlarmDelegate {}
    }

    RoundButton {
        id: addAlarmButton
        text: "+"
        anchors.bottom: alarmListView.bottom
        anchors.bottomMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: alarmDialog.open()
    }

    AlarmDialog {
        id: alarmDialog
        x: Math.round(0.5*(parent.width - width))
        y: Math.round(0.5*(parent.height - height))
        alarmModel: alarmListView.model
    }
}
