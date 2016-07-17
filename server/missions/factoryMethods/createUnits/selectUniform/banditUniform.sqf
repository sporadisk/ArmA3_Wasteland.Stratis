//	@file Name: banditUniform.sqf
/*
 * Returns uniforms and helmets
 * based on unit type and camo choice.
 * Parameters:
 * - unitType: Required, string
 *   Possible values: "UrbanCombat", "HeavyGuard", "AllRound", "Ranger", "VehicleCrew",
 *   "VehiclePassenger", "SeaCrew", "AirCrew"
 */
private ["_unitType", "_camos", "_helmets", "_sniperCamos"];

_unitType = _this select 0;

switch(_unitType) do {
	case "AirCrew": {
		// Civ pilot clothing
		_camos = ["CUP_U_C_Pilot_01", "U_C_Man_casual_2_F", "U_C_Man_casual_3_F", "U_C_Man_casual_1_F",
			"CUP_U_C_Citizen_04", "CUP_U_C_Citizen_03", "U_C_Poloshirt_blue", "U_C_Poloshirt_tricolour",
			"U_Competitor", "U_C_Journalist", "CUP_O_TKI_Khet_Jeans_02", "CUP_U_C_Mechanic_02",
			"U_C_Man_casual_6_F", "U_C_Man_casual_4_F", "U_C_Man_casual_5_F", "U_C_WorkerCoveralls",
			"U_C_Poor_1"];

		// Earcups with voice comm
		_helmets = ["CUP_H_PMC_Cap_Back_EP_Grey", "CUP_H_PMC_Cap_Back_EP_Tan", "CUP_H_PMC_Cap_EP_Grey",
			"CUP_H_PMC_Cap_EP_Tan", "CUP_H_PMC_EP_Headset", "H_Cap_marshal", "H_Cap_headphones"];
	};

	default: {

		// Misc civ clothing
		_camos = ["CUP_U_I_GUE_Anorak_03", "U_I_C_Soldier_Bandit_4_F", "U_I_C_Soldier_Bandit_1_F",
			"U_I_C_Soldier_Bandit_2_F", "U_I_C_Soldier_Bandit_5_F", "U_I_C_Soldier_Bandit_3_F",
			"CUP_U_O_CHDKZ_Bardak", "CUP_U_O_CHDKZ_Lopotev", "CUP_U_C_Citizen_01", "CUP_U_C_Citizen_02",
			"CUP_U_C_Citizen_04", "CUP_U_C_Citizen_03", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_redwhite",
			"U_C_HunterBody_grn", "U_OrestesBody", "CUP_U_C_Profiteer_02", "CUP_U_C_Profiteer_01",
			"CUP_U_C_Rocker_01", "CUP_U_C_Rocker_03", "CUP_U_C_Rocker_02", "CUP_U_C_Rocker_04",
			"U_C_man_sport_2_F", "CUP_U_C_Suit_01", "CUP_U_C_Suit_02", "CUP_U_C_Woodlander_04",
			"CUP_U_C_Worker_01"];

		// Seems Stratis is home to a well-stocked hat shop
		_helmets = ["H_Bandanna_gry", "H_Bandanna_blu", "H_Bandanna_cbr", "CUP_H_FR_BandanaGreen",
			"H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_sgg", "H_Bandanna_sand", "H_Bandanna_surfer",
			"H_Bandanna_surfer_blk", "H_Bandanna_surfer_grn", "CUP_H_FR_BandanaWdl", "H_Bandanna_camo",
			"CUP_H_C_Beanie_01", "CUP_H_C_Beanie_02", "CUP_H_C_Beanie_03", "CUP_H_C_Beanie_04",
			"CUP_H_ChDKZ_Beanie", "H_Beret_blk", "CUP_H_C_Beret_04", "CUP_H_C_Beret_01", "CUP_H_C_Beret_02",
			"CUP_H_C_Beret_03", "H_Booniehat_khk", "H_Booniehat_mcamo", "H_Booniehat_oli", "H_Booniehat_tan",
			"H_Booniehat_tna_F", "H_Booniehat_dgtl", "H_Cap_grn_BI", "H_Cap_blk", "H_Cap_blu",
			"CUP_H_PMC_Cap_Burberry", "H_Cap_blk_CMMG", "H_Cap_grn", "CUP_H_PMC_Cap_Grey", "H_Cap_red",
			"H_Cap_surfer", "H_Cap_tan", "CUP_H_PMC_Cap_Back_Burberry", "CUP_H_PMC_Cap_Back_Grey",
			"CUP_H_PMC_Cap_Back_Tan", "CUP_H_NAPA_Fedora", "H_Hat_blue", "H_Hat_brown", "H_Hat_camo",
			"H_Hat_checker", "H_Hat_grey", "H_Hat_tan", "CUP_H_C_MAGA_01", "CUP_H_C_Policecap_01",
			"H_RacingHelmet_1_black_F", "H_RacingHelmet_1_blue_F", "H_RacingHelmet_2_F", "H_RacingHelmet_1_F",
			"H_RacingHelmet_1_green_F", "H_RacingHelmet_1_orange_F", "H_RacingHelmet_1_red_F",
			"H_RacingHelmet_3_F", "H_RacingHelmet_4_F", "H_RacingHelmet_1_white_F",
			"H_RacingHelmet_1_yellow_F", "H_Shemag_olive", "H_ShemagOpen_tan", "H_ShemagOpen_khk",
			"H_Helmet_Skate", "CUP_H_SLA_Boonie", "CUP_H_SLA_TankerHelmet", "CUP_H_TK_TankerHelmet",
			"H_StrawHat", "CUP_H_TKI_Lungee_01", "CUP_H_TKI_Lungee_02", "CUP_H_TKI_Lungee_05",
			"CUP_H_USArmy_Boonie", "CUP_H_USA_Cap", "CUP_H_USArmy_Helmet_M1_btp",
			"CUP_H_USArmy_Helmet_M1_m81"];
	};
};

_sniperCamos = _camos;

// Return values:
// 1 - An array of uniforms for regular units
// 2 - An array of helmets / hats for all units
// 3 - An array of uniforms for snipers
// 4 - An array of uniforms for female units
[_camos, _helmets, _sniperCamos, ["B_FEM_FIA"]];