local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    local model = GetHashKey(Config.NPC.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    local npc = CreatePed(4, model, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 1, Config.NPC.coords.w, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "weaponMerge:openMenu",
                icon = "fas fa-wrench",
                label = "Silah Birleştir",
            },
        },
        distance = 2.5,
    })
end)

RegisterNetEvent('weaponMerge:openMenu', function()
    local menuOptions = {
        {
            header = "Silah Birleştirme",
            isMenuHeader = true,
        },
        {
            header = "Pistol Birleştir",
            txt = "Pistol parçalarını birleştir.",
            params = {
                event = "silahdonustur:animasyongir",
                args = { weaponType = "pistol" }
            }
        },
    }
    exports['qb-menu']:openMenu(menuOptions)
end)

RegisterNetEvent('silahdonustur:animasyongir', function(data)
    local weaponType = data.weaponType
    TriggerServerEvent('silahdonustur:animasyongir', weaponType)
end)

RegisterNetEvent('weaponMerge:playAnimation', function()
    local playerPed = PlayerPedId()
    local dict = "mp_common"
    local anim = "givetake1_a"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end

    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
    Wait(3000)
    ClearPedTasks(playerPed)
end)
