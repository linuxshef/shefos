import "components"

import QtQuick 2.0
import QtQuick.Layouts 1.2

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls.Styles 1.4


SessionManagementScreen {

    property bool showUsernamePrompt: !showUserList

    property string lastUserName

    //the y position that should be ensured visible when the on screen keyboard is visible
    property int visibleBoundary: mapFromItem(loginButton, 0, 0).y
    onHeightChanged: visibleBoundary = mapFromItem(loginButton, 0, 0).y + loginButton.height + units.smallSpacing

    signal loginRequest(string username, string password)

    onShowUsernamePromptChanged: {
        if (!showUsernamePrompt) {
            lastUserName = ""
        }
    }

    /*
    * Login has been requested with the following username and password
    * If username field is visible, it will be taken from that, otherwise from the "name" property of the currentIndex
    */
    function startLogin() {
        var username = showUsernamePrompt ? userNameInput.text : userList.selectedUser
        var password = passwordBox.text

        //this is partly because it looks nicer
        //but more importantly it works round a Qt bug that can trigger if the app is closed with a TextField focussed
        //DAVE REPORT THE FRICKING THING AND PUT A LINK
        loginButton.forceActiveFocus();
        loginRequest(username, password);
    }

    PlasmaComponents.TextField {
        id: userNameInput
        Layout.fillWidth: true

        text: lastUserName
        visible: showUsernamePrompt
        focus: showUsernamePrompt && !lastUserName //if there's a username prompt it gets focus first, otherwise password does
        placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Username")

        onAccepted: passwordBox.forceActiveFocus()
    }

    PlasmaComponents.TextField {
        id: passwordBox
        Layout.fillWidth: true

        placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Password")
        focus: !showUsernamePrompt || lastUserName
        echoMode: TextInput.Password
        revealPasswordButtonShown: true
        textColor: "#222222"
        horizontalAlignment: TextInput.Center
        onAccepted: startLogin()

        Keys.onEscapePressed: {
            mainStack.currentItem.forceActiveFocus();
        }

        style: TextFieldStyle {
             placeholderTextColor: "#dcdcdc"
            background: Rectangle {
                radius: 1
                color: "#ffffff"
                opacity: 0.7
            }
        }

        //if empty and left or right is pressed change selection in user switch
        //this cannot be in keys.onLeftPressed as then it doesn't reach the password box
        Keys.onPressed: {
            if (event.key == Qt.Key_Left && !text) {
                userList.decrementCurrentIndex();
                event.accepted = true
            }
            if (event.key == Qt.Key_Right && !text) {
                userList.incrementCurrentIndex();
                event.accepted = true
            }
        }

        Connections {
            target: sddm
            onLoginFailed: {
                passwordBox.selectAll()
                passwordBox.forceActiveFocus()
            }
        }
    }
    // PlasmaComponents.Button {
    //     id: loginButton
    //     Layout.fillWidth: true
    //     text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Login")
    //     onClicked: startLogin();
    // }

        Rectangle{
        implicitWidth:  48
        implicitHeight: 48
        color: "transparent"
        anchors.horizontalCenter: passwordBox.horizontalCenter
        anchors.topMargin: 24
        //visible: passwordBox.text != ""
        scale: passwordBox.text != "" ? 1 : 0
        Behavior on scale { 
       NumberAnimation  { duration: 800 ; easing.type: Easing.InOutQuad } 
        } 
        Image {
            anchors.centerIn: parent
            id: loginButton
            source: "components/artwork/go.svg" 
            sourceSize: Qt.size(32,32)
            smooth: true
            opacity: 0.7
        }
        MouseArea {
            anchors.fill: parent
            onClicked: startLogin();
        }
    }

}
