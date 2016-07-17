//	@file Name: createRandomSoldier2.sqf
/*
 * Creates a random soldier.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    unitType: String - (optional, default "AllRound")
 *    unitFaction: String - (optional, default "Military")
 *    unitCamo: String - (optional, default "MultiTerrain")
 *    unitCount: Integer - (optional, default 1)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_soldierTypes", "_uniformTypes", "_vestTypes", "_weaponTypes", "_group", "_position", "_rank",
	"_soldier", "_unitTypes" "_validUnit", "_unitLoadouts", "_rareUnitLoadouts", "_validFaction",
	"_unitFactions", "_unitCamos", "_unitCamo", "_validCamo", "_unitLoadout", "_femaleChance", "_femaleFaces",
	"_maleFaces", "_clothing"];

_unitLoadouts = [];
_rareUnitLoadouts = [];
_unitTypes = ["UrbanCombat", "HeavyGuard", "AllRound", "Ranger", "VehicleCrew", "VehiclePassenger",
	"SeaCrew", "AirCrew"];
_unitFactions = ["Military", "Bandit", "Rebel", "PMC"];
_unitCamos = ["Forest", "MultiTerrain", "Desert", "Tropic"];

_femaleFaces = ["Smith", "Tyler", "Quereshi", "Mason", "Oakes", "Cheung", "Mason_Rigged", "Mason_scars",
	"Mason_v2", "Oakes_v2", "Quereshi_v2", "Smith_v2", "Tyler_scars"];
_maleFaces = ["AfricanHead_02", "Anderson", "AsianHead_A3_04", "CamoHead_African_01_F", "CamoHead_Asian_03_F",
	"CamoHead_Greek_06_F", "CamoHead_Persian_03_F", "CamoHead_White_13_F", "CUP_Cooper", "CUP_Miles",
	"CUP_OHara", "CUP_Rodriguez", "CUP_Sykes", "Garrett", "Gibson", "Gordon", "GreekHead_A3_01",
	"GreekHead_A3_03", "GreekHead_A3_05", "Johnson", "Jones", "Kerry", "Kerry_A_F", "kerry_B1_F",
	"kerry_B2_F", "Kerry_C_F", "Miller", "Moreau", "Moreau_beard", "Nikoladze", "Nikos", "O_Colonel",
	"PersianHead_A3_01", "PersianHead_A3_03", "Rodriguez", "TanoanBossHead", "TanoanHead_A3_01",
	"TanoanHead_A3_02", "TanoanHead_A3_07", "TanoanHead_A3_08", "Taylor", "WhiteHead_01", "WhiteHead_02",
	"WhiteHead_09", "Zee_Black_Head_01", "Zee_White_Head_01", "Zee_White_Head_02_beard", "Zee_White_Head_04",
	"Zee_White_Head_05", "Zee_White_Head_06", "Zee_White_Head_07", "Zee_White_Head_08", "Zee_White_Head_09",
	"Zee_White_Head_10", "Zee_White_Head_11", "Zee_White_Head_12", "Zee_White_Head_13", "Zee_White_Head_14",
	"Zee_White_Head_15", "Zee_White_Head_16", "Zee_White_Head_17", "Zee_White_Head_18", "Zee_White_Head_19",
	"Zee_White_Head_20", "Zee_White_Head_21"];

_group = _this select 0;
_position = _this select 1;
_unitType = param[2, "AllRound", [""]];
_unitFaction = param[3, "Military", [""]];
_unitCamo = param[4, "MultiTerrain", [""]];
_unitCount = param[5, 1, [0]];
_rank = param [6, "", [""]];


// Make sure _unitType parameter is valid (must be equal to one of the _unitTypes)
_validUnit = false;
{
	if (_unitType == _x) then {
		_validUnit = true;
	};
} forEach _unitTypes;

if(!_validUnit) then {
	_unitType = "AllRound";
};

// Make sure _unitFaction parameter is valid (must be equal to one of the _unitFactions)
_validFaction = false;
{
	if (_unitFaction == _x) then {
		_validFaction = true;
	};
} forEach _unitFactions;

if(!_validFaction) then {
	_unitFaction = "Military";
};

// Make sure _unitCamo parameter is valid (must be equal to one of the _unitCamos)
_validCamo = false;
{
	if (_unitCamo == _x) then {
		_validCamo = true;
	};
} forEach _unitCamos;

if(!_validCamo) then {
	_unitCamo = "MultiTerrain";
};

// Launcher + smg / sidearm:
// Not for air crew, vehicle crew or sea crew.
// Rare unit, except in heavy guard units.
if(_unitType != "AirCrew" && _unitType != "VehicleCrew" && _unitType != "SeaCrew") then {
	if(_unitType == "HeavyGuard") then {
		_unitLoadouts pushBack "Launcher";
	} else {
		_rareUnitLoadouts pushBack "Launcher";
	};
};

// LMG / MMG
// Not for air crew or vehicle crew.
// Rare in urban combat crews.
if(_unitType != "AirCrew" && _unitType != "VehicleCrew") then {
	if(_unitType == "UrbanCombat") then {
		_rareUnitLoadouts pushBack "LMG_MMG";
	} else {
		_unitLoadouts pushBack "LMG_MMG";
	};
};

// SMG
// -Only- for vehicle crew, air crew, urban combat units, and bandit units.
if(_unitType == "VehicleCrew" || _unitType == "AirCrew" || _unitType == "UrbanCombat" ||
	_unitFaction == "Bandit") then {
	_unitLoadouts pushBack "SMG";
};

// Assault Rifle
// Not for air crew, vehicle crew or heavy guard units.
if(_unitType != "AirCrew" && _unitType != "VehicleCrew" && _unitType != "HeavyGuard") then {
	_unitLoadouts pushBack "AR";
};

// Assault Rifle + GL
// Not for air crew, vehicle crew or heavy guard units.
if(_unitType != "AirCrew" && _unitType != "VehicleCrew" && _unitType != "HeavyGuard") then {
	_unitLoadouts pushBack "AR_GL";
};

// Sniper
// -Only- for all-round, vehicle passengers, ranger units and Heavy Guard.
// Rare unit, except when unit is of type "Ranger"
// Ranger-type sniper-units will be the only ones to receive ghillie suits.
if(_unitType == "AllRound" || _unitType == "VehiclePassenger" || _unitType == "Ranger" ||
	_unitType == "HeavyGuard") then {
	if(_unitType == "Ranger") then {
		_unitLoadouts pushBack "Sniper";
	} else {
		_rareUnitLoadouts pushBack "Sniper";
	};
};

// Shield + sidearm
// Only in bandit units
// Rare unit
if(_unitFaction == "Bandit") then {
	_rareUnitLoadouts pushBack "Shield";
};

// Shotgun
// Only in bandit units or urban combat units.
if(_unitFaction == "Bandit" || _unitType == "UrbanCombat") then {
	_unitLoadouts pushBack "Shotgun";
};

// Select uniform based on unit type
// Bandits: Large array of random civilian clothes
// Rebels: Array of uniforms that match the selected camo, with civ clothes thrown in.
// Military: One uniform for all units, matching the selected camo.
// PMC: Whatever fits the theme. No regard for camo.
// Chance of female unit:
// (based on https://en.wikipedia.org/wiki/Women_in_the_military_by_country )
// Military: 15%
// Rebel: 40%
// Bandit: 30%
// PMC: 20%
switch(_unitFaction) do {
	default;
	case "Military": {
		_femaleChance = 0.15;
		_clothing = [_unitType, _unitCamo] call selectMilitaryUniform;
	};

	case "Bandit": {
		_femaleChance = 0.3;
		_clothing = [_unitType, _unitCamo] call selectBanditUniform;
	}
}

if ((floor random 100) <= 20) then {
	// Rare unit!
	_unitLoadout = _rareUnitLoadouts call BIS_fnc_selectRandom;
} else {
	_unitLoadout = _unitLoadouts call BIS_fnc_selectRandom;
}



_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;

if (_rank != "") then
{
	_soldier setRank _rank;
};

_soldier spawn refillPrimaryAmmo;
_soldier spawn addMilCap;
_soldier call setMissionSkill;

_soldier addEventHandler ["Killed", server_playerDied];

_soldier
