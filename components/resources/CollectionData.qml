import QtQuick 2.15

Item {
    function getColor(shortName) {
        const alias = getAlias(shortName);
        return collectionData.metadata[alias].color
            ?? collectionData.metadata['default'].color;
    }

    function getVendorYear(shortName) {
        const alias = getAlias(shortName);
        const vendor = collectionData.metadata[alias].vendor ?? '';
        const year = collectionData.metadata[alias].year ?? '';

        return [vendor, year]
            .filter(v => { return v !== '' })
            .join(' • ');
    }

    function getSummary(shortName) {
        const alias = getAlias(shortName);
        return collectionData.metadata[alias].summary ?? '';
	}

    function getImage(shortName) {
        const alias = getAlias(shortName);
        if (alias === 'default') return shortName;
        return collectionData.metadata[alias].image ?? alias;
    }

    function getAlias(shortName) {
        if (aliases[shortName] !== undefined) return aliases[shortName];
        if (metadata[shortName] !== undefined) return shortName;
        return 'default'
    }

    property var aliases: {
        '2600': 'atari2600',
        '5200': 'atari5200',
        '7800': 'atari7800',
        'jaguar': 'atarijaguar',
        'lynx': 'atarilynx',
        'cd-i': 'cdi',
        'msdos': 'dos',
        'dc': 'dreamcast',
        'fc': 'famicom',
        'fba': 'fbneo',
        'fbn': 'fbneo',
        'gc': 'gamecube',
        'gameboy': 'gb',
        'gameboyadvance': 'gba',
        'gameboycolor': 'gbc',
        'md': 'genesis',
        'megadrive': 'genesis',
        'gameandwatch': 'gw',
        'gamewatch': 'gw',
        'sms': 'mastersystem',
        'msx2': 'msx',
        'msx2+': 'msx',
        'aes': 'neogeo',
        'neogeoaes': 'neogeo',
        'pcenginecd': 'pcecd',
        'pce': 'pcengine',
        'pico-8': 'pico8',
        'ps1': 'psx',
        'mega32x': 'sega32x',
        'megacd': 'segacd',
        'superfamicom': 'sfc',
        'superfc': 'sfc',
        'sg-1000': 'sg1000',
        'supernes': 'snes',
        'turbografx16': 'tg16',
        'tg16cd': 'tgcd',
        'turbografx16cd': 'tgcd',
        'vb': 'vboy',
        'virtualboy': 'vboy',
        'wonderswan': 'wswan',
        'wonderswanc': 'wswanc',
        'wonderswancolor': 'wswanc',
        'x68k': 'x68000',

        // launchbox shortnames
        '3do interactive multiplayer': '3do',
        'nintendo 3ds': '3ds',
        'commodore amiga': 'amiga',
        'amstrad cpc': 'amstradcpc',
        'apple ii': 'apple2',
        'atari 2600': 'atari2600',
        'atari 5200': 'atari5200',
        'atari 7800': 'atari7800',
        'atari jaguar': 'atarijaguar',
        'atari lynx': 'atarilynx',
        'atari st': 'atarist',
        'sammy atomiswave': 'atomiswave',
        'commodore 64': 'c64',
        'capcom cps1': 'cps1',
        'capcom cps2': 'cps2',
        'capcom cps3': 'cps3',
        'sega dreamcast': 'dreamcast',
        'final burn alpha': 'fbneo',
        'final burn neo': 'fbneo',
        'nintendo famicom disk system': 'fds',
        'nintendo gamecube': 'gamecube',
        'sega game gear': 'gamegear',
        'nintendo game boy': 'gb',
        'nintendo game boy advance': 'gba',
        'nintendo game boy color': 'gbc',
        'sega genesis': 'genesis',
        'sega mega drive': 'genesis',
        'mattel intellivision': 'intellivision',
        'sega master system': 'mastersystem',
        'microsoft msx': 'msx',
        'microsoft msx2': 'msx',
        'nintendo 64': 'n64',
        'nintendo ds': 'nds',
        'nintendo entertainment system': 'nes',
        'snk neo geo aes': 'neogeo',
        'snk neo geo mvs': 'neogeo',
        'snk neo geo cd': 'neogeocd',
        'snk neo geo pocket': 'ngp',
        'snk neo geo pocket color': 'ngpc',
        'nec pc-fx': 'pcfx',
        'sony playstation 2': 'ps2',
        'sony psp': 'psp',
        'sony playstation': 'psx',
        'sega saturn': 'saturn',
        'sega 32x': 'sega32x',
        'sega cd': 'segacd',
        'sega sg-1000': 'sg1000',
        'super nintendo entertainment system': 'snes',
        'pc engine supergrafx': 'supergrafx',
        'nec turbografx-16': 'tg16',
        'gce vectrex': 'vectrex',
        'nintendo wii': 'wii',
        'nintendo wii u': 'wiiu',
        'sinclair zx spectrum': 'zxspectrum',
    }

    property var metadata: {
        '3do': { color: '#afdb69', vendor: 'The 3DO Company', year: '1993-1996', summary: ''},
        '3ds': { color: '#73bc9e', vendor: 'Nintendo', year: '2011-2020', summary: '' },
        'allgames': { color: '#989898', summary: '' },
        'amiga': { color: '#0747a1', vendor: 'Commodore', year: '1985-1996', summary: 'The Amiga is a family of personal computers marketed by Commodore in the 1980s and 1990s. The first model was launched in 1985 as a high-end home computer and became popular for its graphical, audio and multi-tasking abilities. The Amiga provided a significant upgrade from 8-bit computers, such as the Commodore 64, and the platform quickly grew in popularity among computer enthusiasts. The best selling model, the Amiga 500, was introduced in 1987 and became the leading home computer of the late 1980s and early 1990s in much of Western Europe' },
        'android': { color: '#266f4f', summary: 'Android is a mobile operating system (OS) based on the Linux kernel and currently developed by Google. With a user interface based on direct manipulation, Android is designed primarily for touchscreen mobile devices such as smartphones and tablet computers, with specialized user interfaces for televisions (Android TV), cars (Android Auto), and wrist watches (Android Wear). The OS uses touch inputs that loosely correspond to real-world actions, like swiping, tapping, pinching, and reverse pinching to manipulate on-screen objects, and a virtual keyboard. Despite being primarily designed for touchscreen input, it has also been used in game consoles, digital cameras, regular PCs, and other electronics. As of 2015, Android has the largest installed base of all operating systems.' },
        'arcade': { color: '#528821', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        'amstradcpc': { color: '#4f7524', vendor: 'Amstrad', year: '1984-1990', summary: '' },
        'atari2600': { color: '#4f7524', vendor: 'Atari', year: '1977-1992', summary: 'The Atari Video Computer System (VCS), later named the Atari 2600, is a second generation (1976–1992) home video game console developed and distributed by Atari, Inc. It was released on September 11, 1977 in North America at a retail price of $199. The console was later released in Europe (1978) and Japan (1983 - as the Atari 2800). The Atari 2600 popularized the use of microprocessor-based hardware and games contained on ROM cartridges. The console was discontinued on January 1, 1992. Rereleased as the Atari 2600+. This item is currently available from Atari for pre-order and will ship in December 2023.' },
        'atari5200': { color: '#0685bb', vendor: 'Atari', year: '1982-1984', summary: '' },
        'atari7800': { color: '#1d4b4c', vendor: 'Atari', year: '1986-1992', summary: '' },
        'atarijaguar': { color: '#af4bec', vendor: 'Atari', year: '1993-1996', summary: '' },
        'atarilynx': { color: '#4c9141', vendor: 'Atari', year: '1989-1995', summary: 'The Atari Lynx, usually just referred to as Lynx, is a fourth generation (1987-2004) handheld video game console developed in partnership with Epyx, Inc. and distributed by the Atari Corporation. It was released in September 1989 in North America at a retail price of $149.95. The handheld was also released in Europe (1990) and Japan (1990). The Lynx was the worlds first handheld electronic game with a color LCD screen. The console was discontinued in early 1996, possibly at the time of the companys sale on April 8, 1996.' },
        'atomiswave': { color: '#025669', vendor: 'Sammy', year: '2003-2009', image: 'arcade' },
        'c64': { color: '#887ecb', vendor: 'Commodore', year: '1982-1994', summary: 'The Commodore 64 is an 8-bit home computer introduced in January 1982 by Commodore International. It is listed in the Guinness World Records as the highest-selling single computer model of all time, with independent estimates placing the number sold between 10 and 17 million units. Volume production started in early 1982, marketing in August for US$595 (equivalent to $1,461 in 2015). Preceded by the Commodore VIC-20 and Commodore PET, the C64 took its name from its 64 kilobytes (65,536 bytes) of RAM. It had superior sound and graphical specifications compared to other earlier systems such as the Apple II and Atari 800, with multi-color sprites and a more advanced sound processor.' },
        'cdi': { color: '#1349ca', vendor: 'Philips', year: '1990-1998', summary: '' },
        'colecovision': { color: '#f9182f', vendor: 'Coleco', year: '1982-1985', summary: 'The ColecoVision is a second generation (1976–1992) home video game console developed and distributed by Coleco Industries. It was released in August 1982 in North America at a retail price of $175. The console was later released in Europe (1983). The ColecoVision offered a closer experience to arcade games than its competitors at the time. The console was discontinued in mid-1985.' },
        'cps1': { color: '#025836', vendor: 'Capcom', year: '1988-1995', image: 'arcade', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        'cps2': { color: '#049728', vendor: 'Capcom', year: '1993-2003', image: 'arcade', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        'cps3': { color: '#258ed1', vendor: 'Capcom', year: '1996-1999', image: 'arcade', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        'default': { color: '#194492', summary: '' },
        'dos': { color: '#87151b', vendor: 'Microsoft', year: '1981-2000', summary: 'MS-DOS, short for Microsoft Disk Operating System, was an operating system for x86-based personal computers mostly developed by Microsoft. It was the most commonly used member of the DOS family of operating systems, and was the main operating system for IBM PC compatible personal computers during the 1980s to the mid-1990s, when it was gradually superseded by operating systems offering a graphical user interface (GUI), in various generations of the Microsoft Windows operating system.' },
        'dreamcast': { color: '#2387ff', vendor: 'Sega', year: '1998-2001', summary: 'The Dreamcast is a 128-bit video game console which was released by Sega in late 1998 in Japan and from September 1999 in other territories. It was the first entry in the sixth generation of video game consoles, preceding Sonys PlayStation 2, Microsofts Xbox and the Nintendo GameCube.' },
        'famicom': { color: '#0a866f', vendor: 'Nintendo', year: '1983-2003', image: 'nes', summary: '' },
        'favorites': { color: '#ff4554', vendor: 'Various', summary: '' },
        'fbneo': { color: '#3b2dd4', image: 'arcade', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        'fds': { color: '#191a49', vendor: 'Nintendo', year: '1986-1990', summary: 'The Family Computer Disk System, sometimes shortened as the Famicom Disk System or simply the Disk System, and abbreviated as the FDS or FCD, is a peripheral for Nintendos Family Computer home video game console, released in Japan on February 21, 1986. It uses proprietary floppy disks called "Disk Cards" for data storage. Through its entire production span, 1986–2003, 4.44 million units were sold.  The device is connected to the Famicom deck by plugging a special cartridge known as the RAM Adapter into the systems cartridge port, and attaching that cartridges cable to the disk drive. The RAM adapter contains 32 kilobytes (KB) of RAM for temporary program storage, 8 KB of RAM for tile and sprite data storage, and an ASIC known as the 2C33. The ASIC acts as a disk controller for the floppy drive, and also includes additional sound hardware featuring a single-cycle wavetable-lookup synthesizer. Finally, embedded in the 2C33 is an 8KB BIOS ROM. The Disk Cards used are double-sided, with a total capacity of 112 KB per disk. Many games span both sides of a disk, requiring the user to switch sides at some point during gameplay. A few games use two full disks, totaling four sides. The Disk System is capable of running on six C-cell batteries or the supplied AC adapter. Batteries usually last five months with daily game play. The battery option is due to the likelihood of a standard set of AC plugs already being occupied by a Famicom and a television.' },
        'gamecube': { color: '#4b0082', vendor: 'Nintendo', year: '2001-2007', summary: 'The Nintendo GameCube was the first Nintendo console to use optical discs as its primary storage medium. In contrast with the GameCubes contemporary competitors, Sonys PlayStation 2, Segas Dreamcast and Microsofts Xbox, the GameCube uses mini DVD-based discs instead of full-size DVDs. Partially as a result of this, it does not have the DVD-Video playback functionality of these systems, nor the audio CD playback ability of other consoles that use full-size optical discs.' },
        'gamegear': { color: '#d0970d', vendor: 'Sega', year: '1990-1997', summary: 'The Sega Game Gear was Segas first handheld game console. It was the third commercially available color handheld console, after the Atari Lynx and the TurboExpress. Work began on the console in 1989 under the codename "Project Mercury", following Segas policy at the time of codenaming their systems after planets. The system was released in Japan on October 6, 1990, North America, Europe and Argentina in 1991, and Australia in 1992. The launch price was $150 US and £145 UK. Sega dropped support for the Game Gear in early 1997.' },
        'gb': { color: '#306230', vendor: 'Nintendo', year: '1989-2003', summary: 'The Game Boy is an 8-bit handheld video game console developed and manufactured by Nintendo. It was released in Japan on April 21, 1989, in North America in August 1989, and in Europe in 1990. In Southern Asia, it is known as the "Tata Game Boy" It is the first handheld console in the Game Boy line. It was created by Gunpei Yokoi and Nintendos Research and Development — the same staff who had designed the Game &amp; Watch series as well as several popular games for the NES.  The Game Boy was Nintendos second handheld system following the Game &amp; Watch series introduced in 1980, and it combined features from both the Nintendo Entertainment System and Game and Watch. It was also the first handheld game to use video game cartridges since Milton Bradleys Microvision handheld console. It was originally bundled with the puzzle game Tetris.  Despite many other, technologically superior handheld consoles introduced during its lifetime, the Game Boy was a tremendous success. The Game Boy and Game Boy Color combined have sold 118.69 million units worldwide. Upon its release in the United States, it sold its entire shipment of one million units within weeks.' },
        'gba': { color: '#342692', vendor: 'Nintendo', year: '2001-2008', summary: 'The Game Boy Advance (abbreviated as GBA) is a 32-bit handheld video game console developed, manufactured and marketed by Nintendo as the successor to the Game Boy Color. It was released in Japan on March 21, 2001, in North America on June 11, 2001, in Australia and Europe on June 22, 2001, and in mainland China on June 8, 2004 (iQue Player). Nintendos competitors in the handheld market at the time were the Neo Geo Pocket Color, WonderSwan, GP32, Tapwave Zodiac, and the N-Gage. Despite the competitors best efforts, Nintendo maintained a majority market share with the Game Boy Advance.  As of June 30, 2010, the Game Boy Advance series has sold 81.51 million units worldwide. Its successor, the Nintendo DS, was released in November 2004 and is also compatible with Game Boy Advance software.' },
        'gbc': { color: '#04DCFC', vendor: 'Nintendo', year: '1998-2003', summary: 'The Game Boy Color, (abbreviated as GBC) is a handheld game console manufactured by Nintendo, which was released on October 21, 1998 in Japan and was released in November of the same year in international markets. It is the successor of the Game Boy.  The Game Boy Color, as suggested by the name, features a color screen, but no backlight. It is slightly thicker and taller than the Game Boy Pocket, which is a redesigned Game Boy released in 1996. As with the original Game Boy, it has a custom 8-bit processor somewhat related to a Zilog Z80 central processing unit (CPU). The original name - with its American English spelling of "color" - remained unchanged even in markets where "colour" was the accepted English spelling.  The Game Boy Colors primary competitors were the much more advanced Neo Geo Pocket by SNK and the WonderSwan by Bandai (both released in Japan only), though the Game Boy Color outsold these by a wide margin. The Game Boy and Game Boy Color combined have sold 118.69 million units worldwide. It was discontinued in 2003, shortly after the release of the Game Boy Advance SP.' },
        'genesis': { color: '#df535b', vendor: 'Sega', year: '1988-1997', summary: 'The Sega Genesis, known as the Mega Drive in most regions outside North America, is a 16-bit home video game console which was developed and sold by Sega Enterprises, Ltd. The Genesis was Segas third console and the successor to the Master System. Sega first released the console as the Mega Drive in Japan in 1988, followed by a North American debut under the Genesis moniker in 1989. In 1990, the console was distributed as the Mega Drive by Virgin Mastertronic in Europe, by Ozisoft in Australasia, and by Tec Toy in Brazil. In South Korea, the systems were distributed by Samsung and were known as the Super Gam*Boy, and later the Super Aladdin Boy. The main microprocessor of the Genesis is a 16/32-bit Motorola 68000 CPU clocked at 7.6 MHz. The console also includes a Zilog Z80 sub-processor, which was mainly used to control the sound hardware and also provides backwards compatibility with the Master System.' },
        'gw': { color: '#6f3e80', vendor: 'Nintendo', year: '1980-1991', summary: 'The Game & Watch series are a total of 60 handheld electronic games produced by Nintendo from 1980 to 1991. Created by game designer Gunpei Yokoi, each Game & Watch features a single game to be played on an LCD screen in addition to a clock, an alarm, or both. This console inspired Nintendo to make the Game Boy. It was the earliest Nintendo product to gain major success.' },
        'intellivision': { color: '#4566f5', vendor: 'Mattel', year: '1979-1990', summary: '' },
        'mame': { color: '#082f72', image: 'arcade', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        'mastersystem': { color: '#e60012', vendor: 'Sega', year: '1985-1996', summary: 'The Master System (abbreviated to SMS) is a third-generation video game console that was manufactured and released by Sega in 1985 in Japan (as the Sega Mark III), 1986 in North America and 1987 in Europe. The original SMS could play both cartridges and the credit card-sized "Sega Cards," which retailed for cheaper prices than cartridges but had less code. The SMS also featured accessories such as a light gun and 3D glasses which were designed to work with a range of specially coded games. The Master System was released as a direct competitor to the Nintendo Entertainment System in the third videogame generation The SMS was technically superior to the NES, which predated its release significantly, but failed to overturn Nintendos significant market share advantage in Japan and North America.' },
        'msx': { color: '#ef3208', vendor: 'Microsoft', year: '1983-1993', summary: 'MSX is the name of a standardized home computer architecture, first announced by Microsoft on June 16, 1983. Before the appearance and great success of Nintendos Family Computer, MSX was the platform for which major Japanese game studios, such as Konami and Hudson Soft, produced video game titles. The Metal Gear series, for example, was originally written for MSX hardware.' },
        'mvs': { color: '#851d01', vendor: 'SNK', year: '1990-1997', image: 'arcade', summary: '' },
        'n64': { color: '#ffc001', vendor: 'Nintendo', year: '1996-2002', summary: 'Named for its 64-bit central processing unit, it was released in June 1996 in Japan, September 1996 in North America, March 1997 in Europe and Australia, September 1997 in France and December 1997 in Brazil. As part of the fifth generation of gaming, the N64 competed primarily with the PlayStation and the Sega Saturn. The Nintendo 64 was launched with three games: Super Mario 64 and Pilotwings 64, released worldwide; and Saikyo Habu Shogi, released only in Japan. While the N64 was succeeded by Nintendos MiniDVD-based GameCube in November 2001, N64 consoles remained available until the system was retired in late 2003.' },
        'naomi': { color: '#843c8a', vendor: 'Sega', year: '1998-2001', image: 'arcade', summary: '' },
        'nds': { color: '#ff4554', vendor: 'Nintendo', year: '2004-2013', summary: 'The Nintendo DS or simply, DS, is a 32-bit dual-screen handheld game console developed and released by Nintendo. The device went on sale in North America on November 21, 2004. The DS, short for "Developers System" or "Dual Screen", introduced distinctive new features to handheld gaming: two LCD screens working in tandem (the bottom one featuring a touchscreen), a built-in microphone, and support for wireless connectivity. Both screens are encompassed within a clamshell design similar to the Game Boy Advance SP. The Nintendo DS also features the ability for multiple DS consoles to directly interact with each other over Wi-Fi within a short range without the need to connect to an existing wireless network. Alternatively, they could interact online using the now-closed Nintendo Wi-Fi Connection service.' },
        'neogeo': { color: '#1499de', vendor: 'SNK', year: '1990-2004', summary: 'The Advanced Entertainment System (AES), originally known just as the Neo Geo, is the first video game console in the family. The hardware features comparatively colorful 2D graphics. The hardware was in part designed by Alpha Denshi (later ADK).  Initially, the home system was only available for rent to commercial establishments, such as hotel chains, bars and restaurants, and other venues. When customer response indicated that some gamers were willing to buy a US$650 console, SNK expanded sales and marketing into the home console market. The Neo Geo console was officially launched on 31 January 1990 in Osaka, Japan. The AES is identical to its arcade counterpart, the MVS, so arcade games released for the home market are nearly identical conversions.' },
        'neogeocd': { color: '#9e5c27', vendor: 'SNK', year: '1994-1997', summary: '' },
        'nes': { color: '#D8D8D8', vendor: 'Nintendo', year: '1983-2003', summary: 'The Nintendo Entertainment System is an 8-bit video game console that was released by Nintendo in North America during 1985, in Europe during 1986 and Australia in 1987. In most of Asia, including Japan (where it was first launched in 1983), China, Vietnam, Singapore, the Middle East and Hong Kong, it was released as the Family Computer, commonly shortened as either the romanized contraction Famicom, or abbreviated to FC. In South Korea, it was known as the Hyundai Comboy, and was distributed by Hynix which then was known as Hyundai Electronics.' },
        'ngp': { color: '#b32428', vendor: 'SNK', year: '1998-1999', image: 'ngpc', summary: 'The Neo Geo Pocket is a monochrome handheld game console released by SNK. It was the companys first handheld system and is part of the Neo Geo family. It debuted in Japan in late 1998 but never saw a western release, being exclusive to Japan and smaller Asian markets such as Hong Kong.  The Neo Geo Pocket is considered to be an unsuccessful console. Lower than expected sales resulted in its discontinuation in 1999, and was immediately succeeded by the Neo Geo Pocket Color, a full color device allowing the system to compete more easily with the dominant Game Boy Color handheld, and which also saw a western release. Though the system enjoyed only a short life, there were some significant games released on the system such as Samurai Shodown, and King of Fighters R-1.' },
        'ngpc': { color: '#3f621a', vendor: 'SNK', year: '1999-2001', summary: 'The Neo Geo Pocket Color (also stylized as NEOGEOPOCKET COLOR, often abbreviated NGPC), is a 16-bit color handheld video game console manufactured by SNK. It is a successor to SNKs monochrome Neo Geo Pocket handheld which debuted in 1998 in Japan, with the Color being fully backward compatible. The Neo Geo Pocket Color was released on March 16, 1999 in Japan, August 6, 1999 in North America, and on October 1, 1999 in Europe, entering markets all dominated by Nintendo.  After a good sales start in both the U.S. and Japan with 14 launch titles (a record at the time) subsequent low retail support in the U.S., lack of communication with third-party developers by SNKs American management, the craze about Nintendos Pokémon franchise, anticipation of the 32-bit Game Boy Advance, as well as strong competition from Bandais WonderSwan in Japan, led to a sales decline in both regions.  Meanwhile, SNK had been in financial trouble for at least a year; the company soon collapsed, and was purchased by American pachinko manufacturer Aruze in January 2000. However, Aruze didnt support SNKs video game business enough, leading to SNKs original founder and several other employees to leave and form a new company, BrezzaSoft. Eventually on June 13, 2000, Aruze decided to quit the North American and European markets, marking the end of SNKs worldwide operations and the discontinuation of Neo Geo hardware and software there. The Neo Geo Pocket Color (and other SNK/Neo Geo products) did however, last until 2001 in Japan. It was SNKs last video game console, as the company went bankrupt on October 22, 2001.  Despite its failure the Neo Geo Pocket Color has been regarded as an influential system. Many highly acclaimed games were released for the system, such as SNK vs. Capcom: The Match of the Millennium, King of Fighters R-2, and other quality arcade titles derived from SNKs MVS and AES. It also featured an arcade-style microswitched "clicky stick" joystick, which was praised for its accuracy and being well-suited for fighting games. The systems display and 40-hour battery life were also well received.' },
        'odyssey2': { color: '#9b276d', vendor: 'Magnavox', year: '1978-1984', summary: '' },
        'pcecd': { color: '#6c8156', vendor: 'NEC', year: '1988-1994', summary: 'The TurboGrafx-CD is an add on for the TurboGrafx-16. It was released to expand the library of games of the TurboGrafx 16.' },
        'pcengine': { color: '#25482b', vendor: 'NEC', year: '1987-1994', summary: 'TurboGrafx-16, fully titled as TurboGrafx-16 Entertainment SuperSystem and known in Japan as the PC Engine, is a video game console developed by Hudson Soft and NEC, released in Japan on October 30, 1987, and in North America on August 29, 1989.' },
        'pico8': { color: '#1c542d', vendor: 'Lexaloffle', year: '2015', summary: '' },
        'pokemini': { color: '#19b091', vendor: 'Nintendo', year: '2001-2002', summary: '' },
        'ports': { color: '#1d334a', summary: '' },
        'ps2': { color: '#347867', vendor: 'Sony', year: '2000-2013', summary: '' },
        'psp': { color: '#4e0b9c', vendor: 'Sony', year: '2004-2014', summary: 'The PlayStation Portable (PSP) is a handheld game console developed by Sony. Development of the handheld was announced during E3 2003, and it was unveiled on May 11, 2004, at a Sony press conference before E3 2004. The system was released in Japan on December 12, 2004, in North America on March 24, 2005, and in the PAL region on September 1, 2005. It primarily competed with the Nintendo DS, as part of the seventh generation of video games.  The PlayStation Portable became the most powerful portable system when launched, just after the Nintendo DS in 2004. It was the first real competitor to Nintendos handheld domination, where many challengers, such as SNKs Neo Geo Pocket and Nokias N-Gage, failed. Its GPU encompassed high-end graphics on a handheld, while its 4.3 inch viewing screen and multi-media capabilities, such as its video player and TV tuner, made the PlayStation Portable a major mobile entertainment device at the time. It also features connectivity with the PlayStation 3, other PSPs and the Internet. It is the only handheld console to use an optical disc format, Universal Media Disc (UMD), as its primary storage medium.  The original PSP model (PSP-1000) was replaced by a slimmer model with design changes (PSP-2000/"Slim & Lite") in 2007. Another remodeling followed in 2008, PSP-3000, which included a new screen and an inbuilt microphone. A complete redesign, PSP Go, came in 2009, followed by a budget model, PSP-E1000, in 2011. The PSP line was succeeded by the PlayStation Vita, released in December 2011 in Japan, and in February 2012 worldwide. The PlayStation Vita features backward compatibility with many PlayStation Portable games digitally released on the PlayStation Network, via PlayStation Store. Shipments of the PlayStation Portable ended throughout 2014 worldwide, having sold 80 million units in its 10-year lifetime.' },
        'psx': { color: '#365f8d', vendor: 'Sony', year: '1994-2006', summary: 'The Sony PlayStation, or PS for short, is a fifth generation (1993–2005) home video game console developed and distributed by Sony Interactive Entertainment. It was released on December 3, 1994 in Japan at a retail price of ¥37,000. The console was later released in North America (1995), Europe (1995), Australia (1995), and Korea (1996). The PlayStation was known for standardizing disc based games over cartridges, as well as controllers with two analog sticks and vibration feedback.  The console was discontinued on March 23, 2006.' },
        'recents': { color: '#00c3e3', vendor: 'past 30 days', summary: '' },
        'saturn': { color: '#5b92ff', vendor: 'Sega', year: '1994-2000', summary: '' },
        'scummvm': { color: '#5bce20', vendor: 'Lucasfilm Games', year: '1987-1998', summary: 'Script Creation Utility for Maniac Mansion Virtual Machine (ScummVM) is a set of game engine recreations. Originally designed to play LucasArts adventure games that use the SCUMM system, it also supports a variety of non-SCUMM games by companies like Revolution Software and Adventure Soft. It was originally written by Ludvig Strigeus. Released under the terms of the GNU General Public License, ScummVM is free software.  ScummVM is a reimplementation of the part of the software used to interpret the scripting languages such games used to describe the game world rather than emulating the hardware the games ran on; as such, ScummVM allows the games it supports to be played on platforms other than those for which they were originally released.' },
        'sega32x': { color: '#6935e9', vendor: 'Sega', year: '1994-1996', summary: 'The Sega Mega Drive console received two add-on hardware upgrades during its life time: the Sega Mega-CD and Sega 32X. It is possible to install both of these on the same base console, creating a system called the Sega Mega-CD 32X (PAL region) or Sega CD 32X (USA). This opens the possibility of software that can utilise both the Mega-CDs enhanced storage capacity and ability to play Red Book CD audio, and the 32Xs enhancements in graphics and sound capabilities.  Six games were released that require both add-on units in order to be played. All of these titles are full motion video based games, which were previously available as standalone Mega-CD games, and later had their FMV assets upgraded to take advantage of the 32Xs improved graphics. As such, all six were released on CDs, with the cart slot of the 32X being unused during gameplay.  Japan did not receive any Mega-CD 32X games, however North America received five while Europe recieved four of those five. Surgical Strike, once bound for a North American release, ended up being an exclusive title in Brazil (and curiously wound up being the only Mega-CD 32X game to reach this region). A further half-dozen titles were in development for the Mega-CD 32X at one stage, but were all cancelled, some merely appearing in Mega-CD form and some being moved to the Sega Saturn.' },
        'segacd': { color: '#cc4545', vendor: 'Sega', year: '1991-1996', summary: 'The Sega CD, released as the Mega-CD in most regions outside North America, is a CD-ROM accessory for the Sega Genesis video game console designed and produced by Sega as part of the fourth generation of video game consoles. The add-on was released on December 12, 1991 in Japan, October 15, 1992 in North America, and 1993 in Europe. The Sega CD lets the user play CD-based games and adds extra hardware functionality, such as a faster central processing unit and graphic enhancements. It can also play audio CDs and CD+G discs.Seeking to create an add-on device for the Genesis, Sega developed the unit to read compact discs as its storage medium. The main benefit of CD technology was greater storage capacity, which allowed for games to be nearly 320 times larger than their Genesis cartridge counterparts. This benefit manifested in the form of full motion video (FMV) games like the controversial Night Trap, which became a focus of the 1993 Congressional hearings on issues of video game violence and ratings. Sega of Japan partnered with JVC to design the add-on and refused to consult with Sega of America until the project was completed. Sega of America assembled parts from various "dummy" units to obtain a working prototype. While the add-on became known for several well-received games such as Sonic the Hedgehog CD and Lunar: Eternal Blue, its game library contained a large number of Genesis ports and FMV titles. The Sega CD was redesigned a number of times, including once by Sega and several times by licensed third-party developers.By the end of 1994, the add-on had sold approximately 2.7 million units worldwide, compared to 29 million units for the Genesis sold by that time. In 1995, Sega began shifting its focus towards its new console, the Sega Saturn, over the Genesis and Sega CD. The Sega CD was officially discontinued in 1996. Retrospective reception to the add-on is mixed, praising the Sega CD for its individual offerings and additions to the Genesis functions, but offering criticism to the game library for its depth issues, high price of the unit, and how the add-on was supported by Sega.' },
        'sfc': { color: '#766f81', vendor: 'Nintendo', year: '1990-2003', image: 'snes', summary: 'The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo, as well as the Super Famicom in Japan) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America.In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short.In South Korea, it is known as the Super Comboy and was distributed by Hyundai Electronics.Although each version is essentially the same, several forms of regional lockout prevent the different versions from being compatible with one another.' },
        'sg1000': { color: '#0c8427', vendor: 'Sega', year: '1983-1985', summary: '' },
        'snes': { color: '#aa6aff', vendor: 'Nintendo', year: '1990-2003', summary: 'The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo, as well as the Super Famicom in Japan) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America.In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short.In South Korea, it is known as the Super Comboy and was distributed by Hyundai Electronics.Although each version is essentially the same, several forms of regional lockout prevent the different versions from being compatible with one another.' },
        'supergrafx': { color: '#a66637', vendor: 'NEC', year: '1989-1990', summary: '' },
        'tg16': { color: '#585f21', vendor: 'NEC', year: '1987-1994', image: 'pcengine', summary: 'TurboGrafx-16, fully titled as TurboGrafx-16 Entertainment SuperSystem and known in Japan as the PC Engine, is a video game console developed by Hudson Soft and NEC, released in Japan on October 30, 1987, and in North America on August 29, 1989.' },
        'tgcd': { color: '#340f7a', vendor: 'NEC', year: '1988-1994', image: 'pcengine', summary: 'The TurboGrafx-CD is an add on for the TurboGrafx-16. It was released to expand the library of games of the TurboGrafx 16.' },
        'vboy': { color: '#802325', vendor: 'Nintendo', year: '1995-1996', summary: '' },
        'vectrex': { color: '#8129f1', vendor: 'Milton Bradley', year: '1982-1984', summary: '' },
        'wii': { color: '#e0e027', vendor: 'Nintendo', year: '2006-2017', summary: '' },
        'wswan': { color: '#d38aba', vendor: 'Bandai', year: '1999-2003', summary: 'The Bandai WonderSwan, usually just referred to as WonderSwan, is a fifth generation (1993-2005) handheld video game console developed and distributed by Bandai Co., Ltd. It was released on March 4, 1999 in Japan at a retail price of ¥4,800. The console was not released outside of Japan. The WonderSwan system had a low price point and long battery life which made it a formable competitor to Nintendo in Japan. The console was discontinued in Mid to late 2003.' },
        'wswanc': { color: '#9b3f23', vendor: 'Bandai', year: '1999-2003', summary: 'The Bandai WonderSwan Color, usually just referred to as WonderSwan Color, is a fifth generation (1993-2005) handheld video game console developed and distributed by Bandai Co., Ltd. It was released on December 9, 2000 in Japan at a retail price of ¥6,900. The console was not released outside of Japan. The WonderSwan Color was backwards compatible to the Wonderswan and still held a long lasting battery life. The console was discontinued in mid to late 2003.' },
        'x68000': { color: '#a53180', vendor: 'Sharp', year: '1987-1993', summary: '' },
        'zxspectrum': { color: '#0c46a9', vendor: 'Sinclair', year: '1982-1992', summary: '' },
    };
}
