local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('weaponMerge:mergeWeapon', function(weaponType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local playerJob = Player.PlayerData.job.name
    for _, blockedJob in ipairs(Config.legalmeslek) do
        if playerJob == blockedJob then
            TriggerClientEvent('QBCore:Notify', src, "Legaller bunu kullanamaz!", "error")
            return
        end
    end

    local weaponData = Config.silahbirlestir[weaponType]
    if weaponData then
        local hasAllParts = true

        for _, item in ipairs(weaponData.gerekenmalzemeler) do
            local itemData = Player.Functions.GetItemByName(item)
            if not itemData or itemData.amount < 1 then
                hasAllParts = false
                break
            end
        end

        if hasAllParts then
            for _, item in ipairs(weaponData.gerekenmalzemeler) do
                Player.Functions.RemoveItem(item, 1)
            end

            Player.Functions.AddItem(weaponData.silah, 1)
            TriggerClientEvent('weaponMerge:playAnimation', src)
            TriggerClientEvent('QBCore:Notify', src, "Silah başarıyla birleştirildi!", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Gerekli tüm parçalarınız yok!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Bilinmeyen silah türü!", "error")
    end
end)
