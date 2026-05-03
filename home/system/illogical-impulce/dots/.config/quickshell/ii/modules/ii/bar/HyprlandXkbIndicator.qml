import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.services
import qs.modules.common
import qs.modules.common.widgets

Loader {
    id: root
    property bool vertical: false
    property color color: Appearance.colors.colOnSurfaceVariant
    property string currentLayoutCode: "us"
    visible: true

    Connections {
      target: Hyprland
      function onRawEvent(event) {
          if (event.name === "activelayout") proc.running = true
      }
    }

    Process {
      id: proc
      running: true
      command: ["hyprctl", "devices", "-j"]
      stdout: StdioCollector {
        onStreamFinished: {
          try {
            var devices = JSON.parse(this.text)
            for (var device of devices.keyboards) {
              if (device.main) {
                root.currentLayoutCode = device.active_keymap
                break
              }
            }
          } catch (e) {}
        }
      }
    }

    sourceComponent: Item {
      implicitWidth: root.vertical ? null : layoutCodeText.implicitWidth
      implicitHeight: root.vertical ? layoutCodeText.implicitHeight : null
        
      StyledText {
        id: layoutCodeText
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        text: root.currentLayoutCode.slice(0, 2).toLowerCase();
        font.pixelSize: text.includes("\n") ? Appearance.font.pixelSize.smallie : Appearance.font.pixelSize.small
        color: root.color
        animateChange: true
      }
    }
}
