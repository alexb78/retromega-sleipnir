import QtQuick 2.15

Item {
    property var keys: [
        'listWrapAround', 'bgMusic', 'navSounds', 'darkMode', 'twelveHour',
        'smallFont', 'gameListVideo', 'gameDetailsVideo', 'quietVideo',
        'quickVideo', 'dropShadow',
    ];

    function title(key) { return titles[key]; }
    function toggle(key) { set(key, !values[key]); }

    function get(key) {
        if (values[key] === null) {
            set(key, api.memory.get(key) ?? defaults[key]);
        }

        return values[key];
    }

    function saveAll() {
        for (const key of keys) {
            api.memory.set(key, get(key));
        }
    }

    function set(key, value) {
        if (values[key] === undefined) return;

        values[key] = value;
        callback(key);
    }

    function addCallback(key, callback) {
        if (callbacks[key] === undefined) return;

        callbacks[key].push(callback);
    }

    function callback(key) {
        if (callbacks[key] === undefined) return;

        for (let i = 0; i < callbacks[key].length; i++) {
            callbacks[key][i](values[key]);
        }
    }

    property var defaults: {
        'listWrapAround': true,
        'bgMusic': true,
        'navSounds': true,
        'darkMode': false,
        'twelveHour': false,
        'smallFont': false,
        'gameListVideo': true,
        'gameDetailsVideo': true,
        'quietVideo': false,
        'quickVideo': false,
        'dropShadow': true,
    }

    property var values: {
        'listWrapAround': null,
        'bgMusic': null,
        'navSounds': null,
        'darkMode': null,
        'twelveHour': null,
        'smallFont': null,
        'gameListVideo': null,
        'gameDetailsVideo': null,
        'quietVideo': null,
        'quickVideo': null,
        'dropShadow': null,
    }

    property var callbacks: {
        'listWrapAround': [],
        'bgMusic': [],
        'navSounds': [],
        'darkMode': [],
        'twelveHour': [],
        'smallFont': [],
        'gameListVideo': [],
        'gameDetailsVideo': [],
        'quietVideo': [],
        'quickVideo': [],
        'dropShadow': [],
    }

    property var titles: {
        'listWrapAround': 'List Wrap Around',
        'bgMusic': 'Background Music',
        'navSounds': 'Navigation Sounds',
        'darkMode': 'Dark Theme',
        'twelveHour': 'Twelve Hour Clock',
        'smallFont': 'Use Smaller Font',
        'gameListVideo': 'Video On Game List',
        'gameDetailsVideo': 'Video On Game Details',
        'quietVideo': 'Silent Videos',
        'quickVideo': 'Shorter Video Delay',
        'dropShadow': 'Enable Video/Image Shadow',
    }
}
