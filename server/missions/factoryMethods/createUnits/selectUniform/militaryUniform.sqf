//	@file Name: militaryUniform.sqf
/*
 * Returns uniforms and helmets
 * based on unit type and camo choice.
 * Parameters:
 * - unitType: Required, string
 *   Possible values: "UrbanCombat", "HeavyGuard", "AllRound", "Ranger", "VehicleCrew",
 *   "VehiclePassenger", "SeaCrew", "AirCrew"
 * - unitCamo: Required, string
 *   Possible values: "Forest", "MultiTerrain", "Desert", "Tropic"
 */
private ["_airHelmets", "_camo", "_camoCount", "_camoIndex", "_camos", "_crewHelmets", "_currentElement",
	"_femaleCamos", "_helmets", "_pilotCamos", "_sniperCamo", "_soldierCamos", "_soldierHeadGear",
	"_unitCamo", "_unitType", "_validCamos"];

_unitType = _this select 0;
_unitCamo = _this select 1;

_validCamos = ["Forest", "MultiTerrain", "Desert", "Tropic"];
_camoCount = (count _validCamos -1);

_camoIndex = 0;
for "_x" from 0 to _camoCount do
{
	_currentElement = _validCamos select _x; // Selects 0,1,2,3
	if(_currentElement == _unitCamo) then {
		_camoIndex = _x;
	};
};

_soldierCamos = [ // one camo array per pattern
	["CUP_U_B_BAF_DPM_S1_RolledUp", "CUP_U_B_BAF_DPM_Tshirt", "CUP_U_O_CHDKZ_Kam_04", "U_I_CombatUniform",
		"U_O_T_Soldier_F", "U_O_SpecopsUniform_ocamo", "CUP_U_O_SLA_MixedCamo"], // forest
	["CUP_U_O_CHDKZ_Kam_02", "U_B_CombatUniform_mcam", "U_O_CombatUniform_ocamo", "CUP_U_B_USMC_Officer",
		"CUP_U_B_USMC_MARPAT_WDL_Kneepad", "U_B_CombatUniform_mcam_vest", "CUP_U_O_TK_Green",
		"U_B_CombatUniform_mcam_worn"], // multiTerrain
	["CUP_U_B_BAF_DDPM_S1_RolledUp", "CUP_U_B_BAF_DDPM_Tshirt", "CUP_U_B_BAF_MTP_S5_UnRolled",
		"CUP_U_B_BAF_MTP_S6_UnRolled", "CUP_U_O_SLA_Desert"], // desert
	["CUP_U_O_CHDKZ_Kam_06", "U_B_T_Soldier_F", "U_B_T_Soldier_SL_F", "CUP_U_O_SLA_MixedCamo"]  // tropic
];

_femaleCamos = [ // One female camo per pattern
	"I_FEM_AAF_long", // Forest
	"O_FEM_CSAT_Rolled",  // MTP
	"B_FEM_NATO_long",  // Desert
	"I_FEM_AAF" // Tropic
];

_soldierHeadGear = [
	["CUP_H_USArmy_HelmetMICH_wdl", "CUP_H_RACS_Helmet_olive", "H_HelmetIA", "CUP_H_SLA_Helmet",
		"CUP_H_SLA_BeretRed", "CUP_H_RUS_6B27_NVG_olive"], // Forest
	["CUP_H_BAF_Crew_Helmet_MTP", "CUP_H_RACS_Helmet_olive", "H_HelmetIA",
		"CUP_H_SLA_Helmet", "CUP_H_RUS_6B27_NVG"], // multiTerrain
	["CUP_H_BAF_Officer_Beret", "H_Cap_tan", "CUP_H_USArmy_Helmet_ECH2_Sand"], // desert
	["CUP_H_RACS_Helmet_olive", "CUP_H_SLA_Helmet", "CUP_H_USArmy_Helmet_ECH1_Green",
		"CUP_H_SLA_BeretRed", "CUP_H_RUS_6B27_NVG_olive"]  // tropic
];

