local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('weaponMerge:mergeWeapon', function(weaponType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local weaponData = Config.silahbirlestir[weaponType]
    if weaponData then
        local tumesyalar = true

        for _, item in ipairs(weaponData.gerekenmalzemeler) do
            local itemData = Player.Functions.GetItemByName(item)
            if not itemData or itemData.amount < 1 then
                tumesyalar = false
                break
            end
        end

        if tumesyalar then
            for _, item in ipairs(weaponData.gerekenmalzemeler) do
                Player.Functions.RemoveItem(item, 1)
            end

            Player.Functions.AddItem(weaponData.silah, 1)

            TriggerClientEvent('weaponMerge:playAnimation', src)
            TriggerClientEvent('QBCore:Notify', src, "Pistol başarıyla birleştirildi!", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Gerekli tüm parçalarınız yok!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Bilinmeyen silah türü!", "error")
    end
end)
