import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: root
    Item{
        anchors.fill: parent
        id: background
        Image {
            id: background_image
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "images/background.jpg"
            visible: false
            smooth: false
        }
        BrightnessContrast {
            id: background_contrast
            anchors.fill: background_image
            source: background_image
            brightness: -0.2
            contrast: 0
        }
        FastBlur {
            anchors.fill: background_contrast
            source: background_contrast
            radius: 15
        }
    }

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }



    Item {
        id: content
        anchors.fill: parent
        opacity: 0


        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            sourceSize.height: units.gridUnit * 11
            sourceSize.width: units.gridUnit * 11
            anchors.centerIn: parent
            source: "images/logo.svgz"
            ScaleAnimator on scale {
                property int state
                from: (0.8*state)+(-1*(state-1))
                to: (1*state)+(-0.8*(state-1))
                duration: 4000
                onFinished: {state=state*-1+1; restart ();}
            }


        }

        Image {
            id: busyIndicator
            y: parent.height - (parent.height - logo.y) / 2.5
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/spinner.svg"
            sourceSize.height: units.gridUnit * 3.1
            sourceSize.width: units.gridUnit * 3.1
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
            }
        }
        Item {
            id: progressbar
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height - units.gridUnit * 0
            width: parent.width
            Rectangle{
                id: border
                width: parent.width
                height: units.gridUnit * 0.0
                color: "#F7ADAD"
                opacity: 0.0
            }
            Rectangle{
                id: progress
                height: border.height
                color: "#F76F6F"
                width: border.width / 0 * (stage)
            }
        }

    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
