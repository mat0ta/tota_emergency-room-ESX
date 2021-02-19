ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("next", function(source, args, user)
		local Player = ESX.GetPlayerFromId(source)
		if Player.job.name == "ambulance" then
		MySQL.Async.fetchAll("SELECT * FROM emergency ORDER BY name ASC LIMIT 1", {}, function(result)
		local nombre = result[1].name
		local apellido = result[1].lastname
		local sala = args[1]
		msg = "Emergency Room"
		msg2 = nombre .. " " .. apellido .. " go to the Observations Room Nº [".. sala .."] so that you can be treated by our medical staff. Thank you"
		TriggerClientEvent("SendAlert", -1, msg, msg2)
		MySQL.Async.fetchAll("DELETE FROM emergency WHERE name = '"..result[1].name.."'")
  	  end)
		else
			TriggerClientEvent('chatMessage', source, '[EMERGENCY ROOM SYSTEM]', {255, 0, 0}, "^3This command is for emergency services!")
		end
end)