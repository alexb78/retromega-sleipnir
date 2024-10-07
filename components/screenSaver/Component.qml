// struceOS
// Copyright (C) 2024 my_name_is_p

import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtMultimedia 5.9

Rectangle {
    id: screensaver

    color: '#011936'

    opacity: 0
    Behavior on opacity {NumberAnimation {duration: screensaver.fadeTime * 1000}}

    property int timeout: 30
    property int fadeTime: 5
    property int changeTime: 12

    property bool active: false

    property int rndCount: Math.floor(Math.random() * api.allGames.count)

    Keys.onPressed: {

        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }
    }

    function onCancelPressed() {
        active = false;
        currentView = previousView;
        sounds.back();
        reset();
    }

    Item {
        id: image_wrapper
        anchors.fill: parent

        opacity: 1
        Behavior on opacity {NumberAnimation {duration: 1000}}

        Image { //image
            id: image
            source: api.allGames.get(rndCount).assets.screenshot

            height: parent.height + offset_amount
            width: parent.width + offset_amount

            fillMode: Image.PreserveAspectCrop

            smooth: true
            antialiasing: true

            property int offset_duration: changeTime * 1000
            property real offset_amount: vpx(124)

            Behavior on anchors.topMargin {NumberAnimation {duration: image.offset_duration}}
            Behavior on anchors.bottomMargin {NumberAnimation {duration: image.offset_duration}}
            Behavior on anchors.leftMargin {NumberAnimation {duration: image.offset_duration}}
            Behavior on anchors.rightMargin {NumberAnimation {duration: image.offset_duration}}

            function resetOffset(){
                anchors.top = undefined
                anchors.bottom = undefined
                anchors.left = undefined
                anchors.right = undefined

                let verticalMargin = Math.random() < 0.5 ? "top" : "bottom"
                let horizontalMargin = Math.random() < 0.5 ? "left" : "right"
                let r = (Math.random() * 0.6 + 0.2).toFixed(2)

                offset_duration = 0

                anchors[verticalMargin] = parent[verticalMargin]
                anchors[horizontalMargin] = parent[horizontalMargin]
                anchors[verticalMargin + "Margin"] = r >= 0.5 ? -offset_amount : -offset_amount * (2 * r)
                anchors[horizontalMargin + "Margin"] = (1 - r) >= 0.5 ? -offset_amount : -offset_amount * (2 * (1 - r))

                offset_duration = changeTime * 1000

                anchors[verticalMargin + "Margin"] = anchors[horizontalMargin + "Margin"] = 0
            }
        }

        Image { //logo
            id: logo
            source: api.allGames.get(rndCount).assets.logo

            anchors.top: image_wrapper.top
            anchors.left: image_wrapper.left
            anchors.margins: vpx(48)

            height: vpx(200)
            width: vpx(400)

            fillMode: Image.PreserveAspectFit

            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignTop

            smooth: true
            antialiasing: true

            visible: false

            function resetPosition(){
                anchors.top = undefined
                anchors.bottom = undefined
                anchors.left = undefined
                anchors.right = undefined

                let vAlignment = Math.random() < 0.5 ? "top" : "bottom"
                let hAlignment = Math.random() < 0.5 ? "left" : "right"

                anchors[vAlignment] = parent[vAlignment]
                anchors[hAlignment] = parent[hAlignment]
                verticalAlignment = Image["Align" + vAlignment.charAt(0).toUpperCase() + vAlignment.slice(1)]
                horizontalAlignment = Image["Align" + hAlignment.charAt(0).toUpperCase() + hAlignment.slice(1)]
            }
        }

        DropShadow { //logo_shadow
            id: logo_shadow
            source: logo

            anchors.fill: logo

            color: 'black';
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8
            samples: 16
        }

        Timer {
            id: image_fade
            interval: 1000
            onTriggered: {
                let r = Math.floor(Math.random() * api.allGames.count)
                image.source = api.allGames.get(r).assets.screenshot
                logo.source = api.allGames.get(r).assets.logo

                image.resetOffset()
                logo.resetPosition()
                image_wrapper.opacity = 1
            }
        }

        Timer {
            id: image_change
            interval: changeTime * 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                if(screensaver.active)
                    image_wrapper.changeImage()
            }
        }

        function changeImage(){
            opacity = 0
            image_fade.restart()
        }
    }

    Timer{
        id: timeout
        interval: 1000 * screensaver.timeout
        onTriggered: {
            image.resetOffset()
            screensaver.active = true
            screensaver.opacity = 1
            previousView = currentView;
            currentView = 'screensaver'
        }
    }

    function reset(){
        if(currentView === 'collectionList') {
            timeout.restart()
        } else {
            timeout.stop();
        }
    }
}
