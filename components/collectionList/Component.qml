import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

import '../screenSaver' as ScreenSaver

Item {
    anchors.fill: parent;

    function updateIndex(newIndex) {
        collectionScroll.collectionListView.currentIndex = newIndex;
    }

    Keys.onLeftPressed: {
        event.accepted = true;
        const updated = updateCollectionIndex(currentCollectionIndex - 1);
        screensaver.reset();
        if (updated) { sounds.nav(); }
    }

    Keys.onRightPressed: {
        event.accepted = true;
        const updated = updateCollectionIndex(currentCollectionIndex + 1);
        screensaver.reset();
        if (updated) { sounds.nav(); }
    }

    Keys.onUpPressed: {
        event.accepted = true;
        fullDescription.scrollUp();
        screensaver.reset();
    }
        
    Keys.onDownPressed: {
        event.accepted = true;
        fullDescription.scrollDown();
        screensaver.reset();
    }        

    function onAcceptPressed() {
        currentGame = null;
        updateSortedCollection();
        currentView = 'gameList';
        screensaver.reset();
        sounds.forward();
    }

    function onMorePressed() {
        previousView = currentView;
        fullDescription.anchors.topMargin = 0;
        screensaver.reset();
        sounds.forward();
    }

    function hideFullDescription() {
        fullDescription.anchors.topMargin = root.height;
        fullDescription.resetFlickable();
        screensaver.reset();
        sounds.back();
    }

    function onCheevosPressed() {
        if (!cheevosEnabled) return;
        previousView = currentView;
        currentView = 'cheevos';
        screensaver.reset();
        sounds.forward();
    }

    function onAttractPressed() {
        inAttractMode = true;
        currentView = 'attract';
        screensaver.reset();
        sounds.forward();
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onMorePressed();
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            onCheevosPressed();
        }

        // L1
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            const updated = updateCollectionIndex(0);
            screensaver.reset();
            if (updated) { sounds.nav(); }
        }

        // R1
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            const updated = updateCollectionIndex(allCollections.length - 1);
            screensaver.reset();
            if (updated) { sounds.nav(); }
        }
    }

    Keys.onReleased: {
        // L2
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
            onAttractPressed();
        }

        // R2
        //if (api.keys.isPageDown(event)) {
        //    event.accepted = true;
        //    previousView = currentView;
        //    currentView = 'sorting';
        //    sounds.forward();
        //}
    }

    CollectionScroll {
        id: collectionScroll;

        anchors {
            top: parent.top;
            bottom: collectionListFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: collectionListFooter;
        index: currentCollectionIndex + 1;
        total: allCollections.length;

        buttons: [
            { title: 'Select', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
            { title: 'Menu', key: theme.buttonGuide.cancel, square: false, sigValue: null },
            { title: 'More', key: theme.buttonGuide.details, square: false, sigValue: 'more' },
            { title: 'Cheevos', key: theme.buttonGuide.filters, square: false, visible: cheevosEnabled, sigValue: 'cheevos' },
            { title: 'Attract', key: theme.buttonGuide.pageUp, square: true, sigValue: 'attract' },
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'more')   onMorePressed();
            if (sigValue === 'cheevos') onCheevosPressed();
            if (sigValue === 'attract') onAttractPressed();
        }
    }

    Header.Component {
        showDivider: false;
        shade: 'light';
        //light: true;
        showHeaderLink: true;
        showSorting: false;
    }

    GameDescription {
        id: fullDescription;

        height: parent.height;
        width: parent.width;
        blurSource: collectionScroll;

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
