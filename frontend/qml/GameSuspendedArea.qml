import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

import vg.phoenix.models 1.0
import vg.phoenix.themes 1.0
import vg.phoenix.backend 1.0

// Suspended game section
Rectangle {
    id: gameSuspendedArea;
    color: PhxTheme.common.gameSuspendedBackgroundColor;
    Layout.fillWidth: true;
    height: 65;
    z: parent.z + 1;
    anchors { bottom: parent.bottom }
    visible: root.gameViewObject.videoItem.coreState === Core.STATEPAUSED;

    Row {
        anchors.fill: parent;
        spacing: 0;

        Rectangle {
            anchors { top: parent.top; bottom: parent.bottom; }
            width: PhxTheme.common.menuWidth;
            color: "transparent";

            Image {
                id: gridItemImage;
                anchors { bottomMargin: 8; leftMargin: 8; left: parent.left; right: parent.right; bottom: parent.bottom; }
                visible: true;
                asynchronous: true;
                width: 48;
                height: 48;
                horizontalAlignment: Image.AlignLeft;
                source: "missingArtwork.png";
                sourceSize { width: 400; height: 400; }
                fillMode: Image.PreserveAspectFit;
            }

            Label {
                anchors { left: parent.left; leftMargin: 64; verticalCenter: parent.verticalCenter; }
                elide: Text.ElideRight;
                width: PhxTheme.common.menuWidth - 72;
                text: root.gameViewObject.coreGamePair[ "title" ];
                color: PhxTheme.normalFontColor;
                font.pixelSize: PhxTheme.common.suspendedGameFontSize;
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;
                onClicked: {
                    // Prevent user from clicking on anything while the transition occurs
                    root.disableMouseClicks();

                    // Destroy the compenent this MouseArea lives in
                    layoutStackView.pop();
                }
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                onEntered: {
                    parent.color = PhxTheme.common.gameSuspendedHoverBackgroundColor;
                    rootMouseArea.cursorShape = Qt.PointingHandCursor;
                }
                onExited: {
                    parent.color = "transparent" // "PhxTheme.common.suspendedGameBackgroundColor";
                    rootMouseArea.cursorShape = Qt.ArrowCursor;
                }
            }
        }

        // Play button
        Rectangle {
            anchors { top: parent.top; bottom: parent.bottom; }
            color: "transparent";
            width: 48;
            Button {
                anchors.centerIn: parent;
                width: parent.width;
                iconName: "Play";
                iconSource:  "play.svg";
                style: ButtonStyle { background: Rectangle { color: "transparent"; } }
                MouseArea {
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                    onClicked: {
                        // Prevent user from clicking on anything while the transition occurs
                        root.disableMouseClicks();

                        // Destroy the compenent this MouseArea lives in
                        layoutStackView.pop();
                    }
                    onEntered: { rootMouseArea.cursorShape = Qt.PointingHandCursor; }
                    onExited: { rootMouseArea.cursorShape = Qt.ArrowCursor; }
                }
            }
        }
    }

    Row {
        anchors { top: parent.top; bottom: parent.bottom; right: parent.right; }

        Rectangle {
            anchors { top: parent.top; bottom: parent.bottom; }
            width: 50;
            color: "transparent";

           // Close
           Button {
                anchors.centerIn: parent;
                width: parent.width;
                iconName: "Close";
                iconSource: "close.svg";
                style: ButtonStyle { background: Rectangle { color: "transparent"; } }
                onPressedChanged: {
                    if( pressed ) { root.gameViewObject.videoItem.slotStop(); }
                }
            }
            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                onEntered: { rootMouseArea.cursorShape = Qt.PointingHandCursor; }
                onExited: { rootMouseArea.cursorShape = Qt.ArrowCursor; }
                onClicked: { root.gameViewObject.videoItem.slotStop(); }
            }
        }
    }
}
