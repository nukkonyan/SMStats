
```
Currently in active re-writing process from scratch with better more efficient code-base
and SQL-code as 'SM Stats' (renamed from XStats) with full extended translation support.
The new code is more efficient and impacts less on server performance.

Games supported so far:
Team Fortress 2 (works well, several bugs and issues are to be expected)
Counter-Strike: Source (very buggy, barely worked on yet)

Some functions yet implemented and sooner or later will be.
Some things may not work as intended at the very moment, but will get working sooner or later.
```

### To-do
   - Team Fortress 2
        - Implement spam-detection (exploiting to farm points such as spamming CTF Flag being picked up).
   - stats menu
        - Implement sm_stats <top index | steamid > to manually check statistics of a particular player.
             -  Example sm_stats 30 displays Top 30 current player.
             -  Example sm_stats "STEAM_0:0:1234" displays the player through steamid.
   - overall
        - Potentially 'info module' (Store information of the current players, so after plugin was updated mid-game, stats will be restored).
        - Implement custom achievements functionality.
        - Implement leaderboard ban functionality (Prevented from gaining points).
        - Implement functional K-A-D ratio (Kill-Assist-Death ratio).
        - Implement functional K/D Ratio (Kill-Death ratio).
        - Implement functional time played (Convert x minutes to 1 day 1 hour, etc.)
		- Implement a ban feature which detects if the player has been banned from the server, the player's details on SMStats will be removed.
        - Support more source games.
        - Create website.

[Geoip Country Name Translation](https://github.com/Teamkiller324/SM-Geoip-CountryName) - Required for country name translation and compiling, aswell as for plugin to function.

``SM Stats`` or ``SourceMod Stats`` is a multi-statistical tracking plugin that tracks frags, events, achievements and offers multi-game support, player connection/disconnection messages, player connect sounds, full translation support and more likely to come.

### This project is just a hobby and is in no way made to compete with HLStatsX:CE nor gameME.

## GitHub page to be updated.
