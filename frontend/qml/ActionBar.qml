import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

import vg.phoenix.backend 1.0
import vg.phoenix.themes 1.0

Rectangle {
    height: 65;
    color: Qt.rgba(0,0,0,0.35);

    // actionBar visible only when paused or mouse recently moved and only while not transitioning
    opacity: ( ( ( gameView.coreState === Core.STATEPAUSED ) || ( cursorTimer.running ) )
                && ( !layoutStackView.transitioning ) ) ? 1.0 : 0.0;

    Behavior on opacity {
        PropertyAnimation { duration: 250; }
    }

    function resetWindowSize() {
        root.minimumWidth = root.defaultMinWidth;
        root.minimumHeight = root.defaultMinHeight;
        if( root.height < root.defaultMinHeight ) {
            root.height = root.defaultMinHeight;
        }
        if( root.width < root.defaultMinWidth ) {
            root.width = root.defaultMinWidth;
        }
    }

    Row {
        id: mediaButtonsRow;
        anchors {
            fill: parent;
        }

        spacing: 0;

        Rectangle {
            anchors {
                top: parent.top;
                bottom: parent.bottom;
            }

            width: height;


            Label {
                anchors {
                    centerIn: parent;
                }
                text: videoItem.running ? qsTr( "Pause" ) : qsTr( "Play" );
                color: "black";
            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if ( videoItem.running ) {
                        videoItem.slotPause();
                    } else {
                        videoItem.slotResume();
                    }
                }
            }
        }

        Rectangle {
            anchors {
                top: parent.top;
                bottom: parent.bottom;
            }

            color: "#00000000"
            width: height;

            Label {
                anchors.centerIn: parent;
                color: PhxTheme.normalFontColor;
                text: qsTr( "Blur" );
            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if( blurEffect.visible ) {
                        blurEffect.visible = false;
                    }
                    else if( !blurEffect.visible ) {
                        blurEffect.visible = true;
                    }
                }
            }
        }

        Rectangle {
            anchors {
                top: parent.top;
                bottom: parent.bottom;
            }

            color: "#00000000"
            radius: 0
            width: height;

            Label {
                anchors.centerIn: parent;
                color: PhxTheme.normalFontColor;
                text: qsTr( "Shutdown" );
            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    videoItem.slotStop();
                    root.disableMouseClicks();
                    rootMouseArea.hoverEnabled = false;
                    resetCursor();
                    resetWindowSize();
                    layoutStackView.push( mouseDrivenView );
                }
            }
        }
    }

    Rectangle {
        anchors {
            top: parent.top;
            bottom: parent.bottom;
            right: parent.right;
        }

        color: "#00000000"
        width: height;

        Label {
            anchors.centerIn: parent;
            color: PhxTheme.normalFontColor;
            text: qsTr( "Suspend" );
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                videoItem.slotPause();
                root.disableMouseClicks();
                rootMouseArea.hoverEnabled = false;
                resetCursor();
                resetWindowSize();
                layoutStackView.push( mouseDrivenView );
            }
        }
    }
}
