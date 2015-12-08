local e={}
function e.OnAllocate()end
function e.OnInitialize()end
function e.Update()
	if e.btrainer_disable_action then
		vars.playerDisableActionFlag=PlayerDisableAction.NONE
		e.btrainer_disable_action = false
	end

	if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.RELOAD)==PlayerPad.RELOAD)then

		vars.playerDisableActionFlag=PlayerDisableAction.OPEN_EQUIP_MENU
		e.btrainer_disable_action = true
		e.btrainer_revenge_confirm = false
		
		if (Time.GetRawElapsedTimeSinceStartUp() - e.btrainer_hold_pressed > 1)then

			local btrainer_cycle_playerTypes={PlayerType.SNAKE, PlayerType.DD_MALE, PlayerType.DD_FEMALE, PlayerType.AVATAR}
			local btrainer_cycle_playerTypes_string={"Snake", "DD Male", "DD Female", "Avatar"}
			local btrainer_cycle_playerCode=math.floor(vars.missionCode/1e4)
			local btrainer_cycle_PlayerCamoTypes={PlayerCamoType.OLIVEDRAB, PlayerCamoType.SPLITTER, PlayerCamoType.SQUARE, PlayerCamoType.TIGERSTRIPE, PlayerCamoType.GOLDTIGER, PlayerCamoType.FOXTROT, PlayerCamoType.WOODLAND, PlayerCamoType.WETWORK, PlayerCamoType.SNEAKING_SUIT_GZ, PlayerCamoType.SNEAKING_SUIT_TPP, PlayerCamoType.BATTLEDRESS, PlayerCamoType.PARASITE, PlayerCamoType.LEATHER, PlayerCamoType.SOLIDSNAKE, PlayerCamoType.NINJA, PlayerCamoType.RAIDEN, PlayerCamoType.REALTREE, PlayerCamoType.PANTHER,
			--PlayerCamoType.MGS3, PlayerCamoType.MGS3_NAKED, PlayerCamoType.MGS3_SNEAKING, PlayerCamoType.MGS3_TUXEDO, PlayerCamoType.EVA_CLOSE, PlayerCamoType.EVA_OPEN, PlayerCamoType.BOSS_CLOSE, PlayerCamoType.BOSS_OPEN
			}
			local btrainer_cycle_PlayerCamoTypes_string={"Olivedrab", "Splitter", "Square", "Tigerstripe", "Goldtiger", "Foxtrot", "Woodland", "Wetwork", "Sneaking Suit GZ", "Sneaking Suit TPP", "Battledress", "Parasite", "Leather", "Solid Snake", "Ninja", "Raiden", "Realtree", "Panther", "MGS3",
			--"MGS3_NAKED", "MGS3_SNEAKING", "MGS3_TUXEDO", "EVA_CLOSE", "EVA_OPEN", "BOSS_CLOSE", "BOSS_OPEN"
			}
		
			e.btrainer_hold_pressed = Time.GetRawElapsedTimeSinceStartUp()

			if btrainer_cycle_playerCode~=5 then
			
				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.RIGHT)==PlayerPad.RIGHT)then
					if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ZOOM_CHANGE)==PlayerPad.ZOOM_CHANGE)then
						vars.playerFaceId=vars.playerFaceId + 100
					elseif (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.FIRE)==PlayerPad.FIRE)then
						vars.playerFaceId=vars.playerFaceId + 10
					else
						vars.playerFaceId=vars.playerFaceId + 1
					end
					
					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView(string.format("Face ID: %d", vars.playerFaceId))
				end

				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.LEFT)==PlayerPad.LEFT)then

					if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ZOOM_CHANGE)==PlayerPad.ZOOM_CHANGE)then
						if vars.playerFaceId > 99 then
							vars.playerFaceId=vars.playerFaceId - 100
						else
							vars.playerFaceId=0
						end
					elseif (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.FIRE)==PlayerPad.FIRE)then
						if vars.playerFaceId > 9 then
							vars.playerFaceId=vars.playerFaceId - 10
						else
							vars.playerFaceId=0
						end
					else
						if vars.playerFaceId > 0 then
							vars.playerFaceId=vars.playerFaceId - 1
						else
							vars.playerFaceId=0
						end
					end

					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView(string.format("Face ID: %d", vars.playerFaceId))
				end
				
				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.PRIMARY_WEAPON)==PlayerPad.PRIMARY_WEAPON)then

					if (vars.playerCamoType == PlayerCamoType.SNEAKING_SUIT_GZ)then
						TppUiCommand.AnnounceLogDelayTime(0)
						TppUiCommand.AnnounceLogView("Cannot change player type while using Sneaking Suit GZ")
					else

						if (e.btrainer_playerTypes_index == nil)then
							e.btrainer_playerTypes_index = 0
						end

						if (e.btrainer_playerTypes_face == nil)then
							e.btrainer_playerTypes_face = 0
						end
						
						e.btrainer_playerTypes_index=e.btrainer_playerTypes_index + 1
						
						if (e.btrainer_playerTypes_index > 4 or e.btrainer_playerTypes_index < 1)then
							e.btrainer_playerTypes_index = 1
						end

						if vars.playerFaceId ~= 0 and vars.playerFaceId ~= nil then
							e.btrainer_playerTypes_face = vars.playerFaceId
						end

						if ((vars.playerCamoType == PlayerCamoType.EVA_CLOSE or
							vars.playerCamoType == PlayerCamoType.EVA_OPEN or
							vars.playerCamoType == PlayerCamoType.BOSS_CLOSE or
							vars.playerCamoType == PlayerCamoType.BOSS_OPEN)
							and e.btrainer_playerTypes_index == 2)
						then
							TppUiCommand.AnnounceLogDelayTime(0)
							TppUiCommand.AnnounceLogView("Cannot change player type to DD Male while using this camo")
						elseif ((vars.playerCamoType == PlayerCamoType.MGS3 or
							vars.playerCamoType == PlayerCamoType.MGS3_NAKED or
							vars.playerCamoType == PlayerCamoType.MGS3_SNEAKING or
							vars.playerCamoType == PlayerCamoType.MGS3_TUXEDO)
							and e.btrainer_playerTypes_index == 3)
						then
							TppUiCommand.AnnounceLogDelayTime(0)
							TppUiCommand.AnnounceLogView("Cannot change player type to DD Female while using this camo")
						else
							vars.playerType=btrainer_cycle_playerTypes[e.btrainer_playerTypes_index]
							vars.playerFaceId=0

							if vars.playerType == PlayerType.DD_MALE or vars.playerType == PlayerType.DD_FEMALE then
								vars.playerFaceId = e.btrainer_playerTypes_face
							end
							
							TppUiCommand.AnnounceLogDelayTime(0)
							TppUiCommand.AnnounceLogView(string.format("Changed player type to: %s", btrainer_cycle_playerTypes_string[e.btrainer_playerTypes_index]))
						end
					end
				end
				
				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.DOWN)==PlayerPad.DOWN)then
				
					if (e.btrainer_PlayerCamoTypes_index == nil)then
						e.btrainer_PlayerCamoTypes_index = 0
					end

					e.btrainer_PlayerCamoTypes_index=e.btrainer_PlayerCamoTypes_index + 1

					if (btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.SNEAKING_SUIT_GZ and vars.playerType ~= PlayerType.SNAKE)then
						e.btrainer_PlayerCamoTypes_index=e.btrainer_PlayerCamoTypes_index + 1
					end

					if ((btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.MGS3 or
						btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.MGS3_NAKED or
						btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.MGS3_SNEAKING or
						btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.MGS3_TUXEDO)
						and (vars.playerType == PlayerType.DD_FEMALE))
					then
						e.btrainer_PlayerCamoTypes_index= 23
					end
					
					if ((btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.EVA_CLOSE or
						btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.EVA_OPEN or
						btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.BOSS_CLOSE or
						btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index] == PlayerCamoType.BOSS_OPEN)
						and vars.playerType == PlayerType.DD_MALE)
					then
						e.btrainer_PlayerCamoTypes_index = 1
					end
					
					if (e.btrainer_PlayerCamoTypes_index > #btrainer_cycle_PlayerCamoTypes or e.btrainer_PlayerCamoTypes_index < 1)then
						e.btrainer_PlayerCamoTypes_index = 1
					end
					
					vars.playerCamoType=btrainer_cycle_PlayerCamoTypes[e.btrainer_PlayerCamoTypes_index]
					vars.playerPartsType=PlayerPartsType.NORMAL
					vars.playerFaceEquipId=0


					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView(string.format("Changed player camo to: %s", btrainer_cycle_PlayerCamoTypes_string[e.btrainer_PlayerCamoTypes_index]))
					
				end

			end

		end
	else
		e.btrainer_hold_pressed = Time.GetRawElapsedTimeSinceStartUp()
	end

	if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ACTION)==PlayerPad.ACTION)then

		vars.playerDisableActionFlag=PlayerDisableAction.OPEN_EQUIP_MENU
		e.btrainer_disable_action = true

		if (Time.GetRawElapsedTimeSinceStartUp() - e.btrainer_hold_pressed2 > 1)then

			local btrainer_cycle_weather={TppDefine.WEATHER.SUNNY, TppDefine.WEATHER.CLOUDY, TppDefine.WEATHER.RAINY, TppDefine.WEATHER.SANDSTORM, TppDefine.WEATHER.FOGGY}
			local btrainer_cycle_playerCode=math.floor(vars.missionCode/1e4)
			local btrainer_cycle_weather_string={"Sunny", "Cloudy", "Rainy", "Sandstorm", "Foggy"}
		
			e.btrainer_hold_pressed2 = Time.GetRawElapsedTimeSinceStartUp()

			if btrainer_cycle_playerCode~=5 then
			
				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.RIGHT)==PlayerPad.RIGHT)then
				
					e.btrainer_revenge_confirm = false
				
					if (e.btrainer_ClockTimeScale == nil)then
						e.btrainer_ClockTimeScale = 20
					end

					if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ZOOM_CHANGE)==PlayerPad.ZOOM_CHANGE)then
						e.btrainer_ClockTimeScale = e.btrainer_ClockTimeScale + 100
					elseif (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.FIRE)==PlayerPad.FIRE)then
						e.btrainer_ClockTimeScale = e.btrainer_ClockTimeScale + 10
					else
						e.btrainer_ClockTimeScale = e.btrainer_ClockTimeScale + 1
					end
					
					TppCommand.Weather.SetClockTimeScale(e.btrainer_ClockTimeScale)
					
					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView(string.format("Changed time scale to: %d", e.btrainer_ClockTimeScale))
				end

				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.LEFT)==PlayerPad.LEFT)then
				
					e.btrainer_revenge_confirm = false
				
					if (e.btrainer_ClockTimeScale == nil)then
						e.btrainer_ClockTimeScale = 20
					end

					if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ZOOM_CHANGE)==PlayerPad.ZOOM_CHANGE)then
						e.btrainer_ClockTimeScale = e.btrainer_ClockTimeScale - 100
					elseif (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.FIRE)==PlayerPad.FIRE)then
						e.btrainer_ClockTimeScale = e.btrainer_ClockTimeScale - 10		
					else
						e.btrainer_ClockTimeScale = e.btrainer_ClockTimeScale - 1
					end

					if (e.btrainer_ClockTimeScale < 1)then
						e.btrainer_ClockTimeScale = 0
					end

					TppCommand.Weather.SetClockTimeScale(e.btrainer_ClockTimeScale)
					
					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView(string.format("Changed time scale to: %d", e.btrainer_ClockTimeScale))
				end
				
				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.DOWN)==PlayerPad.DOWN)then

					e.btrainer_revenge_confirm = false
				
					if (e.btrainer_weather_index == nil)then
						e.btrainer_weather_index = 0
					end

					e.btrainer_weather_index=e.btrainer_weather_index + 1
					
					if (e.btrainer_weather_index > 5 or e.btrainer_weather_index < 1)then
						e.btrainer_weather_index = 1
					end
					
					TppWeather.ForceRequestWeather(btrainer_cycle_weather[e.btrainer_weather_index], 0)

					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView(string.format("Changed weather to: %s", btrainer_cycle_weather_string[e.btrainer_weather_index]))

				end

				if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.PRIMARY_WEAPON)==PlayerPad.PRIMARY_WEAPON)then
					if e.btrainer_revenge_confirm and not e.btrainer_revenge_just_press then
						TppRevenge.ResetRevenge()

						e.btrainer_revenge_confirm = false
						
						TppUiCommand.AnnounceLogDelayTime(0)
						TppUiCommand.AnnounceLogView("Reset Enemy Preparedness. Start a new mission to take effect.")
					else
						e.btrainer_revenge_confirm = true
						e.btrainer_revenge_just_press = true
					
						TppUiCommand.AnnounceLogDelayTime(0)
						TppUiCommand.AnnounceLogView("Are you sure? Press again to reset enemy preparedness.")
					end
				end
				
			end

		end
	else
		e.btrainer_hold_pressed2 = Time.GetRawElapsedTimeSinceStartUp()
		e.btrainer_revenge_just_press = false
	end
end
function e.OnTerminate()end
return e