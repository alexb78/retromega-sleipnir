import QtQuick 2.15

Item {
    property alias model: model;

    ListModel {
        id: model;

        ListElement {
            key: 'nameFilter';
            type: 'nameFilter';
        }

        ListElement {
            key: 'genreType';
            title: 'Genre:';
            type: 'genreType';
        }

        ListElement {
            key: 'devType';
            title: 'Developer:';
            type: 'devType';
        }

        ListElement {
            key: 'pubType';
            title: 'Publisher:';
            type: 'pubType';
        }
        
        ListElement {
            key: 'gameType';
            title: 'Game Type:';
            type: 'gameType';
        }

        ListElement {
            key: 'regionType';
            title: 'Region:';
            type: 'regionType';
        }
        
        ListElement {
            key: 'sortBy';
            title: 'Title';
            type: 'sort';
            defaultOrder: 'asc';
        }

        ListElement {
            key: 'lastPlayed';
            title: 'Last Played';
            type: 'sort';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'rating';
            title: 'Rating';
            type: 'sort';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'release';
            title: 'Release Date';
            type: 'sort';
            defaultOrder: 'asc';
        }

        ListElement {
            key: 'favorite';
            title: 'Favorites';
            type: 'sort';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'onlyFavorites';
            title: 'Only Favorites';
            type: 'onlyFavorites';
        }

        ListElement {
            key: 'onlyMultiplayer';
            title: 'Only Multiplayer';
            type: 'onlyMultiplayer';
        }
    }

    function updateSort(key, defaultSort) {
        return () => {
            if (sortKey !== key) {
                sortKey = key;
                sortDir = defaultSort;
                return;
            }

            if (sortDir === Qt.AscendingOrder) {
                sortDir = Qt.DescendingOrder;
                return;
            }

            sortDir = Qt.AscendingOrder;
        }
    }

    function executeCallback(key) {
        const callbacks = {
            nameFilter: () => { sortingComponent.showModal(); },
            sortBy: updateSort('sortBy', Qt.AscendingOrder),
            lastPlayed: updateSort('lastPlayed', Qt.DescendingOrder),
            rating: updateSort('rating', Qt.DescendingOrder),
            release: updateSort('release', Qt.AscendingOrder),
            favorite: updateSort('favorite', Qt.DescendingOrder),
            onlyFavorites: () => { onlyFavorites = !onlyFavorites; },
            onlyMultiplayer: () => { onlyMultiplayer = !onlyMultiplayer; },
            onlyRetail: () => { onlyRetail = !onlyRetail; },
            onlyUSA: () => { onlyUSA = !onlyUSA; },
            gameType: () => { 
                gameTypeIndex = (gameTypeIndex + 1) %gameTypes.length ;
                gameType = gameTypes[gameTypeIndex] ;
            },
            regionType: () => { 
                regionTypeIndex = (regionTypeIndex + 1) %regionTypes.length ; 
                regionType = regionTypes[regionTypeIndex] ;
            },
            genreType: () => { 
                genreTypeIndex = (genreTypeIndex + 1) %genreTypes.length ; 
                genreType = genreTypes[genreTypeIndex] ;
            },
            devType: () => { 
                devTypeIndex = (devTypeIndex + 1) %devTypes.length ; 
                devType = devTypes[devTypeIndex] ;
            },
            pubType: () => { 
                pubTypeIndex = (pubTypeIndex + 1) %pubTypes.length ; 
                pubType = pubTypes[pubTypeIndex] ;
            }
        };

        callbacks[key]();
    }
    
    function executeCallbackClear(key) {
        const callbacks = {
            gameType: () => { gameTypeIndex = 0 ; gameType = gameTypes[gameTypeIndex] ;},
            regionType: () => { regionTypeIndex = 0 ; regionType = regionTypes[regionTypeIndex] ;},
            genreType: () => { genreTypeIndex = 0 ; genreType = genreTypes[genreTypeIndex] ;},
            devType: () => { devTypeIndex = 0 ; devType = devTypes[devTypeIndex] ;},
            pubType: () => { pubTypeIndex = 0 ; pubType = pubTypes[pubTypeIndex] ;},
        };

        callbacks[key]();
    }
}
