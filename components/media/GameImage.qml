import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property bool failed: true;
    property bool videoPlaying: false;
    property string imageSource: '';
    property bool delayedImage: false;
    property var alignment: Image.AlignHCenter;

    visible: {
        if (failed) return false;
        if (videoPlaying) return false;
        if (currentGameList.count === 0) return false;
        if (imageSource.length === 0) return false;

        return true;
    }

    Timer {
        id: imageDelayTimer;

        interval: 75;
        repeat: false;
        onTriggered: {
            boxartImage.source = imageSource;
        }
    }

    onImageSourceChanged: {
        if (delayedImage) {
            imageDelayTimer.restart();
        } else {
            boxartImage.source = imageSource;
        }
    }

    function delayedImageCallback(enabled) {
        delayedImage = enabled;
    }

    function dropShadowCallback(enabled) {
        if (enabled) {
            dropShadow.visible = true;
            boxartRounded.visible = false;
        } else {
            boxartRounded.visible = true;
            dropShadow.visible = false;
        }
    }

    Component.onCompleted: {
        delayedImageCallback(settings.get('delayedImage'));
        settings.addCallback('delayedImage', delayedImageCallback);

        dropShadowCallback(settings.get('dropShadow'));
        settings.addCallback('dropShadow', dropShadowCallback);
    }

    Image {
        id: boxartBuffer;

        // invisible - displayed by the rounded element
        visible: false;
        fillMode: Image.PreserveAspectFit;
        cache: false;
        width: parent.width;
        height: parent.height;
        horizontalAlignment: alignment;
        verticalAlignment: (alignment == Image.AlignHCenter) ? Image.AlignVCenter : Image.AlignTop;
    }

    Image {
        id: boxartImage;

        // invisible - boxartBuffer is shown and updated to prevent flickering
        visible: false;
        fillMode: Image.PreserveAspectFit;
        asynchronous: true;
        cache: false;
        width: parent.width;
        height: parent.height;
        anchors.centerIn: parent;

        onStatusChanged: {
            if (status == Image.Null) {
                failed = true;
            }

            if (status == Image.Error) {
                failed = true;
            }

            if (status === Image.Ready) {
                failed = false;
                boxartBuffer.source = source;
            }
        }
    }

    Item {
        id: boxartMask;

        // invisible - displayed by the rounded element
        visible: false;
        anchors.fill: boxartBuffer;

        Rectangle {
            color: 'white';
            radius: 10;
            anchors.centerIn: (alignment == Image.AlignHCenter) ? parent : undefined;
            anchors.right: (alignment == Image.AlignRight) ? parent.right : undefined;
            anchors.left: (alignment == Image.AlignLeft) ? parent.left : undefined;
            //anchors.top: parent.top;
            //anchors.bottom: parent.bottom;
            width: boxartBuffer.paintedWidth;
            height: boxartBuffer.paintedHeight;
        }
    }

    OpacityMask {
        id: boxartRounded;

        // invisible - displayed by the dropshadow element
        visible: false;
        anchors.fill: boxartBuffer;
        source: boxartBuffer;
        maskSource: boxartMask;
    }

    DropShadow {
        id: dropShadow;

        source: boxartRounded;
        anchors.fill: boxartRounded;
        color: theme.current.dropShadowColor;
        verticalOffset: 5;
        radius: 20;
        samples: 41;
        cached: false;
        visible: true;
    }
}
