import QtQuick 2.15

Rectangle {
    property bool showDivider: true;
    property string shade: 'light';
    //property var light: true;
    property bool showTitle: false;
    property bool showHeaderLink: false;
    property bool showSorting: true;
    property bool showSettings: true;
    property string title: '';

    property bool showBattery: {
        return !isNaN(api.device.batteryPercent);
    }

    property double titleWidth: {
        return root.width - headerWidgets.width
            - (2 * headerWidgets.anchors.rightMargin)
            - headerTitle.anchors.leftMargin;
    }

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
        visible: showDivider;

        anchors {
            bottom: parent.bottom;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

    Text {
        id: headerTitle;

        visible: showTitle;
        text: title.length > 0
            ? title
            : currentCollection.name;
        color: title.length > 0
            ? theme.current.defaultHeaderNameColor
            : collectionData.getColor(currentShortName);
        opacity: theme.current.bgOpacity;
        width: titleWidth;
        elide: Text.ElideRight;

        anchors {
            left: parent.left;
            leftMargin: parent.height * .30;
            verticalCenter: parent.verticalCenter;
        }

        font {
            pixelSize: parent.height * .33;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    HeaderLink {
        id: title_systems

        visible: showHeaderLink ;
        title: "Systems"
        index: 0
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 32
        lightText: parent.shade === 'light'
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                updateCollectionIndex(0);
                updateSortedCollection();
                //currentShortName = 'allgames';
                currentView = 'collectionList';
                //updateGameIndex(0, true);
                sounds.back();    
                setHomeIndex(title_systems.index);    
            }
        }       
        //KeyNavigation.right: title_recent
        //KeyNavigation.left: title_favorites
    }

    HeaderLink {
        id: title_favorites

        visible: showHeaderLink && settings.get('showFavorites');
        title: "Favorites"
        index: 2
        anchors.left: title_systems.right
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 24
        lightText: parent.shade === 'light'
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                currentGame = null;
                //currentShortName = 'favorites';
                updateCollectionIndex(title_favorites.index);
                updateSortedCollection();
                currentView = 'gameList';
                sounds.forward();       
                setHomeIndex(title_favorites.index);    
            }
        }    
        //KeyNavigation.right: title_systems
        //KeyNavigation.left: title_recent
    }

    HeaderLink {
        id: title_recent

        visible: showHeaderLink && settings.get('showRecents');
        title: "Last Played"
        index: 1
        anchors.left: title_favorites.right
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 24
        lightText: parent.shade === 'light'
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                //currentGame = null;
                //currentShortName = 'recents';
                updateCollectionIndex(title_recent.index);
                updateSortedCollection();
                currentView = 'gameList';
                sounds.forward();   
                setHomeIndex(title_recent.index);    
            }
        }      
        //KeyNavigation.right: title_favorites
        //KeyNavigation.left: title_systems
    }           

    Row {
        id: headerWidgets;

        property string shade: parent.shade;
        spacing: parent.height * .30;
        height: parent.height;

        anchors {
            right: parent.right;
            rightMargin: parent.height * .30;
        }
    
        Sort {
            id: sort;

            shade: parent.shade;
            height: parent.height * .5;
            visible: showSorting;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Clock {
            id: clock;

            shade: parent.shade;
            height: parent.height;
            opacity: 0.5;
        }

        Row {
            id: headerBatteryWidget;

            property string shade: parent.shade;
            spacing: parent.height * .15;
            height: parent.height;

//            anchors {
//                right: parent.right;
//                rightMargin: parent.height * .30;
//            }

            Battery {
                id: battery;

                visible: showBattery;
                opacity: 0.5;
                shade: parent.shade;
                height: parent.height * .25;
                width: parent.height * .55;
                anchors.verticalCenter: parent.verticalCenter;
            }

            BatteryPercent {
                id: batteryPercent;

                shade: parent.shade;
                height: parent.height;
                opacity: 0.5;
            }
        }

        Text {
            id: settingsIcon;

            visible: showSettings
            text: glyphs.settings;
            opacity: 0.5;
            color: parent.shade === 'light'
                ? theme.current.settingsColorLight
                : theme.current.settingsColorDark;
            anchors.verticalCenter: parent.verticalCenter;

            font {
                family: glyphs.name;
                pixelSize: parent.height * .33;
            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (currentView === 'settings') {
                        currentView = previousView;
                        sounds.back();
                    } else {
                        previousView = currentView;
                        currentView = 'settings';
                        sounds.forward();
                    }
                }
            }
        }
    }
}
