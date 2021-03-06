/*
 * Copyright 2021 Rui Wang <wangrui@jingos.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.5
import org.kde.kirigami 2.11 as Kirigami
import org.kde.kirigami 2.15 as Kirigami215
import org.kde.kirigami 2.8 as Kirigami28

ScrollablePage {
    id: page

    Layout.fillWidth: true

    title: "PopupGallery"

    background: Item{
    }
    
    actions {
        contextualActions: [
            Kirigami.Action {
                text: "action 1"
            },
            Kirigami.Action {
                text: "action 2"
            }
        ]
    }

    Kirigami215.JDialog{
        id:dialog

        title: "Delete"
        text: "Are you sure you want to delete this file?"
        rightButtonText: qsTr("Save")
        leftButtonText: qsTr("Close")

        visible:false
        sourceItem: page

        onLeftButtonClicked:{
            dialog.close()
        }
    }

    Kirigami215.JInputDialog{
        id:inputDialog

        title: "Enter Password"
        echoMode: TextInput.Password
        visible:false

        onCancelButtonClicked:{
            console.log("###########onCancelButtonClicked")
        }

        onOkButtonClicked:{
            console.log("###########onOkButtonClicked")
            console.log("###########onOkButtonClicked----inputDialog.inputText:" + inputDialog.inputText)
            inputDialog.close()
        }
    }

    Column {
        width: page.width
        spacing: Units.smallSpacing

        Rectangle{
            width:parent.width
            height: 200
            color:"red"

            Text{
                text: "Dialog test1"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: {
                    dialog.startX = mouseX
                    dialog.startY = mouseY
                    dialog.popup
                }
            }
        }

        Rectangle{
            id: dailog2
            width:parent.width
            height: 200
            color:"green"

            Text{
                text: "Dialog test2"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: {
                    dialog.startX = mouseX
                    dialog.startY = mouseY
                    dialog.open()
                    var jx = dailog2.mapToItem(page, dailog2.x, dailog2.y)
                }
            }
        }


        Rectangle{
            width:parent.width
            height: 200
            color:"transparent"

            Text{
                text: "Dialog test3"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    dialog.startX = mouseX
                    dialog.startY = mouseY

                    var jx = dailog2.mapToItem(page, mouseX, mouseY)
                    dialog.open()
                }
            }
        }

        Rectangle{
            width:parent.width
            height: 200
            color:"transparent"

            Text{
                text: "Input Dialog"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    inputDialog.open()
                }
            }
        }
    }
}
