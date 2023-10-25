
```
Currently in active re-writing process from scratch with better more efficient code-base
and SQL-code as 'SM Stats' (renamed from XStats) with full extended translation support.
The new code is more efficient and impacts less on server performance.

Games supported so far:
Team Fortress 2 (works very well, some bugs and issues are to be expected)

Some functions yet implemented and sooner or later will be.
Some things may not work as intended at the very moment, but will get working sooner or later.
```
### SMStats
   - 100% translation supported.
      - Including a custom **'plural splitter'**, similar to Counter-Strike 2's new translation syntax.
   - Tracks:
      - Players (Total playtime, dominations, headshots and much much more.)
      - Weapons (Tracks all kind of weapons, self-explanatory..)
      - Maps (Map total playtime, headshots, backstabs, etc.)
      - Items (found, traded, etc) (Not added yet)
      - Custom achievements. (Not added yet, but there are code mentions about it.)
   - Notes:
      - This project is only just a hobby and is in no way made to compete with HLStatsX:CE nor gameME.
      - [Geoip Country Name Translation](https://github.com/Teamkiller324/SM-Geoip-CountryName) - Required for country name translation and compiling, aswell as for plugin to function.

### To-do
   - stats menu
        - ~~Implement sm_stats <top index | steamid > to manually check statistics of a particular player.~~ Added
             -  ~~Example sm_stats 30 displays Top 30 current player.~~
             -  ~~Example sm_stats "STEAM_0:0:1234" displays the player through steamid.~~
   - overall
        - Implement spam-detection with a penalty (exploiting loopholes to farm points).
        - Implement custom achievements functionality.
        - Implement leaderboard ban functionality (Prevented from gaining points).
        - Implement functional K-A-D ratio (Kill-Assist-Death ratio).
        - Implement functional K/D Ratio (Kill-Death ratio).
        - Implement functional time played (Convert x minutes to 1 day 1 hour, etc.)
	- Implement a ban feature which detects if the player has been banned from the server, the player's details on SMStats will be removed.
        - Fix playtime timer. Right now it is buggy and not working correctly. **(At the moment somewhat fixed.)**
        - Deprecate SMStats Info (It's a temporary solution) and instead use temporary KeyValue file storing. **(Or use SQLite)**
        - Support more source games in the future. such as:
          - Team Fortress 2 Classic.
          - Counter-Strike: Source.
          - Counter-Strike: Global Offensive.
          - Counter-Strike 2.
          - Left 4 Dead 2.
          - and many other.
        - Create website.

## Expected early testing build
   - Somewhere between end of October and possibly as late as early December.
   - This will begin with Team Fortress 2 due to stability reasons.

## Lookin to assist in development?
   - Hit me up on [Steam](https://steamcommunity.com/id/Teamkiller324)!
   - Active SMStats server:
        - 83.253.75.203:27018 (Team Fortress 2)
