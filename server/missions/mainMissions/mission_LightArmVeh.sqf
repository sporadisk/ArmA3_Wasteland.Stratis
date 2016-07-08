// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_LightArmVeh.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_MRAP_01_hmg_F",
		"B_MRAP_01_gmg_F",
		"O_MRAP_02_hmg_F",
		"O_MRAP_02_gmg_F",
		"I_MRAP_03_hmg_F",
		"I_MRAP_03_gmg_F",
		"CUP_B_HMMWV_AGS_GPK_ACR",
		"CUP_B_HMMWV_DSHKM_GPK_ACR",
		"CUP_B_HMMWV_M2_GPK_ACR",
		"CUP_I_LR_MG_AAF",
		"CUP_O_GAZ_Vodnik_AGS_RU",
		"CUP_O_GAZ_Vodnik_BPPU_RU",
		"CUP_O_GAZ_Vodnik_PK_RU",
		"CUP_O_UAZ_SPG9_CHDKZ",
		"CUP_O_UAZ_SPG9_RU"

	] call BIS_fnc_selectRandom;

	_missionType = "Light Armed Vehicle";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;
