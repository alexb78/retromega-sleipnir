// Parts taken from gameOS theme
// Copyright (C) 2018-2020 Seth Powell 

import QtQuick 2.15
import QtMultimedia 5.9
import SortFilterProxyModel 0.2
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0
import QtQml.Models 2.10

FocusScope {
id: root

    property bool showTitle: true;
    property var mediaModel: mediaArray()
    property int mediaIndex: 0
    property bool isVideo: mediaModel.length ? mediaModel[mediaIndex].includes(".mp4") || mediaModel[mediaIndex].includes(".webm") : false

    anchors.fill: parent;

    // Show/hide the media view
    function showMedia() {
        root.mediaIndex = 0;
        root.focus = true;
        root.opacity = 1;
        attractTitle.text = currentGame.title;
        //music.volumeCheck();
        //collectionTitle.text = currentGame.collections.get(0).name;
    }

    function closeMedia() {
        root.opacity = 0;
        //music.volumeCheck();
        //content.focus = true;
    }

    function onCancelPressed() {
        currentView = previousView;
        sounds.back();
        closeMedia()
    }

    function onAcceptPressed() {
        currentGame.launch();
    }

    function mediaArray() {
        let mediaList = [];
        if (currentGame.assets.video) {
            currentGame.assets.videoList.forEach(v => mediaList.push(v));
        }
        currentGame.assets.boxFrontList.forEach(v => mediaList.push(v));
        currentGame.assets.boxBackList.forEach(v => mediaList.push(v));
        currentGame.assets.screenshotList.forEach(v => mediaList.push(v));
        currentGame.assets.titlescreenList.forEach(v => mediaList.push(v));
        currentGame.assets.backgroundList.forEach(v => mediaList.push(v));
        currentGame.assets.cartridgeList.forEach(v => mediaList.push(v));
        return mediaList;
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }
    }

    Component.onCompleted: {
        addCurrentViewCallback(function (currentView) {
            if (currentView === 'media') {
                showMedia();
            } else {
                closeMedia();
            }
        });
        
        if (currentView === 'media') showMedia();
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            if (currentView !== 'media') return;

            if (Qt.application.state === Qt.ApplicationActive) {
                showMedia();
            } else {
                closeMedia();
            }
        }
    }

    Component {
    id: videoWrapper

        Video {
        id: videoPlayer

            source: isVideo ? mediaModel[mediaIndex] : ""
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
            muted: false
            autoPlay: true
        }

    }

    // Video
    Loader {
    id: videoLoader
        
        sourceComponent: root.focus && isVideo ? videoWrapper : undefined
        asynchronous: true
        anchors { fill: parent }
    }
    
    ListView {
    id: medialist

        focus: true
        currentIndex: mediaIndex
        onCurrentIndexChanged: mediaIndex = currentIndex;
        anchors.fill: parent
        orientation: ListView.Horizontal
        clip: true
        preferredHighlightBegin: vpx(0)
        preferredHighlightEnd: parent.width
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 200
        snapMode: ListView.SnapOneItem
        keyNavigationWraps: true
        model: mediaModel
        delegate: Image {
        id: imageholder

            width: root.width
            height: root.height
            source: modelData.includes(".mp4") || modelData.includes(".webm") ? "" : modelData
            smooth: true
            fillMode: Image.PreserveAspectFit
            visible: !isVideo
            asynchronous: true
        }
        Keys.onLeftPressed: { 
            decrementCurrentIndex() 
            sounds.nav()
        }
        Keys.onRightPressed: { 
            incrementCurrentIndex() 
            sounds.nav()
        }
    }

    Row {
    id: blips

        anchors.horizontalCenter: parent.horizontalCenter
        anchors { bottom: parent.bottom; bottomMargin: vpx(20) }
        spacing: vpx(10)
        Repeater {
            model: medialist.count
            Rectangle {
                width: vpx(10)
                height: width
                color: (medialist.currentIndex == index) ? theme.current.titleColor : theme.current.titleColor
                radius: width/2
                opacity: (medialist.currentIndex == index) ? 1 : 0.2
            }
        }
    }

    Text {
        id: attractTitle;

        visible: showTitle;
        width: parent.width;
        color: 'white';
        style: Text.Outline;
        styleColor: 'black';
        horizontalAlignment: Text.AlignRight;
        elide: Text.ElideRight;
        maximumLineCount: 2;
        wrapMode: Text.WordWrap;
        opacity: .6;

        font {
            pixelSize: root.height * .06;
            bold: true;
        }

        anchors {
            top: parent.top;
            topMargin: root.height * .025;
            left: parent.left;
            leftMargin: root.width * .03;
            right: parent.right;
            rightMargin: root.width * .03;
        }
    }

    Text {
        id: collectionTitle;

        visible: showTitle;
        width: parent.width;
        color: 'white';
        style: Text.Outline;
        styleColor: 'black';
        horizontalAlignment: Text.AlignHCenter;
        elide: Text.ElideRight;
        maximumLineCount: 1;
        wrapMode: Text.WordWrap;
        opacity: .6;

        font {
            pixelSize: root.height * .06;
            bold: true;
        }

        anchors {
            bottom: parent.bottom;
            bottomMargin: root.height * .025;
            left: parent.left;
            leftMargin: root.width * .03;
            right: parent.right;
            rightMargin: root.width * .03;
        }
    }
}
