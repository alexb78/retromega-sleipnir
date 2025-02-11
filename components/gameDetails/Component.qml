import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer
import '../media' as Media

Item {
    id: details;
    anchors.fill: parent;
    property bool favoritesChanged: false;
    property bool fullDescriptionShowing: false;

    function onCancelPressed() {
        if (favoritesChanged === true) {
            updateGameIndex(currentGameIndex, true);
            favoritesChanged = false;
        }

        if (inAttractMode) {
            currentView = 'attract';
        } else {
            currentView = 'gameList';
        }
        sounds.back();
    }

    function onAcceptPressed() {
        sounds.launch();
        currentGame.launch();
    }

    function onMediaPressed() {
        previousView = currentView;
        currentView = 'media';
        sounds.nav();
    }

    function onFiltersPressed() {
        currentGame.favorite = !currentGame.favorite;
        favoritesChanged = true;
        sounds.nav();
    }

    function onMorePressed() {
        if (!currentGame.description) return;

        fullDescriptionShowing = true;
        fullDescription.anchors.topMargin = 0;
        sounds.forward();
    }

    function hideFullDescription() {
        fullDescriptionShowing = false;
        fullDescription.anchors.topMargin = root.height;
        fullDescription.resetFlickable();
        sounds.back();
    }
    
    function detailsButtonClicked(button) {
        switch (button) {
            case 'play':
                onAcceptPressed();
                break;
            case 'favorite':
                onFiltersPressed();
                break;
            case 'more':
                onMorePressed();
                break;
            case 'less':
                hideFullDescription();
                break;
        }
    }

    Keys.onUpPressed: {
        event.accepted = true;
        if(fullDescriptionShowing) {
            fullDescription.scrollUp();
            return;
        }
        const updated = updateGameIndex(currentGameIndex - 1);
        if (updated) {
            sounds.nav();
            infoPane.gameDetailsVideo.switchVideo();
            fullDescription.resetFlickable();
        }
    }

    Keys.onDownPressed: {
        event.accepted = true;
        if(fullDescriptionShowing) {
            fullDescription.scrollDown();
            return;
        }
        const updated = updateGameIndex(currentGameIndex + 1);
        if (updated) {
            sounds.nav();
            infoPane.gameDetailsVideo.switchVideo();
            fullDescription.resetFlickable();
        }
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onMediaPressed();
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            onFiltersPressed();
        }
    }

    Keys.onReleased: {
        if (api.keys.isPageDown(event)) {
            event.accepted = true;
            fullDescription.scrollDown();
            gameDescription.scrollDown();
        }
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
            fullDescription.scrollUp();
            gameDescription.scrollUp();
        }
    }

    property var ratingText: {
        if (currentGame === null) return '';
        if (currentGame.rating === 0) return '';

        let stars = [];
        const rating = Math.round(currentGame.rating * 500) / 100;

        for (let i = 0; i < 5; i++) {
            if (rating - i <= 0) {
                stars.push(glyphs.emptyStar);
            } else if (rating - i < 1) {
                stars.push(glyphs.halfStar);
            } else {
                stars.push(glyphs.fullStar);
            }
        }

        return stars.join(' ');
    }

    property string imgScreenshot: {
        if (currentGame === null) return '';
        if (currentGame.assets.screenshot !== "") return currentGame.assets.screenshot;
        return currentGame.assets.boxFront;
    }

    //property string imgTile: {
    //    if (currentGame === null) return '';
    //    if (currentGame.assets.tile !== "") return currentGame.assets.tile;
    //    return currentGame.assets.boxFront;
    //}

    property string imgCart: {
        if (currentGame === null) return '';
        if (currentGame.assets.cartridge !== "") return currentGame.assets.cartridge;
        return currentGame.assets.boxBack;
    }

    property string imgLogo: {
        if (currentGame === null) return '';
        if (currentGame.assets.logo !== "") return currentGame.assets.logo;
        return currentGame.assets.titlescreen;
    }

    property string favoriteGlyph: {
        if (currentGame === null) return '';
        if (currentGame.favorite) return glyphs.favorite;
        return glyphs.unfavorite;
    }

    property string titleText: {
        if (currentGame === null) return '';
        return currentGame.title;
    }

    property string releaseDateText: {
        if (currentGame === null) return '';
        if (!currentGame.releaseYear) return '';
        return currentGame.releaseYear;
    }

    property string playersText: {
        if (currentGame === null) return '';
        if (!currentGame.players) return '';
        return currentGame.players + 'P';
    }

    Component.onCompleted: {
        infoPane.gameDetailsVideo.switchVideo();
        settings.addCallback('gameDetailsVideo', function () {
            infoPane.gameDetailsVideo.switchVideo();
        });
    }

    Rectangle {
        color: theme.current.bgColor;
        anchors {
            top: parent.top;
            bottom: detailsFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }
    
    /* Title and favourite */
    Rectangle {
        id: titleBlock
        color: 'transparent';
        height: root.height * .115 * theme.fontScale;

        anchors {
            left: parent.left;
            right: parent.right;
            top: parent.top;
        }

        // divider
        Rectangle {
            height: 1;
            color: theme.current.dividerColor;

            anchors {
                bottom: parent.bottom;
                left: parent.left;
                leftMargin: 22;
                right: parent.right;
                rightMargin: 22;
            }
        }
    
        Text {
            id: title;

            maximumLineCount: 1;
            text: titleText;
            color: theme.current.detailsColor;
            elide: Text.ElideRight;

            width: parent.width - 100;
            anchors {
                left: parent.left;
                leftMargin: vpx(32);
                verticalCenter: parent.verticalCenter;
            }

            font {
                pixelSize: parent.height * .33;
                letterSpacing: -0.3;
                bold: true;
            }
        }

        Text {
            id: favourite;

            text: favoriteGlyph;
            color: theme.current.detailsColor;

            font {
                family: glyphs.name;
                pixelSize: parent.height * .5;
            }

            anchors {
                right: parent.right;
                rightMargin: vpx(32);
                verticalCenter: parent.verticalCenter;
            }

            horizontalAlignment: Text.AlignRight;

            MouseArea {
                anchors.fill: parent;


                onClicked: {
                    detailsButtonClicked('favorite');
                }
            }

        }
    }

    /* Info pane with metadata and screenshot */
    Flickable {
        id: flickInfoPane;

        flickableDirection: Flickable.VerticalFlick
        onFlickStarted: {
            if (verticalVelocity < 0) {
                const updated = updateGameIndex(currentGameIndex - 1);
                if (updated) {
                    sounds.nav();
                    infoPane.gameDetailsVideo.switchVideo();
                    gameDescription.resetFlickable();
                }
            }
            if (verticalVelocity > 0) {
                const updated = updateGameIndex(currentGameIndex + 1);
                if (updated) {
                    sounds.nav();
                    infoPane.gameDetailsVideo.switchVideo();
                    gameDescription.resetFlickable();
                }
            }
        }
        boundsMovement: Flickable.StopAtBounds
        pressDelay: 0

        anchors {
            top: titleBlock.bottom;
            left: parent.left;
            right: detailsDivider.left;
            bottom: detailsFooter.top;
        }
    }
    
    InfoPane {
        id: infoPane;

        anchors {
            top: titleBlock.bottom;
            topMargin: vpx(20);
            left: parent.left;
            leftMargin: vpx(20);
            right: detailsDivider.left;
            rightMargin: vpx(20);
            bottom: detailsFooter.top;
            bottomMargin: vpx(20);
        }
    }


    /* Vertical divider between info and description */
    Rectangle {
        id: detailsDivider;

        //color: theme.current.dividerColor;
        color: 'transparent';
        width: 10;
        x: parent.width * .4;
        anchors {
            top: titleBlock.bottom;
            topMargin: 22;
            bottom: detailsFooter.top
            bottomMargin: 22;
        }
    }

    /* Vertical pane with rating, players, date */
    VerticalPane {
        id: verticalPane;

        width: vpx(50);
        anchors {
            top: titleBlock.bottom;
            topMargin: vpx(10);
            bottom: detailsFooter.top;
            bottomMargin: vpx(10);
            right: parent.right;
            rightMargin: vpx(22);
        }

        Behavior on anchors.topMargin {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200; }
        }
    }

    Item {
        id: gameGfx;
        height: verticalPane.height * .3;
        anchors {
            top: titleBlock.bottom;
            topMargin: vpx(20);
            left: detailsDivider.right;
            leftMargin: vpx(40);
            right: verticalPane.left;
            rightMargin: vpx(40);
        }

        Media.GameImage {
            id: gameDetailsLogo;
            imageSource: imgLogo;
            width: parent.width * .65 - vpx(80);
            anchors {
                top: parent.top;
                bottom: parent.bottom;
                left: parent.left;
            }
        }

        Media.GameImage {
            id: gameDetailsTile;
            imageSource: imgCart;
            width: parent.width * .50 - vpx(80);
            anchors {
                top: parent.top;
                bottom: parent.bottom;
                right: parent.right;
            }
            //alignment: Image.AlignRight;
        }
    }

    /* Description pane, scrollable */
    GameDescription {
        id: gameDescription;

        anchors {
            top: gameGfx.bottom;
            topMargin: vpx(20);
            left: detailsDivider.right;
            leftMargin: vpx(20);
            right: verticalPane.left;
            rightMargin: vpx(20);
            bottom: detailsFooter.top;
            bottomMargin: vpx(20);
        }

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                detailsButtonClicked('more');
            }
        }

        Behavior on anchors.topMargin {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200  }
        }
    }

    Footer.Component {
        id: detailsFooter;

        total: 0;

        buttons: [
            { title: 'Play', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
            { title: 'Back', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
            { title: 'Media', key: theme.buttonGuide.details, square: false, sigValue: 'media' },
            { title: 'Favorite', key: theme.buttonGuide.filters, square: false, sigValue: 'filters' }
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
            if (sigValue === 'filters') onFiltersPressed();
            if (sigValue === 'media') onMediaPressed();
        }
    }

    FullGameDescription {
        id: fullDescription;

        height: parent.height;
        width: parent.width;
        blurSource: details;

        anchors {
            top: parent.top;
            topMargin: root.height;
            left: parent.left;
            right: parent.right;
        }

        Behavior on anchors.topMargin {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200; }
        }
    }
}
