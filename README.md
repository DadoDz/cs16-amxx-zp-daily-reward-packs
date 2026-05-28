# [ZP] Daily Reward Packs

A simple daily reward system for **Zombie Plague** servers in **Counter-Strike 1.6**.
Players can claim free Ammo Packs every ```12 hours``` using the ```/get``` command.

## Plugin Information

  - **Name**: [ZP] Daily Reward Packs
  - **Version**: 1.0
  - **Author**: DadoDz
  - **Game**: Counter-Strike 1.6
  - **Mod**: Zombie Plague

## Requirements

- AMX Mod X **1.9+**
- Zombie Plague Mod

## Installation
1. Place ```fvault.inc``` in: **addons/amxmodx/scripting/include/**
2. Place ```zp_daily_reward_packs.sma``` in: **addons/amxmodx/scripting/**
3. Compile it with your AMXX compiler.
4. Place the compiled .amxx file in: **addons/amxmodx/plugins/**
5. Add this line to your plugins.ini: ```zp_daily_reward_packs.amxx```
6. Restart your server.

## Required Natives
This plugin uses custom natives to get and set ammo packs, you must change these natives based on your zombie plague version.
- ```native zp_get_user_packs(index)```
- ```native zp_set_user_packs(index, packs)```

## Commands

| Command | Description      |
|---------|------------------|
| `/get`  | Claim Ammo Packs |

## Notice
> This plugin was originally created for my own server.
The concept already exists, this is simply my own lightweight implementation adapted for **Zombie Plague** servers.