switch(_unitType) do {
	case "AirCrew": {
		// pilot coveralls (military)
		// pilot helmet
		_pilotCamos = [
			["U_B_HeliPilotCoveralls", "CUP_U_O_RUS_Gorka_Green"], // forest
			["U_B_HeliPilotCoveralls", "U_I_pilotCoveralls", "U_O_PilotCoveralls"], // multiTerrain
			["CUP_U_I_RACS_PilotOverall", "U_I_HeliPilotCoveralls"], // desert
			["U_B_T_Soldier_AR_F", "U_B_HeliPilotCoveralls", "CUP_U_O_RUS_Gorka_Green"]  // tropic
		];

		_airHelmets = [
			["H_PilotHelmetHeli_I", "H_PilotHelmetHeli_O", "CUP_H_USMC_Helmet_Pilot",
				"CUP_H_BAF_Helmet_Pilot"], // forest
			["H_PilotHelmetHeli_I", "H_PilotHelmetHeli_O", "CUP_H_USMC_Helmet_Pilot", 
				"CUP_H_BAF_Helmet_Pilot", "CUP_H_PMC_EP_Headset"], // multiTerrain
			["CUP_H_TK_PilotHelmet", "CUP_H_USMC_Helmet_Pilot", "CUP_H_RUS_ZSH_Shield_Down",
				"CUP_H_PMC_EP_Headset"], // desert
			["H_PilotHelmetHeli_I", "H_PilotHelmetHeli_O"]  // tropic
		];

		
		_camos = _pilotCamos select _camoIndex;
		_helmets = _airHelmets select _camoIndex;
	};

	case "VehicleCrew": {
		// Standard uniform
		// Crew helmet
		_crewHelmets = [
			["H_HelmetCrew_I", "CUP_H_BAF_Crew_Helmet_DPM", "CUP_H_RUS_TSH_4_Brown"], // forest
			["H_HelmetCrew_O", "CUP_H_BAF_Crew_Helmet_MTP", "CUP_H_RUS_TSH_4_Brown",
				"CUP_H_USMC_Crew_Helmet"], // multiTerrain
			["CUP_H_PMC_EP_Headset", "CUP_H_BAF_Crew_Helmet_DDPM", "CUP_H_RUS_TSH_4_Brown"], // desert
			["H_HelmetCrew_O_ghex_F", "CUP_H_RUS_TSH_4_Brown"]  // tropic
		];
		_camos = _soldierCamos select _camoIndex;
		_helmets = _crewHelmets select _camoIndex;
	};

	case "SeaCrew": {
		// Sea-appropriate uniforms
		// Beret / caps
		// Only one color scheme: Blue. Ignore camo preset.
		_camos = ["U_B_GEN_Commander_F", "U_B_GEN_Soldier_F", "CUP_B_USMC_Navy_Blue",
			"CUP_B_USMC_Navy_Green", "CUP_B_USMC_Navy_Violet", "CUP_B_USMC_Navy_White",
			"CUP_U_O_SLA_Overalls_Tank", "CUP_U_O_SLA_Overalls_Pilot"];
		_helmets = ["H_Beret_02", "CUP_H_SLA_BeretRed", "CUP_H_BAF_Officer_Beret_PRR_U", "H_Watchcap_blk",
			"H_Beret_blk", "H_Beret_gen_F", "CUP_H_RUS_Beret_VDV", "H_Cap_blu", "CUP_H_PMC_Cap_EP_Grey",
			"CUP_H_PMC_EP_Headset", "H_MilCap_blue", "H_MilCap_gen_F", "CUP_H_RACS_Beret_Blue"];
	};

	default: {
		// one random uniform for this squad
		// one helmet for this squad
		_camos = _soldierCamos select _camoIndex;
		_helmets = _soldierHeadGear select _camoIndex;
	};
};



_camo = _camos call BIS_fnc_selectRandom;
if(_unitType == "Ranger") then {
	// Ranger unit snipers get access to ghillie suits.
	_sniperCamos = [
		["U_I_FullGhillie_lsh", "U_O_FullGhillie_lsh", "U_B_FullGhillie_lsh", "CUP_U_B_GER_Fleck_Ghillie",
			"U_I_GhillieSuit", "CUP_U_I_Ghillie_Top"], // Forest
		["U_I_FullGhillie_sard", "U_O_FullGhillie_sard", "U_B_FullGhillie_sard", "U_O_GhillieSuit",
			"U_B_GhillieSuit", "CUP_U_I_Ghillie_Top"],  // MTP
		["CUP_U_B_GER_Ghillie"],  // Desert
		["U_B_T_FullGhillie_tna_F", "U_O_T_FullGhillie_tna_F", "U_O_T_Sniper_F", "U_B_T_Sniper_F"] // Tropic
	];
	_sniperCamo = (_sniperCamos select _camoIndex) call BIS_fnc_selectRandom;
} else {
	// Normal unit snipers do not get ghillie.
	_sniperCamo = _camo;
};

// Return values:
// 1 - An array of uniforms for regular units
// 2 - An array of helmets / hats for all units
// 3 - An array of uniforms for snipers
// 4 - An array of uniforms for female units
[[_camo], [(_helmets call BIS_fnc_selectRandom)], [_sniperCamo], [(_femaleCamos select _camoIndex)]];