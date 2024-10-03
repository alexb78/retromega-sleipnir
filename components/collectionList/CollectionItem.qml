import QtQuick 2.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2

Item {
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            collectionListView.currentIndex = index;
            onAcceptPressed();
        }
    }

    property var hasMoreButton: {
        return true;
        if (currentGame === null) return false;
        if (currentGame.description) return true;
        return false;
    }

    // background stripe
    Image {
        source: '../../assets/images/stripe.png';
        fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignRight;

        anchors {
            fill: parent;
            rightMargin: 70;
        }
    }

    DropShadow {
        source: title;
        verticalOffset: 10;
        color: '#30000000';
        radius: 20;
        samples: 41;
        cached: true;
        anchors.fill: title;
    }

    Text {
        id: title;

        text: modelData.name;
        color: theme.current.titleColor;
        width: root.width * .46;
        wrapMode: Text.WordWrap;
        lineHeight: 0.8;

        font {
            pixelSize: root.height * .075;
            bold: true;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 30;
            verticalCenterOffset: -50;
        }
    }

    Text {

        id: gamesCount;

        text: filteredGamesCollection.count + ' games';
        color: theme.current.titleColor;
        opacity: 0.7;

        anchors {
            left: parent.left;
            leftMargin: 30;
            top: title.bottom;
            topMargin: root.height * .02;
        }

        font {
            pixelSize: root.height * .03;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    Text {
        id: collectionSummary

        text: collectionData.getSummary(modelData.shortName);
        color: theme.current.titleColor
        opacity: 0.7;
        
        anchors {
            left: parent.left;
            right: device.left
            leftMargin: 30;
            rightMargin: 30;
            top: gamesCount.bottom;
            topMargin: root.height * .02;
            bottom: parent.bottom;
            bottomMargin: 75;
        }
        
        font {
            pixelSize: root.height * .03 * theme.fontScale;
            letterSpacing: -0.35;
            bold: true;
        }

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                collectionListView.currentIndex = index;
                onMorePressed();
            }
        }
        
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignJustify
    }

    /*MoreButton {
        pixelSize: parent.height * .04 * theme.fontScale;
        visible: hasMoreButton;

        anchors {
            right: collectionSummary.right;
            //rightMargin: 30;
            bottom: collectionSummary.bottom;
            bottomMargin: 15;
        }
    }*/

    SortFilterProxyModel {
        id: filteredGamesCollection;

        sourceModel: allCollections[collectionListView.currentIndex].games;
        filters: [
            ValueFilter { roleName: 'favorite'; value: true; enabled: onlyFavorites; },
            ExpressionFilter { enabled: onlyMultiplayer; expression: { return players > 1; } },
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
            }},
            RegExpFilter { roleName: 'title'; pattern: nameFilter; caseSensitivity: Qt.CaseInsensitive; enabled: nameFilter !== ''; }
        ]
    }

    Text {
        text: collectionData.getVendorYear(modelData.shortName);
        color: theme.current.titleColor;
        opacity: 0.7;

        font {
            capitalization: Font.AllUppercase;
            pixelSize: root.height * .025;
            letterSpacing: 1.3;
            bold: true;
        }

        anchors {
            left: parent.left;
            leftMargin: 30;
            bottom: title.top;
        }
    }

    Image {
        id: device;

        source: '../../assets/images/devices/' + collectionData.getImage(modelData.shortName) + '.png';
        width: root.width * .40;
        height: root.height * .60;
        fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignHCenter;
        asynchronous: true;
        smooth: false;
        visible: true;

        anchors {
            verticalCenter: parent.verticalCenter;
            verticalCenterOffset: 25;
            right: parent.right;
            rightMargin: root.width * .02;
        }
    }

    DropShadow {
       source: device;
       verticalOffset: 10;
       color: '#30000000';
       radius: 20;
       samples: 41;
       cached: true;
       anchors.fill: device;
    }
}
