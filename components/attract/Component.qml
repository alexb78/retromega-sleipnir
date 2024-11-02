import QtQuick 2.15
import QtMultimedia 5.9
import SortFilterProxyModel 0.2

Flickable {
    property bool showTitle: true;
    property var currentAttractGame;

    anchors.fill: parent;

    flickableDirection: Flickable.VerticalFlick
    onFlickStarted: {
        if (verticalVelocity > 0) {
            onCancelPressed();
        }
    }
    boundsMovement: Flickable.StopAtBounds
    pressDelay: 0

    function quietAttractCallback(enabled) {
        if (enabled) attractPlayer.volume = 0;
        else attractPlayer.volume = .7;
    }

    function onCancelPressed() {
        inAttractMode = false;
        currentView = 'collectionList';
        sounds.back();
    }

    function onDetailsPressed() {
        //settings.toggle('attractTitle');
        //showTitle = settings.get('attractTitle');
        previousView = 'attract'
        currentView = 'gameDetails';
        sounds.forward();
    }

    function onAcceptPressed() {
        attractPlayer.source = currentAttractGame.assets.video;
        currentAttractGame.launch();
    }

    function stopVideo() {
        attractPlayer.stop();
        music.volumeCheck();
    }

    function startVideo() {
        showTitle = settings.get('attractTitle');
        updateSortedCollection();
        nextVideo();
        music.volumeCheck();
    }

    function nextVideo() {
        const gameCount = attractGames.count;

        if (gameCount === 0) {
            showTitle = true;
            attractTitle.text = 'No Videos Found';
            collectionTitle.text = '';
        }

        const randomIndex = Math.floor(Math.random() * gameCount);
        //currentAttractGame = api.allGames.get(attractGames.mapToSource(randomIndex));
        currentAttractGame = currentCollection.games.get(attractGames.mapToSource(randomIndex));
        currentGame = currentAttractGame;
        attractPlayer.source = currentAttractGame.assets.video;
        attractTitle.text = currentAttractGame.title;
        collectionTitle.text = currentAttractGame.collections.get(0).name;
    }

    Keys.onUpPressed: { event.accepted = true; nextVideo(); }
    Keys.onDownPressed: { event.accepted = true; nextVideo(); }
    Keys.onLeftPressed: { event.accepted = true; nextVideo(); }
    Keys.onRightPressed: { event.accepted = true; nextVideo(); }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onDetailsPressed();
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            nextVideo();
        }
    }

    TapHandler {
        id: tapHandler
        gesturePolicy: TapHandler.ReleaseWithinBounds
        onTapped: onDetailsPressed();
        onLongPressed: onAcceptPressed();
    }

    SortFilterProxyModel {
        id: attractGames;

        sourceModel: currentCollection.games;
        filters: [
            ExpressionFilter { expression: { assets.video !== ''; } },
            ExpressionFilter { enabled: gameType; expression: { return tagList.includes(gameType); } },
            ExpressionFilter { enabled: regionType; expression: { return tagList.includes(regionType); } },
            ExpressionFilter { enabled: genreType; expression: { 
                var re = new RegExp(".*" + genreType + ".*");
                return re.test(genre);
            }},
            ExpressionFilter { enabled: devType; expression: { 
                var re = new RegExp(".*" + devType + ".*");
                return re.test(developer);
            }},
            ExpressionFilter { enabled: pubType; expression: { 
                var re = new RegExp(".*" + pubType + ".*");
                return re.test(publisher);
            }}
        ]
    }

    Component.onCompleted: {
        addCurrentViewCallback(function (currentView) {
            if (currentView === 'attract') {
                startVideo();
            } else {
                stopVideo();
            }
        });

        music.registerVideo(attractPlayer);
        if (currentView === 'attract') startVideo();

        quietAttractCallback(settings.get('quietVideo'));
        settings.addCallback('quietVideo', quietAttractCallback);
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            if (currentView !== 'attract') return;

            if (Qt.application.state === Qt.ApplicationActive) {
                startVideo();
            } else {
                stopVideo();
            }
        }
    }

    Video {
        id: attractPlayer;

        volume: 0.7;
        fillMode: VideoOutput.PreserveAspectFit;
        anchors.fill: parent;
        autoPlay: true;

        onStatusChanged: {
            if (status === MediaPlayer.InvalidMedia) {
                nextVideo();
            }

            if (status === MediaPlayer.EndOfMedia) {
                nextVideo();
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
        horizontalAlignment: Text.AlignHCenter;
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
