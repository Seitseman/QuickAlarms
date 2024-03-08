import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Text {
    id: root
    color: Tumbler.tumbler.Material.foreground
    font: Tumbler.tumbler.font
    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 3)
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    text: qsTr("text")
}
