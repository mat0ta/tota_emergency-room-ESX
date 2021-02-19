ESX = nil
TriggerEvent('ESX:getSharedObject', function(obj) ESX = obj end)

local DISCORD_WEBHOOK = "https://discordapp.com/api/webhooks/811647636221329478/zXxt3IaC8eH22uc8mdhL-rAkCNNdtmrXE9GBZqVfEmzz6TaJVOTq1kNuQKb4CYYwgPRy"
function ExtractIdentifiers()
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
            TriggerEvent("log", identifierDiscord)
        end
    end
end

RegisterServerEvent('log')
AddEventHandler('log', function(data)
        for k,v in pairs(GetPlayerIdentifiers(source))do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
              identifier = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
              license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
              xbl  = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
              playerip = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
              playerdiscord = v
              str = string.sub(v, 9)
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
              liveid = v
            end
          end
        
          if playerip == nil then
            playerip = GetPlayerEndpoint(target)
            if playerip == nil then
              playerip = 'not found'
            end
          end
          if playerdiscord == nil then
            playerdiscord = 'not found'
          end
          if str == nil then
            str = "not found"
          end
          if liveid == nil then
            liveid = 'not found'
          end
          if xbl == nil then
            xbl = 'not found'
          end
    
    local connect = {
        {
            ["color"] = "255",
            ["title"] = "New Form | " ..data.plate.."-"..data.lastname,
            timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),

            ["description"] = "First Name: \n `"..data.plate.."` \n Last Name: \n `"..data.lastname.."` \n Age: \n `"..data.age.."` \n Reason: \n`"..data.why.."`\n Gender:\n `"..data.gender.."`".."\n Discord:\n".."<@"..str..">",
	          ["footer"] = {
            ["text"] = "New Emergency Form",
            },
        }
    }
    MySQL.Sync.fetchAll("INSERT INTO `emergency` (`name`,`lastname`) VALUES ('"..data.plate.."', '"..data.lastname.."')")
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "Emergency Room",  avatar_url = "https://i.imgur.com/N8nDVhth.jpg",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('log2')
AddEventHandler('log2', function(data)

    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          identifier = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
          xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
          playerip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          playerdiscord = v
          str = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
          liveid = v
        end
      end
    
      if playerip == nil then
        playerip = GetPlayerEndpoint(target)
        if playerip == nil then
          playerip = 'not found'
        end
      end
      if playerdiscord == nil then
        playerdiscord = 'not found'
      end
      if str == nil then
        str = "not found"
      end
      if liveid == nil then
        liveid = 'not found'
      end
      if xbl == nil then
        xbl = 'not found'
      end

    local connect = {
        {
            ["color"] = "255",
            ["title"] = "New Complaint | " ..data.ft.."-"..data.ln,
            ["description"] = "First Name: \n `"..data.ft.."` \n Last Name: \n `"..data.ln.."`\n Reason: \n `"..data.reason.."`".."\n Date: \n `"..data.date.."`".."\n Discord:\n".."<@"..str..">",
	        ["footer"] = {
                ["text"] = "Police Complaint",
            },
            image = {
                url = data.myImg
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "Police Complaint",  avatar_url = "https://static.wikia.nocookie.net/gta/images/5/5e/Sceau-lspd-gtav.png/revision/latest?cb=20140916194909&path-prefix=fr",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)