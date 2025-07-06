> [!NOTE]
> This project is just a hobby and is in no way made to compete either with **HLStatsX:CE** nor **gameME**.

### SMStats
   - 100% translation supported.
      - Including a custom **'plural splitter'**, similar to Counter-Strike 2's new translation syntax.
      - Translation submissions are welcome and currently is demanded, and would definitely be very appreciating!! ヽ(*・ω・)ﾉ
      - Translator will be granted a custom name colour (´｡• ω •｡`)
   - Updater support
      - The updating process is automatic. (* ^ ω ^)
      - When update is detected, update message are sent to the chat and information are saved to **'SMStats Info'** module, to prevent loss of data.
   - Tracks:
      - Players (Total playtime, dominations, headshots and much much more.)
      - Weapons (Tracks all kind of weapons, self-explanatory..)
      - Maps (Map total playtime, headshots, backstabs, etc.)
      - Kills (Type of kill, distance, etc)
      - Items (found, traded, etc) (Not added yet)
      - Custom achievements. (Not added yet, but there are code mentions about it.)
      - Settings. (Saves settings obviously.)
   - Notes:
      - [Geoip Country Name Translation](https://github.com/nukkonyan/SM-Geoip-CountryName) - Required for country name translation and compiling, aswell as for plugin to function.
      - No Web panel currently exists yet.
      - Currently in active re-writing process from scratch:
          - Better more efficient code-base and SQL-code as 'SM Stats' (renamed from XStats) with full extended translation support.
          - The new code is more efficient and impacts less on server performance.
          - Some functions yet implemented and sooner or later will be.
          - Some things may not work as intended at the very moment, but will get working sooner or later.
      - Games supported so far:
          - Team Fortress 2 (works very well, some bugs and issues are to be expected)
      - Expected early testing build
          - Somewhere between end of October and somewhere between mid november and early-mid december.
          - This will begin with Team Fortress 2 due to stability reasons.
      - Development
          - Perhaps interested in development assistance? Hit me up on [Steam](https://steamcommunity.com/id/nukkonyan)!
   - Credits
      - [Neigeflocon](https://steamcommunity.com/profiles/76561197962831152) - Turkish translations.

### Supported games
   - [x] Team Fortress 2
   - [ ] Team Fortress 2 Classic.
   - [ ] Open Fortress
   - [ ] Counter-Strike: Source
   - [x] Counter-Strike: Global Offensive
   - [ ] Counter-Strike: Classic Offensive.
   - [ ] ClassicCounter
   - [ ] Counter-Strike 2
   - [ ] Legacy Strike (2015 CS:GO)
   - [ ] Left 4 Dead 1
   - [ ] Left 4 Dead 2
   - [ ] Day Of Defeat: Source
### To-do
   - [x] Update Stats Menu
      -  [x] Implement sm_stats <top index | steamid > to manually check statistics of a particular player.
         -  [x] sm_stats 30 **displays Top 30 current player.**
         -  [x] sm_stats "STEAM_0:0:1234" **displays the Top player through steamid.**
   - [ ] Implement spam-detection with a penalty (exploiting loopholes to farm points). (Prevent gaining points).
   - [ ] Implement custom achievements functionality.
   - [ ] Implement functional K-A-D ratio (Kill-Assist-Death ratio).
   - [ ] Implement functional K/D Ratio (Kill-Death ratio).
   - [x] Implement functional time played (Convert x seconds to 1 day 1 hour, etc.)
   - [ ] Implement a ban feature which detects if the player has been banned from the server, the player's details on SMStats will be removed.
   - [ ] Implement a hit location tracker, which tracks where you hit on the enemy's body (Stomach/Torso, Head, Shoulder, Feet, etc)
   - [ ] Implement auto-erase old players from database. ( Not connected after x amount of days )
   - [ ] Fix playtime timer. Right now it is buggy and not working correctly. **(At the moment somewhat fixed.)**
   - [x] Add connect sounds (when a top 10 and top 1 player connects.
   - [ ] Deprecate SMStats Info (temporary solution) and instead use temporary KeyValue file storing. **(Or use SQLite)**
   - [ ] Support more source games in the future.
   - [ ] Create website.
